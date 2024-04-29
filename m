Return-Path: <linux-kernel+bounces-162560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A858B5D92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DC4B26D35
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879E84E00;
	Mon, 29 Apr 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDm2bpgg"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13D84D2A;
	Mon, 29 Apr 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403745; cv=none; b=VT4vT+SEAp++bDCuRPAd+m5YNkUkWg+F+RZv2EEbtOTRCyWfZviiwsoSuXwNn5NS6d6nOHy59lqYPMmO4Ohq5hhuKOWXwC0IKJ/MXgKV7ehGnFihPmtXgmGSpbzxzszWTlXCdZpxL39c1pkH7XewDLhH4S1L2qKWwmabtsZGkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403745; c=relaxed/simple;
	bh=x78mlTOSNCeKuhBeSLrp8lTJqci7URpsTUsfLD+c7bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoYSWQY5P8y4lns5zktlK98vyIjlwDeUDvZfh6c4y2wfbiAkuh4zZE7UsKq4EAXCmOnM3onnswq2lqRbj+Uk6/zlIZ+CdnQPMjbRFiziMbbb4v8HG9cYqhFub123LGIEOdvA/v75HKMOlvi5vGyQg18ii20zmxuEoA7WkubforQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDm2bpgg; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dd041acff1so52798391fa.1;
        Mon, 29 Apr 2024 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714403742; x=1715008542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UWb+wjXyFhA+z+YN1Lsjts+67pUWWgwlP3uOwoNAkY=;
        b=aDm2bpggUeiGc3GEcf06EnmVB/EnQNwWzeHAcXmvYCEetC5QP3dnFhUM/ElKUTvUtk
         HXmmrQMiK4lpygpBP8Ugx/f2nAGZWV8yVgJ7EaEwmGVNPoDxL0Rdwtl5O8yk6we4BTSW
         SingdCnH9wfYZ97yxm0lL8DLCy2HWceuHpZEXxoTgjT/xX15WZGNTKiGC4opCnGkvOGD
         xpTv8dAdGMdTHT1CSc6WyZh/C6C0RBTEXIpqXBOXvCQcA5oOVWrl2U43tKGOUcEIqAWT
         8BTuz5B34yQUJPrvako9nKezq2R+jUwWCSYZ8f8wiEs2ePrVqhNL+2hw5YdG1/NS9wXP
         kE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403742; x=1715008542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UWb+wjXyFhA+z+YN1Lsjts+67pUWWgwlP3uOwoNAkY=;
        b=Fo33UI0fZjvoSD4g1HjdYGTJko/OSGotzUUek62DOq5TdXKHGecGMkariEJwz8Dbpw
         CrDQDfXCVPnI7XfWfICpM3NYhFu3qJ5CiGNbaNpcp+FkodnLova2uOHUaW0opxjVlZC0
         mnMs25XuZxkIgDWdG36vn7PmbrDZELEzCWf0C5SHENoFhYjk37fs0qKVNH9zsPiF9V5J
         Aan/4vJN4RwRGfbJscuCsrSlsTzLUmN97RLpZhtadndO7a/CU3si48tjGvsGBnwj7vjr
         KPEwVY73Z3NVbBltO7D6QTdDpO9/04C5UT/8yvV75OuyNncAjYbLWbcM784B80vcuQ01
         DcUg==
X-Forwarded-Encrypted: i=1; AJvYcCUYWbyJYkjULzsgn9TQt+me3NZyCwwmuofsR1FmZcXcozKMmmIZVWtfpvz9v/RfNCEL5ulDlVIpQlt0fzQfU5xLBU6DclEr5dYoobHn/uCsLrrdCV2db2PFRYcilSwa+N0bqMZbsvLEtUEBXjOo
X-Gm-Message-State: AOJu0YwJJtv2kjwem2XjwdBU2uJg2brO+JaKFpNUDpOqwQmyN9oeDpnN
	1Vy0bmdzCjYJFkXKXef9nG59CJEwUUVc/GdxRTBjmp7iMkJgP3dfavXQZF0wBQp/KEMFuNygMb0
	zdKnsa6kbLMFdi3NowXc7W6slUqOjlg==
X-Google-Smtp-Source: AGHT+IF06A4f1GlmDffVTuIeToSJZQBy3Y+dnpJ5qD62Jmrsw/hDK8txoOny0lpB+VnAmUWyLNNRX2q/DhI+yjefJsI=
X-Received: by 2002:a2e:9c12:0:b0:2e0:3c3f:1d38 with SMTP id
 s18-20020a2e9c12000000b002e03c3f1d38mr2576578lji.30.1714403741655; Mon, 29
 Apr 2024 08:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428054307.1178347-1-iam@sung-woo.kim>
In-Reply-To: <20240428054307.1178347-1-iam@sung-woo.kim>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Apr 2024 11:15:29 -0400
Message-ID: <CABBYNZKDouOrxG1XcSq2me0WW3A3yAbfdtonw2XJ54VZ8+Nbfg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sungwoo,

On Sun, Apr 28, 2024 at 1:43=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wrot=
e:
>
> Hello, could you review this bug and its patch?
>
> l2cap_le_flowctl_init() can cause both div-by-zero and an integer overflo=
w.
>
> l2cap_le_flowctl_init()
>   chan->mps =3D min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
>   chan->rx_credits =3D (chan->imtu / chan->mps) + 1;  <- div-by-zero
>
> Here, mtu could be less than or equal to L2CAP_HDR_SIZE (4). If mtu is 4,=
 it
> causes div-by-zero. If mtu is less than 4, it causes an integer overflow.

That is because it is not valid to have hdev->le_mtu < 0x001b (the
range is 0x001b to 0xffff), so we should really look into checking
that conn->mtu is actually valid.

> How mtu could have such low value:
>
> hci_cc_le_read_buffer_size()
>   hdev->le_mtu =3D __le16_to_cpu(rp->le_mtu);
>
> l2cap_conn_add()
>   conn->mtu =3D hcon->hdev->le_mtu;

Yeah this assignment is incorrect and in fact we don't do that if
le_mtu is zero so we probably should do some checks e.g. le_mtu >
0x001a, or perhaps we need to move the MTU directly to hci_conn so it
can check there are enough buffers to serve the link so we stop the
connection procedure earlier.

> As shown, mtu is an input from an HCI device. So, any HCI device can
> set mtu value to any value, such as lower than 4.
>
> To fix this, this patch adds a validation before subtractions. If MTU is
> too small, the corresponding value will set by 0, and a warning message
> will show up.
>
> However, I'm not sure that 0-ing the value is the best. It'd be great if
> you could comment on this.
>
> Thank you,
> Sungwoo.
>
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 PID: 67 Comm: kworker/u5:0 Tainted: G        W          6.9.0-rc5+=
 #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Workqueue: hci0 hci_rx_work
> RIP: 0010:l2cap_le_flowctl_init+0x19e/0x3f0 net/bluetooth/l2cap_core.c:54=
7
> Code: e8 17 17 0c 00 66 41 89 9f 84 00 00 00 bf 01 00 00 00 41 b8 02 00 0=
0 00 4c 89 fe 4c 89 e2 89 d9 e8 27 17 0c 00 44 89 f0 31 d2 <66> f7 f3 89 c3=
 ff c3 4d 8d b7 88 00 00 00 4c 89 f0 48 c1 e8 03 42
> RSP: 0018:ffff88810bc0f858 EFLAGS: 00010246
> RAX: 00000000000002a0 RBX: 0000000000000000 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: ffff88810bc0f7c0 RDI: ffffc90002dcb66f
> RBP: ffff88810bc0f880 R08: aa69db2dda70ff01 R09: 0000ffaaaaaaaaaa
> R10: 0084000000ffaaaa R11: 0000000000000000 R12: ffff88810d65a084
> R13: dffffc0000000000 R14: 00000000000002a0 R15: ffff88810d65a000
> FS:  0000000000000000(0000) GS:ffff88811ac00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000100 CR3: 0000000103268003 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  l2cap_le_connect_req net/bluetooth/l2cap_core.c:4902 [inline]
>  l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:5420 [inline]
>  l2cap_le_sig_channel net/bluetooth/l2cap_core.c:5486 [inline]
>  l2cap_recv_frame+0xe59d/0x11710 net/bluetooth/l2cap_core.c:6809
>  l2cap_recv_acldata+0x544/0x10a0 net/bluetooth/l2cap_core.c:7506
>  hci_acldata_packet net/bluetooth/hci_core.c:3939 [inline]
>  hci_rx_work+0x5e5/0xb20 net/bluetooth/hci_core.c:4176
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0x90f/0x1530 kernel/workqueue.c:3335
>  worker_thread+0x926/0xe70 kernel/workqueue.c:3416
>  kthread+0x2e3/0x380 kernel/kthread.c:388
>  ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>  net/bluetooth/l2cap_core.c | 94 +++++++++++++++++++++++++++++---------
>  1 file changed, 73 insertions(+), 21 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 84fc70862..472ddfb2e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -541,10 +541,17 @@ static void l2cap_le_flowctl_init(struct l2cap_chan=
 *chan, u16 tx_credits)
>         chan->sdu_last_frag =3D NULL;
>         chan->sdu_len =3D 0;
>         chan->tx_credits =3D tx_credits;
> -       /* Derive MPS from connection MTU to stop HCI fragmentation */
> -       chan->mps =3D min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_=
SIZE);
> -       /* Give enough credits for a full packet */
> -       chan->rx_credits =3D (chan->imtu / chan->mps) + 1;
> +
> +       if (chan->conn->mtu < L2CAP_HDR_SIZE) {
> +               BT_WARN("mtu is too small (mtu %d < %d)", chan->conn->mtu=
, L2CAP_HDR_SIZE);
> +               chan->mps =3D 0;
> +               chan->rx_credits =3D 0;
> +       } else {
> +               /* Derive MPS from connection MTU to stop HCI fragmentati=
on */
> +               chan->mps =3D min_t(u16, chan->imtu, chan->conn->mtu - L2=
CAP_HDR_SIZE);
> +               /* Give enough credits for a full packet */
> +               chan->rx_credits =3D (chan->imtu / chan->mps) + 1;
> +       }
>
>         skb_queue_head_init(&chan->tx_q);
>  }
> @@ -2222,7 +2229,12 @@ static struct sk_buff *l2cap_create_connless_pdu(s=
truct l2cap_chan *chan,
>         BT_DBG("chan %p psm 0x%2.2x len %zu", chan,
>                __le16_to_cpu(chan->psm), len);
>
> -       count =3D min_t(unsigned int, (conn->mtu - hlen), len);
> +       if (conn->mtu < hlen) {
> +               count =3D 0;
> +               BT_WARN("mtu is too small (mtu %d < len %d)", conn->mtu, =
hlen);
> +       } else {
> +               count =3D min_t(unsigned int, (conn->mtu - hlen), len);
> +       }
>
>         skb =3D chan->ops->alloc_skb(chan, hlen, count,
>                                    msg->msg_flags & MSG_DONTWAIT);
> @@ -2253,7 +2265,12 @@ static struct sk_buff *l2cap_create_basic_pdu(stru=
ct l2cap_chan *chan,
>
>         BT_DBG("chan %p len %zu", chan, len);
>
> -       count =3D min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
> +       if (conn->mtu < L2CAP_HDR_SIZE) {
> +               BT_WARN("mtu is too small (mtu %d < %d)", conn->mtu, L2CA=
P_HDR_SIZE);
> +               count =3D 0;
> +       } else {
> +               count =3D min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE=
), len);
> +       }
>
>         skb =3D chan->ops->alloc_skb(chan, L2CAP_HDR_SIZE, count,
>                                    msg->msg_flags & MSG_DONTWAIT);
> @@ -2295,7 +2312,12 @@ static struct sk_buff *l2cap_create_iframe_pdu(str=
uct l2cap_chan *chan,
>         if (chan->fcs =3D=3D L2CAP_FCS_CRC16)
>                 hlen +=3D L2CAP_FCS_SIZE;
>
> -       count =3D min_t(unsigned int, (conn->mtu - hlen), len);
> +       if (conn->mtu < hlen) {
> +               BT_WARN("mtu is too small (mtu %d < len %d)", conn->mtu, =
hlen);
> +               count =3D 0;
> +       } else {
> +               count =3D min_t(unsigned int, (conn->mtu - hlen), len);
> +       }
>
>         skb =3D chan->ops->alloc_skb(chan, hlen, count,
>                                    msg->msg_flags & MSG_DONTWAIT);
> @@ -2412,7 +2434,12 @@ static struct sk_buff *l2cap_create_le_flowctl_pdu=
(struct l2cap_chan *chan,
>         if (sdulen)
>                 hlen +=3D L2CAP_SDULEN_SIZE;
>
> -       count =3D min_t(unsigned int, (conn->mtu - hlen), len);
> +       if (conn->mtu < hlen) {
> +               BT_WARN("mtu is too small (mtu %d < len %d)", conn->mtu, =
hlen);
> +               count =3D 0;
> +       } else {
> +               count =3D min_t(unsigned int, (conn->mtu - hlen), len);
> +       }
>
>         skb =3D chan->ops->alloc_skb(chan, hlen, count,
>                                    msg->msg_flags & MSG_DONTWAIT);
> @@ -3225,6 +3252,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *=
chan, void *data, size_t data
>         void *ptr =3D req->data;
>         void *endptr =3D data + data_size;
>         u16 size;
> +       int hlen;
>
>         BT_DBG("chan %p", chan);
>
> @@ -3275,14 +3303,19 @@ static int l2cap_build_conf_req(struct l2cap_chan=
 *chan, void *data, size_t data
>                 break;
>
>         case L2CAP_MODE_ERTM:
> +               hlen =3D L2CAP_EXT_HDR_SIZE + L2CAP_SDULEN_SIZE + L2CAP_F=
CS_SIZE;
>                 rfc.mode            =3D L2CAP_MODE_ERTM;
>                 rfc.max_transmit    =3D chan->max_tx;
>
>                 __l2cap_set_ertm_timeouts(chan, &rfc);
>
> -               size =3D min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, chan->con=
n->mtu -
> -                            L2CAP_EXT_HDR_SIZE - L2CAP_SDULEN_SIZE -
> -                            L2CAP_FCS_SIZE);
> +               if (chan->conn->mtu < hlen) {
> +                       BT_WARN("mtu is too small (mtu %d < len %d)", cha=
n->conn->mtu, hlen);
> +                       size =3D 0;
> +               } else {
> +                       size =3D min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, c=
han->conn->mtu - hlen);
> +               }
> +
>                 rfc.max_pdu_size =3D cpu_to_le16(size);
>
>                 l2cap_txwin_setup(chan);
> @@ -3310,6 +3343,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *=
chan, void *data, size_t data
>                 break;
>
>         case L2CAP_MODE_STREAMING:
> +               hlen =3D L2CAP_EXT_HDR_SIZE + L2CAP_SDULEN_SIZE + L2CAP_F=
CS_SIZE;
>                 l2cap_txwin_setup(chan);
>                 rfc.mode            =3D L2CAP_MODE_STREAMING;
>                 rfc.txwin_size      =3D 0;
> @@ -3317,9 +3351,12 @@ static int l2cap_build_conf_req(struct l2cap_chan =
*chan, void *data, size_t data
>                 rfc.retrans_timeout =3D 0;
>                 rfc.monitor_timeout =3D 0;
>
> -               size =3D min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, chan->con=
n->mtu -
> -                            L2CAP_EXT_HDR_SIZE - L2CAP_SDULEN_SIZE -
> -                            L2CAP_FCS_SIZE);
> +               if (chan->conn->mtu < hlen) {
> +                       BT_WARN("mtu is too small (mtu %d < len %d)", cha=
n->conn->mtu, hlen);
> +                       size =3D 0;
> +               } else {
> +                       size =3D min_t(u16, L2CAP_DEFAULT_MAX_PDU_SIZE, c=
han->conn->mtu - hlen);
> +               }
>                 rfc.max_pdu_size =3D cpu_to_le16(size);
>
>                 l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> @@ -3351,7 +3388,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *=
chan, void *data, size_t data
>         void *endptr =3D data + data_size;
>         void *req =3D chan->conf_req;
>         int len =3D chan->conf_len;
> -       int type, hint, olen;
> +       int type, hint, olen, hlen;
>         unsigned long val;
>         struct l2cap_conf_rfc rfc =3D { .mode =3D L2CAP_MODE_BASIC };
>         struct l2cap_conf_efs efs;
> @@ -3496,6 +3533,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *=
chan, void *data, size_t data
>                         break;
>
>                 case L2CAP_MODE_ERTM:
> +                       hlen =3D L2CAP_EXT_HDR_SIZE + L2CAP_SDULEN_SIZE +=
 L2CAP_FCS_SIZE;
>                         if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
>                                 chan->remote_tx_win =3D rfc.txwin_size;
>                         else
> @@ -3503,9 +3541,15 @@ static int l2cap_parse_conf_req(struct l2cap_chan =
*chan, void *data, size_t data
>
>                         chan->remote_max_tx =3D rfc.max_transmit;
>
> -                       size =3D min_t(u16, le16_to_cpu(rfc.max_pdu_size)=
,
> -                                    chan->conn->mtu - L2CAP_EXT_HDR_SIZE=
 -
> -                                    L2CAP_SDULEN_SIZE - L2CAP_FCS_SIZE);
> +                       if (chan->conn->mtu < hlen) {
> +                               BT_WARN("mtu is too small (mtu %d < len %=
d)",
> +                                       chan->conn->mtu, hlen);
> +                               size =3D 0;
> +                       } else {
> +                               size =3D min_t(u16, le16_to_cpu(rfc.max_p=
du_size),
> +                                            chan->conn->mtu - hlen);
> +                       }
> +
>                         rfc.max_pdu_size =3D cpu_to_le16(size);
>                         chan->remote_mps =3D size;
>
> @@ -3534,9 +3578,17 @@ static int l2cap_parse_conf_req(struct l2cap_chan =
*chan, void *data, size_t data
>                         break;
>
>                 case L2CAP_MODE_STREAMING:
> -                       size =3D min_t(u16, le16_to_cpu(rfc.max_pdu_size)=
,
> -                                    chan->conn->mtu - L2CAP_EXT_HDR_SIZE=
 -
> -                                    L2CAP_SDULEN_SIZE - L2CAP_FCS_SIZE);
> +                       hlen =3D L2CAP_EXT_HDR_SIZE + L2CAP_SDULEN_SIZE +=
 L2CAP_FCS_SIZE;
> +
> +                       if (chan->conn->mtu < hlen) {
> +                               BT_WARN("mtu is too small (mtu %d < len %=
d)",
> +                                       chan->conn->mtu, hlen);
> +                               size =3D 0;
> +                       } else {
> +                               size =3D min_t(u16, le16_to_cpu(rfc.max_p=
du_size),
> +                                            chan->conn->mtu - hlen);
> +                       }
> +
>                         rfc.max_pdu_size =3D cpu_to_le16(size);
>                         chan->remote_mps =3D size;
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

