Return-Path: <linux-kernel+bounces-49886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32BD8470ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF28E291457
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFC637144;
	Fri,  2 Feb 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geWclKoX"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712B3D6D;
	Fri,  2 Feb 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879721; cv=none; b=ClahJW0keFAbhMJBAVNey26AKzQ3IOIlFpWm+yXXoDRL9nj9/5mc4mtPd4whWsWQKmaDueNue3tbZj5QdumDdr6iQC3Nrq0FE4gFb9FVJDyAhO4xV2SW52U0WiR2tt/QvlTwldyzN4QQHGEcLl9JoBeL6enzR+6Js+/ooaWIcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879721; c=relaxed/simple;
	bh=be3/+gNfitjwgXTusfVYHe12ReY8nX0GAxGrQl7h+64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=by7mJswOxdYmndbTICCkSz6S1hm/z+Wik9aMS5cbedk6YTMReWb5BR7Zl29ADDTjLBN40GlAlB51p5SVGsi9p3YoAZBwnk6T4jQMxdu7EP+SNDGVu1ZEQ2zw2SsWPd0HjDC1tj85uBHCrAT5uXPlHkPD+TNpa+RVtHvYhqv5lgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geWclKoX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6dddf4fc85dso1631189b3a.0;
        Fri, 02 Feb 2024 05:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706879719; x=1707484519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWWxDbFc1s0H43msZb3R2yZAbYlHwiF4o6Dt1xNyb5c=;
        b=geWclKoXwLe4nagQFX0fjJxPTkNetGQrdTqciHFIIT6LlwMgeFCMj3QXPwYjeGjqRb
         aCbKetaY3ZJpsYP+p73CtBx4k9r+Ab2YFp796nIJf9j9CkMY5/a3d0oTVrJLrPV58LNK
         mfd7RTb/TTsta37s4yDRk1jBXe4F5d7Dvs+F/2I9ZJStcCVpOkbWeC6QGirjTxqwyo8Q
         pvQDva+FXni8KLZuuyIy5sbTLMpKxenWYZezB4vKPS9qzBNSRe+77sVmX5bwd/iHbE0i
         9lMkmDZaop+UAfdpv7CwawrlTYXBBbdZ2N65urYAPbgRy5SW4KRXyhprr1dkr8wHoWUR
         rDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879719; x=1707484519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWWxDbFc1s0H43msZb3R2yZAbYlHwiF4o6Dt1xNyb5c=;
        b=Fit7EKOIl0g0sqW7e94EF7HEWmSLtH/T32Vlkk/c1q2Y5TTj9deYPjB5aBmzrii1V8
         t8KUD+A8wATbYBItStpmXcGYoJngpjNgsbPMALXt1TCaimIum8r5/MN7PJwxl/v4vix8
         /zL1Z3zWT81wfDA6jKRITRnFLYIw2gnFUCXVxxebbsJK1YHNmpO3iQrNtb36vFCwxuaw
         sPBOXyuriNB8ddbA1eqjtrV5cHkFz/rlbNFDZpKIpy/jpYzW3lUDcCqEKszPM1p8F2sO
         GiE13/lzwZofGUujPXnAfmH9L3k6f4RH1d2lEPAr4bA/yB0HyQIhPu0ZcA3FD5r/7jGF
         Z0xw==
X-Gm-Message-State: AOJu0Yx1k37tgU4Uo01YEdgadLkWpiJVrEJplo46cntXcuzcj0U279r1
	ARk5h4PIYVNAInjRP6fyjg46psQFS/YSOHoBpJPK8Cl3xu/eb3/MXDQbk/8vYZWvBqFrnC6vFHA
	Kxm4umXvJqC6L57eHRVea616+BtA=
X-Google-Smtp-Source: AGHT+IEEv/kGQPLAUBTIrzRoVfYRzZUzQ0pExjTA1QXrHHzOYJs3MVy1uMEAGhNsUBAO1SU8mvJcclAlTx41fWfFVN0=
X-Received: by 2002:a05:6a20:3149:b0:19c:9c77:853c with SMTP id
 9-20020a056a20314900b0019c9c77853cmr1606806pzk.33.1706879718762; Fri, 02 Feb
 2024 05:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106221907.325127-1-aford173@gmail.com> <20240106221907.325127-2-aford173@gmail.com>
 <20240202122036.7aa66d9d@booty>
In-Reply-To: <20240202122036.7aa66d9d@booty>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 2 Feb 2024 07:15:07 -0600
Message-ID: <CAHCN7x+Fyy76_Qo0757fx3bjg5RWUHU=NQHJu+WenSi9PQrwOg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] phy: freescale: add Samsung HDMI PHY
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, 
	Kishon Vijay Abraham I <kishon@kernel.org>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	NXP Linux Team <linux-imx@nxp.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:20=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootlin=
com> wrote:
>
> Hello Adam,
>
> On Sat,  6 Jan 2024 16:19:05 -0600
> Adam Ford <aford173@gmail.com> wrote:
>
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > This adds the driver for the Samsung HDMI PHY found on the
> > i.MX8MP SoC.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> I had already tested the v2 from Lucas, however I also tested this
> version which works as well, on v6.8-rc1, custom hardware based on the
> Avnet i.MX8MP SMARC SoM.
>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
Thanks for testing.

> Generally speaking, as there are several small patch series around which
> together implement HDMI on iMX8MP and similar, I think it would be much
> easier fore reviewing and testing if they were grouped into a unique
> series.

That will happen for my next attempt to push this series.  It was a
headache for me to gather them all.  I have a github repo setup with
my latest edits here if you're interested:

https://github.com/aford173/linux/tree/for-6.9-imx8mp-hdmi


adam
>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

