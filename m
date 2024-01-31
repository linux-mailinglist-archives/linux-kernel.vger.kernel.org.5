Return-Path: <linux-kernel+bounces-46858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2B584457F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A421C20ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C88112BF32;
	Wed, 31 Jan 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldJ1QjP1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9E12BE99
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720617; cv=none; b=izhpTmbSi6cTgV9MRFK826Vry5dzBPHXyl1G1toXhitp4vJFW2c1HoSroDh1C7sX0wYAEcjIOYpg7Y1A5i0C+OIKONL18qUUpqMcYDWlHFMDkMYS9FOGuo3glnlGyYfobtm4vrF2MIJB/loxBr1BXjkicOQJxk2xz+hPi78B8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720617; c=relaxed/simple;
	bh=k5z0kfJjUREZSnHpb78Vy9aJZkf3Vm8DS3NBWI2dg0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGQwnPsCO+O57/5Wqb7wJRyohSJeh/LPhPjIb5bz34H2er8FKHzums0EHJXGvXD/L7U1raDYSfqxvMtfMxtwUX9W4e4t//fGTYSOW5mUPz2yh0E04IyiBd9z0Ns+UBjzgxOFQAKPaT4eKt4zm9ODFLkPQS0DicqqAPmyUrZnvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ldJ1QjP1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so9684a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706720613; x=1707325413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kAbr9rMOfiWUKrFn+5xYnZ12BoeCWRWCVm9Fg2uVqA=;
        b=ldJ1QjP1yTzbHtU5dtR0ToVudvrCaQ7QuR3L+Cyzpob6YmJloNWG+XWXlXScIOeDR9
         X0jAHM0kytorTHaQL9YAp6N/TIXHKChQCbVLzU1/HEfDtf1wCQtmmxW+T68mK9bCHxaz
         dHnPOo/3TYz0HK7pGutipSOm/UUj5WEBbZ+ZrrnieZkgd4mF+a6cU6JHl3ZKoPyFS0t7
         QTJ5KysYRh4cNf4U3YCxRualaAdD7h/0cgE+NL7yZz5Glv8FHXNrwzTpgAj9KiLsHlyA
         W+z1jGWJcQayE0uuk026EXt3huVBQWnsaJpxqpk0Y5d7xYe6D+bJCRdkoCuJe+Cx5RBH
         Mn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706720613; x=1707325413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kAbr9rMOfiWUKrFn+5xYnZ12BoeCWRWCVm9Fg2uVqA=;
        b=LgUE27dgYyv0Ht0F9KhIScTHSfjWGyiAwVvGOZMInLhwlTO8yZAMdJlBMeRViJAcSO
         EGNcMKWngutWeZ/UzV117ze6X9WvWM5HbZ0Z54ZbuhudhoY2CVkeetPxsvwZAjMYFzFw
         8gkEa/KtiC47G4rfFg3sJABNO8t3L68JA9F0a4XJIAvEkPhHmVJ3RABXX0FCdOuNCBAF
         IpucN7W2vkgDa8iYdtIrwi/fElPFhcj1KdjzINcLX17OlCKJ1WT/F2TJEbdAU45JA6mS
         0Z7sryn6zey7cEdNK/sGN8cUywy4Rn6bWwGak1JZ2MvbGCAjdLnWreV4nooFHEz94PR/
         R1Dg==
X-Gm-Message-State: AOJu0Yz4lUa0phbXdTiOknZ3I33T+xqao0fRko0fMj7lyqmoZ4yB28vk
	ljTD8gYsgBuJQrrC/TsCCrccJapIYGgeDBBA7JF7TqgDgM5ouBqfhu9yt90fakmLdzJ/QnJNuJ3
	yIyd8INOP7s3sFnORcTllLzZRUcVXjp3BKOmv5w2MpM5u2TyV7A==
X-Google-Smtp-Source: AGHT+IHLDFLqxUssM4sVwOZhBThb0eaK4xFarqS8UV9j+FGhRco2Uu28uMQ6+ppgu/6efVn+znERBFOVcJiQeioB7fc=
X-Received: by 2002:a05:6402:288a:b0:55d:2dda:f331 with SMTP id
 eg10-20020a056402288a00b0055d2ddaf331mr435965edb.7.1706720613353; Wed, 31 Jan
 2024 09:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131150332.1326523-1-quic_kriskura@quicinc.com>
In-Reply-To: <20240131150332.1326523-1-quic_kriskura@quicinc.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 31 Jan 2024 09:03:17 -0800
Message-ID: <CANP3RGeHXmEcDN=-h1uGBzu_Ur2UcmiEuFDXAEr0Z2ptXnHq=Q@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hardik Gajjar <hgajjar@de.adit-jv.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:03=E2=80=AFAM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> It is observed sometimes when tethering is used over NCM with Windows 11
> as host, at some instances, the gadget_giveback has one byte appended at
> the end of a proper NTB. When the NTB is parsed, unwrap call looks for
> any leftover bytes in SKB provided by u_ether and if there are any pendin=
g
> bytes, it treats them as a separate NTB and parses it. But in case the
> second NTB (as per unwrap call) is faulty/corrupt, all the datagrams that
> were parsed properly in the first NTB and saved in rx_list are dropped.
>
> Adding a few custom traces showed the following:
>
> [002] d..1  7828.532866: dwc3_gadget_giveback: ep1out:
> req 000000003868811a length 1025/16384 zsI =3D=3D> 0
> [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb toprocess: 102=
5
> [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 175199934=
2
> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb seq: 0xce67
> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x400
> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb ndp_len: 0x10
> [002] d..1  7828.532869: ncm_unwrap_ntb: K: Parsed NTB with 1 frames
>
> In this case, the giveback is of 1025 bytes and block length is 1024.
> The rest 1 byte (which is 0x00) won't be parsed resulting in drop of
> all datagrams in rx_list.
>
> Same is case with packets of size 2048:
> [002] d..1  7828.557948: dwc3_gadget_giveback: ep1out:
> req 0000000011dfd96e length 2049/16384 zsI =3D=3D> 0
> [002] d..1  7828.557949: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 175199934=
2
> [002] d..1  7828.557950: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x800
>
> Lecroy shows one byte coming in extra confirming that the byte is coming
> in from PC:
>
> Transfer 2959 - Bytes Transferred(1025)  Timestamp((18.524 843 590)
> - Transaction 8391 - Data(1025 bytes) Timestamp(18.524 843 590)
> --- Packet 4063861
>       Data(1024 bytes)
>       Duration(2.117us) Idle(14.700ns) Timestamp(18.524 843 590)
> --- Packet 4063863
>       Data(1 byte)
>       Duration(66.160ns) Time(282.000ns) Timestamp(18.524 845 722)
>
> According to Windows driver, no ZLP is needed if wBlockLength is non-zero=
,
> because the non-zero wBlockLength has already told the function side the
> size of transfer to be expected. However, there are in-market NCM devices
> that rely on ZLP as long as the wBlockLength is multiple of wMaxPacketSiz=
e.
> To deal with such devices, it pads an extra 0 at end so the transfer is n=
o
> longer multiple of wMaxPacketSize.
>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/gadget/function/f_ncm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/fun=
ction/f_ncm.c
> index ca5d5f564998..8c314dc98952 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -1338,11 +1338,17 @@ static int ncm_unwrap_ntb(struct gether *port,
>              "Parsed NTB with %d frames\n", dgram_counter);
>
>         to_process -=3D block_len;
> -       if (to_process !=3D 0) {
> +
> +       if (to_process =3D=3D 1 &&
> +           (block_len % 512 =3D=3D 0) &&
> +           (*(unsigned char *)(ntb_ptr + block_len) =3D=3D 0x00)) {

I'm unconvinced this (block_len % 512) works right...
imagine you have 2 ntbs back to back (for example 400 + 624) that
together add up to 1024,
and then a padding null byte.
I think block_len will be 624 then and not 1024.

perhaps this actually needs to be:
  (ntp_ptr + block_len - skb->data) % 512 =3D=3D 0

The point is that AFAICT the multiple of 512/1024 that matters is in
the size of the USB transfer,
not the NTB block size itself.

> +               goto done;
> +       } else if (to_process > 0) {
>                 ntb_ptr =3D (unsigned char *)(ntb_ptr + block_len);

note that ntb_ptr moves forward by block_len here,
so it's *not* always the start of the packet, so block_len is not
necessarily the actual on the wire size.

>                 goto parse_ntb;
>         }
>
> +done:
>         dev_consume_skb_any(skb);
>
>         return 0;
> --
> 2.34.1
>

But it would perhaps be worth confirming in the MS driver source what
exactly they're doing...
(maybe they never even generate multiple ntbs per usb segment...)

You may also want to mention in the commit message that 512 comes from
USB2 block size, and also works for USB3 block size of 1024.

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

