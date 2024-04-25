Return-Path: <linux-kernel+bounces-158795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963698B24FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DD0B25D25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D655A14A63D;
	Thu, 25 Apr 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mUue0AZn"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A337152
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058593; cv=none; b=ayhc1U4B0pCScVSrM5Da7FHk3xNNq1PvcABYL3TM5Kn+RUOfPnGR5t7Y4ch7iPX9ZxuMYkATIvsQRoSY+PdW7/9V5McR42usFZNOPqT7MDkg26vsS8z+0fgvzqC39VvTTc3AVY1PsrBe4FPy1Yzt6ObSS6IoHN1w4vX7RexvuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058593; c=relaxed/simple;
	bh=XwZ+JO6jMDuVSzFezGDh19khl4PM1718Rezhq94PIV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI0gZZHFozp7kUAPfsbdXTFUhzqyLT3ZsHngriP3+m4sRFIXfHzknWE/+H6nGXwxF6uFh5afoc2sWMmGj3AR1GMuTqoD9/IZL54U2befUjoTl1ktOdw6HA/RY/7PAoOVc6Ibw3dQVe6d/cnVzpLwtPCoz9cbXAln3gc37AfaPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mUue0AZn; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78f02298dc6so97614685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714058589; x=1714663389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwZ+JO6jMDuVSzFezGDh19khl4PM1718Rezhq94PIV0=;
        b=mUue0AZnE5ty6DERUkqssfyVsxShep+2qc0Pd6+0HUBtR1cBgRvCNiD9HBCOxrEVnq
         9e5vaC8oLgprfoc+0HgVrJ8Ul7OvVLC288jUPlV5MAzrQjdFqZSfZz0birXYRC62Pe3k
         +aJXOSNuZ8J7HEryfBSyVcLmEvBEAVRNDcLXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714058589; x=1714663389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwZ+JO6jMDuVSzFezGDh19khl4PM1718Rezhq94PIV0=;
        b=loR3jkFCBWMt/J9h4uWiIqv3ZG9/P5rVxQbXuN39kqMFB/xCos8WuwwLnlt6r12Uoc
         siMYrKYbZ5bKpfYViZPEUweKv3n1WS9GN1CYetyVw4M6RaGu547bf2BLfop1hqk94RKz
         WTLZDyxl/6EyhoKQ9ti+4MGFFWDiWWnRUZdUsKql4/asch0bhM0ebeuTOBIMaOEPvgLF
         zLi4swUVhtOYsv6Q/0v8thoemckR/ToY+DcDvnVSx1SuTT1O2pw/Fm3uA34I7R9gGwau
         NNaIFdQA7xW4IeUxvomBIcLH7cunIqoDf/5bwTIdYFYQoY/gf62Y38r4szTG53NfTH+Z
         KGvg==
X-Forwarded-Encrypted: i=1; AJvYcCWhNNn+3hqyVO0+DFdaZEnLht88rZNle6QyAZZzcM71Q7B8uMAcXO+sqXPgWvqX6u1ltna940+rULoDX0xtFYLqkEDSe5l26UWgSVPJ
X-Gm-Message-State: AOJu0Yw+e1QazYihIZy0igBK8PJztMNhV5TC0O2ojfXP9Xo/oZmC5cq2
	Hm1u32nWvzQTfC6mf73GBQI81+9ttqxYpcDl+ERb2UUaCTd1UxxdnFxJ+tizh7qgCPWgMciKskM
	=
X-Google-Smtp-Source: AGHT+IEni6Mnn+/IE8u9hcNtyGBuY2W/Vx4E3kI7d6sDIjdZjaZqj1+BsvQ99dEk7mixXoXOYOiRfg==
X-Received: by 2002:a05:620a:2987:b0:790:98c8:a765 with SMTP id r7-20020a05620a298700b0079098c8a765mr148231qkp.1.1714058588996;
        Thu, 25 Apr 2024 08:23:08 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id o17-20020ae9f511000000b0078f1044bd68sm6850083qkg.50.2024.04.25.08.23.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 08:23:08 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-436ed871225so320741cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:23:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRiUl7Emvk2CvGnL4dylQ+rEkUKWzIcwOWbWuiB2tIWWNr56tzH1LIliov0/LSEDPDHzWBRuVCxIXEUB3r0teFSPSOF/pUv9AkjGlf
X-Received: by 2002:a05:622a:5097:b0:43a:381f:6b11 with SMTP id
 fp23-20020a05622a509700b0043a381f6b11mr264680qtb.19.1714058587159; Thu, 25
 Apr 2024 08:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com> <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com>
In-Reply-To: <ZioW9IDT7B4sas4l@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Apr 2024 23:22:50 +0800
X-Gmail-Original-Message-ID: <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>
Message-ID: <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 4:40=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> > > I assume all Trogdor boards use the same controller, WCN3991 IIUC, bu=
t
> > > if you're worried about there being devices out there using a differe=
nt
> > > address we could possibly also use the new
> > > "qcom,local-bd-address-broken" DT property as an indicator to set the
> > > bdaddr quirk.
> >
> > They all should use the same controller, but I'm just worried because
> > I don't personally know anything about how this address gets
> > programmed nor if there is any guarantee from Qualcomm that it'll be
> > consistent. There are a whole pile of boards in the field, so unless
> > we have some certainty that they all have the same address it feels
> > risky.
>
> Hopefully Janaki and Qualcomm will provide some answers soon.
>
> And otherwise we have another fall back in that we can use the
> "qcom,local-bd-address-broken" property for Trogdor.

Quick question. I haven't spent lots of time digging into the
Bluetooth subsystem, but it seems like if the device tree property is
there it should take precedence anyway, shouldn't it? In other words:
if we think there is built-in storage for the MAC address but we also
see a device tree property then we need to decide which of the two we
are going to use. Are there any instances where there's a bogus DT
property and we want the built-in storage to override it?

-Doug

