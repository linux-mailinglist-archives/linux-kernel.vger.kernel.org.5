Return-Path: <linux-kernel+bounces-97032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1287876498
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00B21C2184E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D271B812;
	Fri,  8 Mar 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+O1OCD1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534ED1AAD7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902585; cv=none; b=lO6UXyIdMUw+PKE9bIPNAE6x60pmHgWUlzp0fgcalYp1R9dBtlYMwMdLqtx3xAZQc/xfW4Uy7/Mr82SDn9MxHJSBJ26R3RTjOOw10bqJAoWeobBV5QUh2IWdJDxfhWNAvDSELBOEQA9bLCdP52RSFw/p3dXNeE5vIOO8PAACopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902585; c=relaxed/simple;
	bh=UQUx+vJYLbayg51PRY1tgXR0gHlN5v3xj0mWADHAYHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5p1iXtQjs1C4rczBuaWsUj8l3Etrvj1ROPA75qHfz61LmDJ4M9OFSTwATv3Na5D5nnEXbRtMVXX1+4dKBL9YIA+1QZD4sNcz5pay2gGI8+pcTRDSMJvw9GIEyiRvDq3fKPJVeXZ/7dDubEKVLFGrEtzzRi7wwLj6IAULkFxuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+O1OCD1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5682df7917eso7822a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709902583; x=1710507383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fm7PqN6wle515KaphgyHt1Rh7fhbY7+uyNPBKeWIyoI=;
        b=h+O1OCD1LOvqUPBkRGARXHJloXsEiK/AXLRT9SqyM+sOxS5GMwHsC1gpqzm0GQFHu7
         WSextPxSiIxyAo6v5QyW1fw2YhwjUtkjAFmqz4TPwQ5mfqsuiszeWhru1xp8ti6RMZE2
         eJaHuhYwV/t0gX5iMGubKtPr70mHLzH5ehnC1QvhaJ+swG3XJNcEwvxGaP+H3AL7/H2H
         LW49x9hUgljiMyKXbiqeHbqIIXZh2kei+M/2QS60Vdv9BRLH2PdtV4aLbtPLMtDvA1iS
         kvo2I/PQz1G0u+dndkvllMxhe5wsV67qx7xOpuW1xgtoIOVNQe7g3UOUV8+3JzEHGTvy
         wGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709902583; x=1710507383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fm7PqN6wle515KaphgyHt1Rh7fhbY7+uyNPBKeWIyoI=;
        b=rvhAWM8Xs0mvWTuVI1T69cGuS42Mwp8mmP2iaLnA66CqfkMJl8mP6LtMxdn/fCGsge
         KJenspkqRjhYcox/3ljtWmBqKcZ2dtrqaEuMwzC+cQ8iMhPHhvUFBnQjyuBvJr8+zO7P
         KJQ3Z7I/whr+++frOFe3JDWc1XSj2WXsCOaXdxzw3a5eYArmpXdKAGgW0B5fiu4dc3RK
         RalQoK1nt6YT07kB0x03P669FfgPeLZzBW2jXIbg1E2sG2NHtSG/IudEaMb+AvJ+dJM9
         t2ySpL2yaJ1k1ckxpL9R+gCC6T1q1ssxTRNeLnL+szyPoZAxlYxl5phyqVWCEecFghqd
         4F/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVKE760n81nowCAJ789gmqkvMimP4qgEFKtpsvpsQVmU+hq3vUKn6AcwkKas0Abx7TbBv5pAo0N0dOzbMKNmw/AaVZchWjFmAuBTUD
X-Gm-Message-State: AOJu0YyiMcOnEN/r363U55ArQ+yjxJaScQxfoLQpdBCZyv+BreSX8lVu
	9+ZXdsi9T3KDFceF6SFbUcsGIqMDnFxdahS3PXQpQR5n6/m/WGyJFBmmnUrf7CbyCBL+cQWDQbe
	Qx9E9yF7jbVST20q6e74nOFXCaaBBszFdYo55
X-Google-Smtp-Source: AGHT+IHdB7K9ApEjeSZs1vfuPJvne1+otYO6v/hac+g2lIh9xq4MSrwrB3nGLAy9lBn4T1Ci4zyjwZ4tgBvNkBHujEc=
X-Received: by 2002:a05:6402:2022:b0:568:271a:8c0f with SMTP id
 ay2-20020a056402202200b00568271a8c0fmr201480edb.7.1709902582518; Fri, 08 Mar
 2024 04:56:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58483266DF047DA017C540CD99272@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58483266DF047DA017C540CD99272@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 13:56:11 +0100
Message-ID: <CANn89i+TboBh3S3tegSqZJvjTCCi_Sa+o3iwETygFw5GqjJPsw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/packet: Add getsockopt support for PACKET_COPY_THRESH
To: Juntong Deng <juntong.deng@outlook.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 1:43=E2=80=AFPM Juntong Deng <juntong.deng@outlook.c=
om> wrote:
>
> Currently getsockopt does not support PACKET_COPY_THRESH,
> and we are unable to get the value of PACKET_COPY_THRESH
> socket option through getsockopt.
>
> This patch adds getsockopt support for PACKET_COPY_THRESH.
>
> In addition, this patch converts access to copy_thresh to
> READ_ONCE/WRITE_ONCE.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
> V1 -> V2: Use READ_ONCE/WRITE_ONCE.
>
>  net/packet/af_packet.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 0db31ca4982d..61270826b9ac 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2318,7 +2318,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct =
net_device *dev,
>         }
>         if (po->tp_version <=3D TPACKET_V2) {
>                 if (macoff + snaplen > po->rx_ring.frame_size) {
> -                       if (po->copy_thresh &&
> +                       if (READ_ONCE(po->copy_thresh) &&
>                             atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvb=
uf) {
>                                 if (skb_shared(skb)) {
>                                         copy_skb =3D skb_clone(skb, GFP_A=
TOMIC);
> @@ -3836,7 +3836,7 @@ packet_setsockopt(struct socket *sock, int level, i=
nt optname, sockptr_t optval,
>                 if (copy_from_sockptr(&val, optval, sizeof(val)))
>                         return -EFAULT;
>
> -               pkt_sk(sk)->copy_thresh =3D val;
> +               WRITE_ONCE(pkt_sk(sk)->copy_thresh, val);
>                 return 0;
>         }
>         case PACKET_VERSION:
> @@ -4090,6 +4090,9 @@ static int packet_getsockopt(struct socket *sock, i=
nt level, int optname,
>         case PACKET_VNET_HDR_SZ:
>                 val =3D READ_ONCE(po->vnet_hdr_sz);
>                 break;
> +       case PACKET_COPY_THRESH:
> +               val =3D READ_ONCE(pkt_sk(sk)->copy_thresh);
> +               break;
>         case PACKET_VERSION:
>                 val =3D po->tp_version;
>                 break;
> --
> 2.39.2
>

I think you forgot to change net/packet/diag.c pdiag_put_info()

