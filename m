Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AED770FD1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 15:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjHENHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHENHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 09:07:32 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52933E7;
        Sat,  5 Aug 2023 06:07:31 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qSH03-0006q9-To; Sat, 05 Aug 2023 15:07:19 +0200
Message-ID: <84f6ea98-0d72-e17a-4b7c-d025f2d34e95@leemhuis.info>
Date:   Sat, 5 Aug 2023 15:07:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] PM: hibernate: move finding the resume device out
 of software_resume
Content-Language: en-US, de-DE
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230531125535.676098-1-hch@lst.de>
 <20230531125535.676098-5-hch@lst.de>
 <2cfa5f55-1d68-8a4f-d049-13f42e0d1484@suse.cz>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2cfa5f55-1d68-8a4f-d049-13f42e0d1484@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691240851;88782bfb;
X-HE-SMSGID: 1qSH03-0006q9-To
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 03.08.23 10:27, Vlastimil Babka wrote:
> On 5/31/23 14:55, Christoph Hellwig wrote:
>> software_resume can be called either from an init call in the boot code,
>> or from sysfs once the system has finished booting, and the two
>> invocation methods this can't race with each other.
>>
>> For the latter case we did just parse the suspend device manually, while
>> the former might not have one.  Split software_resume so that the search
>> only happens for the boot case, which also means the special lockdep
>> nesting annotation can go away as the system transition mutex can be
>> taken a little later and doesn't have the sysfs locking nest inside it.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> This caused a regression for me in 6.5-rc1+, fix below.
> 
> ----8<----
>>From 95a310ae6cfae9b3cab61e54a1bce488c3ab93a1 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 2 Aug 2023 15:46:18 +0200
> Subject: [PATCH] PM: hibernate: fix resume_store() return value when
>  hibernation not available
> 
> On a laptop with hibernation set up but not actively used, and with
> secure boot and lockdown enabled kernel, 6.5-rc1 gets stuck on boot with
> the following repeated messages:
> 
>   A start job is running for Resume from hibernation using device /dev/system/swap (24s / no limit)
>   lockdown_is_locked_down: 25311154 callbacks suppressed
>   Lockdown: systemd-hiberna: hibernation is restricted; see man kernel_lockdown.7
>   ...
> 
> Checking the resume code leads to commit cc89c63e2fe3 ("PM: hibernate:
> move finding the resume device out of software_resume") which
> inadvertently changed the return value from resume_store() to 0 when
> !hibernation_available(). This apparently translates to userspace
> write() returning 0 as in number of bytes written, and userspace looping
> indefinitely in the attempt to write the intended value.
> 
> Fix this by returning the full number of bytes that were to be written,
> as that's what was done before the commit.
> 
> Fixes: cc89c63e2fe3 ("PM: hibernate: move finding the resume device out of software_resume")
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced cc89c63e2fe3
#regzbot title pm: boot problems when hibernate is configured and kernel
locked down
#regzbot fix: PM: hibernate: fix resume_store() return value when
hibernation not available
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
