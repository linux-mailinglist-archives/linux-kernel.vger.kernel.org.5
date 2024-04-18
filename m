Return-Path: <linux-kernel+bounces-150063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6078A99E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6581C21830
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6691C22091;
	Thu, 18 Apr 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL6auBgc"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734FE57B;
	Thu, 18 Apr 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443522; cv=none; b=tgiIB44WUUNxaRG6GJQHzOiWnTlUomHmEQxM0IfKPv93RdYrpv5LX8wpsHu2vnGs/61iG2YSaR8bN1Rn1Cv1zxPqBI5VVeeYO8QliZ7f4DiCXqloqipNrkbB39j6wykLUBj74dEPZPeLIXtxKXG/q/W6BANFsEv17HN0yOk5skE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443522; c=relaxed/simple;
	bh=8T5tDNpijMOGTkIpZA85sKyrwj4gV3Qgom9RsdstytQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbbabniFvyVYE1cGG5JuSX7z0GGEcAGvqnLd44L2aaAFTkFqN6ZuvAscnHZDrmFWZbjZvOQztVLyjJNKi11wT9bT/gzknkBGN6ZdAoLefrkIxZIGIX+YaiC8rSvC75Me9CwT95hLoNoZCStAnUFKnEZxjw145u+LQpg+0+8iEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL6auBgc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso585123f8f.2;
        Thu, 18 Apr 2024 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713443519; x=1714048319; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f20jXAs0R410nde+WOZddVWtxUvYuYRobOHpSmKOaaQ=;
        b=bL6auBgcQPYBnWJltKDmPU7TZ/0HKjRzFsPBcmt114QZ/9BpovI5RaTLUqbgdfveDP
         4jconqddv44KwVds53tGEBsEr//S1B/mbneunwUEbeG5A+Ifasko9C2PhzvUjqKwjrT9
         hf7YrtYCDBpsbfJpMiskUFtNIOdEqxUm0WnxPNSmqCVKhsjTCcEa/2k3cIHNCVdCVsha
         MlsLkhMQTfqLFhXeQZTI+Lgya6AH+cfQKyS61GM3beIeT6AYcJhCULv7n0ErEaiY57MJ
         VA9TdNLgO3XVGH9NCjxlqDsJM1HXQLExkwu5ptpEgkcWk79VZG5My9OTMld2chmwQu9M
         81OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713443519; x=1714048319;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f20jXAs0R410nde+WOZddVWtxUvYuYRobOHpSmKOaaQ=;
        b=qIvwfZTTY+6gegTTsYzkqeLXM3qhDuYP/CLAvXKthER+IxWuofNICgJzoH1Cj47yB7
         EE+5or0bIGUzzxzZ3kOJ3UoQs+3/U+LZhPN8JPG4dQwbzn0Nyo6y/1VVxwkY26rH9l8X
         ZpOWXeQz3/PSxDRxyIqFw+RFuS7sYkRRAxjostCDOk+JHEcUsaiTWLS47YtNOcGZ+B+h
         6k4lIfXjofbuLXyTRaQKTFEWSHnp6j1pFa2O+zsLEhkFTXnoboutp118UaP9V6p+j3kF
         dZPuR8f+jxQOxouYAgCAONLzMUe+icytkSBxwmWySL00UWv1laBVk4wwVRQKScBfuvt+
         Q9iw==
X-Forwarded-Encrypted: i=1; AJvYcCULmWynKR+7BMGobwCQuX3jaNxD6EG2EQT6lG1d10U3v3BG69KLKmpy4O+xhjgRDRY08HrW2b9hDrckbs+fs7SpEsmll1FDwMQDBL7Heti8908YQ2qvKcG1WLuW0Q8741boRrvR
X-Gm-Message-State: AOJu0Yykizl9q3Hkx3gMclodZUwhbTEg2UaEMWi5wu9tUwSLCF/xAVm9
	DPXbiG1K1YeOW4yQixb4XKlMc3Hib0VemggWTkhsktpzvNs1DoOm
X-Google-Smtp-Source: AGHT+IGNDZ9xxSlFasBFyFMQ9stqMTrPtzNuO2e6Tiex39gwe1cv2145+fyDbw4VjYUw/oakuTtrIA==
X-Received: by 2002:a5d:5266:0:b0:343:84ca:ef27 with SMTP id l6-20020a5d5266000000b0034384caef27mr1703207wrc.41.1713443518595;
        Thu, 18 Apr 2024 05:31:58 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id e5-20020adfe385000000b003455e5d2569sm1790839wrm.0.2024.04.18.05.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:31:57 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:31:55 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v2] net: phy: marvell-88q2xxx: add support for Rev B1 and
 B2
Message-ID: <20240418123155.GA248236@debian>
References: <20240417-mv88q222x-revb1-b2-init-v2-1-7ef41f87722a@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417-mv88q222x-revb1-b2-init-v2-1-7ef41f87722a@ew.tq-group.com>

Am Wed, Apr 17, 2024 at 04:06:36PM +0200 schrieb Gregor Herburger:
> Different revisions of the Marvell 88q2xxx phy needs different init
> sequences.
> 
> Add init sequence for Rev B1 and Rev B2. Rev B2 init sequence skips one
> register write.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> ---
> Hi,
> 
> as discussed when adding support for Marvell 88Q2220 Revision B0 [1],
> newer revisions need different init sequences. So add support for Rev B1
> and B2 with this patch.
> 
> [1] https://lore.kernel.org/netdev/20240216205302.GC3873@debian/
> 
> Best regards
> Gregor
> ---
> Changes in v2:
> - Add helper function to write phy mmd sequences
> - Link to v1: https://lore.kernel.org/r/20240403-mv88q222x-revb1-b2-init-v1-1-48b855464c37@ew.tq-group.com
> ---
>  drivers/net/phy/marvell-88q2xxx.c | 119 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 103 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index 6b4bd9883304..bbbb3efb7877 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -12,6 +12,8 @@
>  #include <linux/hwmon.h>
>  
>  #define PHY_ID_88Q2220_REVB0	(MARVELL_PHY_ID_88Q2220 | 0x1)
> +#define PHY_ID_88Q2220_REVB1	(MARVELL_PHY_ID_88Q2220 | 0x2)
> +#define PHY_ID_88Q2220_REVB2	(MARVELL_PHY_ID_88Q2220 | 0x3)
>  
>  #define MDIO_MMD_AN_MV_STAT			32769
>  #define MDIO_MMD_AN_MV_STAT_ANEG		0x0100
> @@ -129,6 +131,49 @@ static const struct mmd_val mv88q222x_revb0_init_seq1[] = {
>  	{ MDIO_MMD_PCS, 0xfe05, 0x755c },
>  };
>  
> +static const struct mmd_val mv88q222x_revb1_init_seq0[] = {
> +	{ MDIO_MMD_PCS, 0xFFE4, 0x0007 },
> +	{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
> +	{ MDIO_MMD_PCS, 0xFFE3, 0x7000 },
> +	{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0840 },
> +};
> +
> +static const struct mmd_val mv88q222x_revb2_init_seq0[] = {
> +	{ MDIO_MMD_PCS, 0xFFE4, 0x0007 },
> +	{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
> +	{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0840 },
> +};
> +
> +static const struct mmd_val mv88q222x_revb1_revb2_init_seq1[] = {
> +	{ MDIO_MMD_PCS, 0xFE07, 0x125A },
> +	{ MDIO_MMD_PCS, 0xFE09, 0x1288 },
> +	{ MDIO_MMD_PCS, 0xFE08, 0x2588 },
> +	{ MDIO_MMD_PCS, 0xFE72, 0x042C },
> +	{ MDIO_MMD_PCS, 0xFFE4, 0x0071 },
> +	{ MDIO_MMD_PCS, 0xFFE4, 0x0001 },
> +	{ MDIO_MMD_PCS, 0xFE1B, 0x0048 },
> +	{ MDIO_MMD_PMAPMD, 0x0000, 0x0000 },
> +	{ MDIO_MMD_PCS, 0x0000, 0x0000 },
> +	{ MDIO_MMD_PCS, 0xFFDB, 0xFC10 },
> +	{ MDIO_MMD_PCS, 0xFE1B, 0x58 },
> +	{ MDIO_MMD_PCS, 0xFCAD, 0x030C },
> +	{ MDIO_MMD_PCS, 0x8032, 0x6001 },
> +	{ MDIO_MMD_PCS, 0xFDFF, 0x05A5 },
> +	{ MDIO_MMD_PCS, 0xFDEC, 0xDBAF },
> +	{ MDIO_MMD_PCS, 0xFCAB, 0x1054 },
> +	{ MDIO_MMD_PCS, 0xFCAC, 0x1483 },
> +	{ MDIO_MMD_PCS, 0x8033, 0xC801 },
> +	{ MDIO_MMD_AN, 0x8032, 0x2020 },
> +	{ MDIO_MMD_AN, 0x8031, 0xA28 },
> +	{ MDIO_MMD_AN, 0x8031, 0xC28 },
> +	{ MDIO_MMD_PCS, 0xFBBA, 0x0CB2 },
> +	{ MDIO_MMD_PCS, 0xFBBB, 0x0C4A },
> +	{ MDIO_MMD_PCS, 0xFE5F, 0xE8 },
> +	{ MDIO_MMD_PCS, 0xFE05, 0x755C },
> +	{ MDIO_MMD_PCS, 0xFA20, 0x002A },
> +	{ MDIO_MMD_PCS, 0xFE11, 0x1105 },
> +};
> +
nit: use small letters for hex values.

>  static int mv88q2xxx_soft_reset(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -687,31 +732,72 @@ static int mv88q222x_soft_reset(struct phy_device *phydev)
>  	return 0;
>  }
>  
> -static int mv88q222x_revb0_config_init(struct phy_device *phydev)
> +static int mv88q222x_write_mmd_vals(struct phy_device *phydev,
> +				    const struct mmd_val *vals, size_t len)
>  {
> -	int ret, i;
> +	int ret;
>  
> -	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb0_init_seq0); i++) {
> -		ret = phy_write_mmd(phydev, mv88q222x_revb0_init_seq0[i].devad,
> -				    mv88q222x_revb0_init_seq0[i].regnum,
> -				    mv88q222x_revb0_init_seq0[i].val);
> +	for (; len; vals++, len--) {
> +		ret = phy_write_mmd(phydev, vals->devad, vals->regnum,
> +				    vals->val);
>  		if (ret < 0)
>  			return ret;
>  	}
>  
> +	return 0;
> +}
> +
> +static int mv88q222x_revb0_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb0_init_seq0,
> +				       ARRAY_SIZE(mv88q222x_revb0_init_seq0));
> +	if (ret < 0)
> +		return ret;
> +
>  	usleep_range(5000, 10000);
>  
> -	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb0_init_seq1); i++) {
> -		ret = phy_write_mmd(phydev, mv88q222x_revb0_init_seq1[i].devad,
> -				    mv88q222x_revb0_init_seq1[i].regnum,
> -				    mv88q222x_revb0_init_seq1[i].val);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb0_init_seq1,
> +				       ARRAY_SIZE(mv88q222x_revb0_init_seq1));
> +	if (ret < 0)
> +		return ret;
>  
>  	return mv88q2xxx_config_init(phydev);
>  }
>  
> +static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
> +{
> +	bool is_rev_b1 = phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB1;
> +	int ret;
> +
> +	if (is_rev_b1)
> +		ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb1_init_seq0,
> +					       ARRAY_SIZE(mv88q222x_revb1_init_seq0));
> +	else
> +		ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb2_init_seq0,
> +					       ARRAY_SIZE(mv88q222x_revb2_init_seq0));
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(3000, 5000);
> +
> +	ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb1_revb2_init_seq1,
> +				       ARRAY_SIZE(mv88q222x_revb1_revb2_init_seq1));
> +	if (ret < 0)
> +		return ret;
> +
> +	return mv88q2xxx_config_init(phydev);
> +}
> +
> +static int mv88q222x_config_init(struct phy_device *phydev)
> +{
> +	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
> +		return mv88q222x_revb0_config_init(phydev);
> +	else
> +		return mv88q222x_revb1_revb2_config_init(phydev);
> +}
> +
>  static int mv88q222x_cable_test_start(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -810,14 +896,15 @@ static struct phy_driver mv88q2xxx_driver[] = {
>  		.get_sqi_max		= mv88q2xxx_get_sqi_max,
>  	},
>  	{
> -		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
> +		.phy_id			= MARVELL_PHY_ID_88Q2220,
> +		.phy_id_mask		= MARVELL_PHY_ID_MASK,
>  		.name			= "mv88q2220",
>  		.flags			= PHY_POLL_CABLE_TEST,
>  		.probe			= mv88q2xxx_probe,
>  		.get_features		= mv88q2xxx_get_features,
>  		.config_aneg		= mv88q2xxx_config_aneg,
>  		.aneg_done		= genphy_c45_aneg_done,
> -		.config_init		= mv88q222x_revb0_config_init,
> +		.config_init		= mv88q222x_config_init,
>  		.read_status		= mv88q2xxx_read_status,
>  		.soft_reset		= mv88q222x_soft_reset,
>  		.config_intr		= mv88q2xxx_config_intr,
> @@ -836,7 +923,7 @@ module_phy_driver(mv88q2xxx_driver);
>  
>  static struct mdio_device_id __maybe_unused mv88q2xxx_tbl[] = {
>  	{ MARVELL_PHY_ID_88Q2110, MARVELL_PHY_ID_MASK },
> -	{ PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0), },
> +	{ MARVELL_PHY_ID_88Q2220, MARVELL_PHY_ID_MASK },
>  	{ /*sentinel*/ }
>  };
>  MODULE_DEVICE_TABLE(mdio, mv88q2xxx_tbl);
>
Hi Gregor,

tested it for rev. B0 and it works as expected.

Tested-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Best regards,
Dimitri Fedrau

> ---
> base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
> change-id: 20240403-mv88q222x-revb1-b2-init-9961d2cf1d27
> 
> Best regards,
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
> 

