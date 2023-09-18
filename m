Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB18E7A4686
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbjIRKBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbjIRKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB41A6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695031228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvG27PpDuZE/TeKcTyHQ6S9T2/UNXS4dt080b2s8UzU=;
        b=Mw3wIdstQ//JcOCb7a/4I8UjgiBuxx9jxjP20JSlZtaigsc2A/FWd+A8MYAxwPT++mxPeJ
        KiUl5SOBhPC/edQg/sFv0M7omdAXx00LKJCg8mYRswbz5Dj9jxXkaAmQhRhJgIk7RNtykD
        gTXe41uIVTdkDbfLbBKdLSkNG1iYjNs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-zyZkMDJdP62KNb2E34BWDQ-1; Mon, 18 Sep 2023 06:00:27 -0400
X-MC-Unique: zyZkMDJdP62KNb2E34BWDQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-320004980a2so1216346f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695031226; x=1695636026;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvG27PpDuZE/TeKcTyHQ6S9T2/UNXS4dt080b2s8UzU=;
        b=Oq9bneX9hQGRh05fAIa+R5wKA1QbYr9obgZgisAyfiCVb4Yy/k6+et7dMnDxVOtXLp
         eD9y73rWw4e0s1z8TV26X4nPsJk1/jMS16gXbyj5XfAoDoVmtbRBlxOaCwlwMLWwrfWH
         yclJPAPFBG9BqUcSp26esFX31seBaad7AVVdoSwMi99v5ZO+NDmlb9zlXVXmJPvN/5g+
         c9E4Tiz+O4yuRB9RztIO8P8jXS6WULhOs36fTEAWeDUYJddewzMI+3k+DAos6zVWwg0X
         mQsvmIQR6lvDeE3vkbn4GF8LhlM1xcgrr1RV29yjKdRnvnZFfb8aTeiwmlHUIXSxnTYv
         T32g==
X-Gm-Message-State: AOJu0YyKGsnsfb/z0hexxvqmnhSRD0hbq7ns07x5saVvuuvvNG+yke7z
        7Q0WsAM1GQNX8QQvPZAiQw7WdLfwOruykoh47KTb+qzEYKmzqwXg1Jt/QuPShd2sd+Kp8dyBfht
        +iQwlu2MRzMTw4BwNrpgzECzj
X-Received: by 2002:a5d:5149:0:b0:315:8a13:ef17 with SMTP id u9-20020a5d5149000000b003158a13ef17mr7276426wrt.65.1695031225788;
        Mon, 18 Sep 2023 03:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdmoqdtnwTH2Hk1XJM8jwqwNqw5MubHZDVFXu5BER3b9bfCLDPMFN6UzXApC7Y2yDhRBR9Cw==
X-Received: by 2002:a5d:5149:0:b0:315:8a13:ef17 with SMTP id u9-20020a5d5149000000b003158a13ef17mr7276401wrt.65.1695031225377;
        Mon, 18 Sep 2023 03:00:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b003176eab8868sm12369552wrs.82.2023.09.18.03.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 03:00:24 -0700 (PDT)
Message-ID: <a841592f-942d-b1b7-db93-7bd31c96e4eb@redhat.com>
Date:   Mon, 18 Sep 2023 12:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [mm?] WARNING in page_add_anon_rmap
Content-Language: en-US
To:     syzbot <syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <0000000000008bf71d06059a2276@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0000000000008bf71d06059a2276@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.23 05:57, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    98897dc735cf Add linux-next specific files for 20230914
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1214a152680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1502c503717ada5c
> dashboard link: https://syzkaller.appspot.com/bug?extid=6e4f59235036c3c2e296
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15869ea0680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f1b952680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/00e4c0af5a8a/disk-98897dc7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7b54a00eee56/vmlinux-98897dc7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/100094353b8e/bzImage-98897dc7.xz
> 
> The issue was bisected to:
> 
> commit b8575fa4abaa1dee1a61f1f27a86a02757310a7e
> Author: David Hildenbrand <david@redhat.com>
> Date:   Wed Sep 13 12:51:12 2023 +0000
> 
>      mm/rmap: simplify PageAnonExclusive sanity checks when adding anon rmap
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140e9ea0680000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=160e9ea0680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=120e9ea0680000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com
> Fixes: b8575fa4abaa ("mm/rmap: simplify PageAnonExclusive sanity checks when adding anon rmap")
> 
> page last free stack trace:
>   reset_page_owner include/linux/page_owner.h:24 [inline]
>   free_pages_prepare mm/page_alloc.c:1138 [inline]
>   free_unref_page+0x554/0xd70 mm/page_alloc.c:2460
>   free_contig_range+0xb6/0x190 mm/page_alloc.c:6396
>   destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
>   debug_vm_pgtable+0x1d79/0x3df0 mm/debug_vm_pgtable.c:1408
>   do_one_initcall+0x117/0x630 init/main.c:1232
>   do_initcall_level init/main.c:1294 [inline]
>   do_initcalls init/main.c:1310 [inline]
>   do_basic_setup init/main.c:1329 [inline]
>   kernel_init_freeable+0x5c2/0x8f0 init/main.c:1547
>   kernel_init+0x1c/0x2a0 init/main.c:1437
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5039 at mm/rmap.c:1252 page_add_anon_rmap+0xc33/0x1a70 mm/rmap.c:1252
> Modules linked in:
> CPU: 0 PID: 5039 Comm: syz-executor266 Not tainted 6.6.0-rc1-next-20230914-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
> RIP: 0010:page_add_anon_rmap+0xc33/0x1a70 mm/rmap.c:1252
> Code: 48 c1 eb 11 83 e3 01 89 de e8 79 d4 b8 ff 84 db 0f 84 36 fb ff ff e8 3c d9 b8 ff 48 c7 c6 80 83 99 8a 4c 89 e7 e8 dd 02 f7 ff <0f> 0b e9 1b fb ff ff e8 21 d9 b8 ff 49 89 dd 31 ff 41 81 e5 ff 0f
> RSP: 0018:ffffc90003ccf900 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: ffff88801c4a5940 RSI: ffffffff81cf16a3 RDI: 0000000000000000
> RBP: ffff888072c4fb00 R08: 0000000000000000 R09: fffffbfff1d9c7b2
> R10: ffffffff8ece3d97 R11: 0000000000000001 R12: ffffea0001c88000
> R13: 00fff800000a0078 R14: 0000000000000000 R15: ffffea0001cc4d88
> FS:  0000555555943380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020123008 CR3: 000000001c4d7000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   __split_huge_pmd_locked mm/huge_memory.c:2276 [inline]
>   __split_huge_pmd+0x17d5/0x31e0 mm/huge_memory.c:2320
>   split_huge_pmd_address mm/huge_memory.c:2336 [inline]
>   split_huge_pmd_if_needed mm/huge_memory.c:2348 [inline]
>   split_huge_pmd_if_needed mm/huge_memory.c:2339 [inline]
>   vma_adjust_trans_huge+0x2da/0x560 mm/huge_memory.c:2360
>   __split_vma+0xba3/0x1070 mm/mmap.c:2376
>   split_vma+0xc8/0x110 mm/mmap.c:2412
>   mlock_fixup+0x9b7/0x1290 mm/mlock.c:438
>   apply_vma_lock_flags+0x250/0x370 mm/mlock.c:514
>   do_mlock+0x263/0x820 mm/mlock.c:610
>   __do_sys_mlock mm/mlock.c:624 [inline]
>   __se_sys_mlock mm/mlock.c:622 [inline]
>   __x64_sys_mlock+0x59/0x80 mm/mlock.c:622
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f23893c4329
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc63bf5018 EFLAGS: 00000246 ORIG_RAX: 0000000000000095
> RAX: ffffffffffffffda RBX: 00007ffc63bf51f8 RCX: 00007f23893c4329
> RDX: 00007f23893c4329 RSI: 0000000000001000 RDI: 00000000202cf000
> RBP: 00007f2389437610 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000023a R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffc63bf51e8 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


 From 4b945ca15817b491123cc922f022b253134075b7 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2023 11:16:57 +0200
Subject: [PATCH] fixup: mm/rmap: simplify PageAnonExclusive sanity checks when
  adding anon rmap

While PTE-mapping a THP, we temporarily have an exclusive page of a THP
mapped by both, a PMD and a PTE at the same time. Update our check to
allow for that combination.

Reported-by: syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/rmap.c | 6 ++++--
  1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 789a2beb8b3a..f13a2927163d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1249,8 +1249,10 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
  	}
  	if (flags & RMAP_EXCLUSIVE)
  		SetPageAnonExclusive(page);
-	VM_WARN_ON_FOLIO(page_mapcount(page) > 1 && PageAnonExclusive(page),
-			 folio);
+	/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
+	VM_WARN_ON_FOLIO((atomic_read(&page->_mapcount) > 0 ||
+			  (folio_test_large(folio) && folio_entire_mapcount(folio) > 1)) &&
+			 PageAnonExclusive(page), folio);
  
  	mlock_vma_folio(folio, vma, compound);
  }
-- 
2.41.0


-- 
Cheers,

David / dhildenb

