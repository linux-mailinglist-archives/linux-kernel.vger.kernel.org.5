Return-Path: <linux-kernel+bounces-52336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F008496DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE61D1F215A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2912E4E;
	Mon,  5 Feb 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRsy6Eot"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395612B84;
	Mon,  5 Feb 2024 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126231; cv=none; b=LTpjWKFRlXLjMgp4hR8pDNdONVqSKTwcLXOcgKHpftn932iusDAn9gWRq3xIKWNVlhFD8WQZOiBZWuPqqBH7+XVeKz8TSeopZazutg9jSARQWfkt5HYav23AJz494Mbqt55+1VNmwzON+g1qYjEeiGQMfa35uNDTIu6t0KfwSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126231; c=relaxed/simple;
	bh=XshrRxej5JW1j777R3dRv6CxLAJqshyFFx5Qgcj9oZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UReLt8ZP9k3U89xTn0ffeWvVf5/ke2+zqrFHmkCtsSQ8P6nvZZRIRNPzjPu7OVVqkKcVXEk+PRuIugLcVdlXzI3evGiTKts3jThCGKTKkvVaEIn3MRN7qgS3wSupjn5V/grGou6sYQ5/+dIDVjtFIwPWJvH6Z1OrJLB2yleOrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRsy6Eot; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-296a79e6295so242222a91.3;
        Mon, 05 Feb 2024 01:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707126229; x=1707731029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhsSrZqtjbGX4G5Me8+nepxYnJ3PLPOLi3AIvHxYUqE=;
        b=WRsy6Eot52B2UDgWfv57Y63hHh6s9mwraybfZxAJNFV3tYTnxR2dok/qBtmxndtxld
         LI9IT1yc6qjmX9WrbGbmmqhZwm5zbyLV5GC6SHWqw4XE4FvSLNvd8xA+gYH7Zh7DgczK
         IJvvitkKNWj93K21m5SjoFvE+IgtMZToWHwauWL3fVd9g9d36hmZ5XWBsVC5qlpRZAeT
         e2BEtvion9WaBmChJvFwUbsixWTipvLI6LTgERvj2wWCcOQjKCD+VNc71qO6LpJ3iBIl
         yBj9kzbniNfv6XN7++76B50fpLYOc7FguN3dbvPqdJVESWF8UVeEheq5W4iZzHZC6CbE
         Litg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126229; x=1707731029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhsSrZqtjbGX4G5Me8+nepxYnJ3PLPOLi3AIvHxYUqE=;
        b=g6pw0+qih2Azco48ekGFT72XtvHrw+LVucGJKA3sW2wkfjJMdrlS14WZR0wbASrleM
         Bk/H8LfiZOZkiPiBIdGOKOw6ibCg/sLmfJy5sopqknKoKCRXO5IjLDUuM5El8ZyFBm7h
         42wMC0Dc9qD0XcIr3TAPdmzO2DkDV5JzdsDsTCDkG60Yk9UiHHAb6XQSk6SWFPNT7s1I
         89Fjz8VIa4zXZCjrOMnOybThMJZHNsemC0V4EMCjAdpLGFs0UscQ+SOtoW7OpELCGMKx
         8TYiVtbAIlA6ccigCgdOk5R2XAn1/7FwO4Zd4LMy0++b66v5PFm0x/IB7ublI+r+R8HH
         YlIg==
X-Gm-Message-State: AOJu0YwfEH1OJNEmc+U6TxmBDaLHXiyXd6xeIHE/vsnqbSske8jr34dG
	57A+BCLUtHba0M+P6GVbrNopRzZ5rsVJUWgDQJ0dJIy2QVnGpq4e
X-Google-Smtp-Source: AGHT+IHFO097j/YQLLeAtsmj9mY5GZrwM73nWWGx0K3d62mTKZNyqQClmv7cTRP+6v6j+MscpsXM/g==
X-Received: by 2002:a17:90b:a0b:b0:296:7bc4:5926 with SMTP id gg11-20020a17090b0a0b00b002967bc45926mr3965970pjb.10.1707126229479;
        Mon, 05 Feb 2024 01:43:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUJ77OY+TTLPUJ4rBAtbIQtLRDtzNn+/A7igp66tHUElMNAIs5Sp9uVHNzeBwC0ZpuU7rqLqBoN7o94EPieLu5kV5lCkbEmadmny01yPsGz835tZgmJUPZHdgzXbwK0ps+lZX3qdtUTFXkMo+04V2GYGaftHII0fb3ROxJtsNg4plnbKQL46lFrbG7xSqrfbRf4FnYUBQ2uy0J5uF1dkKdbrZDPPc3FsLJi6ZQHkZhiQfrGDfqT43Zy58BfiP/JWyrvLCxpecPGQ8LpcogT4bQ2o5ZqTK/PZbksjPy4YBXUGXP04nE6//hU9nTI6e/XbY+Ec+HA/BIEmrkXhUUlLpiWzMLjWZ0vCFT46r3Nv86DL80JoIpgWXPkTOiZvsqrWuT6Yae5ujVxGpTia6cDkhekCX8rVFqW2RBeaJ9gsydEQy69vdGH9dc3t/83eW+VyhEHFwB3uJkH4QG1RqhuZIDTayjTjMVqMt6fI6zx9LF+B7a4KvqP2VUg3OFcCoaHynvJSFFhdL/G005aHvZx5MD9vg69EkUt/dVKuyRpRWhiK3u6pjaSHxjI3ifUvNQ4LyIhXIcr/neFsQQmcsN8fup4Xg5wlC6GL3sVwSj6JaIgZ4Y2w1I8YwwyOankzrCSMGN+osME8PFf30VePb3KflDWcutrUlwiMfP3ykZmvfcTQQ2DtpbihK+tioL/FdVGMWpWFba0vbb27Lx4x89PA5L7XQbGNQhF2WnFCGdykculm918l99RaDnLhXgMO9nIZsMpQuGyt3xfPd0pnn3lHOtXdd0Go1s+D16wNCcU+DicQoveUIcrtUuxH45EFAZAmG+zWuE/8yYX+h8Mr3qoq6WGqJeg1Gbruu13sOmyaiIxoD6X+CKwbMN9t1mFv6O5rRduLJnLppF09OYdNFEXlhey6aS2K/p+/0WoKOk6j4ndIcy+CoY53mjc/d1m2loqRQs8z
 i8TdobNoi4aXRu9uy8zwp9hHQdPgju9SYsPMyTjPtRIbFBJ8S3Vqayn6DQOoAhbEIDJUHlRnFwQfb4FBTTtdgxVcJowE61TGXDxKC+1FmkwC0rCvnoDDHOzycJmqgX8tnrXmeNEQ8ksQKXZPDWfeefA9ICa3fe8r5cZJw9xYCmDKBanp8yuRxqW1ObPJ1hVGkrOeql2Lx+DCg3Cq9Zyx7hjogO0zJnNOz4W9iQ9fdScWAatCWm9pE6GquUNG6aL4c+2DeaUCI6vAcLT+cHASC0OYgPGu1s2bXgZgN0g48YMVk54BZVk3XTkg4qipuvZs5XtrcdjKvQsMhG4ITiNgyNRGLIM4koCoL7ThJwil5OYP6R83CuLUHoIhWVxagFdb66KZ2fo5oe0W+v4iE7ldhdJQ==
Received: from t480 (89.208.247.201.16clouds.com. [89.208.247.201])
        by smtp.gmail.com with ESMTPSA id iy5-20020a170903130500b001d944e8f0fdsm5878958plb.32.2024.02.05.01.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:43:48 -0800 (PST)
Date: Mon, 5 Feb 2024 17:43:33 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Andre Przywara <andre.przywara@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Heiko Stuebner <heiko@sntech.de>,
	James Hilliard <james.hilliard1@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>, Marek Vasut <marex@denx.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH v2 0/3] ARM: dts: imx6dl: Add support for Sielaff i.MX6
 Solo board
Message-ID: <ZcCsbnNVKJk95cij@t480>
References: <20240116181100.382388-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116181100.382388-1-frieder@fris.de>

On Tue, Jan 16, 2024 at 07:10:25PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This series adds upstream support for the Sielaff i.MX6 Solo board.
> It is used as controller and user interface in vending machines. It
> is based on the i.MX6 Solo SoC and features the following
> peripherals and interfaces:
> 
> * 512 MB DDR3 RAM
> * 512 MB NAND Flash
> * 1 MB NOR Flash
> * SD card
> * Debug LED
> * Debug UART
> * Key Inputs
> * RTC
> * RS232
> * 100 MBit Ethernet
> * USB Hub
> * USB OTG
> * HDMI
> * 7" LVDS IPS panel
> * PWM Backlight
> * Optional Extension Board with USB Ethernet NIC
> 
> Patch 1 adds the vendor prefix, patch 2 adds the DT bindings and
> patch 3 adds the DT.
> 
> Changes in v2:
> * Add Acked-by from Conor (Thanks!)
> * Fix touchscreen node names (Thanks Fabio!)
> 
> Frieder Schrempf (3):
>   dt-bindings: vendor-prefixes: Add Sielaff

>   dt-bindings: arm: fsl: Add Sielaff i.MX6 Solo board
>   ARM: dts: imx6dl: Add support for Sielaff i.MX6 Solo board

Applied both, thanks!

