Return-Path: <linux-kernel+bounces-65726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C418550E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3331C217EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C711272D0;
	Wed, 14 Feb 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZRDla7Rf"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105137D418;
	Wed, 14 Feb 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933296; cv=none; b=aSTWmaZYLRguLYaVsztRxNHZxh5phHstZwLKV0weNuOQkc3eeuyd2oeHpxfYdIALxJyAXDOY97e5+/3pCMKM0hWcRI31rGtsyNMAymGeh6t7fR/q8zsKYMipz7tCTMHXzbylyuaoI6x8dKp7AAW6QZlmOvXre2TfkOH4gGn3CLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933296; c=relaxed/simple;
	bh=uqn4JgPiYURzkqOf09s3/ySAX1UzVvMdPvnJ8vJSKBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOp1LydM2QnJA4iMaqvc2YZEfeKSJVI1kg0NaEPXaSE7Nq0LxzF468xwkqXy0dPdu2N0Mp+9/J7Y27uuZy1Zjr0isjTrNLtrCvVUyQt+/c7TOWThbEmtxY0EMAx6bDn8R985kEhI0luqzJALYgRokZH0cxJR6JHLrAGH1tfIAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZRDla7Rf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+4ZRUXnSz4b1qZeQ5nORmugk2/Wj0JX8Orjc4mefblY=; b=ZRDla7RfroZNN68j+2HIa/ySP4
	ynjC6n9ahAvCywWCuv9twxAgn7gs6HeUe5OR44+Bd5FTXzDS2PgCpbvh74IoeFjHFcNpo+hUrA5aJ
	IqhpKAYY4psyPp8jfFzi+FpcqCPFogYgKS7FDmHvUlIjrhD2OJar04PyZIF5xsicRItw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raJTG-007oQu-C5; Wed, 14 Feb 2024 18:54:58 +0100
Date: Wed, 14 Feb 2024 18:54:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 09/14] net: phy: marvell-88q2xxx: add cable
 test support
Message-ID: <fe604759-d1cd-4a4d-ba64-69936b3e6598@lunn.ch>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-10-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213213955.178762-10-dima.fedrau@gmail.com>

> +static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
> +					   bool *finished)
> +{
> +	int ret;
> +	u32 dist;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TDR_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	*finished = true;

That looks odd. Is there no status bit which says it has completed? Is
it guaranteed to complete within a fixed time? How is it guaranteed that
mv88q222x_cable_test_get_status() is called at the necessary delay after 
mv88q222x_cable_test_start()?

	Andrew

