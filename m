Return-Path: <linux-kernel+bounces-31551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A609832FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001E3284297
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899D57320;
	Fri, 19 Jan 2024 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkQFUxDp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584BC5647F;
	Fri, 19 Jan 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696850; cv=none; b=PGiksyk4oyVD7DOqthqWPUlynCLm4Mj8hRecW78Sg4vztU/27kAN6+ZjyeS6GtvmEkaJJvfzSuzRGmNrHc67k7ufgJ/bMsmvQTrImtKjxmd7PHIAUg2VRGIDn9h25QZ1/I/DkNbtJGJ+un2At+90i61fAh02GcMVEMc1dkngjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696850; c=relaxed/simple;
	bh=KAd8AWbTkshrRCVPFHm8BpulYfCthrHqV9SjDOl9BW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqn1CKP8G1onvAtv3ErTYodH07dmLKCVtFwjMO3X6oNyaFvGX2n6ZdrqkTpEbJZ6tlvrUOVLPoEkOkizb3FspVd0kFzbyfSysgvLd13TJodcVEiJt/lVvurAyuMq/AWEth0VyxDiBywN+iYqedSl9lUoIxKaK6qgbtd98bxLBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkQFUxDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199DDC433C7;
	Fri, 19 Jan 2024 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705696849;
	bh=KAd8AWbTkshrRCVPFHm8BpulYfCthrHqV9SjDOl9BW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkQFUxDp44h+6jZ/E1s2lwKY6TwoSWbVkuy3bnePBOwYoICkirSJ04tgQ+Zq1qpFV
	 1s6dPHs6KVtDZ4itQ0DFg6uO4EWpPfK1/A4Ydu1kuu099cx66Nk6/RNMisOWA2gnLF
	 V4pS7d10gK5BRZA2BiNmuYAouKWVpsvJt3QfssqC+aKVaa71HnJu9+xt/WyszGYEjt
	 wdzkaE4PCuhLYo6rkHCCpe6v9fY9nE8IwtoUk43lsIz1FbjNQ6iUFsTpyVCnV0Myaw
	 OoUjBfsDicR/kICF1tImpeLJdwT41Si2shE3nfpcz23YG0BWgXxNbCvSgSVuI5SVhD
	 Yaz4y/grHUrVQ==
Date: Fri, 19 Jan 2024 20:40:43 +0000
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [RFC PATCH v2 2/3] net: ti: icssg-switch: Add switchdev based
 driver for ethernet switch support
Message-ID: <20240119204043.GC105385@kernel.org>
References: <20240118071005.1514498-1-danishanwar@ti.com>
 <20240118071005.1514498-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118071005.1514498-3-danishanwar@ti.com>

On Thu, Jan 18, 2024 at 12:40:04PM +0530, MD Danish Anwar wrote:

..

> @@ -211,6 +216,15 @@ struct prueth_pdata {
>   * @iep0: pointer to IEP0 device
>   * @iep1: pointer to IEP1 device
>   * @vlan_tbl: VLAN-FID table pointer
> + * @hw_bridge_dev: pointer to HW bridge net device
> + * @br_members: bitmask of bridge member ports
> + * @prueth_netdevice_nb: netdevice notifier block
> + * @prueth_switchdevice_nb: switchdev notifier block

nit: s/prueth_switchdevice_nb/prueth_switchdev_nb/

     Flagged by ./scripts/kernel-doc -none

> + * @prueth_switchdev_bl_nb: switchdev blocking notifier block
> + * @is_switch_mode: flag to indicate if device is in Switch mode
> + * @is_switchmode_supported: indicates platform support for switch mode
> + * @switch_id: ID for mapping switch ports to bridge
> + * @default_vlan: Default VLAN for host
>   */
>  struct prueth {
>  	struct device *dev;
> @@ -236,6 +250,16 @@ struct prueth {
>  	struct icss_iep *iep0;
>  	struct icss_iep *iep1;
>  	struct prueth_vlan_tbl *vlan_tbl;
> +
> +	struct net_device *hw_bridge_dev;
> +	u8 br_members;
> +	struct notifier_block prueth_netdevice_nb;
> +	struct notifier_block prueth_switchdev_nb;
> +	struct notifier_block prueth_switchdev_bl_nb;
> +	bool is_switch_mode;
> +	bool is_switchmode_supported;
> +	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
> +	int default_vlan;
>  };
>  
>  struct emac_tx_ts_response {

..

