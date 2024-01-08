Return-Path: <linux-kernel+bounces-19385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9350826C32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F59D282F37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD014288;
	Mon,  8 Jan 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkLnXY8u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C11426D;
	Mon,  8 Jan 2024 11:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA26BC433C7;
	Mon,  8 Jan 2024 11:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704712129;
	bh=wEJjNDaehk6eNSabXV7AmGugSgejPKqecFRSyFZ8RZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkLnXY8u4eI9km5fTHwImF1ktVgLyZ6u2QGrP7Hk+OgzoGS2vG8mnJyRaxXn+91iH
	 nwC+Dl+c79JuUYMhoX+SsMBWnmT1P9qwWOpSWnHSGJ9ltXJKc6VANm/u95gJgCavAX
	 dkLmyBLZe+XuRwRJeeCgDzytrVvnp42JLFZ1Zi3vWxteEcdk1pzIFAFB/hQE1nKd4X
	 j6QH4T4Q3dBf8wKpKhZz8grpjjpFlwEN98upscb41xbxcyTClGu+OiB5+I2rPhKtib
	 LzdaDjZ26pI6G0rXjjk9UytWHG+rJFOfoWF+c2AFz3n5qhuX0Lih89cMxiUUiqSlub
	 gSKOzV9j51BIQ==
Date: Mon, 8 Jan 2024 11:08:44 +0000
From: Simon Horman <horms@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 5/5] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <20240108110844.GH132648@kernel.org>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
 <20240108093702.13476-6-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108093702.13476-6-dima.fedrau@gmail.com>

On Mon, Jan 08, 2024 at 10:37:00AM +0100, Dimitri Fedrau wrote:
> Add a driver for the Marvell 88Q2220. This driver allows to detect the
> link, switch between 100BASE-T1 and 1000BASE-T1 and switch between
> master and slave mode. Autonegoation is supported.

nit: Autonegotiation

> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/net/phy/marvell-88q2xxx.c | 206 +++++++++++++++++++++++++++++-
>  include/linux/marvell_phy.h       |   1 +
>  2 files changed, 201 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c

...

> @@ -29,6 +36,42 @@
>  
>  #define MDIO_MMD_PCS_MV_RX_STAT			33328
>  
> +struct mmd_val {
> +	int devad;
> +	u32 regnum;
> +	u16 val;
> +};
> +
> +const struct mmd_val mv88q222x_revb0_init_seq0[] = {
> +	{ MDIO_MMD_PCS, 0x8033, 0x6801 },
> +	{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
> +	{ MDIO_MMD_PMAPMD, MDIO_CTRL1,
> +	  MDIO_CTRL1_LPOWER | MDIO_PMA_CTRL1_SPEED1000 },
> +	{ MDIO_MMD_PCS, 0xfe1b, 0x48 },
> +	{ MDIO_MMD_PCS, 0xffe4, 0x6b6 },
> +	{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0 },
> +	{ MDIO_MMD_PCS, MDIO_CTRL1, 0x0 },
> +};
> +
> +const struct mmd_val mv88q222x_revb0_init_seq1[] = {
> +	{ MDIO_MMD_PCS, 0xfe79, 0x0 },
> +	{ MDIO_MMD_PCS, 0xfe07, 0x125a },
> +	{ MDIO_MMD_PCS, 0xfe09, 0x1288 },
> +	{ MDIO_MMD_PCS, 0xfe08, 0x2588 },
> +	{ MDIO_MMD_PCS, 0xfe11, 0x1105 },
> +	{ MDIO_MMD_PCS, 0xfe72, 0x042c },
> +	{ MDIO_MMD_PCS, 0xfbba, 0xcb2 },
> +	{ MDIO_MMD_PCS, 0xfbbb, 0xc4a },
> +	{ MDIO_MMD_AN, 0x8032, 0x2020 },
> +	{ MDIO_MMD_AN, 0x8031, 0xa28 },
> +	{ MDIO_MMD_AN, 0x8031, 0xc28 },
> +	{ MDIO_MMD_PCS, 0xffdb, 0xfc10 },
> +	{ MDIO_MMD_PCS, 0xfe1b, 0x58 },
> +	{ MDIO_MMD_PCS, 0xfe79, 0x4 },
> +	{ MDIO_MMD_PCS, 0xfe5f, 0xe8 },
> +	{ MDIO_MMD_PCS, 0xfe05, 0x755c },
> +};

nit: mv88q222x_revb0_init_seq0 and mv88q222x_revb0_init_seq1 seem
    to only be used in this file. Perhaps they should be static.

...

