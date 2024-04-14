Return-Path: <linux-kernel+bounces-144306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCE28A4465
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5964B21553
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB556135A64;
	Sun, 14 Apr 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkHI/Zd1"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA13E47F;
	Sun, 14 Apr 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713115417; cv=none; b=G4mACU2rXLKWj6Ds4tUMZkgui4rCirdkbeZh36Uz/CIzAfisPZm1tAueqyr7MaeJjLglbR/EsV7FcbXTO6nqlLU01Jpns4XUwbBHf++D0rSD1K0YL7il+RCHIRa9KU0Q3G1EseH27u09H8rfV2Huho564he0dMUg322wQpAoxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713115417; c=relaxed/simple;
	bh=pJxKpmlvWn9Ryhv4cRMt/j4muAxaILk/kKZuiFSDZqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqRuRfeV2JDhwbgB2CDqrnJC+43pTW7S3L8DDWusZizwov/S8G1OFBvHsdNtSs80kApzY7eK8gXZn+q6tIqCtgwlDgGyLKdULk9ybSJk1gt0V0FNpoC3rLF9dS6tlkB3uW8/b6+oMYUzbhhESmvdxUInoFNfH+jlOSDHdAFr2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkHI/Zd1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so2131873f8f.0;
        Sun, 14 Apr 2024 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713115414; x=1713720214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+N9+N4eerzdxQXWvGPhnZufnj4UP/wYsCHFWKc83mw=;
        b=hkHI/Zd1uOyXouZlaHypnrxoe0x3w4d1OJ6JcYPog70dw7UgvxDvm0skBYOn/81apj
         Pigddz2RZZbgBF/g0TBt9TiTZm+G68+DVlx8AdIMtPh45wMoYoRVTP7HAQlCCTmGIA6u
         7ExErwoEnNmhUkCvF+Idfs8+JpemXNZk/HinAvoPaNfswJ0Yxz8gbWLrUvOIvCwCb+9D
         xUn4eFDEP9CpXaA3lfU4/Tr1bfkV39QmKr1hQLoz7YDTL6UROmjjOEN/bc7Fy0zCprZ/
         WbHX5ZJSlQJpqDU8T02Y9zukNp29Nzx3CQrsEIlh3wMCNdOiwY+UHshr1ZusbYi6g3VI
         Mglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713115414; x=1713720214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+N9+N4eerzdxQXWvGPhnZufnj4UP/wYsCHFWKc83mw=;
        b=C93Ay6tpOVHJ032k5Oh49odG5RPfHMz2osjF8hWywYcDY4TOakEl8oFuzhMuUpappu
         ZIacU4dpYqNopDqOMm5JOB6AYNwdeb1vBZ3Vri423ZJUj0Yd8P6s/pu7PI4LsTfQqyyn
         AF8Ykbnq3o4dfI/DExNRba2o2gU/HrmZ7jZc9tlK8d47+QeE5O6F+vsix1Qn+4V2sEH+
         WHjd3N+SALBjdqUq7CBpqXAD5us7BW97Wr76p7fAOwv+7wY9wAQnEOi0zRpTlNU73JNC
         LUQr5B+PbPyqlZqDpd/wXvgexCkE0+x5aipEWmWO7Vlbz3FYWKgKLrVDM6EwwO2gXN8X
         aQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCVMHL3I+a8NxKSdfUcqvMxo8NxGO4dex0UMQfulMiy4oxzts+o3YNWkqd592Xqp4btm9Rl7DUA6CpWxn3LJeOa4nuEH0FBjCR0R+9G1+8kStkajEo4Qa00oWaOa/BfztHZRdnCm
X-Gm-Message-State: AOJu0YwAI/ivGH2yFBEdWqC6HUuDYpfn7ytxOnx1KTWMal2ND3XVnc0I
	EYZAkCE8lxFsko+ElXPvIiPY+dWs6kQU5Uf8pU4rdVP7RpsLDRWqUg2Pi94sOJbV6TZXWKUs013
	eFAWDN8hY1+zrtg4sosK/ZMgZhqM=
X-Google-Smtp-Source: AGHT+IFt4wJMUA6ouw1KIr24b3lJh1KJixsu21FCFeCw1OiVGr34Ka++qWw27eehLCNAQ30QS/gzWzTcbhVLhGLylfQ=
X-Received: by 2002:a05:6000:1bc2:b0:33e:c91a:127e with SMTP id
 j2-20020a0560001bc200b0033ec91a127emr5889026wrv.63.1713115413507; Sun, 14 Apr
 2024 10:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412152120.115067-1-richardbgobert@gmail.com>
 <20240412152120.115067-2-richardbgobert@gmail.com> <661ad1136bc10_3be9a7294c2@willemb.c.googlers.com.notmuch>
In-Reply-To: <661ad1136bc10_3be9a7294c2@willemb.c.googlers.com.notmuch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 14 Apr 2024 10:22:56 -0700
Message-ID: <CAKgT0UfB+3DTjK7vq1uvG-2xtA53pw03ygJhwSG8j1bPtmYU8A@mail.gmail.com>
Subject: Re: [PATCH net v1 1/2] net: gro: add flush check in udp_gro_receive_segment
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 11:38=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Richard Gobert wrote:
> > GRO-GSO path is supposed to be transparent and as such L3 flush checks =
are
> > relevant to all flows which call skb_gro_receive. This patch uses the s=
ame
> > logic and code from tcp_gro_receive but in the relevant flow path in
> > udp_gro_receive_segment.
> >
> > Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) U=
DP GRO packets")
> > Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> > ---
> >  net/ipv4/udp_offload.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index 3498dd1d0694..1f4e08f43c4b 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segment(stru=
ct list_head *head,
> >       struct sk_buff *p;
> >       unsigned int ulen;
> >       int ret =3D 0;
> > +     int flush;
> >
> >       /* requires non zero csum, for symmetry with GSO */
> >       if (!uh->check) {
> > @@ -528,7 +529,17 @@ static struct sk_buff *udp_gro_receive_segment(str=
uct list_head *head,
> >                               skb_gro_postpull_rcsum(skb, uh,
> >                                                      sizeof(struct udph=
dr));
> >
> > -                             ret =3D skb_gro_receive(p, skb);
> > +                             flush =3D NAPI_GRO_CB(p)->flush;
> > +
> > +                             if (NAPI_GRO_CB(p)->flush_id !=3D 1 ||
> > +                                 NAPI_GRO_CB(p)->count !=3D 1 ||
> > +                                 !NAPI_GRO_CB(p)->is_atomic)
> > +                                     flush |=3D NAPI_GRO_CB(p)->flush_=
id;
> > +                             else
> > +                                     NAPI_GRO_CB(p)->is_atomic =3D fal=
se;
> > +
> > +                             if (flush || skb_gro_receive(p, skb))
> > +                                     ret =3D 1;
>
> UDP_L4 does not have the SKB_GSO_TCP_FIXEDID that uses is_atomic as
> input.
>
> And I still don't fully internalize the flush_id logic after staring
> at it for more than one coffee.

The flush_id field is there to indicate the difference between the
current IPv4 ID of the previous IP header. It is meant to be used in
conjunction with the is_atomic for the frame coalescing. Basically
after the second frame we can decide the pattern either incrementing
IPv4 ID or fixed, so on frames 3 or later we can decide to drop the
frame if it doesn't follow that pattern.

> But even ignoring those, the flush signal of NAPI_GRO_CB(p)->flush
> set the network layer must be followed, so ACK. Thanks for the fix.

I'm not sure about the placement of this code though. That is the one
thing that seems off to me. Specifically this seems like it should be
done before we start the postpull, not after. It should be something
that can terminate the flow before we attempt to aggregate the UDP
headers.

