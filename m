Return-Path: <linux-kernel+bounces-36862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFAD83A7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F0B291916
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513820DD2;
	Wed, 24 Jan 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdUeeD7J"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38831B7E7;
	Wed, 24 Jan 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095707; cv=none; b=Ueaa3W8Lwfifn4hI2cnlKVSAecm5I1CXJ4fbmKZufAcGocqb+82bfluvZjb6XMVP3BGen9chnx1s5XpG6oMu6nA697jiPCEHQmDbqT2BmLEurihYzWypC8swtat7SbX/MFLseg1wfewYOiU7NY1a0vQpLCZWZt6lGEvvUBEugW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095707; c=relaxed/simple;
	bh=r5P74bClM0Y/Nw8KBoTHNtFNfwgS0H4TFcvTQX4Dr/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iLEacD5X2ZT91hZIt9xhjBEFyz4pIXUn5gPsPVLEyg5mr6P4vb6FxGjLdm6ztG5TZNlGWP0po0edRfERws7aUFZyFMKAlWLlacHXc2YXrLs5Fy5kisPwsFds1q5CLXZjWNIcT77VmB8xsxUFJpa4ym0dt6mnQIGjdYkCaqwj2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdUeeD7J; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso5796551e87.3;
        Wed, 24 Jan 2024 03:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706095703; x=1706700503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=19zsXtwg36DXVDsy+4i27k7o2CEiU+qV1nDyQjqpjRU=;
        b=XdUeeD7JpJ/Pn5LHsRlwCUV7LCKIdCpRoA8OUI88EPjl5Usb8VZ+5r6i/eCEgL51fK
         ZzUQGcmBF0aEyxQjZvJbNs31v4oUYDJ0ArUIDlN6v47aa4xkgxBMifxBqTqqjWBH6E9C
         tOA+k1Vh6YznB3BJ0G/Cpel0ohlYKIYyPsr6TFxbeWjf5G+4vEJcR1pIiJVEIitYFlFs
         SBxyDESnwlZbCA6/9b7H5homCR8rx1oYkqsqEIXhzZ1MMxjJQG4m3Xo2U0Y+TVJVrtm1
         t1qavGeIwQWdeaKp2UWYtpA8RI64nv5hTKTfVviULOS9eNCooq3bvXpd44La0FG5Nim5
         wZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095703; x=1706700503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19zsXtwg36DXVDsy+4i27k7o2CEiU+qV1nDyQjqpjRU=;
        b=D1bAa5T//yRuMYYPNhgMolK0OV9o7nKAzKZRmWaBKj7aTgs+SpWnEO1z+wi2uicQnq
         6N0CkQEsrF/EvwBS+uJEwKXwWHj/FV1VwSmv1qMGqQGuVFfMWOqhq8xLrvVDt1yfwEi1
         KOAFf+4cLwdoffgjXRvjvYWP6C/Ue3bQsgtyVTlHFXk51Bf2T13friJ7W3Jvj4le3GxC
         sTNwbqoeD0CHbaJOd7GIXro5w1AeRpMOHPTe+DfTw+/452ciAQLnUxJ7aqRSjJYYlrMe
         rFHE6wYbGXzKuyeRu/IPrL2u7ltyX8mbxCu6ByELmZXZOLCFLCjYWPWKZ62tTLbIvBKK
         me0A==
X-Gm-Message-State: AOJu0Yy2+/fdVnzJrzq6kZLqrarPP3aCB+U6pHbELCyf9B3GI8Bh3pGt
	KeSFkVGcob5vWn3VsWSuq/zTx5qc5BkYM31qjiI6OH615J8Gac0+
X-Google-Smtp-Source: AGHT+IH7xH8oWyqYKIFhEJ5qTsz+x6bLkoTDLlHSuZvmlD+8CSE8n9uXR3Qs1YpVnCCFGIlhoTW1ow==
X-Received: by 2002:a05:6512:202:b0:510:40a:4cb2 with SMTP id a2-20020a056512020200b00510040a4cb2mr1465756lfo.38.1706095703323;
        Wed, 24 Jan 2024 03:28:23 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906c00d00b00a2a1bbda0a6sm15497995ejz.175.2024.01.24.03.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 03:28:23 -0800 (PST)
Message-ID: <49c0375637372ccae122f2abd2b992406bb40a5c.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] net: phy: adin: add recovered clock output
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, Michael Hennerich
 <michael.hennerich@analog.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 24 Jan 2024 12:31:38 +0100
In-Reply-To: <20240124102554.1327853-2-f.pfitzner@pengutronix.de>
References: <20240122110311.2725036-1-f.pfitzner@pengutronix.de>
	 <20240124102554.1327853-2-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-24 at 11:25 +0100, Fabian Pfitzner wrote:
> The ADIN1300 offers three distinct output clocks which can be accessed
> through the GP_CLK pin. The DT only offers two of the possible options
> and thus the 125MHz-recovered output clock is missing.
>=20
> As there is no other way to configure this pin than through the DT it
> should be possible to do so for all available outputs.
>=20
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/net/phy/adin.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
> index 2e1a46e121d9..b1ed6fd24763 100644
> --- a/drivers/net/phy/adin.c
> +++ b/drivers/net/phy/adin.c
> @@ -508,6 +508,8 @@ static int adin_config_clk_out(struct phy_device *phy=
dev)
> =C2=A0		sel |=3D ADIN1300_GE_CLK_CFG_25;
> =C2=A0	} else if (strcmp(val, "125mhz-free-running") =3D=3D 0) {
> =C2=A0		sel |=3D ADIN1300_GE_CLK_CFG_FREE_125;
> +	} else if (strcmp(val, "125mhz-recovered") =3D=3D 0) {
> +		sel |=3D ADIN1300_GE_CLK_CFG_RCVR_125;
> =C2=A0	} else if (strcmp(val, "adaptive-free-running") =3D=3D 0) {
> =C2=A0		sel |=3D ADIN1300_GE_CLK_CFG_HRT_FREE;
> =C2=A0	} else {


