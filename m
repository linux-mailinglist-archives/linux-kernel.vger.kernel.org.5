Return-Path: <linux-kernel+bounces-137799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA5D89E7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69181F23B12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB517FD;
	Wed, 10 Apr 2024 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riJ6917K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318F391;
	Wed, 10 Apr 2024 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712448; cv=none; b=OoXLkCNjMSU7enuyxLxOYZ38V9CvDeGgCZPsC75zpZ1NDP5d8eGAuQvfMdQabdVluCsNAK9KemGUri2JB+6chm2HswzpOVwJ6wcKAyYmk+BECycPI8dSrrDdfBzVbl6f7OHdhSpKzOs6U/+7uZu1S53UDN061qYvVkHs5N6eOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712448; c=relaxed/simple;
	bh=q2tSh/sYbSxvQVVhorLxNwZpuvP0uBvNHMIk0JP8zUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soe2MkEJrENnecBmvsCx+BsIMlzb+ngVs5VNroitw3ToRDuVS2vfHiNUFP92Gdl56pi/jwCavlqpdBDa7WXkLvsBSE893AF9JQz56oBsyWKr99jrgsmbrSDPoKZL8jVKP7P4+vu4u13eU2NcRxHkgZd+Ygk/2iK2P/veLYW+c8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riJ6917K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94883C433C7;
	Wed, 10 Apr 2024 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712712447;
	bh=q2tSh/sYbSxvQVVhorLxNwZpuvP0uBvNHMIk0JP8zUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=riJ6917KTbycUcwzl5X+15b0Es1e8f6b1ydfFMc2/2UZX9J7juMtDtyeb9zufa3AN
	 4K2mxe+Bm7dDpAyOvfSLhfabriZyfl3DNlyynCWN4pJw1u7tncJ8hcZ2DsLpP319SU
	 mWf1DiKy+AC64RMLtOXB8m65+HHOrYye8c0aqORzHyARNF0F2VK/9TyDJESd9NPg6h
	 UI5rLDHF7Kko8/02PoNm5XEBn4JZfQz9R4HPFAsQx/BpPOf7ChmCAI9fhvD6Z70Zhc
	 SL4pX+CNajtbzKxTEo43vKJesKBPSBv9paBYshU4kHf+0AFdm2M7K96zBDdFCsxrvM
	 /O+SdeDgXzmgA==
Date: Tue, 9 Apr 2024 18:27:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v10 07/13] net: Add struct
 kernel_ethtool_ts_info
Message-ID: <20240409182725.139856d5@kernel.org>
In-Reply-To: <20240409-feature_ptp_netnext-v10-7-0fa2ea5c89a9@bootlin.com>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
	<20240409-feature_ptp_netnext-v10-7-0fa2ea5c89a9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Apr 2024 10:26:29 +0200 Kory Maincent wrote:
> In prevision to add new UAPI for hwtstamp we will be limited to the struct
> ethtool_ts_info that is currently passed in fixed binary format through the
> ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if new kernel code
> already started operating on an extensible kernel variant of that
> structure, similar in concept to struct kernel_hwtstamp_config vs struct
> hwtstamp_config.
> 
> Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, here
> we introduce the kernel-only structure in include/linux/ethtool.h.
> The manual copy is then made in the function called by ETHTOOL_GET_TS_INFO.

This one now conflicts :(

Applying: net: Add struct kernel_ethtool_ts_info
error: sha1 information is lacking or useless (drivers/net/phy/marvell_ptp.c).
error: could not build fake ancestor
-- 
pw-bot: cr

