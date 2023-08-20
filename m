Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE389781D2F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHTJgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjHTJgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:36:43 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23E01AC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 02:32:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 8074516C004A;
        Sun, 20 Aug 2023 12:32:56 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zVhDgEjmY7wN; Sun, 20 Aug 2023 12:32:55 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1692523975; bh=kDnTcqSTQdlLHPpQOf5RRj+TVFls2LmJQQQrfzPriCk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fViGGRzXCd7v5DsOstN+pqTrYAkAg0Mae2L6QgAcM8zUeelBB64Kq3LLNCcKY4Wug
         0J76mfBHwpyBXU44E7hTzxipE58kkhGkXBYd3SrC6pbpx3UQvB2QJ9VjBK9cWkVxAs
         469J+R8h41J5X1jKqxUaS3ayCd0HVWWhGc3EboUA=
To:     Mark Brown <broonie@kernel.org>
Cc:     =?utf-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
        yangxiaohua <yangxiaohua@everest-semi.com>,
        Zhu Ning <zhuning@everest-semi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
In-Reply-To: <8cddbe1c-20d7-4b8f-ba02-f86bbb5a54c5@sirena.org.uk>
References: <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
 <87lejpwxzf.fsf@mutex.one> <ZBr9rJn50ovG1w9W@sirena.org.uk>
 <87ttycjyw3.fsf@mutex.one> <ZBty1CdPaWm0IcRi@sirena.org.uk>
 <87r0t9uc08.fsf@mutex.one> <ZCRCqJ7oG6oefo9g@sirena.org.uk>
 <87zg2pxtog.fsf@mutex.one>
 <d2be9183-87fd-4cc4-a239-9401b5b88364@sirena.org.uk>
 <87o7j5b9bd.fsf@mutex.one>
 <8cddbe1c-20d7-4b8f-ba02-f86bbb5a54c5@sirena.org.uk>
Date:   Sun, 20 Aug 2023 12:32:52 +0300
Message-ID: <878ra683ej.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> You'd need to pull the relevant supplies out of DAPM and handle them in
> the CODEC suspend/resume callback.

Can you please suggest an approach that would be acceptable to you?
In the original patch series I sent, you didn't agree to the approach
to disable the jack detection in the machine driver suspend callback
and re-enable it in the resume callback. You suggested to do it in the
CODEC suspend/resume callbacks. As I explained previously (and Zhu Ning
confirmed in his email) this wouldn't work, since as long as the jack
detection is enabled, the CODEC suspend/resume callbacks do not get
called.
The second option (which you also do not seem to agree) is to enable
idle_bias_on.

So I don't know how to continue with this and merge this new machine
driver.
