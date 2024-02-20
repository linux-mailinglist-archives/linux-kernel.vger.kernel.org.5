Return-Path: <linux-kernel+bounces-72727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C385B85B803
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FA91F26B09
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95363410;
	Tue, 20 Feb 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lhMvpXN9"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975762172
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422215; cv=none; b=muakdn6wX+E0kt/kkEF7yrjNsIYBqZ9iDcE3fe4eFgavXXUaC6k5tJfhyO9fAnCZChpFWI67s+knVbxQlrwp9NtYV/XkyIrJ4J1YIJt+LAAk+0R8N3shMLyQBrmKuR0k4hHhTKvkTDK5VKJuDFrDvawoFsE6CZ4vQWC8YsaslbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422215; c=relaxed/simple;
	bh=rlFKBjfxBfB5przc60p+qp81VvS1nj/vKLjjDNglv3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWrsCMS0Saug1RlGk2wx84rZxAMfqdJNH2mC8NHnv/nLHFt8X+gxty9JbDN5hZvbQD6K+2mPQhp37L5FpsvBDa+8udbVwbhjSTKih96b6Ah9Ac+sHLtb+M5MUjANCHmxtIL89Z37/zr5u6OCAlG1LS8TYMH4sVIhgKp+QN08C+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lhMvpXN9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so7048666a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708422213; x=1709027013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wXGNSO7EAp4ThzIsFzmHN2w6lFZhp54XNCpapquw2M=;
        b=lhMvpXN904q2pks39RZqlAavJW8u9xVuxVNfmDwC0VRkR06xSxBTTOcx2TmUarqFOw
         n29uVI1hmLITquzoPhEO7VBmWTKO/iWJgzxkpJ6R8JUU0OPq6fVsuY1nRTL047tONHdj
         YxSo+arbnPZxqXm8fn79pXozFqIV7zoZwJc6uRIuLggcZmmzo2lruNee7VgS7r3nWh1H
         C3OEn3+EXha5AdDMtvirEUAf1JyYTjbnHFFtkaewLNamlU+UWsZmeRP4DbrN+JFwmCRy
         Wm1hMSAMefS1I/wjZXERJhqnapVlX9I2MwJ06AvkQwZsku8CHo2TLXPqKsbu46FAgfzI
         H/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422213; x=1709027013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wXGNSO7EAp4ThzIsFzmHN2w6lFZhp54XNCpapquw2M=;
        b=GlWju0OUxGXRgeCPU9BNoNoxbzNKWc+G1tS6tmX2xeiaGN18Jzz6Q2MsCLEfCILRQn
         mR0pXfM6LNT5xc36pVYn+PxVlZz5elqkSlaLhgdR6ykeTVDJEoATNNtnjIERM5dzFE3L
         7rauCUu0Z7smcCissv2gOZVgZRTy63S1SegT3EcxrknnY+OwQIBQVlVdWMHbw2ORXSTx
         lSEMU1q5r8VP1Qx5Si8TNcEghoUhafMTpVsR1YwmAKh2Z2y/DNc7BXFwQyQ9ffI3tPrG
         wNcXgxNTW9yYWBl/4fgeZDmTnpkcG0tJppPQyeouDQrUN9OSDRimdpfduWgZ/Kai9+Vv
         Rwgg==
X-Forwarded-Encrypted: i=1; AJvYcCVbzbaipwoKa5ENXiiZS39MOAP1po1oNYWRE6mDg03xOy6z6rU2qquX3huF+No2xijQll2jDlmVl/V29TLorzL5VAhf1Ic+DuzNz79+
X-Gm-Message-State: AOJu0Yy2x6XYuGdn0gHrukK2bSjToUNsoefNJPenbdBgmzQtJhU16SZR
	xedJ3JJRMYDe1MkskJ/6E7xql3eIS1ufeaQFF1M3h2qXxMiHI81TugZvA1UOoTUG5imRLazCoSJ
	DlDD2TSwOn6069MkTEmRyx6vUyEJQocutC5QR
X-Google-Smtp-Source: AGHT+IGo8bMi1ufIugwBQxJ09WQnYJlAWn1e8eQOJeCgyp5JhtuInq+rAAuyt68+BhpUHU0p7WmO3Bz0UMzJA8+aWuo=
X-Received: by 2002:a05:6402:3588:b0:564:762c:fe5e with SMTP id
 y8-20020a056402358800b00564762cfe5emr3859938edc.20.1708422212502; Tue, 20 Feb
 2024 01:43:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220081205.135063-1-raychi@google.com> <2024022024-trout-kennel-6d14@gregkh>
 <4d62d4d0-3f28-486b-8132-4cc571b6f721@quicinc.com>
In-Reply-To: <4d62d4d0-3f28-486b-8132-4cc571b6f721@quicinc.com>
From: Ray Chi <raychi@google.com>
Date: Tue, 20 Feb 2024 17:42:56 +0800
Message-ID: <CAPBYUsD=3ux8RXgRcroVsmpqNs0D+2NeLhqPHh3TBB_oq=ziXA@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: remove warning during kernel boot
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Thinh.Nguyen@synopsys.com, 
	quic_uaggarwa@quicinc.com, albertccwang@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

I verified the Thinh's patch and the warning could be
fixed. Thanks for the information.

Regards,
Ray

On Tue, Feb 20, 2024 at 4:40=E2=80=AFPM Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 2/20/2024 2:04 PM, Greg KH wrote:
> > On Tue, Feb 20, 2024 at 04:12:04PM +0800, Ray Chi wrote:
> >> The dwc3->gadget_driver is not initialized during the dwc3 probe
> >> process. This leads to a warning when the runtime power management (PM=
)
> >> attempts to suspend the gadget using dwc3_gadget_suspend().
> >
> > What type of warning happens?
> >
> >> This patch adds a check to prevent the warning.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference =
in dwc3_gadget_suspend")
> >> Signed-off-by: Ray Chi <raychi@google.com>
> >> ---
> >>   drivers/usb/dwc3/gadget.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> >> index 28f49400f3e8..de987cffe1ec 100644
> >> --- a/drivers/usb/dwc3/gadget.c
> >> +++ b/drivers/usb/dwc3/gadget.c
> >> @@ -4708,6 +4708,9 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
> >>      unsigned long flags;
> >>      int ret;
> >>
> >> +    if (!dwc->gadget_driver)
> >> +            return 0;
> >> +
> >
> > This directly reverts part of the commit you say this fixes, are you
> > SURE about this?  Why?
> >
>
> Hi Ray,
>
> Thinh sent a patch recently addressing the issue in soft disconnect.
> Can you check if it helps:
>
> https://lore.kernel.org/all/e3be9b929934e0680a6f4b8f6eb11b18ae9c7e07.1708=
043922.git.Thinh.Nguyen@synopsys.com/
>
> Regards,
> Krishna,

