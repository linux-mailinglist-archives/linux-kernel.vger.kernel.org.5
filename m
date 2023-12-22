Return-Path: <linux-kernel+bounces-9729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA57781CA50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192C11C20E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E910318C27;
	Fri, 22 Dec 2023 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctcXJKZ2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A719BD3;
	Fri, 22 Dec 2023 12:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EDEC433CA;
	Fri, 22 Dec 2023 12:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703249564;
	bh=7XWGcOrq/RDTo8zQVqjxLsAsAQ6YQ8CXxz6OTo3M7HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctcXJKZ2iRVYnCCHSwbYGMB5ikB+PqhrA0xKcspRtJDDZbd/qi1dzFzTjWOttRgcD
	 wG1szO5tDBRemQjNyvv0MwwLnKQ3ORAaYgWSxgwwsO/Kpt+aYL8Xk/8ga5vOctKptw
	 HgE8LiK8KKfzNaLCXO18k/CuO5QOYbTBJwj7VqGIu2c7hc7WUKOFkBAbZQQlIibMvM
	 RqDCLLDUVfSAx3icsOsDBca5eC7OkvTSgq+qvPZhHVVFzxuk4fURkTUVShiV9FKGEN
	 Q9Sch8Eh7sjrcOSQeXyAbJfamJ8bbE3a6HWXppJtoi7fdJL83qgwNV2hGe8+iCsIcW
	 fSsycsr3KYTBw==
Date: Fri, 22 Dec 2023 13:52:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, wens@csie.org, samuel@sholland.org,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v5 1/3] phy: handle optional regulator for PHY
Message-ID: <20231222125234.GF1202958@kernel.org>
References: <20231220203537.83479-1-jernej.skrabec@gmail.com>
 <20231220203537.83479-2-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220203537.83479-2-jernej.skrabec@gmail.com>

On Wed, Dec 20, 2023 at 09:35:35PM +0100, Jernej Skrabec wrote:
> From: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> Add handling of optional regulators for PHY.
> 
> Regulators need to be enabled before PHY scanning, so MDIO bus
> initiate this task.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Hi Jernej,

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3cc52826f18e..832cb2d4f76a 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -757,6 +757,9 @@ struct phy_device {
>  	void (*phy_link_change)(struct phy_device *phydev, bool up);
>  	void (*adjust_link)(struct net_device *dev);
>  
> +	int regulator_cnt;
> +	struct regulator_bulk_data *consumers;

Please add these two new fields to the kernel doc
for struct phy_device which appears a above this hunk in phy.h.

> +
>  #if IS_ENABLED(CONFIG_MACSEC)
>  	/* MACsec management functions */
>  	const struct macsec_ops *macsec_ops;

-- 
pw-bot: changes-requested

