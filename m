Return-Path: <linux-kernel+bounces-63591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BC08531EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F657B21E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8583E55E71;
	Tue, 13 Feb 2024 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3GUCKn9"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA55577C;
	Tue, 13 Feb 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830959; cv=none; b=ebxJx5dHoRppd802s0wYYhxf/sGUOzmDRGiBkcBBuujdorf2XDXu9bex4VuoDi4gfBmFUNbS6Uw1kXhsKQ+segYjVBHaQ/rjNGjKHsX/W8KXrk2LTt6neFc/heI0BSaA4wkuCKUTCY1YqxHyqs+2D0aQ40XnHZQ5yTfhSwwexaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830959; c=relaxed/simple;
	bh=vtTZA17cL6Wm52kSuIewLvI/yQxbjqL1mzAraV6tiIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axf/H06ec9DwdZ9b1FeHI8NK+z7j/+bU5pjz1K4LkTjF5uX5BUTCHRV53wZ4ipQKqwV53J4G49rr2DKFZ2UKFHJ5pZdh2MuxtK5pR7omBZFkLODkDluvSzitBpcv9cdetVM1VRoiuxTDiLZM4OlX7IH8dPei/VbXg/JKgsQynwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3GUCKn9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso2957680a12.3;
        Tue, 13 Feb 2024 05:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707830957; x=1708435757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaeqwtgSIyVzHS16YQknys4xdcQHPDxWpe0YrROxhb0=;
        b=L3GUCKn96cZE+da9YuktTaTFi18VC1mwaoF9Iy2CVNrwRAlxXlU9LTzDtwvG9eTXm6
         9EeY8OkvH4olQl23BWziTi32sig7Y9xj6Amqxoc9BoYAvSQoVSrmr8pllaDrniGfGM/j
         m6N26uuLmdlZ7LdHUhyEkl0yS/RUCPB75Q6Ll0NN+21tSi1lvW0NTuKo3Fnblpj8F+YP
         C45czeBH6pK8/1IDCpUCYparZahSII9qIyrf8SViJREpDHpPgogDwQF3tK3ADTCpQVae
         gsTCjhWsp2pLptDycHVifnvxNMZ4+2OU84m/chLcibnYb6j7g/1czUI5ljMbyRdrUAl3
         WvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830957; x=1708435757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaeqwtgSIyVzHS16YQknys4xdcQHPDxWpe0YrROxhb0=;
        b=dnzZJfrIOtGoetSCQEUW9pSyqFT5vgBYHT13bB2qStjtXqfU2UCIF1tcYchBy085qs
         3muBlTCcw+umZPMHjEQ+nPj/1mNk2i+wE20t2G2XcmX8ZzWYMpLFkW7gFih+CJhVQnxc
         KVqSVs4D44HEvVVAoX0mQstAUQ5mZuxkSJpAwUM+uyqmqNnbhrc/vnnyGHFmBIaH6oQm
         iy2fMLp71JJH9rQ+ACVBQpvj9Rs56nEq6T3Q2gaGfzvtva4LIyhnm/mswBe9Wfz34I+S
         SZ+fQxzCwz2IHZySMcLynT9O3r+Xs15XLyiZtBph2R7GaMsmN/c8Fu0EY0l3i+RXcUOV
         urbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMTq6lvfCdYH1aCuuIY8DD54302+NdVtLCMbUi0l1NSEZhbJu+zshAZzJphIU6BTNxknOJ4fNY2t33Q+9dTdcsXTyYgW+fBW25agAWrD13D6Xx2WMW3dxTP7xcxf4FsDLQajeAbxSxCg==
X-Gm-Message-State: AOJu0Yy6/LCBCa22UldXSRU4zIgKjPljKptXD/vsh5hJ/3C4vMxlMoOI
	qshtD1ZMCjKlO/0cyR7FBkj87lALEPepxC0FZSRL11eoBXbxtN64cZ3VMrMXtveIs7wbxMLOsYX
	sjui7+1Y/DY+xrOMHRGsa3pRutL0=
X-Google-Smtp-Source: AGHT+IFirH4aeuABJGuJpGluUR/k6qc7RQ0cPXWpBU05uEa+O9ZbTIMRRS7wseCb+9I+EE5L24HoLreQuoUG8z9cSWc=
X-Received: by 2002:a17:90a:cf13:b0:297:ca7:fd10 with SMTP id
 h19-20020a17090acf1300b002970ca7fd10mr6856956pju.1.1707830957041; Tue, 13 Feb
 2024 05:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124146.202391-1-aford173@gmail.com> <20240213125618.GG52537@atomide.com>
 <20240213130208.GI52537@atomide.com>
In-Reply-To: <20240213130208.GI52537@atomide.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 13 Feb 2024 07:29:05 -0600
Message-ID: <CAHCN7xLmTEk0439XTuRPG7SSdH=4YiMTmrSXmfTkpC2bo_kNGw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: omap3: Migrate hsmmc driver to sdhci driver
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, aford@beaconembedded.com, 
	=?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 7:02=E2=80=AFAM Tony Lindgren <tony@atomide.com> wr=
ote:
>
> * Tony Lindgren <tony@atomide.com> [240213 12:56]:
> > * Adam Ford <aford173@gmail.com> [240213 12:41]:
> > > The sdhci driver has been around for several years, and it supports
> > > the OMAP3 family.  Instead of using the older driver, let's finally
> > > migrate to the newer one.
> >
> > I think we also should do these to avoid incomplete conversion:
> >
> > - ti,dual-volt property can be dropped
> >
> > - ti,non-removable should become non-removable

I'll do a more comprehensive search for these flags.  When I did my
testing on the AM3517, I didn't notice these, but I see now that
others might.  I'll do a multi-patch series to first address the
multi-block, then  omap3-ldp.dts, then migrate the omap3.dtsi to the
new driver while dropping the flags, and lastly update the individual
boards accordingly.  I just have one question below.
> >
> > - ti,omap3-pre-es3-hsmmc probably should not be needed with sdhci
>
> Hmm actually we may need to set SDHCI_QUIRK_NO_MULTIBLOCK for
> compatible ti,omap3-pre-es3-hsmmc.

Should I update the driver and binding to add  ti,omap3-pre-es3-sdhci
to set that flag, or should we create a boolean (maybe
'ti,sdhci-no-multiblock') to the device tree options for that driver?

adam
>
> Regards,
>
> Tony

