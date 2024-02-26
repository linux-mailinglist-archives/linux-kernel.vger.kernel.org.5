Return-Path: <linux-kernel+bounces-82375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D5868367
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B326928E2C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82082131E57;
	Mon, 26 Feb 2024 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtRu16vM"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431F130E55
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984611; cv=none; b=LKsd5Z6ZmDmeBWh90FvVcKuaQst6MaX64U8RbyXVYJgMJBGm5eJzKASVdV/+qQ5D4c1O9RXSZ3S4ZqIjW06zlc/9U+sp/SEh27mloizaxpb4W6khNhIwx+08xjHIEHVdm20R1+WwDdJGyPxLhBoMjuOMMCHXScIwcW0a+8dtfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984611; c=relaxed/simple;
	bh=8u2FC3jAwvrF6TPDojQJKao+PCsVs+BnFj6gQL2hy2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utoDeILkcmEnq4x2tDM9s3jFJKPWZgjyEIGUnf+NCXUxVnbkWxUxyFmTDmuc/JpOK4U9vwJZH+N3PzFIRnVYbFm+Q7RnfogmuVoRYq2RWgNU659HC17qEbYmMn2mlM/4bIHzOeJBNLaY83xaPbO9WNSNVicSTFGqnRU2lb58Bec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtRu16vM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so617a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708984607; x=1709589407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azUYynWCdgGcNWjxX8ZZ1okg2QCYfjC5Um2iCEPR9g4=;
        b=rtRu16vMxr4Br2s/krLpxlMa3gUY5w+R0egHVC7ddsFzjFQIJYa6kDxxvB2r9FZ5uY
         E4/P81DN09m1P3m0551nQtaaquRSJvNVLhHkOfaTRKJuCeyXgV81AZ7y/PnOgTLHA/HI
         pD3MgUo5ixURyg83HGl/W74U+870irPHOV11fXp3Tol+CXdkz/e8WrQsF4qTQHscVJOu
         XTRKnicFT9+jLbp/IqOtC9HJrsUQsZrKAbTy7+jzdHY5og0UKXPbmfgRVVp6+WPY9UR2
         uIJLoAfxza0FTbnPJK7aI9o0kqqyb83Pl6Bm78d+yna5WSrOHJGa3rh2Ww25zMGHQyDY
         B0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708984607; x=1709589407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azUYynWCdgGcNWjxX8ZZ1okg2QCYfjC5Um2iCEPR9g4=;
        b=daS0d358gPfRQhBe/fAePne/YOca4IdtW0Ey4wBbQMiR+4nFNnfBi2+WLwpa3zYsXx
         ZhVr9xvFFhbETsFqunfrNyHGG2qTDd6I4B5D4StB3UWjlTjUW11WR0Jcf2qOPcGW3pvQ
         aoRXPS8GvygterU8nqBWLnBrz3Zn7HhvvsYiUt1s1IKVg3QxdRL1iPOXBWAvKws/4vyU
         CsqGEusgePlgwOBWHCcGmq8RD9RoHUwlj6kc+zx5uTGNZrZGBts2vxCjLhRZ7IyHtdX+
         ++WqggOD6Sx+UuQkArnKoFcO3Ufr1TtwpUoOHjeccAm68f7jkfgXxpW8a96j6VLfdmu5
         n9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVABgsWuUYz3/hMP9I0T0KV4bmoCOu0pBjfy+BCeoKmM99iqe2lueMxEedyB0q04HKAcPNNvnI/A8pxaXSz9aF/CC78HMr1r/hkLw2z
X-Gm-Message-State: AOJu0YxqAyJiT2Jnc1kKKy/iIWsSEVkvFGy+jD/qS2fmFV09ARsKP3v/
	Ge5AHLJU9EVu0/4u7f1nFwkHhUfvCzOkcZn9JyDXdWC3Bn8XGo/c11sGzURqNqNKDBGsHg4P36b
	10DDyRQDjho9PNNKmCTfE4G6ew8NnH3ofmR3H
X-Google-Smtp-Source: AGHT+IFi3ylAsCIsvdv/4W6+maO7OqFdyJK2LjzRb/kVlH1D+Q89qTQR6aA+BoWJaN4QVWomh07SqDONCGS3/cNvlWI=
X-Received: by 2002:a50:9e2a:0:b0:565:ad42:b97d with SMTP id
 z39-20020a509e2a000000b00565ad42b97dmr89705ede.0.1708984606786; Mon, 26 Feb
 2024 13:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226112816.2616719-1-quic_kriskura@quicinc.com>
In-Reply-To: <20240226112816.2616719-1-quic_kriskura@quicinc.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 26 Feb 2024 13:56:30 -0800
Message-ID: <CANP3RGf7qsuwcgVpmOoH0QNh-v4PjRh_xj7Rcz=YJ1TbGiPK0Q@mail.gmail.com>
Subject: Re: [RFC PATCH] usb: gadget: ncm: Fix handling of zero block length packets
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 3:28=E2=80=AFAM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> While connecting to a Linux host with CDC_NCM_NTB_DEF_SIZE_TX
> set to 65536, it has been observed that we receive short packets,
> which come at interval of 5-10 seconds sometimes and have block
> length zero but still contain 1-2 valid datagrams present.
>
> According to the NCM spec:
>
> "If wBlockLength =3D 0x0000, the block is terminated by a
> short packet. In this case, the USB transfer must still
> be shorter than dwNtbInMaxSize or dwNtbOutMaxSize. If
> exactly dwNtbInMaxSize or dwNtbOutMaxSize bytes are sent,
> and the size is a multiple of wMaxPacketSize for the
> given pipe, then no ZLP shall be sent.
>
> wBlockLength=3D 0x0000 must be used with extreme care, because
> of the possibility that the host and device may get out of
> sync, and because of test issues.
>
> wBlockLength =3D 0x0000 allows the sender to reduce latency by
> starting to send a very large NTB, and then shortening it when
> the sender discovers that there=E2=80=99s not sufficient data to justify
> sending a large NTB"
>
> However, there is a potential issue with the current implementation,
> as it checks for the occurrence of multiple NTBs in a single
> giveback by verifying if the leftover bytes to be processed is zero
> or not. If the block length reads zero, we would process the same
> NTB infintely because the leftover bytes is never zero and it leads
> to a crash. Fix this by bailing out if block length reads zero.
>
> Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's=
 in unwrap call")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>
> PS: Although this issue was seen after CDC_NCM_NTB_DEF_SIZE_TX
> was modified to 64K on host side, I still believe this
> can come up at any time as per the spec. Also I assumed
> that the giveback where block length is zero, has only
> one NTB and not multiple ones.
>
>  drivers/usb/gadget/function/f_ncm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/fun=
ction/f_ncm.c
> index e2a059cfda2c..355e370e5140 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -1337,6 +1337,9 @@ static int ncm_unwrap_ntb(struct gether *port,
>         VDBG(port->func.config->cdev,
>              "Parsed NTB with %d frames\n", dgram_counter);
>
> +       if (block_len =3D=3D 0)
> +               goto done;
> +
>         to_process -=3D block_len;
>
>         /*
> @@ -1351,6 +1354,7 @@ static int ncm_unwrap_ntb(struct gether *port,
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

In general this is of course fine (though see Greg's auto-complaint).

I haven't thought too much about this, but I just wonder whether the
check for block_len =3D=3D 0
shouldn't be just after block_len is read, ie. somewhere just after:

block_len =3D get_ncm(&tmp, opts->block_length);

as it is kind of weird to be handling block_len =3D=3D 0 at the point where
you are already theoretically done processing the block...

I guess, as is, this assumes the block isn't actually of length 0,
since there's a bunch of following get_ncm() calls...
Are those guaranteed to be valid?

I guess I don't actually see the infinite loop with block_len =3D=3D 0,
since get_ncm() always moves us forward...

Maybe your patch *is* correct as is, and you just need a comment
explaining *why* block_len =3D=3D 0 is terminal at the spot you're adding t=
he check.

Also couldn't you fix this without goto, by changing

  } else if (to_process > 0) {
to
  } else if (to_process && block_len) {
    // See NCM spec.  zero block_len means short packet.

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

