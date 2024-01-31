Return-Path: <linux-kernel+bounces-46894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0208445E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C0B1C24896
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B271812F582;
	Wed, 31 Jan 2024 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zp5BTwBv"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2712C553
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721530; cv=none; b=NnkwmpLHhlKZcpIuMffHvI2H1BgsLmThRXAS348SCoi1MxPbV1AkYXh1qofdzkfbYwVicmgWL3wdNBT/jW2Zi0v7IVy8QKinHa+SExLFck24Q33nrhqJgxFaRODGcltS1+M0f0wHZFCh4aS92m839Ztmm2BIETKuPnsJHWojaE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721530; c=relaxed/simple;
	bh=EUatuG24str+B+qoqT7fZBnQVgvmuUlT/BAN3+vvE0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ky6mud5HS59Vo8MTc4pnLHzO0ku7IanXV3uOlbBgTIlYND2ml8+XAicqfqU5hGeaLMMnQn/aqVYmHw1SznVNzu/9oPEgRKy533iqko8OCVBn4mdjzMsgxhviVw/UFyHAGfb6ucFyQaIHiBjPnYLe/euhbNwzhcYSxI0JxN/5xfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zp5BTwBv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f85a2a43fso13107a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706721527; x=1707326327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3mGoL3zDkzMLFYV1uUnwg42JaoVUwZ52/NIbjZh/FM=;
        b=Zp5BTwBvsrD766Afla41NsTjXdJrX6X2uNHTiL7X/FbKOkYYjAXbxfkxnwyA0R594R
         RLsnI0OVebQKMmhjG26jFoRLo0umThCXSW2CXXMSk3FgcFhDqebZcCPot5Dx4ZYwTsuK
         nM6C6sqoQ6mzQMKEbCpaTXXFbyy+rwaic3BcoXbDvGEC7zVYES1LZwe2OldzrYvHTWJX
         shR2aDXAyWo9gVAeEY02DCgbr6v8S4dHWZrJdvZ8XeqIwpDTinyj3c+H9Y5tTkpPkQDK
         yRrDBLHmjqhq1UIk7Qd2MFG6vE7f7zC3idHOaqant17VTYy3ON1eTcsAr1aHn8nfjhNb
         1IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706721527; x=1707326327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3mGoL3zDkzMLFYV1uUnwg42JaoVUwZ52/NIbjZh/FM=;
        b=S/B+B2CeQsO7ZaD1QeAr0zRJk+FbrTF+YONh/KWZlKJnGBY3mKHtOQHhlvML3YSht4
         lSyqgUO4JyuDM4HPZtkp28QuDuezNHKBMIwRvJr9WOwxOP2WQ426sELD5RTlQFEGhooy
         vGuf7czBZGwz7Fdb7TKA3bbltRV7jH44705tu1K28wZ68S5aHfdi03XbOgVEyMpMu2uK
         5JJE40VUt2gEVh/BGJyaX7rHnsaC+fE9JJUZx/d50OTahsHQYgArS9DrkQlk2dcE7s+c
         aqRLKnpC9tmT4c4uYvOn0HEwd0qzJHqmhwYEBok9ZG1jx0RrsoVQ+inMMmxx2D4+348a
         YoWg==
X-Gm-Message-State: AOJu0Yw3ebe6S1ULAfTO4QDM6NuuHUdGAdofcqxx1begzDAIgiBtXsAi
	kgREKaVgNAtrHdZ78yiukkhLAD/H5zFkvNGq8a9s/TLMTpNq8p73gvg7sWHPnu4P7oqR8W7OHbD
	04eTrq0Z9n9DywoB2TRqfPhBBLVCPSu9gmf7A
X-Google-Smtp-Source: AGHT+IE3dsyGqpf9PRrRcVat+owS5CMutKYfaFAUt1MAXTE8r60robbHPrVWf8XnLeeR+lXWkJfwCP09BjviYaqcHaQ=
X-Received: by 2002:a05:6402:312f:b0:55d:2163:7ed1 with SMTP id
 dd15-20020a056402312f00b0055d21637ed1mr453402edb.1.1706721526917; Wed, 31 Jan
 2024 09:18:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131150332.1326523-1-quic_kriskura@quicinc.com>
 <CANP3RGeHXmEcDN=-h1uGBzu_Ur2UcmiEuFDXAEr0Z2ptXnHq=Q@mail.gmail.com> <CANP3RGeQ0-2vg0OeOHCuUzgeRRH4JyPw511Eoyy=HA-M9YAX2A@mail.gmail.com>
In-Reply-To: <CANP3RGeQ0-2vg0OeOHCuUzgeRRH4JyPw511Eoyy=HA-M9YAX2A@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 31 Jan 2024 09:18:35 -0800
Message-ID: <CANP3RGebjQhjCMVg5h936kp2mcCFcRvwzwi+84vxzFeUnmQwCQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hardik Gajjar <hgajjar@de.adit-jv.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:14=E2=80=AFAM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> On Wed, Jan 31, 2024 at 9:03=E2=80=AFAM Maciej =C5=BBenczykowski <maze@go=
ogle.com> wrote:
> >
> > On Wed, Jan 31, 2024 at 7:03=E2=80=AFAM Krishna Kurapati
> > <quic_kriskura@quicinc.com> wrote:
> > >
> > > It is observed sometimes when tethering is used over NCM with Windows=
 11
> > > as host, at some instances, the gadget_giveback has one byte appended=
 at
> > > the end of a proper NTB. When the NTB is parsed, unwrap call looks fo=
r
> > > any leftover bytes in SKB provided by u_ether and if there are any pe=
nding
> > > bytes, it treats them as a separate NTB and parses it. But in case th=
e
> > > second NTB (as per unwrap call) is faulty/corrupt, all the datagrams =
that
> > > were parsed properly in the first NTB and saved in rx_list are droppe=
d.
> > >
> > > Adding a few custom traces showed the following:
> > >
> > > [002] d..1  7828.532866: dwc3_gadget_giveback: ep1out:
> > > req 000000003868811a length 1025/16384 zsI =3D=3D> 0
> > > [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb toprocess:=
 1025
> > > [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 17519=
99342
> > > [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb seq: 0xce6=
7
> > > [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0=
x400
> > > [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb ndp_len: 0=
x10
> > > [002] d..1  7828.532869: ncm_unwrap_ntb: K: Parsed NTB with 1 frames
> > >
> > > In this case, the giveback is of 1025 bytes and block length is 1024.
> > > The rest 1 byte (which is 0x00) won't be parsed resulting in drop of
> > > all datagrams in rx_list.
> > >
> > > Same is case with packets of size 2048:
> > > [002] d..1  7828.557948: dwc3_gadget_giveback: ep1out:
> > > req 0000000011dfd96e length 2049/16384 zsI =3D=3D> 0
> > > [002] d..1  7828.557949: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 17519=
99342
> > > [002] d..1  7828.557950: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0=
x800
> > >
> > > Lecroy shows one byte coming in extra confirming that the byte is com=
ing
> > > in from PC:
> > >
> > > Transfer 2959 - Bytes Transferred(1025)  Timestamp((18.524 843 590)
> > > - Transaction 8391 - Data(1025 bytes) Timestamp(18.524 843 590)
> > > --- Packet 4063861
> > >       Data(1024 bytes)
> > >       Duration(2.117us) Idle(14.700ns) Timestamp(18.524 843 590)
> > > --- Packet 4063863
> > >       Data(1 byte)
> > >       Duration(66.160ns) Time(282.000ns) Timestamp(18.524 845 722)
> > >
> > > According to Windows driver, no ZLP is needed if wBlockLength is non-=
zero,
> > > because the non-zero wBlockLength has already told the function side =
the
> > > size of transfer to be expected. However, there are in-market NCM dev=
ices
> > > that rely on ZLP as long as the wBlockLength is multiple of wMaxPacke=
tSize.
> > > To deal with such devices, it pads an extra 0 at end so the transfer =
is no
> > > longer multiple of wMaxPacketSize.
> > >
> > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > ---
> > >  drivers/usb/gadget/function/f_ncm.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget=
/function/f_ncm.c
> > > index ca5d5f564998..8c314dc98952 100644
> > > --- a/drivers/usb/gadget/function/f_ncm.c
> > > +++ b/drivers/usb/gadget/function/f_ncm.c
> > > @@ -1338,11 +1338,17 @@ static int ncm_unwrap_ntb(struct gether *port=
,
> > >              "Parsed NTB with %d frames\n", dgram_counter);
> > >
> > >         to_process -=3D block_len;
> > > -       if (to_process !=3D 0) {
> > > +
> > > +       if (to_process =3D=3D 1 &&
> > > +           (block_len % 512 =3D=3D 0) &&
> > > +           (*(unsigned char *)(ntb_ptr + block_len) =3D=3D 0x00)) {
> >
> > I'm unconvinced this (block_len % 512) works right...
> > imagine you have 2 ntbs back to back (for example 400 + 624) that
> > together add up to 1024,
> > and then a padding null byte.
> > I think block_len will be 624 then and not 1024.
> >
> > perhaps this actually needs to be:
> >   (ntp_ptr + block_len - skb->data) % 512 =3D=3D 0
> >
> > The point is that AFAICT the multiple of 512/1024 that matters is in
> > the size of the USB transfer,
> > not the NTB block size itself.
> >
> > > +               goto done;
> > > +       } else if (to_process > 0) {
> > >                 ntb_ptr =3D (unsigned char *)(ntb_ptr + block_len);
> >
> > note that ntb_ptr moves forward by block_len here,
> > so it's *not* always the start of the packet, so block_len is not
> > necessarily the actual on the wire size.
> >
> > >                 goto parse_ntb;
> > >         }
> > >
> > > +done:
> > >         dev_consume_skb_any(skb);
> > >
> > >         return 0;
> > > --
> > > 2.34.1
> > >
> >
> > But it would perhaps be worth confirming in the MS driver source what
> > exactly they're doing...
> > (maybe they never even generate multiple ntbs per usb segment...)
> >
> > You may also want to mention in the commit message that 512 comes from
> > USB2 block size, and also works for USB3 block size of 1024.
>
> Also since this is a fix, it should probably have a Fixes tag
> (possibly on some original sha1 that added the driver, since I think
> it's always been broken) or at least a commit title that more clearly
> flags it as a 'fix' or cc stable...
>
> (something like 'usb: gadget: ncm: fix rare win11 packet discard')
>
> We definitely want this to hit LTS...

One more thing: the 'goto done' and 'done' label are not needed -
that's already the natural code flow...
So the 'goto' could just be replaced with a comment or perhaps with
--to_process.

