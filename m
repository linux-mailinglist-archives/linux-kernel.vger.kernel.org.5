Return-Path: <linux-kernel+bounces-97040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A058764C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D2E1F226AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7BD200D5;
	Fri,  8 Mar 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+gaKhe/"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196F10A34;
	Fri,  8 Mar 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903512; cv=none; b=cV9gBuSG32ZDh9Al/87XOR0w3PtXtrUqnj25cVj62ku08rdSKpQKamqb4CrSqZkc+GftTg9RMDhPdUY1iYnQnUXR8eyny1+ksxOVOLdnCQt/yrpZ8IU5yIijfogDwoQPrqKaGP5mqndUbgMmXfVTUsgT+ULkpQGAi1J/b+41sGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903512; c=relaxed/simple;
	bh=JW/jVIaU96o6BFKFV+Hpp8LRCawyJhrKD/asgcBfzSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYI7J9o6xrHT27pnovgNbLoyV3amntE+9LNxu3Jfwhexs5zfXMxcLiECjabwJVXCRZb9Ho+xDfuio5prNmjPVrZC6ZNeXCF4EqV8hwEobFJKVhW02HmzFTncrVU/W159fLSyNr9bedaThMm3GFEEoNqy+PcPYa6uPWndHH3T+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+gaKhe/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a458eb7db13so303529566b.2;
        Fri, 08 Mar 2024 05:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709903509; x=1710508309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGq+jgqU3Fs7LfeBp/kruC5Fh0mzhcdDwgbZAEOMazM=;
        b=U+gaKhe/3zHcNn5raQK6c8B0UkhGbdlf7dIZzp4BI87RNe3cBp1mUfGQrdcseIqYHd
         2f8Ze1YI9kYFCGFKWgTWvV2cVMOhYyMTuwpPNY5ORV0658zc6ts66Qcm0xdWj8J6Jlkq
         0+KYkNw+3VTacB48rhQPWZpuo4xRLkExwbUZ6AQCrsYhxa59PJFRKCTwxag46desVU+s
         7kmtxyvLznlNODsz19UwqV31Rtw9BjUKcXQzDFVLHXDzTIkVPfdraYUCZZVUE85Zxu27
         Rf7xAgOBdH93tOmwjZW2LNg6+xN4H1OGEJHsMQ0vPhuo6JX4rJXpwyYS2GEaZULKGCmA
         b2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709903509; x=1710508309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGq+jgqU3Fs7LfeBp/kruC5Fh0mzhcdDwgbZAEOMazM=;
        b=n6Svp8yPXfutnsKARkJ68D7WKwtiVKvg/OkM8QtdKvEl+zGvOSt7L6Iwryy9ZHtNAI
         Tx0RrBvJ3YPT7DyDfuzEOB23NkPjHVXEODdbUSZ/Yy1dpPuLD/KoA0Yczj2RIFaG+xkn
         E81hCHT5L4etFlMtpS3kKVkEdHryOaXN0Oxzm9/+L96p2QeRWVwEAJ7+KeZNmlJVaMtl
         H8OCY6axDJEeEImj2R1e+6GJOF1TXFfp1m+dQmZycR1u4ClsC5KwIxresZrNJ9ujf6aM
         6AWoDTpHZSqyE8SwT/x6dBbxHXgkTVf6DJE62mSH9FLDFcZPRtrS7q0B7pPuxTWtyLt5
         lLiw==
X-Forwarded-Encrypted: i=1; AJvYcCXWYHZgfDovyxQPJwNJaesZlo034mlA14ow3c99xuf4UT1dZFHgvTcxHc5IaHkCuvRO7bQ+z1EMJ0+6rZclEdU01MKc/75KU91o4/fBpa7O6e3BlG1wTepH3zh+VjADtZj0Jbch
X-Gm-Message-State: AOJu0Yw1oCp3i4buvb6/7iKknqbrLBK/uf1aTytxdxIHlD8O138X0g3K
	F307Xp/y+1PWtaKtyv/4G0g6WJqXRuW8cHm8QdesUcrgeHaW+Z7kCMsbvMR9l+WE3O+7MRXbAWy
	n91wlIn/DVcq4DkzoWX0nwd1qZhE=
X-Google-Smtp-Source: AGHT+IF3RKMb1nYJUHb3CB0FWWkA99zSspvCa/aMBRnHJZCF857WtJtnKtqEyew/Jln4lyeanWB04+5OKIR5e+Y4JxQ=
X-Received: by 2002:a17:906:bc54:b0:a43:f182:66c4 with SMTP id
 s20-20020a170906bc5400b00a43f18266c4mr14960738ejv.17.1709903509558; Fri, 08
 Mar 2024 05:11:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58483266DF047DA017C540CD99272@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CANn89i+TboBh3S3tegSqZJvjTCCi_Sa+o3iwETygFw5GqjJPsw@mail.gmail.com>
In-Reply-To: <CANn89i+TboBh3S3tegSqZJvjTCCi_Sa+o3iwETygFw5GqjJPsw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 8 Mar 2024 21:11:12 +0800
Message-ID: <CAL+tcoDpZNqU9eJ0oyTyBrcHxnqR_HoGbqy0wznmyczpR05XtA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/packet: Add getsockopt support for PACKET_COPY_THRESH
To: Eric Dumazet <edumazet@google.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 8:56=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Mar 8, 2024 at 1:43=E2=80=AFPM Juntong Deng <juntong.deng@outlook=
com> wrote:
> >
> > Currently getsockopt does not support PACKET_COPY_THRESH,
> > and we are unable to get the value of PACKET_COPY_THRESH
> > socket option through getsockopt.
> >
> > This patch adds getsockopt support for PACKET_COPY_THRESH.
> >
> > In addition, this patch converts access to copy_thresh to
> > READ_ONCE/WRITE_ONCE.
> >
> > Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> > ---
> > V1 -> V2: Use READ_ONCE/WRITE_ONCE.
> >
> >  net/packet/af_packet.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 0db31ca4982d..61270826b9ac 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2318,7 +2318,7 @@ static int tpacket_rcv(struct sk_buff *skb, struc=
t net_device *dev,
> >         }
> >         if (po->tp_version <=3D TPACKET_V2) {
> >                 if (macoff + snaplen > po->rx_ring.frame_size) {
> > -                       if (po->copy_thresh &&
> > +                       if (READ_ONCE(po->copy_thresh) &&
> >                             atomic_read(&sk->sk_rmem_alloc) < sk->sk_rc=
vbuf) {
> >                                 if (skb_shared(skb)) {
> >                                         copy_skb =3D skb_clone(skb, GFP=
_ATOMIC);
> > @@ -3836,7 +3836,7 @@ packet_setsockopt(struct socket *sock, int level,=
 int optname, sockptr_t optval,
> >                 if (copy_from_sockptr(&val, optval, sizeof(val)))
> >                         return -EFAULT;
> >
> > -               pkt_sk(sk)->copy_thresh =3D val;
> > +               WRITE_ONCE(pkt_sk(sk)->copy_thresh, val);
> >                 return 0;
> >         }
> >         case PACKET_VERSION:
> > @@ -4090,6 +4090,9 @@ static int packet_getsockopt(struct socket *sock,=
 int level, int optname,
> >         case PACKET_VNET_HDR_SZ:
> >                 val =3D READ_ONCE(po->vnet_hdr_sz);
> >                 break;
> > +       case PACKET_COPY_THRESH:
> > +               val =3D READ_ONCE(pkt_sk(sk)->copy_thresh);
> > +               break;
> >         case PACKET_VERSION:
> >                 val =3D po->tp_version;
> >                 break;
> > --
> > 2.39.2
> >
>
> I think you forgot to change net/packet/diag.c pdiag_put_info()
>

Ah, he updated his patch so soon even without taking a break.

I just replied to the v1 thread with three changes made.

Juntong, you could check your v1 patch thread and you will see the
missing point.

Thanks,
Jason

