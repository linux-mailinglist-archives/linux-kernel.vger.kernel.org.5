Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F627ED684
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbjKOWAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjKOWAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:00:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC62919B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:00:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC1C433C7;
        Wed, 15 Nov 2023 22:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700085607;
        bh=50kvp/0FUGpyKqtbnxNCKHZKsnQxgGiwUm+ioZcye4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bibK28lYI/7r+3taZvRJyOt7Dgvyhz3WDRX3g7Q0gHL10cuofmkLyVhbbLp8CAFTx
         wcU08FnMWJorunbZCmzfecLOskcLinrrdxMCP6WgfWsNQTTbYP2micH2Ia35eRuA62
         ADHFKLo89vFlMMDO7HF891vMy4E1UwsnfaXHv2Yo=
Date:   Wed, 15 Nov 2023 14:00:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com>
Cc:     david@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, usama.anjum@collabora.com,
        wangkefeng.wang@huawei.com
Subject: Re: [syzbot] [mm?] WARNING in unmap_page_range (2)
Message-Id: <20231115140006.cc7de06f89b1f885f4583af0@linux-foundation.org>
In-Reply-To: <000000000000b0e576060a30ee3b@google.com>
References: <000000000000b0e576060a30ee3b@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 05:32:19 -0800 syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ac347a0655db Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15ff3057680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=287570229f5c0a7c
> dashboard link: https://syzkaller.appspot.com/bug?extid=7ca4b2719dc742b8d0a4
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162a25ff680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d62338e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/00e30e1a5133/disk-ac347a06.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/07c43bc37935/vmlinux-ac347a06.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c6690c715398/bzImage-ac347a06.xz
> 
> The issue was bisected to:
> 
> commit 12f6b01a0bcbeeab8cc9305673314adb3adf80f7
> Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Date:   Mon Aug 21 14:15:15 2023 +0000
> 
>     fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag

Thanks.  The bisection is surprising, but the mentioned patch does
mess with pagemap.

How about we add this?

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/memory.c:zap_pte_range() print bad swap entry
Date: Wed Nov 15 01:54:18 PM PST 2023

We have a report of this WARN() triggering.  Let's print the offending
swp_entry_t to help diagnosis.

Link: https://lkml.kernel.org/r/000000000000b0e576060a30ee3b@google.com
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/memory.c~a
+++ a/mm/memory.c
@@ -1521,6 +1521,7 @@ static unsigned long zap_pte_range(struc
 				continue;
 		} else {
 			/* We should have covered all the swap entry types */
+			pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
 			WARN_ON_ONCE(1);
 		}
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
_

