Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5E17FE3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbjK2XG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2XGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:06:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46142D5E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:06:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934F7C433C8;
        Wed, 29 Nov 2023 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701299190;
        bh=/WgUayWWWkxbFck8hTcs1QOiZXOjLOOEvYOvKvwD0iE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PN4mgVDNZWOM3Mt13aA18yzTp+QM/mNKDN/09Nhq5W+eUSveBnuef43Nqosb9pBkG
         9iAMbd20kI1HdnnWI3rgqxfSOJaquDyQSR2L3HkGlSwHGbLSDuNwLNg9QpRVBQ/1Lk
         CC/lJITRwxVcvgIrsNaknnVa+vZd/er4eL4fgkvI=
Date:   Wed, 29 Nov 2023 15:06:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: No care given to GDB scripts..
Message-Id: <20231129150629.0a82efbfc1494972e4e4f8cb@linux-foundation.org>
In-Reply-To: <cfc3aa17-0f1b-4ffc-b848-33baa51b1196@gmail.com>
References: <cfc3aa17-0f1b-4ffc-b848-33baa51b1196@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 14:48:02 -0800 Florian Fainelli <f.fainelli@gmail.com> wrote:

> Hello,
> 
> It is quite clear that there are zero cares being given to making sure 
> that GDB scripts continue to work after making changes to core kernel 
> code, and why would you, because you probably did not know those 
> existed, but they do and they are used, and useful.
> 
> A recent example that was fixed by Kuan-Ying is this:
> 
> and now of course, "lx-interupts" also stopped working altogether after 
> this change:
> 
> https://lore.kernel.org/r/20230519134902.1495562-4-sdonthineni@nvidia.com
> 
> and who knows what else I could not test that is also broken.
> 
> We really need to find a better way to stop breaking GDB scripts, they 
> break way too often to be even remotely usable, and this is really sad.
> 
> It is also quite clear that we do not have enough continuous integration 
> and regression testing to ensure those breakages are caught ahead of time...
> 

This isn't terribly surprising - the gdb scripts are a pretty remote
corner and are peculiarly sensitive to getting damaged by routine
kernel development.

Is there any way of scripting the scripts so we can have some sort of
automated testing down under tools/testing/selftests/?
