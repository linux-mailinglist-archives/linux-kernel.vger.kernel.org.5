Return-Path: <linux-kernel+bounces-97085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7993087654A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081EA1F24773
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593736AFC;
	Fri,  8 Mar 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+Oq4h2P"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05717EF;
	Fri,  8 Mar 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904484; cv=none; b=ZR9qr95VGXW75MXFX/ojhFLIVJ1d7ikeb3iPKK096wnf0WkEMWUZ5kGte0PCgoucebYFEf/L3S64JKHrSp8wFkkCIqO8XM8DZMyDKXOYujofMoKT3xexSgMi74QK+ofP7/cG48vVxkJPDoarEFPE+KS4CeoYFK58iUNnW5Uek9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904484; c=relaxed/simple;
	bh=hhKhXs9ZdVSehKaqBwJ8DY9Txa1P8L0TLTB+9MUW46w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsragfGSF7Ore3PmRO0U7V3IFt7zRO76mhi2nnYB6qH2X2Lf92vPu9F6uSyj2O22KuJsFDq4qA2K/Ltcg2aWfct1HoseFbaGOg5YqHYWvUDrRLNCv454WFpm+0Fcrzyg3AHS3p5aSu0Q8oRrRbAP35umpL/cS2TpPJP2E+oEEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+Oq4h2P; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44e3176120so288107166b.1;
        Fri, 08 Mar 2024 05:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709904481; x=1710509281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuKXTIvJNfdKUyXVvaiWe2kMamo2ZJzl393Ve5lqrIg=;
        b=W+Oq4h2PwAdon7TynwZlu3cOMDeJTxS9sBiwk9A6XKYio0bZ7uxTpLT73fbRz2CC4G
         mbdWyN11XbCdOfdY2E/yAiLT2H4bXXi8CfVxGklK8DCxpd8W/TJisw4dVIX8MW1/AeIt
         Ap6PIXmdbzeYY2lsozMRNSsZF4oOs28IlBSCy/RvE5zd8p6wVOTdJ4V2MDugiTq7IY+1
         C+nTLzOa4RykEjMe2EOFhBQ8ZnXBNDLmQ+u1wj1uvZeTTTYMTXFHqG+RcyEIPfH0Z6Lb
         9lAaU2Fw9ti36YuJL60lM3ZKDZNZWfoHsBaRdxjp70rbrnk8ZW/FBZSMsSPzw2tnrKTq
         ZTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709904481; x=1710509281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuKXTIvJNfdKUyXVvaiWe2kMamo2ZJzl393Ve5lqrIg=;
        b=GXPn8jR0XQ9ymHfw+SoKcqCfmSKPfp8CWYL0DHxj9FwITzewXgEuzsIYrd+dxLtwo0
         5jH9H/bSQ2fnY3lHtUl7JO8w04Z2HZMtjfxna/IrDbpMiAn9maJyqZcpuT7ejQx6LK/E
         7jwbIQZ55lUenMZMWFCOZsJbwcSKjSBuFecMJftiV5sxknLW+PHAntVQxh+3loPGkaxU
         kBOS1puttN1RdqvZJArdiOpMwxPorOBfPfL4/kpTQI3dsO7ODFjkQbmKxk9GOjEFNmeJ
         7Ulq/zPyXkVl719WLCa/QWLDZo3N/yKiWotkgq3cRyEqeZzNmsXPHcTNeMVykoBta3Cf
         QTvw==
X-Forwarded-Encrypted: i=1; AJvYcCXEeUKF5AWUYAqv/JIrlWYMBp9z3RJV0YwBF9nblw938zn1aP1VLfKPDMSRUZFfyg43xb7WgH9FL6uRf2Kv+vSlFaga+sDeGyOzM4IqKKk/bJqlsWNGQOLWeUtgLioxeq2JlrrD
X-Gm-Message-State: AOJu0YzKlUn+smgPJkVV4R/2a2XHhV2DSG7nMGHxisQtT03/hxxRUQBh
	csxtbNF1AYFZz3tz8ephve/yP1tX3udzrUwmIypno2BkMIlVlWXPfaQcOUYfN+TCtIMWRCXgOay
	baRfFJmxndpkDCq1IvPR+eGxW2C0=
X-Google-Smtp-Source: AGHT+IGfevllGJN8BvruE7IUSutHQU80j5biB/RycxPcwKQdSVfbblazy+sCUBWBe07Hx9mSCbyLGszaU7R+Xa5azyI=
X-Received: by 2002:a17:906:39da:b0:a44:e2e0:bda8 with SMTP id
 i26-20020a17090639da00b00a44e2e0bda8mr12604487eje.0.1709904480790; Fri, 08
 Mar 2024 05:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58483266DF047DA017C540CD99272@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CANn89i+TboBh3S3tegSqZJvjTCCi_Sa+o3iwETygFw5GqjJPsw@mail.gmail.com>
 <CAL+tcoDpZNqU9eJ0oyTyBrcHxnqR_HoGbqy0wznmyczpR05XtA@mail.gmail.com> <AM6PR03MB5848654CAA0174407FD4DE7299272@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848654CAA0174407FD4DE7299272@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 8 Mar 2024 21:27:24 +0800
Message-ID: <CAL+tcoAwPv7bquhmaUr_NckEfQbp2xuNNOSswtmxRHHVCiY9+A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/packet: Add getsockopt support for PACKET_COPY_THRESH
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Eric Dumazet <edumazet@google.com>, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:19=E2=80=AFPM Juntong Deng <juntong.deng@outlook.c=
om> wrote:
>
> On 2024/3/8 21:11, Jason Xing wrote:
> > On Fri, Mar 8, 2024 at 8:56=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >>
> >> On Fri, Mar 8, 2024 at 1:43=E2=80=AFPM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>>
> >>> Currently getsockopt does not support PACKET_COPY_THRESH,
> >>> and we are unable to get the value of PACKET_COPY_THRESH
> >>> socket option through getsockopt.
> >>>
> >>> This patch adds getsockopt support for PACKET_COPY_THRESH.
> >>>
> >>> In addition, this patch converts access to copy_thresh to
> >>> READ_ONCE/WRITE_ONCE.
> >>>
> >>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >>> ---
> >>> V1 -> V2: Use READ_ONCE/WRITE_ONCE.
> >>>
> >>>   net/packet/af_packet.c | 7 +++++--
> >>>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> >>> index 0db31ca4982d..61270826b9ac 100644
> >>> --- a/net/packet/af_packet.c
> >>> +++ b/net/packet/af_packet.c
> >>> @@ -2318,7 +2318,7 @@ static int tpacket_rcv(struct sk_buff *skb, str=
uct net_device *dev,
> >>>          }
> >>>          if (po->tp_version <=3D TPACKET_V2) {
> >>>                  if (macoff + snaplen > po->rx_ring.frame_size) {
> >>> -                       if (po->copy_thresh &&
> >>> +                       if (READ_ONCE(po->copy_thresh) &&
> >>>                              atomic_read(&sk->sk_rmem_alloc) < sk->sk=
_rcvbuf) {
> >>>                                  if (skb_shared(skb)) {
> >>>                                          copy_skb =3D skb_clone(skb, =
GFP_ATOMIC);
> >>> @@ -3836,7 +3836,7 @@ packet_setsockopt(struct socket *sock, int leve=
l, int optname, sockptr_t optval,
> >>>                  if (copy_from_sockptr(&val, optval, sizeof(val)))
> >>>                          return -EFAULT;
> >>>
> >>> -               pkt_sk(sk)->copy_thresh =3D val;
> >>> +               WRITE_ONCE(pkt_sk(sk)->copy_thresh, val);
> >>>                  return 0;
> >>>          }
> >>>          case PACKET_VERSION:
> >>> @@ -4090,6 +4090,9 @@ static int packet_getsockopt(struct socket *soc=
k, int level, int optname,
> >>>          case PACKET_VNET_HDR_SZ:
> >>>                  val =3D READ_ONCE(po->vnet_hdr_sz);
> >>>                  break;
> >>> +       case PACKET_COPY_THRESH:
> >>> +               val =3D READ_ONCE(pkt_sk(sk)->copy_thresh);
> >>> +               break;
> >>>          case PACKET_VERSION:
> >>>                  val =3D po->tp_version;
> >>>                  break;
> >>> --
> >>> 2.39.2
> >>>
> >>
> >> I think you forgot to change net/packet/diag.c pdiag_put_info()
> >>
> >
> > Ah, he updated his patch so soon even without taking a break.
> >
> > I just replied to the v1 thread with three changes made.
> >
> > Juntong, you could check your v1 patch thread and you will see the
> > missing point.
> >
> > Thanks,
> > Jason
>
> Hi Jason,
>
> Thanks, I have fixed this in the v3 patch.

The patch itself looks good to me.

But next time please do not post the patch too often, you have to wait
around 24 hour at least. We need to obey the rule. Then you have
plenty of time to collect/rethink about those suggestions...

Thanks,
Jason

