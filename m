Return-Path: <linux-kernel+bounces-65729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FB58550E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AB6285D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8E2127B5D;
	Wed, 14 Feb 2024 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="owtK9vph"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7701272CD;
	Wed, 14 Feb 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933343; cv=none; b=u+HWYsCjMSas5VTWkt654m1uTvPgjE6M7uRS3/Z+jv7ENFvQXzXB6A+seweEd18GV7+aPPIRL9kOGk6d0hjC64ESnM3WzNUiRmLDp/p0JyxE9Lz3xhvGrDYd8ruM+0V8sfdbAkpt4TRYMRSo9CGpixCLAG1368As8cWpIfuujE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933343; c=relaxed/simple;
	bh=Nw7+vdT/duayZz/jMu/uTkdvCgtRC8RYfJqfMVkxq0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa1MAWqjqhrsfEKfKU6SHk7pe4+ZOsH97W8BX2XXvKUQ+DHSKKRcCO2eoe+GMF2IoGEoGIXgTKL3SRjZhmkQHCClM85PWbfOUzNT0YkqJlEAiIUPohqrD+OD2Ua+RcqruFa/ivlCwrpTtCocC9tjsUZVTuK5okA3mPD2CkpkW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=owtK9vph; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7PW7iQBUkHKpGxwZBS1QhoLnsi0mP3M0IqEdbwJt7cg=; b=owtK9vphaHlWGfIV56l03Iqbqh
	G/Y8mbMMXJrnKJNswm2o7LGdiQpGl895H0ibVdKZ/i4rVk+AnL/X+DvtIU1IzPN9d7f3YirDTNvCF
	v7miZpQz5AvG3Owh/knmB+lydFXZGrZs5LnKZzEEL1wAEK+DNnqzCezzPDi6Gk0v6ZpY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raJU1-007oRw-Ez; Wed, 14 Feb 2024 18:55:45 +0100
Date: Wed, 14 Feb 2024 18:55:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 13/14] net: phy: marvell-88q2xxx: remove
 duplicated assignment of pma_extable
Message-ID: <0595282e-8734-4f9e-8d3e-0867b2cc0d41@lunn.ch>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-14-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213213955.178762-14-dima.fedrau@gmail.com>

On Tue, Feb 13, 2024 at 10:39:52PM +0100, Dimitri Fedrau wrote:
> Remove assignment of phydev->pma_extable in mv88q222x_revb0_config_init.
> It is already done in mv88q2xxx_config_init, just call
> mv88q2xxx_config_init.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

