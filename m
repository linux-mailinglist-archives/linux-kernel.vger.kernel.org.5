Return-Path: <linux-kernel+bounces-46986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59205844788
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3DC1C22684
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA3B2E842;
	Wed, 31 Jan 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2ciPy2l"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13A210E2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727291; cv=none; b=AwCOGzF6d+sN83yeFELvcXrcROCwWakXu85EJBVYUa58nHtVu5cUGx5M4hhcuehOg0GSHqqYkCgRNNi/aSXMgzc1vuuyx0C+CkV5pk1NME91DvLQxVzl5Ub3zDOWenmNZ8XaAgpqVMSzJg6xuUrTCZGIpe1pOoe6l8VVNP2V52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727291; c=relaxed/simple;
	bh=3V+YKvKrpBbnFWyJ6WDt6SSY9qJtRsghsH0vEdHvFZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Juz05cceFNUJco3nb9NdlfLK3Ld1wBQU/FiNHPcT8GyaT7vDtv1kSAuqhKKbly4hKalzoH/mmbo02NlnXJOUT1QicKwI6SqOfdN4/1ehuW8FkE1GnIQcv9b+jeOLGXaApd5sOEJSya+2+FzS2JfuMp+Kp7ohqcMcf80BGJi/M4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2ciPy2l; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f85a2a43fso1149a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706727288; x=1707332088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ComD7hCLm/APlWm7DsL+N9hy5N2gsE2j2HsRU5ZeSCQ=;
        b=T2ciPy2llBq2hfa8gi8zaxHelYKmI8LePiyhTV8Tp8pBY7EI61tUezQiQaGY+tS8Xw
         uSfUffdNlsRWvhRUtauY0QLUoXGOpZ4SLVrD9XvOPhjjIDazUcnsu8OTXX91VYQZdENv
         2SV3IuckEicm39qCb/XqU98SUuReoh7mRxIKEtBZ6JKbf7aeO+0zY2mYG+V62mrdtuAs
         TEKfZ9aCQxUOwseOuFoqwSPNux0AXY4+oRnjAbAlOPy+8M0KTbNACtGPsL8p8D2lx/eQ
         aQkVbJF34YEj+40VxEWdksXtmw9xOvTOtuqyYqmW1n8p0XHxHmGMrgnyIQJKvlwX6ViX
         3JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706727288; x=1707332088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ComD7hCLm/APlWm7DsL+N9hy5N2gsE2j2HsRU5ZeSCQ=;
        b=dUBWYdkaBCv7LK7yfE/g5xA/oyF2q0iOabToa1iemjgqipogUuIy/tg5SHRHHPlJi3
         Vugb5IkOwXAibL9zdRb1aRoj5jZNAvrvEkA+sYfHG7pGGi6aI6GEP4oWe5UXYPIgk1fD
         nXnFg+qD6elYmoXZ6iWyT97Lw8oHs+a75aLqq+owm4TBKSSjKcn9s16BpTvPvMyC1r0C
         PwLZVpUZFLgRrDYCNf3C2fkefn5nuZ2n1bO6r7e+eHlMxU+1oDxaX4qDtDHtBKWaqeu8
         ME9NQZc9bGuTCm29LpqgzKoY8ZOynf4B8J8WBpu8ISYfJbLi8YViUNRjvn/zkG2XMjfo
         d2KA==
X-Gm-Message-State: AOJu0Yy8XWsY5YKYSYgN+qm3/nlvs7uUlYcgBNNHHNOzjnMFHoWvQuml
	rWGYlc3JoMf11BUVBC32DFaasesZwl0NFVthGo8MDIBtLDeNDotYa3/g1KFPlJ102b9/1u5Ms+0
	GreaDXolYrHsle1Djqbs+Q0lZSyW5xLl//eAM
X-Google-Smtp-Source: AGHT+IFPqW+JAe3FMYW5uOJ0tiy02m+Ybg2K+5UdAWNQfGiZmP6e9PMEYj1P2kR1SojU1yeHBjOc6LJHwF+CeomoT8M=
X-Received: by 2002:a50:d618:0:b0:55f:649c:2617 with SMTP id
 x24-20020a50d618000000b0055f649c2617mr33737edi.2.1706727287698; Wed, 31 Jan
 2024 10:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131150332.1326523-1-quic_kriskura@quicinc.com>
 <CANP3RGeHXmEcDN=-h1uGBzu_Ur2UcmiEuFDXAEr0Z2ptXnHq=Q@mail.gmail.com> <47bf719c-a5c1-473b-9fa0-8cad84f0721c@quicinc.com>
In-Reply-To: <47bf719c-a5c1-473b-9fa0-8cad84f0721c@quicinc.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 31 Jan 2024 10:54:31 -0800
Message-ID: <CANP3RGf8=3OwCDnE8UT8PQNRwQrtLO97_yR+Vm0h12Q3anbtVA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hardik Gajjar <hgajjar@de.adit-jv.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:08=E2=80=AFAM Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 1/31/2024 10:33 PM, Maciej =C5=BBenczykowski wrote:
> >>
> >> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/=
function/f_ncm.c
> >> index ca5d5f564998..8c314dc98952 100644
> >> --- a/drivers/usb/gadget/function/f_ncm.c
> >> +++ b/drivers/usb/gadget/function/f_ncm.c
> >> @@ -1338,11 +1338,17 @@ static int ncm_unwrap_ntb(struct gether *port,
> >>               "Parsed NTB with %d frames\n", dgram_counter);
> >>
> >>          to_process -=3D block_len;
> >> -       if (to_process !=3D 0) {
> >> +
> >> +       if (to_process =3D=3D 1 &&
> >> +           (block_len % 512 =3D=3D 0) &&
> >> +           (*(unsigned char *)(ntb_ptr + block_len) =3D=3D 0x00)) {
> >
>
> Hi Maciej,
>
> > I'm unconvinced this (block_len % 512) works right...
> > imagine you have 2 ntbs back to back (for example 400 + 624) that
> > together add up to 1024,
> > and then a padding null byte.
> > I think block_len will be 624 then and not 1024.
> >
> > perhaps this actually needs to be:
> >    (ntp_ptr + block_len - skb->data) % 512 =3D=3D 0
> >
> > The point is that AFAICT the multiple of 512/1024 that matters is in
> > the size of the USB transfer,
> > not the NTB block size itself.
> >
>
> Ahh !!  So you mean, since this comes because the host doesn't want to
> send packets of size wMaxPacketSize on the wire, we need to consider the

of size 'multiple of 512 or 1024', but yes.

> length of data parsed so far to be checked against 512/1024 and not
> block length.

I believe so, yes.

I believe they are trying to avoid having to send ZLPs.
That's determined *purely* by the size of things as they show up on
the usb cable (ie. the size of the usb xfer).
ie. that's where things that are a multiple of 512 (USB2) or 1024
(USB3) need an extra 0 byte sized packet to prevent ZLP.

The actual size of the NTB doesn't matter.

That said... maybe we're overcomplicating this...
Maybe it's enough to just remove this modulo check entirely (I know I
asked for it before).

Ultimately if we just do:

// Windows NCM driver avoids USB ZLPs by adding a 1-byte zero pad as needed
if (to_process =3D=3D 1 && !*(u8*)(ntb_ptr + block_len)) --to_process;

it'll fix the problem too, and perhaps be easier to understand?

> But either ways, the implementation in the patch also the same thing in
> a different way right ? Process all NTB's present iteratively and while
> doing so, check if there is one byte left. So if there are multiple
> NTB's mixed up to form a packet of size 1024, even then, both the logics
> would converge onto the point where they find that one byte is left.
>
> >> +               goto done;
> >> +       } else if (to_process > 0) {
> >>                  ntb_ptr =3D (unsigned char *)(ntb_ptr + block_len);
> >
> > note that ntb_ptr moves forward by block_len here,
> > so it's *not* always the start of the packet, so block_len is not
> > necessarily the actual on the wire size.
> >
>
> Apologies, I didn't understand this comment. By moving the ntb_ptr by
> block length, we are pointing to the (last byte/ start of the next NTB)
> right as we are fixing in [1] ?

I was just pointing out why the above doesn't (afaict) work.

>
> >>                  goto parse_ntb;
> >>          }
> >>
> >> +done:
> >>          dev_consume_skb_any(skb);
> >>
> >>          return 0;
> >> --
> >> 2.34.1
> >>
> >
> > But it would perhaps be worth confirming in the MS driver source what
> > exactly they're doing...
> > (maybe they never even generate multiple ntbs per usb segment...)
> >
>
> Yes they do and we made a fix for that in [1].
>
>
> > You may also want to mention in the commit message that 512 comes from
> > USB2 block size, and also works for USB3 block size of 1024.
> >
>
> Sure. Will update the commit message accordingly.
>
> [1]:
> https://lore.kernel.org/all/20230927105858.12950-1-quic_kriskura@quicinc.=
com/
>
> Regards,
> Krishna,

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

