Return-Path: <linux-kernel+bounces-46885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C088445C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACCD1C222CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5E912DD9A;
	Wed, 31 Jan 2024 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1h+oD56h"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC212CDBE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721280; cv=none; b=jhZqwzft02rf87nVZnDQKzTeqn7QNXKf93NdR0xOFGj88C34kWHc4GFvzZlEKu9jmnvnKtVzgpKOLJCq8L+BRzKQrSlezPjasdYC40YtzEiygu/6UAUjLgLyB3ooB5EDV3opaNCm2XClZoHCtzASrnoZV/VcpO2kRY4JcfVlp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721280; c=relaxed/simple;
	bh=rfqRqUtJ//r4c1NBdbPZjP7C8eT/0xKnLitvg6frWkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKA/DbGd5dufhrWZEuac15p05YBCue9bIfwgqhv5+2lONPmHmuB/dZ02IaJparp3Q7IXMK41+0BTmUPcKFg/xPI9f+6i6PZxZ2Vv+zJcndY2A9FIJEbNXxl2mrxzSbiAcsQAxcjImGoaey6sfgBewbekxYH5bz497LhdPTPhbY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1h+oD56h; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso21230a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706721277; x=1707326077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G7YPuuCj4Sd+HPq5QnWx+eVJ5zxdIE0sIOPuC+ZvJg=;
        b=1h+oD56h80T7hK2sAqvwNGipX2VNZzBc/ZSK7+uFhAEjNpZQTgspXTdImLfYUnXtjy
         ZSvwg45/ygSS3WUbC4chp/JNlZCuOawPwNW5i4xGxePA6wKVJfcwI8X9Zduw62taeTSd
         1R3P4qv+czL7BO73rM7TnL1G66DprJ9aEhQ4TPdaDEmua0a5dPqyeMdvRMYbaatvsbj0
         hE2fMlglhjUCYoeeih40Zs1lQeVfob+np3nFicwW+CBnLGvMR3iUgL8m0vRh2L+N5/Cc
         bazR9RdYYChv7DwQYn/m0OWxxC0BLjX/YbkQo2K3uIhWXfMjy7jEYAd/DK8vAHbdJkmo
         NE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706721277; x=1707326077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G7YPuuCj4Sd+HPq5QnWx+eVJ5zxdIE0sIOPuC+ZvJg=;
        b=HQs/c3kf+J9yf4ewai3lbPy/ZWi3Hge3Bse10/JC0pIr7NuT21qmOaNqlSEA6CX+Wo
         t69ddBYzzRmLPFHaRWU+DTM+5KGh2yvl+PDlHqXPG7zJ62lXbFFTkdHVrTLD28idDncW
         /o7WypKCsCeNFTQsT/F6Zitan09Kop4pLhr4UG7ZnPWieTfBS0XQeACWLGGAWzLf/Rrn
         rnj6xtxIZbPTkulHEZVi3SNJml32dEyvIsPQnEud1Iuocxdu5mRCSUZqkgfqGjgnWIuo
         7qd4FnaUFZYsDNkGyNPlwtFuAUXNyujkovwg55kr/Fm0ZV2OTI0RwuWiYnTWCPxTfUmb
         RnHg==
X-Gm-Message-State: AOJu0YyBBjg77Uxg9G0JmZq9Vl2k7Xlyb6GQ7s8JUQx+xqOSOJkV5Zq0
	HlNpRIelVJck/3PXY1RxSaP2D40wyeFRfgkd84R5FZrzzLhXQ2wvLxd9Nf8J+h+2jg0AX5JOwZf
	BvoeMWgiu1XtsZCalC/BXMRDI8fGY3QuJp0vP
X-Google-Smtp-Source: AGHT+IFzB0QghT9abWRLpUul6x17lvqezW2yBZmY+sQIo666Xsjg2HAzPCA9qPYo6RaXtsAJVQ1jRHPRNewhQ/ZF/Eg=
X-Received: by 2002:a05:6402:5c3:b0:55f:a1af:badc with SMTP id
 n3-20020a05640205c300b0055fa1afbadcmr60568edx.6.1706721276865; Wed, 31 Jan
 2024 09:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131150332.1326523-1-quic_kriskura@quicinc.com> <CANP3RGeHXmEcDN=-h1uGBzu_Ur2UcmiEuFDXAEr0Z2ptXnHq=Q@mail.gmail.com>
In-Reply-To: <CANP3RGeHXmEcDN=-h1uGBzu_Ur2UcmiEuFDXAEr0Z2ptXnHq=Q@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 31 Jan 2024 09:14:21 -0800
Message-ID: <CANP3RGeQ0-2vg0OeOHCuUzgeRRH4JyPw511Eoyy=HA-M9YAX2A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hardik Gajjar <hgajjar@de.adit-jv.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:03=E2=80=AFAM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> On Wed, Jan 31, 2024 at 7:03=E2=80=AFAM Krishna Kurapati
> <quic_kriskura@quicinc.com> wrote:
> >
> > It is observed sometimes when tethering is used over NCM with Windows 1=
1
> > as host, at some instances, the gadget_giveback has one byte appended a=
t
> > the end of a proper NTB. When the NTB is parsed, unwrap call looks for
> > any leftover bytes in SKB provided by u_ether and if there are any pend=
ing
> > bytes, it treats them as a separate NTB and parses it. But in case the
> > second NTB (as per unwrap call) is faulty/corrupt, all the datagrams th=
at
> > were parsed properly in the first NTB and saved in rx_list are dropped.
> >
> > Adding a few custom traces showed the following:
> >
> > [002] d..1  7828.532866: dwc3_gadget_giveback: ep1out:
> > req 000000003868811a length 1025/16384 zsI =3D=3D> 0
> > [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb toprocess: 1=
025
> > [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 1751999=
342
> > [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb seq: 0xce67
> > [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x4=
00
> > [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb ndp_len: 0x1=
0
> > [002] d..1  7828.532869: ncm_unwrap_ntb: K: Parsed NTB with 1 frames
> >
> > In this case, the giveback is of 1025 bytes and block length is 1024.
> > The rest 1 byte (which is 0x00) won't be parsed resulting in drop of
> > all datagrams in rx_list.
> >
> > Same is case with packets of size 2048:
> > [002] d..1  7828.557948: dwc3_gadget_giveback: ep1out:
> > req 0000000011dfd96e length 2049/16384 zsI =3D=3D> 0
> > [002] d..1  7828.557949: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 1751999=
342
> > [002] d..1  7828.557950: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x8=
00
> >
> > Lecroy shows one byte coming in extra confirming that the byte is comin=
g
> > in from PC:
> >
> > Transfer 2959 - Bytes Transferred(1025)  Timestamp((18.524 843 590)
> > - Transaction 8391 - Data(1025 bytes) Timestamp(18.524 843 590)
> > --- Packet 4063861
> >       Data(1024 bytes)
> >       Duration(2.117us) Idle(14.700ns) Timestamp(18.524 843 590)
> > --- Packet 4063863
> >       Data(1 byte)
> >       Duration(66.160ns) Time(282.000ns) Timestamp(18.524 845 722)
> >
> > According to Windows driver, no ZLP is needed if wBlockLength is non-ze=
ro,
> > because the non-zero wBlockLength has already told the function side th=
e
> > size of transfer to be expected. However, there are in-market NCM devic=
es
> > that rely on ZLP as long as the wBlockLength is multiple of wMaxPacketS=
ize.
> > To deal with such devices, it pads an extra 0 at end so the transfer is=
 no
> > longer multiple of wMaxPacketSize.
> >
> > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > ---
> >  drivers/usb/gadget/function/f_ncm.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/f=
unction/f_ncm.c
> > index ca5d5f564998..8c314dc98952 100644
> > --- a/drivers/usb/gadget/function/f_ncm.c
> > +++ b/drivers/usb/gadget/function/f_ncm.c
> > @@ -1338,11 +1338,17 @@ static int ncm_unwrap_ntb(struct gether *port,
> >              "Parsed NTB with %d frames\n", dgram_counter);
> >
> >         to_process -=3D block_len;
> > -       if (to_process !=3D 0) {
> > +
> > +       if (to_process =3D=3D 1 &&
> > +           (block_len % 512 =3D=3D 0) &&
> > +           (*(unsigned char *)(ntb_ptr + block_len) =3D=3D 0x00)) {
>
> I'm unconvinced this (block_len % 512) works right...
> imagine you have 2 ntbs back to back (for example 400 + 624) that
> together add up to 1024,
> and then a padding null byte.
> I think block_len will be 624 then and not 1024.
>
> perhaps this actually needs to be:
>   (ntp_ptr + block_len - skb->data) % 512 =3D=3D 0
>
> The point is that AFAICT the multiple of 512/1024 that matters is in
> the size of the USB transfer,
> not the NTB block size itself.
>
> > +               goto done;
> > +       } else if (to_process > 0) {
> >                 ntb_ptr =3D (unsigned char *)(ntb_ptr + block_len);
>
> note that ntb_ptr moves forward by block_len here,
> so it's *not* always the start of the packet, so block_len is not
> necessarily the actual on the wire size.
>
> >                 goto parse_ntb;
> >         }
> >
> > +done:
> >         dev_consume_skb_any(skb);
> >
> >         return 0;
> > --
> > 2.34.1
> >
>
> But it would perhaps be worth confirming in the MS driver source what
> exactly they're doing...
> (maybe they never even generate multiple ntbs per usb segment...)
>
> You may also want to mention in the commit message that 512 comes from
> USB2 block size, and also works for USB3 block size of 1024.

Also since this is a fix, it should probably have a Fixes tag
(possibly on some original sha1 that added the driver, since I think
it's always been broken) or at least a commit title that more clearly
flags it as a 'fix' or cc stable...

(something like 'usb: gadget: ncm: fix rare win11 packet discard')

We definitely want this to hit LTS...

