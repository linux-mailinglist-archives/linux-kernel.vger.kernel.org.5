Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FFE763695
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjGZMnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGZMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:43:42 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F97219A0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:43:29 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qOdrS-0004i9-B8; Wed, 26 Jul 2023 14:43:26 +0200
Message-ID: <2e453cab-9049-98e5-1d96-2305fbb751ee@leemhuis.info>
Date:   Wed, 26 Jul 2023 14:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: two reports about NULL pointer dereferences in mm subsystem since
 5.18(?) with qbittorrent on XFS
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690375409;710a131e;
X-HE-SMSGID: 1qOdrS-0004i9-B8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone! There are two regression reports with somewhat similar
symptoms in bugzilla.kernel.org that seem to not get the attention they
IMHO deserve. Both reports describe oopses due to a NULL pointer
dereference that seems to happen in the mm subsystem when using
qbittorrent on XFS. It seems quite a few users of that combination run
into problems.

One report initially received replies from Akpm and Willy, but at some
point the regression apparently fell through the cracks (I prodded a few
times, but was ignored). The other never got a reply from a mm developer
afaics. I hope to revive things with this mail to finally get them on
track and resolved.

What follows is a *very rough* overview about the two reports which
might be caused by the same or different bugs in the code. Both
descriptions will leave out lots of details on purpose, as it can easily
happen that I understood something wrong; sorry, this can happen in my
position, so handle the following with care.


The older of the two reports is
https://bugzilla.kernel.org/show_bug.cgi?id=216646 (from November last
year); the report already mentioned that disabling THP avoids the oopses
due to a NULL pointer dereference. The problems was actually bisected to
793917d997d ("mm/readahead: Add large folio readahead") [v5.18-rc1] at
one point (https://bugzilla.kernel.org/show_bug.cgi?id=216646#c6 ). The
reporter was able to avoid the problem by switching from XFS to Btrfs
(https://bugzilla.kernel.org/show_bug.cgi?id=216646#c18 ). Someone else
not that long ago in the ticket reported that 66dabbb65d6 ("mm: return
an ERR_PTR from __filemap_get_folio") [v6.4-rc1] is a partial fix (side
note: I wonder if we should backport that to 6.1.y). The problem is also
discussed in https://github.com/arvidn/libtorrent/issues/6952, as it
seems quite a few other users of libtorrent based software encountered
it. I recently asked in that ticket to test if 6.5-rc is still affected,
but got no reply so far.


The other report is https://bugzilla.kernel.org/show_bug.cgi?id=217441;
the reporter never managed a bisection. Disabling THP apparently does
not help for tha reporter, so it might be something totally different. I
recently asked if the problems is still happening with recent kernels.
Two users confirmed it does, it just takes a lot longer to trigger (if
that is due to 66dabbb65d6 or not is not known). One of those users
tested with linux-next and provided this:

> Jul 20 19:03:24 smoon7.bkoty.ru kernel: BUG: kernel NULL pointer dereference, address: 0000000000000096
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: #PF: supervisor read access in kernel mode
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: #PF: error_code(0x0000) - not-present page
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: PGD 0 P4D 0
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: CPU: 4 PID: 305164 Comm: qbittorrent-nox Tainted: G     U             6.5.0-rc2-next-20230718-1-next-git-03113-gaeba456828b4 #1 8d98cf92e1199e734fba1ef76a33030687665b92
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: Hardware name: Gigabyte Technology Co., Ltd. H470M DS3H/H470M DS3H, BIOS F4b 06/22/2020
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: RIP: 0010:filemap_get_entry+0x8a/0x130
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: Code: 24 18 03 00 00 00 48 89 e7 e8 32 54 a6 00 48 89 c3 48 3d 02 04 00 00 74 e4 48 3d 06 04 00 00 74 dc 48 85 c0 74 4f a8 01 75 4b <8b> 40 34 85 c0 74 cc 8d 50 01 f0 0f b1 53 34 75 f2 48 8b 54 24 18
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: RSP: 0000:ffffb7d6c4e1bc70 EFLAGS: 00010246
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: RAX: 0000000000000062 RBX: 0000000000000062 RCX: 0000000000000002
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: RDX: 000000000000001c RSI: ffff996fdd57c490 RDI: ffffb7d6c4e1bc70
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: R10: ffff99695e549d50 R11: ffff99695e549d0c R12: ffff99699ffe2fc0
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: R13: 000000000001eb9d R14: 0000000000000000 R15: ffff9969a06cfef8
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: FS:  00007f9077fff6c0(0000) GS:ffff9970de300000(0000) knlGS:0000000000000000
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: CR2: 0000000000000096 CR3: 0000000344754004 CR4: 00000000003706e0
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: Call Trace:
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  <TASK>
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  ? __die+0x23/0x70
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  ? page_fault_oops+0x171/0x4e0
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  ? psi_group_change+0x213/0x3c0
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  ? exc_page_fault+0x7f/0x180
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  ? asm_exc_page_fault+0x26/0x30
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  ? filemap_get_entry+0x8a/0x130
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  __filemap_get_folio+0x2b/0x230
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  filemap_fault+0x6b/0x9f0
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  ? filemap_map_pages+0x2dc/0x560
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  __do_fault+0x30/0x130
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  do_fault+0x26c/0x430
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  __handle_mm_fault+0x73f/0xbb0
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  handle_mm_fault+0x17f/0x360
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  do_user_addr_fault+0x1e6/0x640
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  exc_page_fault+0x7f/0x180
> Jul 20 19:03:24 smoon7.bkoty.ru kernel:  asm_exc_page_fault+0x26/0x30
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: RIP: 0033:0x7f909336cb0d
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: Code: 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 83 fa 20 72 23 <c5> fe 6f 06 48 83 fa 40 0f 87 a5 00 00 00 c5 fe 6f 4c 16 e0 c5 fe
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: RSP: 002b:00007f9077ffd298 EFLAGS: 00010202
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: RAX: 00007f9050012770 RBX: 00007f9077ffe300 RCX: 00007f9077ffd4c0
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: RDX: 0000000000004000 RSI: 00007f77e759d10f RDI: 00007f9050012770
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
> Jul 20 19:03:24 smoon7.bkoty.ru kernel: R13: 00007f9050000bf0 R14: 0000000000000007 R15: 000000001eb9d10f
> [...]

But we apparently have at least two people that still care about this
problem. Could anyone maybe help them somewhat so we can with a bit of
luck maybe finally get down to the actually cause and fix it?


That's it from my side. Really hope this will get things moving again.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
