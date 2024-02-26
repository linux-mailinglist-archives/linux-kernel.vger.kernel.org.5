Return-Path: <linux-kernel+bounces-81829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B4867A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C171F244A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218B12BF01;
	Mon, 26 Feb 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KD6zZoZg"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3C12AAE5;
	Mon, 26 Feb 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962239; cv=none; b=NtOMSoNFwR7+XoevLuhr3b0MQoObjXnVHDeSCSlUg4cZUtyZ8S+FDM4o1tm/sMYzNH9/mILJNxi87XO4MDDNQjkF9eDdEcrx2Q9yB4S0YqA4AUN0uPR4cLi47uiJ/tamxACTu2M+LMwnGu75jCBHElIar03cq9kVsBjzRRNnWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962239; c=relaxed/simple;
	bh=A01BNmVP9A1tmR3VtlSByNSQsi8R6HrQkgjno3xZJLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu5d/1H+doX7zRGeaBdZp7oJK7UJ9p39ZXzxytjovadEaXmdXnsIc/QwjiZxkKSgupzvH64lprGpeDWmekt1NCTjJ9b05xSLK+Cf8XWfZ83jf5ooWdVxCL+N9dCkr8YxpSWPvbFDOzDFEumoW8JpKYsUvOgv4hy/jMJn79HRDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KD6zZoZg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VQ6ZSxatzFmn25+yzQDmr+s/5uD5itV+q5l/DZTxHwI=; b=KD6zZoZgvnLZUnuYQ6vfPvEv0x
	NkfDIfPm42C8wJTy/gC4AEFjeVv9Mpa6TDw3lgLpKSb8ZoiDbCPoQJ3g/WZyap/7vtjJbf79DSbqv
	H0lpUuKbvBUIE3upA4C6MhLt8aaUvEIpz9PqwOel9giPa49lg4oVkXkoFhNQ39u068KQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1red9A-008jol-KK; Mon, 26 Feb 2024 16:44:04 +0100
Date: Mon, 26 Feb 2024 16:44:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
Subject: Re: [PATCH] net: phy: dp83826: disable WOL at init
Message-ID: <0fca6571-39ee-47de-94bc-1bf9749192b1@lunn.ch>
References: <20240223143127.1942129-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223143127.1942129-1-catalin.popescu@leica-geosystems.com>

On Fri, Feb 23, 2024 at 03:31:27PM +0100, Catalin Popescu wrote:
> Commit d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
> introduced a regression in that WOL is not disabled by default for DP83826.
> WOL should normally be enabled through ethtool.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning") is
only in net-next? So you should set the patch subject to
net-next. See:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

Please also add a Fixes tag.

The change itself looks O.K.

       Andrew

