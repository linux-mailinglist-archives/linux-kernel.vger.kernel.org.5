Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C64F76F3B6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjHCT6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjHCT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:57:55 -0400
X-Greylist: delayed 1218 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 12:57:51 PDT
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8E3420F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:57:51 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 6A3EE16C004D;
        Thu,  3 Aug 2023 22:37:31 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UkDLHQPYQ4Tw; Thu,  3 Aug 2023 22:37:30 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1691091450; bh=P0M+BMtHtIHMTuHkmOp7SS8Q1e715kFf0lQ1SHEGD/A=;
        h=From:To:Cc:Subject:Date:From;
        b=DeJRxVk1ZC1H6H36SbSolINpFMff0D0HNnOJOnV7f77SvoX+rdzSvN3Fjt49cXuVi
         lLA0fOSEYKKHoudZdYDTKy5343qvDRS4eqLjgyoP6N6E4G00cISMVV9gBmzF/57s64
         1pEbpn9nRl+AxkIXxCAbUNwe6r4iQA0S2AiClGFE=
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        <linux-kernel@vger.kernel.org>
Subject: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops
 support for acp pci driver"
Date:   Thu, 03 Aug 2023 22:22:07 +0300
Message-ID: <87a5v8szhc.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to develop a sound machine driver based on the acp legacy driver.
The first version of the driver was sent for review on the alsa mailing list this
spring: https://lore.kernel.org/all/20230320203519.20137-1-posteuca@mutex.one

I'm trying to fix some of the issues that were brought up during the review back then,
but when I ported the patches to the latest commit on the for-next
branch, I noticed a regression where I couldn't hear any sound at all.

So I started a bisect session and found that the first bad commit is:
ASoC: amd: acp: add pm ops support for acp pci driver
commit 088a40980efbc2c449b72f0f2c7ebd82f71d08e2
https://lore.kernel.org/lkml/20230622152406.3709231-11-Syed.SabaKareem@amd.com

If I revert this commit sound works as expected. So I started tinkering a little bit
with it and I believe that what happens is that the acp pci driver
enters the autosuspend state and never leaves this state at all.
I noticed this because if I increase the autosuspend delay to a much
larger value, then the sound works until that delay passes.
I added traces and I can see that when the delay expires the suspend callback snd_acp_suspend()
gets called, but the resume callback snd_acp_resume() never gets called.

I'm no expert in runtime power management (though I did read a bit on it), so I don't understand
all the things that happen underneath, but one thing that is not clear to me is who's supposed
to mark activity on this device and keep it from entering autosuspend if the user wants to play
some sound? Shouldn't there be some counterpart that calls pm_runtime_mark_last_busy() ?
I looked through the code and can't find who's calling pm_runtime_mark_last_busy().

Some help here would be welcome. Is there something missing in my machine driver code, or
is the runtime pm handling in acp pci driver wrong?
