Return-Path: <linux-kernel+bounces-63716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB0A853391
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6BEB27CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013855812A;
	Tue, 13 Feb 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b="XltMvdij"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D855EE69
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835837; cv=none; b=UMvgz2oYagMY6yw3pl8VdObLcqybaWcegCBULoGJhpj9N3W6YH8nZ8LDaI4ktnQa+orYh8RiB27rWiWRW86cXBAenZNce03SoBGUiukkwc7TasUBT/XUlBsqIRBq4MfB5mq3alypglwNxz8n9nzG3S0rC7YwfKpCJHeVV8t1FR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835837; c=relaxed/simple;
	bh=CZoN3i7XJzre4jd4qikn3fslxobuEEEJDNql/BAQ0/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAbeqZNGsPBi36Qy7aKl6rSsmhFjJENw9sZBDU3XG/qOH/QcmqGtj2AQ39V47/rttLE4HQizVtzgdvk3dZxtndoI5etOhDuA0Wf6Tlpi8oLm8zUmK4JLRAN5Tpig4fiflniynp6qyvWa+SZsEoAv9lxctJFup+gupuTZfQVx21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re; spf=pass smtp.mailfrom=mwa.re; dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b=XltMvdij; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mwa.re
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5114c05806eso7103102e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1707835833; x=1708440633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIriFNrO5RwDl0i8OFgd8O5e6yhYA4cnaSts661zHg4=;
        b=XltMvdijGPwlIJbJKI9asq1MbMVkCeNT6bgaLoL9drYtnRSDorpL62fRPTcdXFMK1y
         ZcGbuaEjW/qqnhxKkWYmU6agO9KzyE14mcAYP8tXhaXytqzeHg1r/YTRAmP4zFd9w1Zf
         CD9gpTpQ2f72nqCWfoKpO7tQ7j4ly7KQDixtgCkPIdavEpTlaRKCJaYpS8dRs4J+o97B
         eFXpFVE9SBB7H1L7dp6peC6RpT/CIdfZUDJPu9fRpJqj54V7nPObg2COnUx/w4lbozs1
         OU2s9Pl2s+iMeVUA5uLIJE9iNqy0Gc2If3aERiSIyJ0biLuVQ72Ir/AODdmb47T29hJI
         vRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835833; x=1708440633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIriFNrO5RwDl0i8OFgd8O5e6yhYA4cnaSts661zHg4=;
        b=pDrok7hi0dLvQpUwTDHSTE5Phv7O2826kojYlAl9f8jOsHOJkcuvAKAxto6S05Vcli
         7WztGPyCuxOogDQmBxA3EPK+y+FgslcntH5qVXkjdbtbMyf7lB1Y3/x3gnL2dhT93JLG
         txYe5muhQyeUjpNgYbvpza7NlVMP2XXdifBbugcmC2N5pUiZYYOc7OYPEJOD6Pw3/dXs
         4rejvtbNw+FGu5PTaN2LB1PrzHxcE7mcuU5EwvTcdgIlnAtbQp4bnuTQRdAaxFWn+IGd
         WmELZxwtSxyd+shSDyd1ULtKNaKtdpvM9sk+/4uVbXhwwF1yS4EfM+hesREJECT2mKCK
         +qvg==
X-Forwarded-Encrypted: i=1; AJvYcCVHBjIvBGKdCKudRGzSgYG5a2DO4pzoTkvzFWkXJE+TSdzirJftIDnaJ5mVURWmFq6B2oM+7mt4riEnhGNWBoE8N9g0kWDWnDX+QM/4
X-Gm-Message-State: AOJu0Yx5py3xSVSfvIDnfeVLa916azCCGEEnlWrCac+okxnPDgiL2HfC
	FPL4IItab6CMwLbImUohFELr67AeS+JmcM7NRn7vqSHZGyk5t9PT8gWpuLLDUrnE+vmMPhsy32u
	3bdTuqDVQ4UDAcql6t7nqsgofhHzAH/TbkDiiPw==
X-Google-Smtp-Source: AGHT+IHxYSwVhZhFR6FRJarX3HSiuN0jewWaPBZ+hlua2hMm5m6FSUCCwcoPApsKWpjN0PEEMuG0WfXqcLCGiOPO4pg=
X-Received: by 2002:ac2:41ca:0:b0:511:1ed7:61b8 with SMTP id
 d10-20020ac241ca000000b005111ed761b8mr6948902lfi.30.1707835833350; Tue, 13
 Feb 2024 06:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANi1PHh4W7KPagKkvZW6cNAQqgAeG3zxaaTJKkg3KiTbsFRMdg@mail.gmail.com>
 <1b2558f7-94ea-123e-dd3f-b43ecd85c2ef@linux.intel.com>
In-Reply-To: <1b2558f7-94ea-123e-dd3f-b43ecd85c2ef@linux.intel.com>
From: Jan Henrik Weinstock <jan@mwa.re>
Date: Tue, 13 Feb 2024 15:50:22 +0100
Message-ID: <CANi1PHhY67HZxivA9mCoNXfM4YUOjm=tCZsnhrrcu4E6dqDYUQ@mail.gmail.com>
Subject: Re: XHCI without USB2 ports
To: Mathias Nyman <mathias.nyman@linux.intel.com>, mathias.nyman@intel.com, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Lukas_J=C3=BCnger?= <lukas@mwa.re>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Di., 13. Feb. 2024 um 10:58 Uhr schrieb Mathias Nyman
<mathias.nyman@linux.intel.com>:
>
> On 12.2.2024 20.39, Jan Henrik Weinstock wrote:
> > Hi all,
> >
> > I am currently working on an XHCI platform device simulation model. I
> > noticed that the Linux driver (Linux 6.5.6 xhci-hcd) stops working
> > when I configure the model without any USB2 ports. During an interrupt
> > (TRB_PORT_STATUS), I only get "xhci-hcd 12100000.usb: ignore port
> > event for removed USB3 hcd."
> >
> > During xhci_irq, in handle_port_status, xhci->shared_hcd is NULL [1],
> > so the interrupt gets ignored. However, shared_hcd would only ever be
> > allocated during xhci_plat_probe [2], if the device has both USB2 and
> > USB3 ports, i.e. xhci_has_one_roothub returns false [3].
> >
> > Without any USB2 ports, a shared_hcd will never be allocated in the
> > first place, and handle_port_status will always exit early.
>
> This is true.
> That port handling code is from a time before xhci driver supported singl=
e
> roothub setups.
>
> I think all single roothub cases so far have been xHC hosts with only USB=
2
> ports. This is probably the first one with only USB3 ports.
>
> I have a vague memory that USB3 specification would require USB3 ports to
> be backwards compatible, and support USB2.
>
> But xhci driver could still support it, does this change help:
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index f0d8a607ff21..6ef081f5ef05 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1893,7 +1893,8 @@ static void handle_port_status(struct xhci_hcd *xhc=
i,
>          }
>
>          /* We might get interrupts after shared_hcd is removed */
> -       if (port->rhub =3D=3D &xhci->usb3_rhub && xhci->shared_hcd =3D=3D=
 NULL) {
> +       if (!xhci_has_one_roothub(xhci) && xhci->shared_hcd =3D=3D NULL &=
&
> +           port->rhub =3D=3D &xhci->usb3_rhub) {
>                  xhci_dbg(xhci, "ignore port event for removed USB3 hcd\n=
");
>                  bogus_port_status =3D true;
>                  goto cleanup;
>
> Thanks
> Mathias
>

Yes, this patch fixes the problem for me. Thanks!

Is it so unusual to have an XHCI that has only USB3 ports?

My understanding was that a port can either be USB3 or USB2 (assigned
via the Supported Protocol Capability).

This would mean that in order to work correctly with Linux, all XHCIs
right now would have to support at least one USB2 port in addition to
their USB3 ports.

Best regards
Jan

--=20
Dr.-Ing. Jan Henrik Weinstock
Managing Director

MachineWare GmbH | www.machineware.de
H=C3=BChnermarkt 19, 52062 Aachen, Germany
Amtsgericht Aachen HRB25734

Gesch=C3=A4ftsf=C3=BChrung
Lukas J=C3=BCnger
Dr.-Ing. Jan Henrik Weinstock

