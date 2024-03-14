Return-Path: <linux-kernel+bounces-103364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A290187BE95
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46E61C22115
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29F70CCF;
	Thu, 14 Mar 2024 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqEtNZJk"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33A70CBE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425362; cv=none; b=regtN9vHblFtBIQif7Lv3Nv0lzLAlCB+aWp5J2ZATmHUKkje83or4eYmdhG2CvsWXeFyzwptGfMojEzOC7myhPQloW4APOZztXqF1iiAtUTkVyN1omDwWIEUyfRz3eaG4wN7ae2jV2DIHzI32FzuwKlT3BdT3D7I3UOVirB2+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425362; c=relaxed/simple;
	bh=y8brmKX45ZzZJPOYxXwPNDT83PMuCnG1y0vX9Gdz2Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZd1WnWbr29us8AM4Xlv2lBvFQvxqCee3X7bS2aL1Sc5x4YFHoW20VjcDUNYdcAuq9RuiCnNnuNfj8QaNVAKlN2+lXu+lUpiUrPTwhygSzgTdmKC1X1sXM3auf3KFx3B1LAW9Qdw2lB56q/xbsh1g2tELZLobj1WdjbUFN6ol5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqEtNZJk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5687ebddd8eso18161a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710425359; x=1711030159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S++Vf8oj18wvwMBuvc+mlbBQAzlNbzY5FSl7qh9lRe0=;
        b=DqEtNZJkp1/VllCbaJClU7QnKAuRCzVzodEVB5UW5DyJQAvLDmwYHT1lajwe++Y248
         lObbMYVac8ZpUJhPxR1TJsYn3yR3U9uHj4Rm7cq6sZpaUI60enCkL2ppkHZ914Lxm3nE
         TvFPxyChGU4EGQS56UGu5WxWfvI736u2oRs3SArZ99F709sTJLoyyf53D/CuURR6M77Z
         kV0t1LY4fLAVd0d86oiBQVzk9XvdDW68XDblt59nFCknK6mp/fnjhO6L92RB5G+JbBuf
         cyN1RA7Z6rjH4uGqzPo90XWVWVQ0ws0vHUU9krxz9Jf35mLh69ASmZlmpqM2UFzL5E+i
         SFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425359; x=1711030159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S++Vf8oj18wvwMBuvc+mlbBQAzlNbzY5FSl7qh9lRe0=;
        b=g1OhB0egSFlMKj1IqcZPAY7XkX6CJfh9NnAHC6TWCW8x+6VOjIW+nUQx+sxCTHMMgK
         d39hkqaHq0xjc6NXlBLTCag4M0x0iUD//sRUDB6V/PGYp00dr9o7tKrVaO1Y18z/Pca8
         6xXQrDHWd8t8jCjGp6CLyeZpfyx2wGLHp3lTNCOf6nlnIbA+VTyfU7Lc55n6FKdu0C+c
         RrLf/nrv0vPE43qoy3eBLwMaLm7hXPXBcVBpQR14zcRGpCSQJJxEAWiYz6BL7YWtQBWk
         MrQHBAdOBeurHbpWcBtTaTlrUos93U9CBBlmOTK8N8AwG3s8KR5kIwCQrfhVtaRSHRSQ
         3xfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUht4QGZjAdaj/7KCdi7yf2ZqqA4ryOqJ4tggQ+Zd8tk+r8vLWVStNey85Cuz9n1jPl49JrOfeFAkR590uy3bBwooiw+iFgO+Vsspsg
X-Gm-Message-State: AOJu0YydKl6iI0weJEgfZp6F6L+mLSFswOKgrBIYjY+gqp4IZK2fX0Z1
	d6F04ycX3aPOLbkXjUsjZh+Dzv83pJVdqqSsacvkrDSoiNvxNLmoWQLzXxRwEuicGFxthTdAFSN
	nCD2xHE4lhR2NKPKvHTLdmCfNqlREpl1M1S63
X-Google-Smtp-Source: AGHT+IH+se+0PsSWJE7nQhdmEzMtgt2vtyaI5+PFVgBg7GHI4NBbE+z+XhFAHu2Vr+EbOonNdUAtgVNJFjtrH1+MB10=
X-Received: by 2002:a05:6402:7d2:b0:568:9aca:8ae6 with SMTP id
 u18-20020a05640207d200b005689aca8ae6mr158286edy.4.1710425358794; Thu, 14 Mar
 2024 07:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000058907006139f66b4@google.com>
In-Reply-To: <00000000000058907006139f66b4@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Mar 2024 15:09:05 +0100
Message-ID: <CANn89i+Z7MfbkBLOv=p7KZ7=K1rKHO4P1OL5LYDCtBiyqsa9oQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] KCSAN: data-race in dev_queue_xmit_nit / packet_setsockopt
To: syzbot <syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 3:06=E2=80=AFPM syzbot
<syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://g=
i..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11e6a90118000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D943916f31352d=
d09
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc669c1136495a2e=
7c31f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6e7a2dd336dc/dis=
k-480e035f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8cb00a02987d/vmlinu=
x-480e035f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f325a1992de8/b=
zImage-480e035f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in dev_queue_xmit_nit / packet_setsockopt
>
> write to 0xffff888107804542 of 1 bytes by task 22618 on cpu 0:
>  packet_setsockopt+0xd83/0xfd0 net/packet/af_packet.c:4003
>  do_sock_setsockopt net/socket.c:2311 [inline]
>  __sys_setsockopt+0x1d8/0x250 net/socket.c:2334
>  __do_sys_setsockopt net/socket.c:2343 [inline]
>  __se_sys_setsockopt net/socket.c:2340 [inline]
>  __x64_sys_setsockopt+0x66/0x80 net/socket.c:2340
>  do_syscall_64+0xd3/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> read to 0xffff888107804542 of 1 bytes by task 27 on cpu 1:
>  dev_queue_xmit_nit+0x82/0x620 net/core/dev.c:2248
>  xmit_one net/core/dev.c:3527 [inline]
>  dev_hard_start_xmit+0xcc/0x3f0 net/core/dev.c:3547
>  __dev_queue_xmit+0xf24/0x1dd0 net/core/dev.c:4335
>  dev_queue_xmit include/linux/netdevice.h:3091 [inline]
>  batadv_send_skb_packet+0x264/0x300 net/batman-adv/send.c:108
>  batadv_send_broadcast_skb+0x24/0x30 net/batman-adv/send.c:127
>  batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
>  batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
>  batadv_iv_send_outstanding_bat_ogm_packet+0x3f0/0x4b0 net/batman-adv/bat=
_iv_ogm.c:1700
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0x465/0x990 kernel/workqueue.c:3335
>  worker_thread+0x526/0x730 kernel/workqueue.c:3416
>  kthread+0x1d1/0x210 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>
> value changed: 0x00 -> 0x01
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 27 Comm: kworker/u8:1 Tainted: G        W          6.8.0-syzk=
aller-08073-g480e035fc4c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
> Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

I will submit this fix soon:

diff --git a/net/core/dev.c b/net/core/dev.c
index 0766a245816bdf70f6609dc7b6d694ae81e7a9e5..722787c3275527f1652ec98623f=
61500ee753b45
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2245,7 +2245,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb,
struct net_device *dev)
        rcu_read_lock();
 again:
        list_for_each_entry_rcu(ptype, ptype_list, list) {
-               if (ptype->ignore_outgoing)
+               if (READ_ONCE(ptype->ignore_outgoing))
                        continue;

                /* Never send packets back to the socket
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 61270826b9ac73e66f9011c3230d4668f0bf7c77..7cfc7d301508fcead214fbdb4e9=
62b0553a17916
100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4000,7 +4000,7 @@ packet_setsockopt(struct socket *sock, int
level, int optname, sockptr_t optval,
                if (val < 0 || val > 1)
                        return -EINVAL;

-               po->prot_hook.ignore_outgoing =3D !!val;
+               WRITE_ONCE(po->prot_hook.ignore_outgoing, !!val);
                return 0;
        }
        case PACKET_TX_HAS_OFF:
@@ -4134,7 +4134,7 @@ static int packet_getsockopt(struct socket
*sock, int level, int optname,
                       0);
                break;
        case PACKET_IGNORE_OUTGOING:
-               val =3D po->prot_hook.ignore_outgoing;
+               val =3D READ_ONCE(po->prot_hook.ignore_outgoing);
                break;
        case PACKET_ROLLOVER_STATS:
                if (!po->rollover)

