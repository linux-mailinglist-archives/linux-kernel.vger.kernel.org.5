Return-Path: <linux-kernel+bounces-65733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9368550F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD581C2A1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF3D129A79;
	Wed, 14 Feb 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ags5qKqz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC28127B5F;
	Wed, 14 Feb 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933363; cv=none; b=TMJcbnHiYvqYoirLLGbJzJ4SrJSRh83oenBvFQcB0r1IjElTctMDYHL8fHZxMWNMyUoA9gipdupvGsbPRBWsjPRH+u+Wru6HzAI/xupduqIwNfp57y0eqnvgbMUIpzhEXYVbZ7+sfYGglMCPP22p/fWSSgjwPbDN8vVc9VN/6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933363; c=relaxed/simple;
	bh=EPgOn88Bqs3+CbigrNlKuT37+FLfbDO+xmmDOk72BtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtswMEdiySx6Yb4qwS3vfKAdIqhPSD17B1MdAS4ZNnwPWbTh61aNHstStXqiIXyvnwB71H6Q9ajlydpKoH+XAUnkcKcpWhF9Vft0o1Spgso6xwVtU1Rtu5zxp0RU/eprhgD2KYHi3blusAZE+ECmsTdyzWkIjRMp2p7CMrfW2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ags5qKqz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FjPork/vCYUNmQ8wmh/BaLGaTRTv7+JxGtfWI5A+6XI=; b=Ags5qKqzplLOLZ99ZzVKqUcQEL
	0DHvjNd/tNy5KTst0xvEnwUZEKu9NSYOsyjkZtb14+qCgus0m3G94sBwGvDVnSo1oFMcdsGMQgz9M
	B/OWvNjr7fiEZEffbNT67hHhoZ7qP+pKYA58JdToblnngKOwoRtTPdiTfQkebxxX3XZY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raJUL-007oSe-Pd; Wed, 14 Feb 2024 18:56:05 +0100
Date: Wed, 14 Feb 2024 18:56:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 14/14] net: phy: marvell-88q2xxx: move
 interrupt configuration
Message-ID: <32493eb6-a55d-401c-b359-0c58b1d22f12@lunn.ch>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-15-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213213955.178762-15-dima.fedrau@gmail.com>

On Tue, Feb 13, 2024 at 10:39:53PM +0100, Dimitri Fedrau wrote:
> Move interrupt configuration from mv88q222x_revb0_config_init to
> mv88q2xxx_config_init. Same register and bits are used for the 88q2xxx
> devices.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

