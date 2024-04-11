Return-Path: <linux-kernel+bounces-139682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A18A066F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A9F1F25E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C252D13BAC8;
	Thu, 11 Apr 2024 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBuO32Tg"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9AD13B5A7;
	Thu, 11 Apr 2024 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804457; cv=none; b=sDR9gt4hpk05kBExhj48yGoEqjW/VeDlHA1wUha6ylisn71qQ7Afzddi0zp0X9Qeto/g2dOrDBwajyNHxK+rgojr4CR+Ljk0WR7XROD2eB7aVzEJDRAT6mubBoQVfpeyd7uKBhZdKTAxQSryI5tTAYk0ROjz8iI4LemZ8W2N46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804457; c=relaxed/simple;
	bh=JHPfVU2SbhevASOUuCl9jIR7oh3kyRirjd2zOQml7Hs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DxPmI07B3bpjpgtpznubK4OkJ75uvMgBr8zMPAsyeHdEHdgd1uoZCSl08pIcoAxth3DDv6vn81zNT6m2xRjyG56yPwlgHdL8HURTaq4XRrS69YGJ1bmKbyH0qqQ+gsCRJnoC3bFqRy4Okyxnk3m/TM3hVhgcCue1eS/SiDsX8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBuO32Tg; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-47a0bebeacaso1408978137.0;
        Wed, 10 Apr 2024 20:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712804454; x=1713409254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EwanpfmN8Wfp66ZF7BNbhmU8e95IyJQR7hcqQHi9SE=;
        b=XBuO32Tg752fagbeXHtwp1MHJTRkF2QL42BqrUqUhDHTXN8DhfxYkIX608O/QgKEt2
         v2Zmbik50uAV0obQ6XZZCFf+6mYP+LOK/LjIZ4s92/TrhaAjB9X9xfU9nJunA4oPjYYh
         SOz73LFpU5fOgkKBtWyo3NgQY9jei6kT2a315sXCJ5VKPOb/+7ouuYPch6AEleCTip7C
         Xt+q923rn0BBStMk6P98O5g7cKg1pVF6y2ZwvdmmdLtoIRybacOcixAIn52m2x3M3Foq
         LfD8MijxxKGf8detMWzHhuG+U2QwyAHPt8AH9W1m8NmvQIOtFbuIT1O4eWXe8HaCKNq9
         aIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712804454; x=1713409254;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0EwanpfmN8Wfp66ZF7BNbhmU8e95IyJQR7hcqQHi9SE=;
        b=GE5wrbtQ2gWfI6nYeRBHR1NiaIHy7aSWPryyWdwyJ429CVv2+FwfFmBM5lj9HL2a9W
         KCZckTohZmoBOORSmTeNIYKbgk02klWnAyP3avpM7HPtAPEv2eXzLd84FMIsnyRBEU4V
         YGzFYCdU8rzw6ekvpuNlHtrHs9nrsDXT+GBTfK9sQKphr0T41bFICTGW97W5IcsMDpy5
         FJysQqZ0viI+60zHAoydjHT+QWCbXjVVsazHC4YCUIFhz/HngmF6Rq4Wiq9veJAMpGl5
         Zb/vDicvwq06j0Uu/CIVcE+zGD61XF65Zfcxk8Fl3sKSqt870sOSeZTD3HCcbtYZUaOo
         qexA==
X-Forwarded-Encrypted: i=1; AJvYcCVTNYR2pNhWyWed+WoUScbJmkmX//UTCMP0ACkivm8kCjbqIqNsUBxiwWhBNvedJc/4bOfZUZ1nJy2JXvSNL6L3s5O9JPPyZs7Hl05cADAa/ntOmku5fnq5wnrvr3nfdmiZdjUu4cfkiEjCt+NSUOUZX4g8R2EjPQ8n+QKP8KJQ
X-Gm-Message-State: AOJu0YyUho9rPEEsNlZJ712hByc8NogVf8qokxCpt5XiB+b/jVVuhHO0
	BHeVWOUbByB1L8yM6tptKGfqNsC3kLoIgcwh+rbX8Z3WKAxgjAdL
X-Google-Smtp-Source: AGHT+IF0n8eerAqlwySj3arpU4ymiZD5M8Xwc5+6Pmjoc1p7/OStmssdMR0jQeZb02m9Ymt0t5OAUQ==
X-Received: by 2002:a05:6102:955:b0:47a:317f:eff7 with SMTP id a21-20020a056102095500b0047a317feff7mr1918245vsi.0.1712804454115;
        Wed, 10 Apr 2024 20:00:54 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id e7-20020a0cf747000000b0069943d0e5a3sm358899qvo.93.2024.04.10.20.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 20:00:53 -0700 (PDT)
Date: Wed, 10 Apr 2024 23:00:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kory Maincent <kory.maincent@bootlin.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, 
 Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
Message-ID: <66175265992c8_2d6bc6294d8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240409-feature_ptp_netnext-v10-8-0fa2ea5c89a9@bootlin.com>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
 <20240409-feature_ptp_netnext-v10-8-0fa2ea5c89a9@bootlin.com>
Subject: Re: [PATCH net-next v10 08/13] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kory Maincent wrote:
> Prepare for future hardware timestamp selection by adding source and
> corresponding pointers to ptp_clock structure. Additionally, introduce
> helpers for registering specific phydev or netdev PTP clocks, retrieving
> PTP clock information such as hwtstamp source or phydev/netdev pointers,
> and obtaining the ptp_clock structure from the phc index.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v8:
> - New patch.
> 
> Change in v10:
> - Add get and put function to avoid unregistering a ptp clock object used.
> - Fix kdoc issues.
> ---
>  drivers/ptp/ptp_clock.c          | 114 +++++++++++++++++++++++++++++++++++++++
>  drivers/ptp/ptp_private.h        |   5 ++
>  include/linux/ptp_clock_kernel.h | 104 +++++++++++++++++++++++++++++++++++
>  3 files changed, 223 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index c56cd0f63909..f962f460ec9d 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -512,6 +512,120 @@ void ptp_cancel_worker_sync(struct ptp_clock *ptp)
>  }
>  EXPORT_SYMBOL(ptp_cancel_worker_sync);
>  
> +struct ptp_clock *netdev_ptp_clock_register(struct ptp_clock_info *info,
> +					    struct net_device *dev)
> +{
> +	struct ptp_clock *ptp;
> +
> +	ptp = ptp_clock_register(info, &dev->dev);
> +	if (IS_ERR(ptp))
> +		return ptp;
> +
> +	ptp->phc_source = HWTSTAMP_SOURCE_NETDEV;
> +	ptp->netdev = dev;
> +
> +	return ptp;
> +}
> +EXPORT_SYMBOL(netdev_ptp_clock_register);
> +
> +struct ptp_clock *phydev_ptp_clock_register(struct ptp_clock_info *info,
> +					    struct phy_device *phydev)
> +{
> +	struct ptp_clock *ptp;
> +
> +	ptp = ptp_clock_register(info, &phydev->mdio.dev);
> +	if (IS_ERR(ptp))
> +		return ptp;
> +
> +	ptp->phc_source = HWTSTAMP_SOURCE_PHYLIB;
> +	ptp->phydev = phydev;
> +
> +	return ptp;
> +}
> +EXPORT_SYMBOL(phydev_ptp_clock_register);
> +
> +bool ptp_clock_from_phylib(struct ptp_clock *ptp)
> +{
> +	return ptp->phc_source == HWTSTAMP_SOURCE_PHYLIB;
> +}
> +EXPORT_SYMBOL(ptp_clock_from_phylib);
> +
> +bool ptp_clock_from_netdev(struct ptp_clock *ptp)
> +{
> +	return ptp->phc_source == HWTSTAMP_SOURCE_NETDEV;
> +}
> +EXPORT_SYMBOL(ptp_clock_from_netdev);
> +
> +struct net_device *ptp_clock_netdev(struct ptp_clock *ptp)
> +{
> +	if (ptp->phc_source != HWTSTAMP_SOURCE_NETDEV)
> +		return NULL;
> +
> +	return ptp->netdev;
> +}
> +EXPORT_SYMBOL(ptp_clock_netdev);
> +
> +struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp)
> +{
> +	if (ptp->phc_source != HWTSTAMP_SOURCE_PHYLIB)
> +		return NULL;
> +
> +	return ptp->phydev;
> +}
> +EXPORT_SYMBOL(ptp_clock_phydev);

IMHO these four helpers just add a layer of indirection without much
benefit.

Do we ever expect more than two sources? Else, the phc_source could be
embedded as the least significant bit of the pointer in the union. In
that case we would need helpers to return the pointer without that LSB.
But space in struct ptp_clock is probably not so valuable that we need
to play such games.

> +/**
> + * netdev_ptp_clock_register() - register a PTP hardware clock driver for
> + *				 a net device
> + *
> + * @info: Structure describing the new clock.
> + * @dev:  Pointer of the net device
> + */
> +
> +extern struct ptp_clock *
> +netdev_ptp_clock_register(struct ptp_clock_info *info,
> +			  struct net_device *dev);

No need for explicit extern?

