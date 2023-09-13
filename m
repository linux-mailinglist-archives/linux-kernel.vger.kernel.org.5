Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC1179DCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbjIMAE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjIMAEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:04:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6852010E6;
        Tue, 12 Sep 2023 17:04:21 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b974031aeaso107061131fa.0;
        Tue, 12 Sep 2023 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694563459; x=1695168259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYqtldXjaIbkofQ9EGajkaEKo3opUg1EXy6HgLBgrys=;
        b=MkYsr5vvsV0lBXmZ/ruw5r9O1s35HL5o5FE3XtSZXsrf69vufiaghLu0suKc74A1l/
         u3Xh+mIe9t53wVptK2DYcWfFEzCNjVQ2LqquAlokplu7cEgNgP0AkjJ91XOMpgu+F/Ip
         6UgwKRl8EKfzbgmWavup/WF4klTC3iEulprA1wGdkpeex4fCpVS0Pi0XXhlsoVKNBbUI
         Vh7LnTRYiWOMefXtUv4symCIs4lxg1YPZkO5xM4kU/Vcz3ShcpStRIs9xMeQbzIU84rO
         iTRHGykXLLUX5QR6Iaa3OR7+2kOk9VRY+Djp1kyG5wEXOyJ1SqZbSBTK2WGGhU/PyWTf
         wCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694563459; x=1695168259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYqtldXjaIbkofQ9EGajkaEKo3opUg1EXy6HgLBgrys=;
        b=oZ5shopB9da07Yj7cHS3mIOaJp/mdeemtV7KG5JgcrLnhmelu45h11uEm2JVYqpzkM
         CyjrmhhreqwGGRWL4zrSZWLZeeWiiW07zlZSUht/UwnwjQZ15BTRBXMCr/IOFwO9GnJE
         F77bCqly9rCHCjdvqZk9y69B52bdTYVaFjtCbDvkoc49zLmeRnLnzvWKZG24ANx9Q4ap
         afKC9a9u8mrAvPHiD5qS6AsoEc9avtnZaQXaTxFbtoubWfoGIN9Fnt872zT+RyQ4Wj8T
         BU92ScYXYW1UNafuCajPCMAOomAhZ8kc1G2adPtGHGUEo+qp0SA8EOy3UvfboFiT44TT
         Pvtg==
X-Gm-Message-State: AOJu0YwBeuV/O+n8CDYdrHiGN0ki7tKRpNZnocuC79NdaBJ3zUJ9PU73
        q8NvCUP9pysaR95MIbAdaDiaZLz0anrkaP/50sg=
X-Google-Smtp-Source: AGHT+IGDjbjRS64pleRYqIUkKF+sXzxgCOVjZKZ8y6Foxytz4c8MWBDobr/hqybN7T3ELGZePV5/5G6D6aicP89fGoY=
X-Received: by 2002:a2e:9c52:0:b0:2b9:e24d:21f6 with SMTP id
 t18-20020a2e9c52000000b002b9e24d21f6mr961461ljj.20.1694563459093; Tue, 12 Sep
 2023 17:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <BL0PR11MB3106630748E9A97C1E32A14EE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB3106630748E9A97C1E32A14EE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Sep 2023 17:04:06 -0700
Message-ID: <CABBYNZLveT7S8+1CqZfp+O-Pp0GyRUEvy3gwovg+a1isUhr3BA@mail.gmail.com>
Subject: Re: KASAN: slab-use-after-free Read in hci_conn_hash_flush
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>
Cc:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sanan,

On Tue, Sep 12, 2023 at 4:02=E2=80=AFPM Sanan Hasanov <Sanan.Hasanov@ucf.ed=
u> wrote:
>
> Good day, dear maintainers,
>
> We found a bug using a modified kernel configuration file used by syzbot.
>
> We enhanced the coverage of the configuration file using our tool, klocal=
izer.
>
> Kernel Branch: 6.3.0-next-20230426
> Kernel Config: https://drive.google.com/file/d/19nzVDVMtaTo8fv7RMtXDGYQze=
RnNpp-r/view?usp=3Dsharing
> Reproducer: https://drive.google.com/file/d/1vzoYO_aW6XQqR6NAaJqvacOcJy9J=
6R-0/view?usp=3Dsharing
>
> Thank you!
>
> Best regards,
> Sanan Hasanov
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in hci_conn_hash_flush+0x1fa/0x230
> Read of size 8 at addr ffff8880780da000 by task syz-executor.7/5990
>
> CPU: 3 PID: 5990 Comm: syz-executor.7 Not tainted 6.3.0-next-20230426 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x178/0x260
>  print_report+0xc1/0x5e0
>  kasan_report+0xc0/0xf0
>  hci_conn_hash_flush+0x1fa/0x230
>  hci_dev_close_sync+0x5c2/0x1060
>  hci_unregister_dev+0x1ce/0x4a0
>  vhci_release+0x80/0xf0
>  __fput+0x27c/0xa90
>  task_work_run+0x168/0x260
>  do_exit+0xbd9/0x2b20
>  do_group_exit+0xd4/0x2a0
>  __x64_sys_exit_group+0x3e/0x50
>  do_syscall_64+0x39/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7ff463e8edcd
> Code: Unable to access opcode bytes at 0x7ff463e8eda3.
> RSP: 002b:00007ffde1873c18 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00007ffde1874480 RCX: 00007ff463e8edcd
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000043
> RBP: 0000000000000003 R08: 0000000000000026 R09: 00007ffde1874480
> R10: 0000000000000026 R11: 0000000000000202 R12: 0000000000000000
> R13: 00007ff463eeba70 R14: 0000000000000002 R15: 00007ffde18744c0
>  </TASK>
>
> Allocated by task 24391:
>  kasan_save_stack+0x22/0x40
>  kasan_set_track+0x25/0x30
>  __kasan_kmalloc+0x7c/0x90
>  hci_conn_add+0xa5/0x1570
>  hci_connect_sco+0x3e4/0xf50
>  sco_sock_connect+0x2c0/0x9c0
>  __sys_connect_file+0x153/0x1a0
>  __sys_connect+0x165/0x1a0
>  __x64_sys_connect+0x72/0xb0
>  do_syscall_64+0x39/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Freed by task 5990:
>  kasan_save_stack+0x22/0x40
>  kasan_set_track+0x25/0x30
>  kasan_save_free_info+0x2b/0x40
>  ____kasan_slab_free+0x120/0x180
>  __kmem_cache_free+0xcf/0x280
>  device_release+0xa3/0x240
>  kobject_put+0x175/0x270
>  put_device+0x1f/0x30
>  hci_conn_del+0x2df/0x860
>  hci_conn_unlink+0x25b/0x3e0
>  hci_conn_unlink+0x2ef/0x3e0
>  hci_conn_hash_flush+0x18d/0x230
>  hci_dev_close_sync+0x5c2/0x1060
>  hci_unregister_dev+0x1ce/0x4a0
>  vhci_release+0x80/0xf0
>  __fput+0x27c/0xa90
>  task_work_run+0x168/0x260
>  do_exit+0xbd9/0x2b20
>  do_group_exit+0xd4/0x2a0
>  __x64_sys_exit_group+0x3e/0x50
>  do_syscall_64+0x39/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Last potentially related work creation:
>  kasan_save_stack+0x22/0x40
>  __kasan_record_aux_stack+0x60/0x70
>  insert_work+0x48/0x360
>  __queue_work+0x5bc/0xfe0
>  __queue_delayed_work+0x1c8/0x270
>  queue_delayed_work_on+0x162/0x1c0
>  sco_chan_del+0x1db/0x430
>  __sco_sock_close+0x11f/0x640
>  sco_sock_release+0x9f/0x2d0
>  __sock_release+0xcd/0x290
>  sock_close+0x1c/0x20
>  __fput+0x27c/0xa90
>  task_work_run+0x168/0x260
>  get_signal+0x1cb/0x2460
>  arch_do_signal_or_restart+0x79/0x5a0
>  exit_to_user_mode_prepare+0x128/0x1e0
>  syscall_exit_to_user_mode+0x1a/0x40
>  do_syscall_64+0x46/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff8880780da000
>  which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 0 bytes inside of
>  freed 4096-byte region [ffff8880780da000, ffff8880780db000)
>
> The buggy address belongs to the physical page:
> page:00000000fca63b13 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x780da
> head:00000000fca63b13 order:1 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
> flags: 0xfffe0000010200(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x3fff)
> page_type: 0x1()
> raw: 00fffe0000010200 ffff888100040900 ffffea000438c110 ffffea0001323210
> raw: 0000000000000000 ffff8880780da000 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8880780d9f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff8880780d9f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >ffff8880780da000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff8880780da080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880780da100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> general protection fault, probably for non-canonical address 0xe0b5dc4c80=
0002ec: 0000 [#1] PREEMPT SMP KASAN
> KASAN: maybe wild-memory-access in range [0x05af026400001760-0x05af026400=
001767]
> CPU: 3 PID: 5990 Comm: syz-executor.7 Tainted: G    B              6.3.0-=
next-20230426 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:__list_del_entry_valid+0x91/0x1b0
> Code: de 48 39 c2 0f 84 80 00 00 00 48 b8 22 01 00 00 00 00 ad de 48 39 c=
1 74 7f 48 b8 00 00 00 00 00 fc ff df 48 89 cf 48 c1 ef 03 <80> 3c 07 00 0f=
 85 e7 00 00 00 4c 8b 01 49 39 f0 75 6d 48 8d 7a 08
> RSP: 0018:ffffc9000d81fae0 EFLAGS: 00010213
> RAX: dffffc0000000000 RBX: ffff8880780da000 RCX: 05af026400001766
> RDX: ffff888046d06800 RSI: ffff8880780da000 RDI: 00b5e04c800002ec
> RBP: ffff8880780da260 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff88e0008b R12: ffff8880780da008
> R13: ffff8880780da260 R14: dffffc0000000000 R15: ffff88805f51c000
> FS:  0000000000000000(0000) GS:ffff88811a180000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055d74eb5c6a0 CR3: 000000010e5b2000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  hci_conn_cleanup+0x15d/0x7e0
>  hci_conn_del+0x2df/0x860
>  hci_conn_hash_flush+0x195/0x230
>  hci_dev_close_sync+0x5c2/0x1060
>  hci_unregister_dev+0x1ce/0x4a0
>  vhci_release+0x80/0xf0
>  __fput+0x27c/0xa90
>  task_work_run+0x168/0x260
>  do_exit+0xbd9/0x2b20
>  do_group_exit+0xd4/0x2a0
>  __x64_sys_exit_group+0x3e/0x50
>  do_syscall_64+0x39/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7ff463e8edcd
> Code: Unable to access opcode bytes at 0x7ff463e8eda3.
> RSP: 002b:00007ffde1873c18 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00007ffde1874480 RCX: 00007ff463e8edcd
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000043
> RBP: 0000000000000003 R08: 0000000000000026 R09: 00007ffde1874480
> R10: 0000000000000026 R11: 0000000000000202 R12: 0000000000000000
> R13: 00007ff463eeba70 R14: 0000000000000002 R15: 00007ffde18744c0
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__list_del_entry_valid+0x91/0x1b0
> Code: de 48 39 c2 0f 84 80 00 00 00 48 b8 22 01 00 00 00 00 ad de 48 39 c=
1 74 7f 48 b8 00 00 00 00 00 fc ff df 48 89 cf 48 c1 ef 03 <80> 3c 07 00 0f=
 85 e7 00 00 00 4c 8b 01 49 39 f0 75 6d 48 8d 7a 08
> RSP: 0018:ffffc9000d81fae0 EFLAGS: 00010213
> RAX: dffffc0000000000 RBX: ffff8880780da000 RCX: 05af026400001766
> RDX: ffff888046d06800 RSI: ffff8880780da000 RDI: 00b5e04c800002ec
> RBP: ffff8880780da260 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff88e0008b R12: ffff8880780da008
> R13: ffff8880780da260 R14: dffffc0000000000 R15: ffff88805f51c000
> FS:  0000000000000000(0000) GS:ffff88811a180000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055d74eb5c6a0 CR3: 000000010e5b2000 CR4: 0000000000350ee0
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0:   48 39 c2                cmp    %rax,%rdx
>    3:   0f 84 80 00 00 00       je     0x89
>    9:   48 b8 22 01 00 00 00    movabs $0xdead000000000122,%rax
>   10:   00 ad de
>   13:   48 39 c1                cmp    %rax,%rcx
>   16:   74 7f                   je     0x97
>   18:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   1f:   fc ff df
>   22:   48 89 cf                mov    %rcx,%rdi
>   25:   48 c1 ef 03             shr    $0x3,%rdi
> * 29:   80 3c 07 00             cmpb   $0x0,(%rdi,%rax,1) <-- trapping in=
struction
>   2d:   0f 85 e7 00 00 00       jne    0x11a
>   33:   4c 8b 01                mov    (%rcx),%r8
>   36:   49 39 f0                cmp    %rsi,%r8
>   39:   75 6d                   jne    0xa8
>   3b:   48 8d 7a 08             lea    0x8(%rdx),%rdi

Are you guys checking if these bugs have not been fixed already, for
example this one I suspect has been fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Da2ac591cb4d83e1f2d4b4adb3c14b2c79764650a

--=20
Luiz Augusto von Dentz
