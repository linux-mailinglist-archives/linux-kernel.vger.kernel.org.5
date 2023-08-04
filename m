Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8567705D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjHDQW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjHDQWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:22:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093BD170F;
        Fri,  4 Aug 2023 09:22:23 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qRxZD-0000Tv-0E; Fri, 04 Aug 2023 18:22:19 +0200
Message-ID: <ef208002-2978-f92e-0dd0-ba20369005fb@leemhuis.info>
Date:   Fri, 4 Aug 2023 18:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: XFS metadata CRC errors on zram block device on ppc64le
 architecture
Content-Language: en-US, de-DE
To:     Dusty Mabe <dusty@dustymabe.com>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, marmijo@redhat.com
References: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691166143;57a49f8e;
X-HE-SMSGID: 1qRxZD-0000Tv-0E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 02.08.23 05:31, Dusty Mabe wrote:
> In Fedora CoreOS we found an issue with an interaction of an XFS filesystem on a zram block device on ppc64le:
> 
> - https://github.com/coreos/fedora-coreos-tracker/issues/1489
> - https://bugzilla.redhat.com/show_bug.cgi?id=2221314
> 
> The dmesg output shows several errors:
> 
> ```
> [ 3247.206007] XFS (zram0): Mounting V5 Filesystem 0b7d6149-614c-4f4c-9a1f-a80a9810f58f
> [ 3247.210781] XFS (zram0): Metadata CRC error detected at xfs_agf_read_verify+0x108/0x150 [xfs], xfs_agf block 0x80008 
> [ 3247.211121] XFS (zram0): Unmount and run xfs_repair
> [...]
> We ran a kernel bisect and narrowed it down to offending commit af8b04c6:
> 
> ```
> [root@ibm-p8-kvm-03-guest-02 linux]# git bisect good
> af8b04c63708fa730c0257084fab91fb2a9cecc4 is the first bad commit
> commit af8b04c63708fa730c0257084fab91fb2a9cecc4
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue Apr 11 19:14:46 2023 +0200
> 
>     zram: simplify bvec iteration in __zram_make_request
>     
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced af8b04c63708fa730c0257084fab91fb2a9cec
#regzbot title zram: XFS metadata CRC errors on zram block device on ppc64le
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
