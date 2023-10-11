Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9847C47B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbjJKCTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344739AbjJKCS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:18:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68AC8E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:18:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50308217223so7943163e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696990736; x=1697595536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IjhCQdR9FSIb4mXchtT0S67Pn10MnE0igEvhgyIFe/Q=;
        b=Xgc/leIG+L2q4m2Fz4Dns4RnqkgTh2M5Quk7KQ4V2pkUv/u+0AN+xWQN/9cMt5dCci
         LN2zRkb09vwQpZwqunRoY1nlVbjei0pn+33PVFc1bxq0D7Ee4VfPj2ZUJs6C9m14G6GI
         khBexiNOUb8yl9KdVjieUIaMmRCjPxXlGqmkkLaJXM/xUNdO3JnVAQmlzLMuY+Ze+prb
         wk24b/WkkC2AHsetnxQkkKxaLg4YRwLWfljO+H4Fwcebyg7gD0UH9MKFL9DLq9JiSaX9
         PER/8UINxUl08OimpkSw8DTM4D+41p7TUF1mkMSdjumN1RHonac2IpqUANkKWo5aRqxA
         R3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696990736; x=1697595536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjhCQdR9FSIb4mXchtT0S67Pn10MnE0igEvhgyIFe/Q=;
        b=I9X1DFmSwbXt1wPWaJCgiGDZ6sh2us7bmm+z53zFgKyRmSyxTHmA/Ubrf92cpL7KXD
         BWtNA6fAIpYvdu02Re+6O/U/JxH7k0mofUVR4dLAgr9EMvRYScOFI0ffb4pjKM4Rf9wV
         +vOkB1CDuB8/TwBVHrvYsBbw7rEiAg/PxsmCKi+M6O5vcPmc5C7fedQD131TRBKEwLJZ
         LKDCBjcJNr1R/wQFwRjSJdctlmfKYlWhwR0/Y9iujllOhaTzt0p868zckCGer35e38cs
         HPPBo7eSJRjnO9Gaa5EiL+wn13RjX2U+acnm8OzIfnYCpUBeHMWu3o3B+WRiKreXmBop
         AVfw==
X-Gm-Message-State: AOJu0YxepsyB7wKgImpHAlpnZY3IrDfklNCwzlHNbTJEBnAEPpmZJT+3
        iTbLHgCrltM5FWpTS+QW6Fw3WlUlvfygAddXXSe7PSvIixEYjw==
X-Google-Smtp-Source: AGHT+IG455eJiJRDOe/hop6m/utv20TiZn18bkPOboRVVmi0yObSKu9mZc8I/dQ5g7g9loxS9h9Dk7pogKaU30lJLmQ=
X-Received: by 2002:a19:7119:0:b0:503:2e6:6862 with SMTP id
 m25-20020a197119000000b0050302e66862mr14460379lfc.32.1696990735472; Tue, 10
 Oct 2023 19:18:55 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Wed, 11 Oct 2023 10:18:44 +0800
Message-ID: <CALcu4rYmqcMReMWCDx60=-WeTgNMZGxNGc3GMUXhdS6kNBDw_w@mail.gmail.com>
Subject: KASAN: slab-out-of-bounds Read in ntfs_readdir
To:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net
Cc:     linkinjeon@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel,  the following crash
was triggered.

HEAD commit: f291209eca5eba0b4704fa0832af57b12dbc1a02 (  Merge tag
'net-6.6-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net=EF=BC=89
git tree: upstream

My local Linux repository is a few commits behind the main branch, so
I pulled the latest branch and validated the crash on it. The issue
still persists.

console output:
https://drive.google.com/file/d/1NdDXed0sG9aBNPZ9mriMt89l6X5Gg5ZN/view?usp=
=3Ddrive_link
kernel config:https://drive.google.com/file/d/11ueBuZ-2vOvQRAH7qlGib6JACvk1=
WmJq/view?usp=3Ddrive_link
C reproducer:https://drive.google.com/file/d/1SdzoHnEAy_BRCRiGsIyxmck56SrKD=
n9H/view?usp=3Ddrive_link
Syzlang reproducer:
https://drive.google.com/file/d/1cFnKjf2E9mko-8NKgeT7YBoMIpu3ahKv/view?usp=
=3Ddrive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in ntfs_filldir fs/ntfs/dir.c:1021 [inline]
BUG: KASAN: slab-out-of-bounds in ntfs_readdir+0x1457/0x29a0 fs/ntfs/dir.c:=
1200
Read of size 1 at addr ffff88806099dff1 by task syz-executor.2/19012

CPU: 2 PID: 19012 Comm: syz-executor.2 Not tainted 6.6.0-rc4-gf291209eca5e =
#4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd5/0x150 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc1/0x5e0 mm/kasan/report.c:475
 kasan_report+0xba/0xf0 mm/kasan/report.c:588
 ntfs_filldir fs/ntfs/dir.c:1021 [inline]
 ntfs_readdir+0x1457/0x29a0 fs/ntfs/dir.c:1200
 wrap_directory_iterator+0xa1/0xe0 fs/readdir.c:67
 iterate_dir+0x1ea/0x600 fs/readdir.c:106
 __do_sys_getdents fs/readdir.c:322 [inline]
 __se_sys_getdents fs/readdir.c:307 [inline]
 __x64_sys_getdents+0x14a/0x2d0 fs/readdir.c:307
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f541788eced
Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f541858d028 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007f54179cbf80 RCX: 00007f541788eced
RDX: 0000000000000040 RSI: 0000000020001640 RDI: 0000000000000003
RBP: 00007f54178f04a6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f54179cbf80 R15: 00007f541856d000
 </TASK>

Allocated by task 19012:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0x9e/0xa0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1023 [inline]
 __kmalloc+0x5d/0x190 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 ntfs_readdir+0x1180/0x29a0 fs/ntfs/dir.c:1162
 wrap_directory_iterator+0xa1/0xe0 fs/readdir.c:67
 iterate_dir+0x1ea/0x600 fs/readdir.c:106
 __do_sys_getdents fs/readdir.c:322 [inline]
 __se_sys_getdents fs/readdir.c:307 [inline]
 __x64_sys_getdents+0x14a/0x2d0 fs/readdir.c:307
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88806099df80
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 57 bytes to the right of
 allocated 56-byte region [ffff88806099df80, ffff88806099dfb8)

The buggy address belongs to the physical page:
page:ffffea0001826740 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x6099d
flags: 0xfff00000000800(slab|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888011442640 ffffea0000576900 dead000000000004
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 8090, tgid 8090
(syz-executor.2), ts 240981630987, free_ts 0
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xf09/0x2c50 mm/page_alloc.c:3170
 __alloc_pages+0x1c7/0x490 mm/page_alloc.c:4426
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x261/0x390 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0xbda/0x15e0 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x136/0x340 mm/slub.c:3517
 kmalloc_trace+0x22/0xd0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 snmp6_alloc_dev net/ipv6/addrconf.c:350 [inline]
 ipv6_add_dev+0x533/0x13b0 net/ipv6/addrconf.c:404
 addrconf_notify+0x753/0x1960 net/ipv6/addrconf.c:3589
 notifier_call_chain+0xb6/0x3c0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1970
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 register_netdevice+0xf23/0x14c0 net/core/dev.c:10169
 veth_newlink+0x31c/0x980 drivers/net/veth.c:1908
 rtnl_newlink_create net/core/rtnetlink.c:3485 [inline]
 __rtnl_newlink+0x110a/0x18e0 net/core/rtnetlink.c:3705
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3718
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88806099de80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff88806099df00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff88806099df80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
                                                             ^
 ffff88806099e000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88806099e080: 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
