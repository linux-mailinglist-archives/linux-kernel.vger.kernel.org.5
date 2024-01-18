Return-Path: <linux-kernel+bounces-30374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0AF831DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9091F26021
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0802C6B1;
	Thu, 18 Jan 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4IVJv5pT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC02C1A0;
	Thu, 18 Jan 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596856; cv=none; b=l70qJd0ugzTDDK8rY7dq+QDThPZ3UL9CkJLlew/T0czCZ+QkTI27kARnUqM55LyMenNhLzC+0/f+w2of+vuuGbrGjdDWAziply9rXuawVTO7QxgLgPGR2nIcsnbNeaZ9nx44h5RCnnREDQ1kH8foCq5AuIgOT3nClfrzT3eYMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596856; c=relaxed/simple;
	bh=crJwJ8X/wzPlvScgIcXHTUknQHUelOOysLDVlUFds9k=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=IL6ATNP6z7IDyC9j4swL+pTVSYD/0wcxP5lHkxlXNL5z6fhYMkxqsmt5eGqIHcYB0oRocwDu3SoH9FsLuVBrfs6XuhsTNzSzpk7LiJlpge1P5EIENNAbdtMKJZmtle9V95cHjkqlvSmAqfrKqFJZ5OTDr+kWu5kZFhpdYRX4+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4IVJv5pT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jHGZBZk6Jjgp+pfdwPf2DTLVgfHtKK0y+HPwY/B39uE=; b=4IVJv5pTb0iY61RpsCsMhhL01N
	5zSwfq5bMPtgMyVp2gKNwMCOUBzt6HjqtZEAd11XWRhi/q+dKhzT7S4/Wutcu2/AJYnEXPMKI2aE/
	Lgs6vjWwiylS+0Xn4md/7EY7wpfwCFYQbaIldPtHOX0zzyixSmJnS8IR3PSEQHHFAkP8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQVeQ-005UkO-ND; Thu, 18 Jan 2024 17:53:58 +0100
Date: Thu, 18 Jan 2024 17:53:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: adin1100: Fix nullptr exception for phy
 interrupts
Message-ID: <322d5543-4d13-48a7-af58-daa8cc840f05@lunn.ch>
References: <20240118104341.10832-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118104341.10832-1-andre.werner@systec-electronic.com>

On Thu, Jan 18, 2024 at 11:43:41AM +0100, Andre Werner wrote:
> If using ADIN1100 as an external phy, e.g. in combination with
> "smsc95xx", we ran into nullptr exception by creating a link.
> 
> In our case the "smsc95xx" does not check for an available interrupt handler
> on external phy driver to use poll instead of interrupts if no handler is
> available. So we decide to implement a small handler in the phy driver
> to support other MACs as well.
> 
> I update the driver to add an interrupt handler because libphy
> does not check if their is a interrupt handler available either.
> 
> There are several interrupts maskable at the phy, but only link change interrupts
> are handled by the driver yet.
> 
> We tested the combination "smsc95xx" and "adin1100" with Linux Kernel 6.6.9
> and Linux Kernel 6.1.0, respectively.

Hi Andre

A few different things....

Please could you give more details of the null pointer
exception. phylib should test if the needed methods have been
implemented in the PHY driver, and not tried to use interrupts when
they are missing. It should of polled the PHY. So i would like to
understand what went wrong. Maybe we have a phylib core bug we should
be fixing. Or a bug in the smsc95xx driver.

Please take a read of
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Patches like this should be against net-next, not 6.6.9 etc. Also,
net-next is currently closed due to the merge window being open. Its
fine to post patches, but please mark them RFC until the merge window
is over.

The patch itself looks O.K, but i would make the commit message more
formal. You can add additional comments under the --- which will not
become part of the git history.

       Andrew

