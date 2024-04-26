Return-Path: <linux-kernel+bounces-160341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CDE8B3C25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F4FB27056
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0045C14AD3D;
	Fri, 26 Apr 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SyNAJODq"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6110149C7B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147193; cv=none; b=BIqUo6zpu9WmsDrcaNeqltoPFsBEujYvpplzWRmCxm2ToCnXB1cJlSQjosbyljGn6ySojYYnUd+BXH7RP2J8DrsuhX+UjTkK4q/z0aFhQnyeLdwbXWxwCtsKDQtW8IeyswBIHFAubEcKwEfuaKDwxBo7GH83gqkQumEveii2Bk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147193; c=relaxed/simple;
	bh=u50beQV18hEyI5LxaEHKX9vkm/X/4BQOF74VimhDrcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvJxFoZrdn9vpeocgJILSKoaCraCfIjvrdtjj8MmAcDH5Xql0GzGKQ/etLzNnlPtWL1u9nu4iIuEWJkz/nizdy11vIxXTgYypVhWOFB9nB1duUikTvAD4uH6KLGXPZjIkx7bJEI4Tqs+32KCDfFJiNG45PEpWPlTyvyqU2D4fDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=SyNAJODq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57267852b3dso90996a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1714147190; x=1714751990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRgG3X0s6uXL5fPpg4hJDh3wuxhTgN8x+QviafboKYY=;
        b=SyNAJODqghjYF1LGj2LYdsOUzpHrGbqiCWDOILlP26USgIjW4m9CeqZf6pUFWXMVeA
         Vssubg/TRRh/0NluHuqiOstUPWO+oIElQolcVCLGsFLbRuTOqYJsUDh7LoK+VYDEs8Xy
         VAfx3v5c99/gTpaJV0NK0h07NHZXCjVIDvcoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147190; x=1714751990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRgG3X0s6uXL5fPpg4hJDh3wuxhTgN8x+QviafboKYY=;
        b=bJROP3b4iVC6Q6O6EDFGkoMzG8rwqlycfS4tjcCdBp8LNpKFeCzxNMO7/SOKu5AViv
         Z+EkJmFM2os/SMGJqGNVbIEYsVxi+VKNHhPopClvk/W5Fr55bofdaovhkkTwgmWRpQdr
         hDdhh3E/kGe20vTjts8NY2+bsGHPHc3KBHZa/FWC9ZOMJxIe+Rz26TX2+X2MOvAd7tHr
         98XYvCR932tfaqxYd7an9Vu0/Do+hJmMPiH9HNZ+gl0fo15aYFtc/+KDTXmhyfu+8K07
         Zkm+swZag6v/tb7A0tmoIaz81QwLUcgteLkZHvE+gON/G7z9xIpbHLznhIGWDR+kdFTx
         ZfQg==
X-Forwarded-Encrypted: i=1; AJvYcCXzUal5nnH6FGtJxN7q5B1jMDhA+YR4Jt2sRa4zS/5g1Fd+16sA8YgBWw40UG+nRwaj/cZjSfQVCp5JxGT8H759V2a3Lj51VENHE4uC
X-Gm-Message-State: AOJu0YzsN1C7vrtiMGE8v++QKPqxzmiCVmHygLpVz1UCpVtinvryxW3+
	Ey7TAegEsC2rRCEpu3TjlFymjsSzZUTfYMYsHAGxxdHd/n6dLIrEtZ6fMRrV7tFRyMvIiTRuKoa
	92vfi16wciw78gMJfThVnV/GgPm/zHQ9xNTGNkA==
X-Google-Smtp-Source: AGHT+IG0yQxJ1lDKJPK5e25bpzn4mkXQ33Oq7j0E0rzaS+j9wS81xPfcHpvsxVMz77H2/j25/AKFpVyXxhihRRm8etA=
X-Received: by 2002:a50:8e5e:0:b0:572:33c6:bfd3 with SMTP id
 30-20020a508e5e000000b0057233c6bfd3mr2088058edx.36.1714147190045; Fri, 26 Apr
 2024 08:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426152730.9806-1-fabio.aiuto@engicam.com>
 <20240426152730.9806-4-fabio.aiuto@engicam.com> <CAOMZO5D=Ens3f-FnjEf8SDSTCChdzKW3m7LH+t6y6qUtWsSRZg@mail.gmail.com>
In-Reply-To: <CAOMZO5D=Ens3f-FnjEf8SDSTCChdzKW3m7LH+t6y6qUtWsSRZg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 26 Apr 2024 17:59:39 +0200
Message-ID: <CAOf5uwkB7Z7FUt5K8CP3sEoCEahE=ipuXX4MRZYNgDw6eMuEfg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM
 2.0 Starter Kit
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Aiuto <fabio.aiuto@engicam.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Matteo Lisi <matteo.lisi@engicam.com>, Mirko Ardinghi <mirko.ardinghi@engicam.com>, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Apr 26, 2024 at 5:56=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Fabio,
>
> On Fri, Apr 26, 2024 at 12:31=E2=80=AFPM Fabio Aiuto <fabio.aiuto@engicam=
com> wrote:
>
> > +&usdhc3 { /* WiFi */
> > +       #address-cells =3D <1>;
> > +       #size-cells =3D <0>;
> > +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > +       pinctrl-0 =3D <&pinctrl_usdhc3>;
> > +       pinctrl-1 =3D <&pinctrl_usdhc3>;
> > +       pinctrl-2 =3D <&pinctrl_usdhc3>;
> > +       mmc-pwrseq =3D <&usdhc3_pwrseq>;
> > +       bus-width =3D <4>;
> > +       no-1-8-v;
> > +       non-removable;
> > +       max-frequency =3D <25000000>;
>
> Is this 25MHz limitation correct?

This make the wifi a bit slow ;). You should be able to go to ~50Mhz at
3.3v. BTW the other mux
are not needed "state_100mhz", "state_200mhz";

Sorry both Fabio, I did not see before

Michael


Michael




--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

