Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B27FD387
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjK2KFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjK2KEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:04:52 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23375D66
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:04:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so10576a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701252296; x=1701857096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swaxqzVnWqGyjLOql3dgeNSaHkk6fmtsxd2+zTz+o1c=;
        b=v0NC3kFYhY6bVlFHmjQiDDENAPtu4DcqDCQ4dXjXIOjFpPDBQiGwe5XXQJCA13qqi+
         Ajmbfw5z42UnzueQs6xCGYOAqB0GiJDa89NJhgPLX39LHRv3BhONKfb6nv6maZUAfy2c
         QocDAmVc+OXkKJ6PurTXj1OkvVWUA1MEnYKKDoyavpqrGVNswSFeoQ2BOqaE+H5yLitM
         f6WGPjXlmWZJPvhUpTo9dpMaBmAFW/JVCnNtieaNFUrJJ1GdsW8awZoSvx+IdbZCidUz
         IJi1DLeuE81ypEnn2qiCLlxdZwQJBSllzzJWgwctFyzJ9Z6UiTXuSD97DzNsw6i7WmNB
         Aj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252296; x=1701857096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swaxqzVnWqGyjLOql3dgeNSaHkk6fmtsxd2+zTz+o1c=;
        b=s4BjQYoSQjgZ22BBO5fce3VHWJf3TzyXNXfQgiN1wrx45bxYgxc566mWuxfYBKwT5m
         6iMGokCssiSJHykdU59suM2VCDiF+06GfcehBIUYYjIO5IrYd999wvfzjn2GxzUf55a5
         jPWwPiY+UTSQ5NXwzVYU7KD9wDddSmZUTTCV2dxSlWmoWoeyzLk4FV5uPwtSnjEDeriq
         nuSEG7x0mNJHkZD/yeOMkZKjy4nXExqYpFCafDTdxl15s4gwIcxE7fYhaqmXgX+tUfUm
         pyMW2Oqe7QJzun52i89Xt36NKmJWljgSMHdZvu28BkiXXui19PkdlIx7/m6bTJv6JgM8
         4cjw==
X-Gm-Message-State: AOJu0YzKFze4m0QBX1cz71ubeNF/q1Y+2oztP+9wj2AaMkyaiW9YyCFa
        F5JpvNqgk3F1TFbtmzv8gQjDf+n1EJK5bTj5LrvgvQ==
X-Google-Smtp-Source: AGHT+IHLAAeS0RulPxNYAbgsuX91KIaF2yspSDeHUqste1rIxKou+4LDgbXikNvgACEQ8phetg3Jfo/i5RFnXegISr8=
X-Received: by 2002:a05:6402:2215:b0:54b:81ba:93b2 with SMTP id
 cq21-20020a056402221500b0054b81ba93b2mr401323edb.2.1701252296304; Wed, 29 Nov
 2023 02:04:56 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001fc0bf060b479b58@google.com>
In-Reply-To: <0000000000001fc0bf060b479b58@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 Nov 2023 11:04:42 +0100
Message-ID: <CANn89iJveDLca46gC8ND8Ym6Le1FUr0mPzAAYDh_6-1N5uEj6A@mail.gmail.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in ipgre_xmit
To:     syzbot <syzbot+2cb7b1bd08dc77ae7f89@syzkaller.appspotmail.com>,
        Shigeru Yoshida <syoshida@redhat.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 11:00=E2=80=AFAM syzbot
<syzbot+2cb7b1bd08dc77ae7f89@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    18d46e76d7c2 Merge tag 'for-6.7-rc3-tag' of git://git.ker=
n..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1412e7e8e8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df711bc2a7eb1d=
b25
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2cb7b1bd08dc77a=
e7f89
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cb96093de792/dis=
k-18d46e76.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/630ca4e2d778/vmlinu=
x-18d46e76.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/65573a727973/b=
zImage-18d46e76.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+2cb7b1bd08dc77ae7f89@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> BUG: KMSAN: uninit-value in ipgre_xmit+0xdc2/0xe20 net/ipv4/ip_gre.c:662
>  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
>  ipgre_xmit+0xdc2/0xe20 net/ipv4/ip_gre.c:662
>  __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4954 [inline]
>  xmit_one net/core/dev.c:3545 [inline]
>  dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3561
>  __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4346
>  dev_queue_xmit include/linux/netdevice.h:3134 [inline]
>  __bpf_tx_skb net/core/filter.c:2133 [inline]
>  __bpf_redirect_no_mac net/core/filter.c:2163 [inline]
>  __bpf_redirect+0xdd7/0x1600 net/core/filter.c:2186
>  ____bpf_clone_redirect net/core/filter.c:2457 [inline]
>  bpf_clone_redirect+0x328/0x470 net/core/filter.c:2429
>  ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1958
>  __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2199
>  bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
>  __bpf_prog_run include/linux/filter.h:651 [inline]
>  bpf_prog_run include/linux/filter.h:658 [inline]
>  bpf_test_run+0x482/0xb00 net/bpf/test_run.c:423
>  bpf_prog_test_run_skb+0x14e5/0x1f20 net/bpf/test_run.c:1045
>  bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4040
>  __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5401
>  __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
>  __ia32_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5485
>  do_syscall_32_irqs_on arch/x86/entry/common.c:164 [inline]
>  __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:230
>  do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:255
>  do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:293
>  entry_SYSENTER_compat_after_hwframe+0x70/0x7a
>
> Uninit was created at:
>  slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
>  slab_alloc_node mm/slub.c:3478 [inline]
>  kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
>  pskb_expand_head+0x226/0x1a00 net/core/skbuff.c:2098
>  skb_ensure_writable+0x3d3/0x460 net/core/skbuff.c:5958
>  __bpf_try_make_writable net/core/filter.c:1662 [inline]
>  bpf_try_make_writable net/core/filter.c:1668 [inline]
>  bpf_try_make_head_writable net/core/filter.c:1676 [inline]
>  ____bpf_clone_redirect net/core/filter.c:2451 [inline]
>  bpf_clone_redirect+0x17f/0x470 net/core/filter.c:2429
>  ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1958
>  __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2199
>  bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
>  __bpf_prog_run include/linux/filter.h:651 [inline]
>  bpf_prog_run include/linux/filter.h:658 [inline]
>  bpf_test_run+0x482/0xb00 net/bpf/test_run.c:423
>  bpf_prog_test_run_skb+0x14e5/0x1f20 net/bpf/test_run.c:1045
>  bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4040
>  __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5401
>  __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
>  __ia32_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5485
>  do_syscall_32_irqs_on arch/x86/entry/common.c:164 [inline]
>  __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:230
>  do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:255
>  do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:293
>  entry_SYSENTER_compat_after_hwframe+0x70/0x7a
>
> CPU: 1 PID: 8859 Comm: syz-executor.2 Not tainted 6.7.0-rc3-syzkaller-000=
24-g18d46e76d7c2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/10/2023
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

Fix under discussion would be:

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 22a26d1d29a09d234f18ce3b0f329e5047c0c046..5169c3c72cffe49cef613e69889=
d139db867ff74
100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -635,15 +635,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
        }

        if (dev->header_ops) {
+               int pull_len =3D tunnel->hlen + sizeof(struct iphdr);
+
                if (skb_cow_head(skb, 0))
                        goto free_skb;

                tnl_params =3D (const struct iphdr *)skb->data;

-               /* Pull skb since ip_tunnel_xmit() needs skb->data pointing
-                * to gre header.
-                */
-               skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
+               if (!pskb_network_may_pull(skb, pull_len))
+                       goto free_skb;
+
+               /* ip_tunnel_xmit() needs skb->data pointing to gre header.=
 */
+               skb_pull(skb, pull_len);
                skb_reset_mac_header(skb);

                if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
