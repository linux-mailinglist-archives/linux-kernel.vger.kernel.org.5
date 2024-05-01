Return-Path: <linux-kernel+bounces-165087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9DA8B8794
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE9B1C21272
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81B50A8F;
	Wed,  1 May 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X+YdsjmR"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50655502BA
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555366; cv=none; b=ifkzo86oHmQDx6IJBCXgqFpPDp5eLoMbqwPd4YgjS8HzvGcsbaL1U9n5SD9Gldm1rfsK9KZzk4fWZ/dEspKAelzhW5XRWUsXsgKEO0CKiiJ7Wt/MQsXFSp8XORbDEZdFlORkQhdI+pWFSBy4wLjTOH1BHSvjnH0QRsNAz9a+G1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555366; c=relaxed/simple;
	bh=h454Qj5KhLSCbGhQvCNTcfUV1kbjFSC6wSOJxY/M/CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvS6W6pffnLuphq//2hcazIa5G0iv9zl6/dD46tEeTfN/i9CIk/+5h6AhuwjGoJFt2Kf5MesXk65E6RhJrhksQhiMUwxRFr+2mhvy/lo0ZKsr5grWA1EmJEDJmFMS2RM1b4KTiJ4El88ceaILKr3U4xaGvl9+iSfYY9ftUqmeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X+YdsjmR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43ab76cac73so5628291cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714555364; x=1715160164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8HAWxGiDH4jeEhVPnilAd/2cv2d7GxBiD11a90klzw=;
        b=X+YdsjmRtEMjWWEKXZkgbY8UJgvGZ9IASayBLrxN3oQAiO0LQ2dQRYhWjaiGmBSHck
         ogGOzViucCATnN9rZ+MHX7Jg8Xbwy9wWN/0gOqzOopkIxU5oH7JTzFwgQDegjz8FpVmY
         k8DlZheiqsqYaCzUWFXK12QiT7dmajqS6wo1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555364; x=1715160164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8HAWxGiDH4jeEhVPnilAd/2cv2d7GxBiD11a90klzw=;
        b=HexyqRfX4H6FZpVth1S9hw910zabCaGoL+6LoNFATxBEANieMAiruydeFKGWDsQ0os
         w3TyvP4Khw9DzTrgneRG1vqWs+3gFCnugfjgR/Ei/PJD7IYp4VOqFqbaZ1o7NIX/d7XR
         2i6x0fSe3xN2WohAVOuyymIZfjoLk82ecvL4o9DeVNJ3A3gbopzXHbYbauLxnNkM+t2F
         NrwbrmSk0x7aDhz3b3KIJtR7Lt74hFt3odwZMz018VBJ8mP/KdzWusvEKTNzaoAIihUD
         ZpPM8RFtfuN/wmrSJ5Woy20vlLTp1zDY/+i3jFqACJM+stnrtHGg+YJlVoxbpZ+rE41L
         8bOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8zBvIACfbCqbpJnCcigIro3jN4CH++j1qkbTLLquxL+FShEek+3Sr1kc8ReTWMXHgpKpkjStNmrcoiD/1Q0Prk/nrwOP+IDE32EsI
X-Gm-Message-State: AOJu0YzIKBZwQpLxjwEx6EbBvzti3DFPwn/rVycWMH4z9a/M4UssUzIo
	EwxQklTLrhETQGWb3J32X2NjMP/R1G1w/4zA0ld2IDmFjY+SnKfKjuJka7zxfF5a5/aI3lYEJvh
	ieQ==
X-Google-Smtp-Source: AGHT+IG9ZAQ/s0NlAxp+FVbQ4vnv6V5DDNDUqD2VsnZB9G3fGHg7pj3NkaBUUtzf/5lL9rr09vUCUg==
X-Received: by 2002:a05:622a:5b06:b0:439:656d:843d with SMTP id ea6-20020a05622a5b0600b00439656d843dmr8221856qtb.18.1714555364063;
        Wed, 01 May 2024 02:22:44 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id c6-20020ac80546000000b00436bb57faddsm12112405qth.25.2024.05.01.02.22.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 02:22:43 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78ebc7e1586so66647885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:22:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxFLdcTLVPz9DT6IR5MxUejyxuIPnTYFrRs4ooyO5jJFfIpQJu4i3gBcnS2CdDoJ7V6HUxDPSvqicQ8d0f/hzn5FAc3u2dGpD9nsoR
X-Received: by 2002:a05:620a:2685:b0:790:76ea:b47c with SMTP id
 c5-20020a05620a268500b0079076eab47cmr8101133qkp.24.1714555362327; Wed, 01 May
 2024 02:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430-fix-ipu6-v1-0-9b31fbbce6e4@chromium.org>
 <20240430-fix-ipu6-v1-2-9b31fbbce6e4@chromium.org> <42svo2ykapj3atpds3dedqzybp4vh7vcvje622n4cxz6geaw2w@mfazrgyw6653>
In-Reply-To: <42svo2ykapj3atpds3dedqzybp4vh7vcvje622n4cxz6geaw2w@mfazrgyw6653>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 1 May 2024 11:22:26 +0200
X-Gmail-Original-Message-ID: <CANiDSCsJvTV81H_jUWufFGp0TqE7u9t=6MKO8BU294aanomm-Q@mail.gmail.com>
Message-ID: <CANiDSCsJvTV81H_jUWufFGp0TqE7u9t=6MKO8BU294aanomm-Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: intel/ipu6: Switch to RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS
To: Hidenori Kobayashi <hidenorik@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Tianshu Qiu <tian.shu.qiu@intel.com>, linux-media@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 1 May 2024 at 11:20, Hidenori Kobayashi <hidenorik@chromium.org> wr=
ote:
>
> On Tue, Apr 30, 2024 at 12:55:34PM +0000, Ricardo Ribalda wrote:
> > Replace the old helpers with its modern alternative.
> > Now we do not need to set '__maybe_unused' annotations when we are not
> > enabling the PM configurations.
> >
> > Fixes:
> > drivers/media/pci/intel/ipu6/ipu6.c:841:12: warning: =E2=80=98ipu6_runt=
ime_resume=E2=80=99 defined but not used [-Wunused-function]
> > drivers/media/pci/intel/ipu6/ipu6.c:806:12: warning: =E2=80=98ipu6_resu=
me=E2=80=99 defined but not used [-Wunused-function]
> > drivers/media/pci/intel/ipu6/ipu6.c:801:12: warning: =E2=80=98ipu6_susp=
end=E2=80=99 defined but not used [-Wunused-function]
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/pci/intel/ipu6/ipu6.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/in=
tel/ipu6/ipu6.c
> > index 4b1f69d14d71..ff5ca0c52781 100644
> > --- a/drivers/media/pci/intel/ipu6/ipu6.c
> > +++ b/drivers/media/pci/intel/ipu6/ipu6.c
> > @@ -803,7 +803,7 @@ static int ipu6_suspend(struct device *dev)
> >       return 0;
> >  }
> >
> > -static int ipu6_resume(struct device *dev)
> > +static int __maybe_unused ipu6_resume(struct device *dev)
>
> Doesn't this contradict your commit message?
Ups, good catch!

I started by adding __maybe_unused everywhere and then decided to use
a different macro. Will upload a new revision later today.

>
> >  {
> >       struct pci_dev *pdev =3D to_pci_dev(dev);
> >       struct ipu6_device *isp =3D pci_get_drvdata(pdev);
> > @@ -860,8 +860,8 @@ static int ipu6_runtime_resume(struct device *dev)
> >  }
> >
> >  static const struct dev_pm_ops ipu6_pm_ops =3D {
> > -     SET_SYSTEM_SLEEP_PM_OPS(&ipu6_suspend, &ipu6_resume)
> > -     SET_RUNTIME_PM_OPS(&ipu6_suspend, &ipu6_runtime_resume, NULL)
> > +     SYSTEM_SLEEP_PM_OPS(&ipu6_suspend, &ipu6_resume)
> > +     RUNTIME_PM_OPS(&ipu6_suspend, &ipu6_runtime_resume, NULL)
> >  };
> >
> >  MODULE_DEVICE_TABLE(pci, ipu6_pci_tbl);
> >
> > --
> > 2.44.0.769.g3c40516874-goog
> >
> >



--=20
Ricardo Ribalda

