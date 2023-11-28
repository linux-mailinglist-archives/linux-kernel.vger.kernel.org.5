Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74FA7FC28E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344798AbjK1QFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346465AbjK1QFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:05:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8B31BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:05:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so13326a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701187546; x=1701792346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2cTKWI7R55/iFDTqwsIaf+WXaI/iXMnBA7xP0H4r4c=;
        b=Q4QxmKQQScv5b0hhfI/va1tScKymbgrgyegc2SsNs7VornAnEHvlG68r/7Bpeqb3/y
         ogpjp2H/QyuOiw4Ngvn7oQ/T16oyl1PYVcAfNLtGktzjwioP6vXLaYW9/enfGcfByzIz
         D7lWKv8/hGJ98t5+05I3LfpyYJ7Lyv3wK4Mt/e3c1Scr3Q2vjxJrz3X2tv4RExdL25X4
         PzoaTAZNIHdbz9wmYLCPr/bMod/NFtZRfAkyK0sxZDeERFpinmdOynRfo/CVvDAArE67
         5N+IqLRsFToLEXR8sGMBhDRTo5Lq0wTYstiDISSLXWp5qDbSq3P5bfgSSPQPYPWUjJfZ
         fkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187546; x=1701792346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2cTKWI7R55/iFDTqwsIaf+WXaI/iXMnBA7xP0H4r4c=;
        b=VvJbUbibsNCGTYJ7C/i6X8tqySg0j47Ut/4F4gnQkAhvdfc/MBjsf4orI6346O0ipI
         sjeynQZgXRjjHxm7zbsHABVbkIj+zjCt3EXwpDxcc7/yda4q1pKzcAI+hPrTXWo6TuSt
         IsiLQwyipSL/kmiujXGnchaODASHNl44428cXNCv6pLwfzr2sXaWzkYPDL3Dh8wK27Y7
         nTzx4pp2Yz3zbR5G1RvSj+oDweVNQzbQTL1gbKdh8YZqD93r3kMKA9Ur5ATpPKoaVk+V
         FbP9Tnb/kY4h7OF0H6iYDbYVk9TIowJhIorLLIdHaurQ7YWymRlgZx4kPTTkhMX8V6eQ
         +n2g==
X-Gm-Message-State: AOJu0YxXOToBhO76yVN0p/idgxQdKElzLv5u7evdUttz2Iv1E/zTBQ3H
        XoH6AjjWzjWbUFESFrhbZ1zx5kyumSZvk9BxcZ60eg==
X-Google-Smtp-Source: AGHT+IHJKBbj/F5FKZ1D3ESO8Jmia2QT/9SbwyLr/znN2c+WFOVGeF/jMWhQjnH3nWm7VD5AHCIclaTm33tGIPxdiPY=
X-Received: by 2002:a05:6402:5515:b0:543:fb17:1a8 with SMTP id
 fi21-20020a056402551500b00543fb1701a8mr862055edb.3.1701187546023; Tue, 28 Nov
 2023 08:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20231126151652.372783-1-syoshida@redhat.com> <CANn89iKcstKYWoqUCXHO__7PfVRMFNnN5nRQVCTAADvFbcJRww@mail.gmail.com>
 <9daf8509e39cd20d9d806afdb425ad43af037f8d.camel@redhat.com>
In-Reply-To: <9daf8509e39cd20d9d806afdb425ad43af037f8d.camel@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 28 Nov 2023 17:05:34 +0100
Message-ID: <CANn89iKO-5nwPAUtOzqRfqLhK77kgQB7Ep33rwFM+hgNKARLEw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in ipgre_xmit()
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Shigeru Yoshida <syoshida@redhat.com>, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Nov 28, 2023 at 4:51=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2023-11-28 at 16:45 +0100, Eric Dumazet wrote:
> > On Sun, Nov 26, 2023 at 4:17=E2=80=AFPM Shigeru Yoshida <syoshida@redha=
t.com> wrote:
> > >
> > > In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() ret=
urns
> > > true. For example, applications can create a malformed packet that ca=
uses
> > > this problem with PF_PACKET.
> > >
> > > This patch fixes the problem by dropping skb and returning from the
> > > function if skb_pull() fails.
> > >
> > > Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> > > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > > ---
> > >  net/ipv4/ip_gre.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> > > index 22a26d1d29a0..95efa97cb84b 100644
> > > --- a/net/ipv4/ip_gre.c
> > > +++ b/net/ipv4/ip_gre.c
> > > @@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb=
,
> > >                 /* Pull skb since ip_tunnel_xmit() needs skb->data po=
inting
> > >                  * to gre header.
> > >                  */
> > > -               skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
> > > +               if (!skb_pull(skb, tunnel->hlen + sizeof(struct iphdr=
)))
> > > +                       goto free_skb;
> > >                 skb_reset_mac_header(skb);
> > >
> > >                 if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> > > --
> >
> >
> > I have syszbot reports with an actual repro for this one.
>
> Could you please share them? I could not find easily the reports in
> https://syzkaller.appspot.com/upstream

Stack trace looks like the following:

skbuff: skb_under_panic: text:ffffffff845f50a0 len:920 put:20
head:ffff888171931000 data:ffff888171930ff8 tail:0x390 end:0x680
dev:gre4
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:120 !
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12705 Comm: kworker/0:0 Not tainted
6.1.43-syzkaller-00022-g8f46c3493178 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 10/09/2023
Workqueue: mld mld_ifc_work
RIP: 0010:skb_panic net/core/skbuff.c:120 [inline]
RIP: 0010:skb_under_panic+0x14c/0x150 net/core/skbuff.c:130
Code: 60 98 da 85 48 c7 c6 05 6b 2f 86 48 8b 55 c0 8b 4d d4 44 8b 45
d0 4c 8b 4d c8 53 41 55 41 54 41 57 e8 fc db f4 00 48 83 c4 20 <0f> 0b
66 90 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 18 41
RSP: 0018:ffffc9000551f0a0 EFLAGS: 00010286
RAX: 0000000000000087 RBX: ffff888162226000 RCX: 98ecdd4da3f28000
RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000000
RBP: ffffc9000551f0e0 R08: ffffffff815a9ea5 R09: fffff52000aa3dad
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000390
R13: 0000000000000680 R14: dffffc0000000000 R15: ffff888171930ff8
FS: 0000000000000000(0000) GS:ffff8881f7000000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f421000 CR3: 000000010f5a3000 CR4: 00000000003506b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
skb_push+0xf3/0x120 net/core/skbuff.c:2181
iptunnel_xmit+0x2d0/0x940 net/ipv4/ip_tunnel_core.c:67
ip_tunnel_xmit+0x218f/0x2ae0 net/ipv4/ip_tunnel.c:813
__gre_xmit net/ipv4/ip_gre.c:469 [inline]
ipgre_xmit+0x7ac/0xaa0 net/ipv4/ip_gre.c:661
__netdev_start_xmit include/linux/netdevice.h:4908 [inline]
netdev_start_xmit include/linux/netdevice.h:4922 [inline]
xmit_one net/core/dev.c:3602 [inline]
dev_hard_start_xmit+0x1de/0x630 net/core/dev.c:3618
__dev_queue_xmit+0x18c0/0x3700 net/core/dev.c:4268
dev_queue_xmit include/linux/netdevice.h:3076 [inline]
neigh_direct_output+0x17/0x20 net/core/neighbour.c:1592
neigh_output include/net/neighbour.h:552 [inline]
ip6_finish_output2+0x104a/0x1820 net/ipv6/ip6_output.c:134
__ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
ip6_finish_output+0x5d9/0xb60 net/ipv6/ip6_output.c:206
NF_HOOK_COND include/linux/netfilter.h:294 [inline]
ip6_output+0x1f7/0x4d0 net/ipv6/ip6_output.c:227
dst_output include/net/dst.h:444 [inline]
NF_HOOK include/linux/netfilter.h:305 [inline]
mld_sendpack+0x803/0xe40 net/ipv6/mcast.c:1820
mld_send_cr net/ipv6/mcast.c:2121 [inline]
mld_ifc_work+0x7dc/0xba0 net/ipv6/mcast.c:2653
process_one_work+0x73d/0xcb0 kernel/workqueue.c:2299
worker_thread+0xa60/0x1260 kernel/workqueue.c:2446
kthread+0x26d/0x300 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic net/core/skbuff.c:120 [inline]
RIP: 0010:skb_under_panic+0x14c/0x150 net/core/skbuff.c:130
Code: 60 98 da 85 48 c7 c6 05 6b 2f 86 48 8b 55 c0 8b 4d d4 44 8b 45
d0 4c 8b 4d c8 53 41 55 41 54 41 57 e8 fc db f4 00 48 83 c4 20 <0f> 0b
66 90 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 18 41
RSP: 0018:ffffc9000551f0a0 EFLAGS: 00010286
RAX: 0000000000000087 RBX: ffff888162226000 RCX: 98ecdd4da3f28000
RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000000
RBP: ffffc9000551f0e0 R08: ffffffff815a9ea5 R09: fffff52000aa3dad
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000390
R13: 0000000000000680 R14: dffffc0000000000 R15: ffff888171930ff8
FS: 0000000000000000(0000) GS:ffff8881f7000000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f421000 CR3: 000000010f5a3000 CR4: 00000000003506b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
