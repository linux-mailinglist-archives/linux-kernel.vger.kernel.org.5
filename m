Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69CA79BD88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349260AbjIKVc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbjIKM1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:27:18 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CCF1B9;
        Mon, 11 Sep 2023 05:27:13 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qfg0T-0000WD-Fw; Mon, 11 Sep 2023 14:27:09 +0200
Message-ID: <7e9735bf-c42b-4f03-8645-8cdbf87a75f3@leemhuis.info>
Date:   Mon, 11 Sep 2023 14:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Content-Language: en-US, de-DE
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694435233;82f00e33;
X-HE-SMSGID: 1qfg0T-0000WD-Fw
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 29.08.23 18:42, Geert Uytterhoeven wrote:
> 
> On Fri, 18 Aug 2023, Liam R. Howlett wrote:
>> The current implementation of append may cause duplicate data and/or
>> incorrect ranges to be returned to a reader during an update.  Although
>> this has not been reported or seen, disable the append write operation
>> while the tree is in rcu mode out of an abundance of caution.
>>
>> During the analysis of the mas_next_slot() the following was
>> artificially created by separating the writer and reader code:
> [...]
> Thanks for your patch, which is now commit cfeb6ae8bcb96ccf
> ("maple_tree: disable mas_wr_append() when other readers are
> possible") in v6.5, and is being backported to stable.
> 
> On Renesas RZ/A1 and RZ/A2 (single-core Cortex-A9), this causes the
> following warning:
> > […]
> Reverting this commit fixes the issue.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced cfeb6ae8bcb96ccf
#regzbot title maple_tree: warning on Renesas RZ/A1 and RZ/A2
(single-core Cortex-A9
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
