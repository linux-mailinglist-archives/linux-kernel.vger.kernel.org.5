Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9507980BA85
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjLJLrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjLJLrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:47:00 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D57FF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:47:05 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1rCIH2-0002L8-9l; Sun, 10 Dec 2023 12:47:04 +0100
Message-ID: <e41899d8-6517-48fb-b657-c123325033a0@leemhuis.info>
Date:   Sun, 10 Dec 2023 12:47:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Content-Language: en-US, de-DE
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     linux-kernel@vger.kernel.org
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
 <20231122221947.781812-1-jsperbeck@google.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20231122221947.781812-1-jsperbeck@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702208826;3acb51af;
X-HE-SMSGID: 1rCIH2-0002L8-9l
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 22.11.23 23:19, John Sperbeck wrote:
> I have a platform with both LOCAL_APIC and LOCAL_X2APIC entries for
> each CPU.  However, the ids for the LOCAL_APIC entries are all
> invalid ids of 255, so they have always been skipped in acpi_parse_lapic()
> by this code from f3bf1dbe64b6 ("x86/acpi: Prevent LAPIC id 0xff from being
> accounted"):
> 
>     /* Ignore invalid ID */
>     if (processor->id == 0xff)
>             return 0;
> 
> With the change in this thread, the return value of 0 means that the
> 'count' variable in acpi_parse_entries_array() is incremented.  The
> positive return value means that 'has_lapic_cpus' is set, even though
> no entries were actually matched.  Then, when the MADT is iterated
> with acpi_parse_x2apic(), the x2apic entries with ids less than 255
> are skipped and most of my CPUs aren't recognized.
> 
> I think the original version of this change was okay for this case in
> https://lore.kernel.org/lkml/87pm4bp54z.ffs@tglx/T/
> 
> P.S. I could be convinced that the MADT for my platform is somewhat
> ill-formed and that I'm relying on pre-existing behavior.  I'm not
> well-versed enough in the topic to know for sure.

To be sure the issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced 8e9c42d776d6
#regzbot title x86/acpi: CPU core aren't recognized
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
