Return-Path: <linux-kernel+bounces-109474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7AD8819A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B792844EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3085C7B;
	Wed, 20 Mar 2024 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zQXJE7vc"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D5BA45;
	Wed, 20 Mar 2024 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975198; cv=none; b=GC/zu8yTPNG6x+ksE/mD96HIeWdGK3X85bIT+/z3WyPgBAP1wuGy8lpyFxqlTCqg8Hv1qAM8UNtYhMkZBoXeAPFZaJwIZIb8af+xFtEKyH9TCLDlCoBCwfKKpeScAA14jmeAXSTzMtiyoaTWj+vkImxX3kyFIIGTWoJSbnPqKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975198; c=relaxed/simple;
	bh=LxOwNqItoGww2SXOkAgOwGKpdrnrybWfJpdwcqgsAxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0osLWcpI0Gn0+MSCVhrVUfe61TrP0Ri973/wU3omoQpRBrwOJBW7X8J/e1K5hU46LUe9tecAzaOaCpw1vkFvCRgfY5Joa3zG1Mm3Wdy1YkyQQJBQFwrTiCRpjPN/a6E7axSl9u3wjCUPhW9Kg2u5LcpzBCqIF90/aqpP5tM4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zQXJE7vc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZQ5bl/zj2pbCCs6ni9E3xhdbegTyO49cnfIVZy3JuwA=; b=zQXJE7vcEnb8875Wcv3yKIaFRV
	c77Zm+c2VOVNjh1jPlygBo1Rt0fCPqwz7w1DRQdNU/1pfRleV0ZZUcwudmd25Mu1Zw4j3Rrtqm9MG
	IgEWuMa8LGsA0gvZdQkI6exWlqgpRDltj7xrE/S9sW7qgVlH0coevNGQnZUl78QAXBeI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rn4o2-00AosD-Gf; Wed, 20 Mar 2024 23:53:10 +0100
Date: Wed, 20 Mar 2024 23:53:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Message-ID: <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>

> +	if (netdev->phydev) {
> +		ret = phy_ethtool_set_wol(netdev->phydev, wol);
> +		if (ret != -EOPNOTSUPP && ret != 0)
> +			return ret;

I'm not sure this condition is correct.

If there is an error, and the error is not EOPNOTSUPP, you want to
report that error. However, if the PHY can support the WoL
configuration, it will return 0, and this function should exit, WoL in
the MAC is not needed. And doing WoL in the PHY consumes less power
since you can suspend the MAC.

So i think it should simply be:

> +		if (ret != -EOPNOTSUPP)
> +			return ret;

Do you have a board with this MAC with a PHY which does have some WoL
support. Could you test PHY WoL is used when appropriate?

	Andrew

