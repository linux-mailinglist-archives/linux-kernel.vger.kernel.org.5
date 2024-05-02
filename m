Return-Path: <linux-kernel+bounces-166530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10148B9BDF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BEA284535
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E513C67B;
	Thu,  2 May 2024 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OP4wk2Lz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BDE137C4E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657753; cv=none; b=SnQSyC3AnU5on273ZvIkBpZFsr/58LnkcRgnjZQv+jDdCvaai40amkppAhrHSwHIMk1C7aqAqSF28gWrI5DQXGrfhA3FUomsfJIS/paVHDgWz0HSDMT19mNdrSQ+3vqJFdZVZhwOMtLUWtfDqwA/lA30BZNtnHcCnhqOv31sbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657753; c=relaxed/simple;
	bh=vVxLL8i98iBhBYnoNcpafxJISu1Z50Oip9xF6rNOG88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gmo7IFuA3K0lsJJEbbPhrceCYwbwsFIVr0ANtyg8LRhekx061HShzbIJQ/NF32AUatb7gbfAjUoPkdhsC1pmeslmItF0av9m3Y4KdOLrpNbzsLPWfoFxLp2RTjQvsFh9tO4GfZRZJ+brO9aJKFUJozBE/0RmmNtgSw2l75uIAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OP4wk2Lz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714657750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cwbiTB0Bb8e4LKusQ22V8ARx4WRfXXPLK23Z4+9kwOg=;
	b=OP4wk2Lz6vjIVJ5CBG5f1LUJ8vbCgF2pn3CNtgHenZdEydpYsiiG1PJE3QUPz6VtqIb9gc
	O4gfYTiXhPWShq5ScqgB7X10X6hC9IyhMauGJTj7j57tp/HjwFFQIIBTcipFPRjKQn7Sn5
	in+HHm5tpjJGJdpmsTCTfR5f/EjLF7c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-2pnI4PWDP66ihgxj9WM6jw-1; Thu, 02 May 2024 09:49:08 -0400
X-MC-Unique: 2pnI4PWDP66ihgxj9WM6jw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34d9467c5f9so413279f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 06:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657747; x=1715262547;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwbiTB0Bb8e4LKusQ22V8ARx4WRfXXPLK23Z4+9kwOg=;
        b=CT4ewz8Jhl5outBR1HAinqPdjHeZj5RJOpMCxPh4/Kcm2U5MOeU3raV4kOvy0e7rxc
         deFhnRbTH8PNsYnwrhOQt4VL+Z031SQLv9kym9mDfDiVcLemUHJ656jnPyd2wjAgSdZP
         eZDIgg4wcAw4Byij1V6kKTFR9C5C25nyB2aYISoGmDwiCthFEXzAEohXcZRLUZkg+UEn
         RpQL4kiO+yUV7iM9sysbLtLigEwoyajeORrvuXpCK5DFHnNHlYUnbz7z7nbW8LIRJClS
         8Xuii1rMqgqzCwHUrUVcYBkFyfR3KmtPi9q2rXQidpMNvdf/3hpHPRn/XLEnVl5729N7
         8TUA==
X-Forwarded-Encrypted: i=1; AJvYcCVk+U1gfbLrZ0tR2+Wnc33JdLUiERztH4ymkjdfoGR1kZXAIqUv3l4a9LrsUHLMumxzqw4XB+Q6j40Z1EMG7rdTu8uBknf/GJ8B1yht
X-Gm-Message-State: AOJu0Yztk8XmtcElrqWta8MNCbyNMe4QR26n+HX5W0P5GkUKV6mwNZC7
	wctbT8VLXkqoEBtzho5GyG6Y0GlkXPa6AYaqmZSt35c6InftXYPWeQ2dB6QXTAcmbY5SjEDVx1j
	dwxruimrOmfUS6llpbQGV+3cMJUJ62KfGAEZqiLIuRiKuj/U+KOax7viiS2KviQ==
X-Received: by 2002:adf:f8c8:0:b0:34d:8ccf:c9ce with SMTP id f8-20020adff8c8000000b0034d8ccfc9cemr3569983wrq.5.1714657747127;
        Thu, 02 May 2024 06:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExXQgZwvu7kgwOrg+G5EcVKbU2rvv0h+Ze7J9NkQbmU2l7DmurhqKAeG+mgk4f1QSK0MZSKA==
X-Received: by 2002:adf:f8c8:0:b0:34d:8ccf:c9ce with SMTP id f8-20020adff8c8000000b0034d8ccfc9cemr3569963wrq.5.1714657746675;
        Thu, 02 May 2024 06:49:06 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b52:6510::f71])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d620a000000b0034ddb760da2sm1325231wru.79.2024.05.02.06.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:49:06 -0700 (PDT)
Message-ID: <d28a2bea1c7bb28dd1870116ddbdba78cf3817a4.camel@redhat.com>
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
From: Paolo Abeni <pabeni@redhat.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com, 
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Date: Thu, 02 May 2024 15:49:04 +0200
In-Reply-To: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-30 at 10:36 +0530, Raju Lakkaraju wrote:
> Introduce a new member named 'wolopts' to the 'phy_device' structure to
> store the user-specified Wake-on-LAN (WOL) settings. Update this member
> within the phy driver's 'set_wol()' function whenever the WOL configurati=
on
> is modified by the user.
>=20
> Currently, when the system resumes from sleep, the 'phy_init_hw()' functi=
on
> resets the PHY's configuration and interrupts, which leads to problems up=
on
> subsequent WOL attempts. By retaining the desired WOL settings in 'wolopt=
s',
> we can ensure that the PHY's WOL configuration is correctly reapplied
> through 'phy_ethtool_set_wol()' before a system suspend, thereby resolvin=
g
> the issue
>=20
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/phy/mxl-gpy.c    | 5 +++++
>  drivers/net/phy/phy_device.c | 5 +++++
>  include/linux/phy.h          | 2 ++
>  3 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index b2d36a3a96f1..6edb29a1d77e 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c
> @@ -680,6 +680,7 @@ static int gpy_set_wol(struct phy_device *phydev,
>  	struct net_device *attach_dev =3D phydev->attached_dev;
>  	int ret;
> =20
> +	phydev->wolopts =3D 0;
>  	if (wol->wolopts & WAKE_MAGIC) {
>  		/* MAC address - Byte0:Byte1:Byte2:Byte3:Byte4:Byte5
>  		 * VPSPEC2_WOL_AD45 =3D Byte0:Byte1
> @@ -725,6 +726,8 @@ static int gpy_set_wol(struct phy_device *phydev,
>  		ret =3D phy_read(phydev, PHY_ISTAT);
>  		if (ret < 0)
>  			return ret;
> +
> +		phydev->wolopts |=3D WAKE_MAGIC;

I'm wondering if 'phydev->wolopts' could/should be handled in the
common code.

>  	} else {
>  		/* Disable magic packet matching */
>  		ret =3D phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
> @@ -748,6 +751,8 @@ static int gpy_set_wol(struct phy_device *phydev,
>  		if (ret & (PHY_IMASK_MASK & ~PHY_IMASK_LSTC))
>  			phy_trigger_machine(phydev);
> =20
> +		phydev->wolopts |=3D WAKE_PHY;
> +
>  		return 0;
>  	}
> =20
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 616bd7ba46cb..9740f08ad98e 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2038,6 +2038,11 @@ int phy_suspend(struct phy_device *phydev)
>  	if (phydev->suspended)
>  		return 0;
> =20
> +	if (phydev->wolopts) {
> +		wol.wolopts =3D phydev->wolopts;
> +		phy_ethtool_set_wol(phydev, &wol);

The above will fail when the phy does not provide wol operations -
should never happen when 'wolopts !=3D 0', but possibly worth catching
the error?

Thanks,

Paolo


