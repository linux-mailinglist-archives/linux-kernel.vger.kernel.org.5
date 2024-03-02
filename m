Return-Path: <linux-kernel+bounces-89550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5D86F1DE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C421B239A4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEFE36AEF;
	Sat,  2 Mar 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VIFSnxko"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA22206C;
	Sat,  2 Mar 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709404697; cv=none; b=aBwY6+u1J6XqATUiLwyJDJ9tA8AxXVDVJGivqmY/vPIYesO2erus9lxl9SE3JhaB3wZENFfZnx0XAHUaNvfclKkoSyPsDMFZqzqbOXZqyQwQ4zfFu0Q8Ud4SsBlud4wqWGrZfY73PaWN+o+R3Khl69KJ5mYViHo12uMnnumv3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709404697; c=relaxed/simple;
	bh=O/iAoaa1NTYAHsYqQMTf5oaXoEjoekvm3NLm9Bztn9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byon0YMxQe7ctZURSxquxLP2WgcMzG/aCxwOLrj3lGHjz7NnkhDPQXe0l7b83GYRMZ/+WKDThO5aalOfq7b/cd0dEGGih3c3Ih+P661A9RMdO5th655CnZdN3buEZMWO5k4xqlkKqjy2vwd/dBdD2RHbTsqrmNxDawFkMoeRs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VIFSnxko; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LBFIkPivxpjlQMZ6H3Z2IewYrnJUFq+ab1mTNhFUHmw=; b=VIFSnxkolX6BzFVh6gRMcVJXz9
	kHTHIndr3ICqHAGgzDwHoAJVsbqCLVPhcqZkitkcwT0T11uydofN7w9ptcymJ5tu9YuaouvdGowXO
	d719qNFZ9rLxtqTzZVbrJZVymtLKifSJfvKtQX0x9SLlBDJmIqT0GjxpTr4HprIKBhPY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rgUFV-009D37-U0; Sat, 02 Mar 2024 19:38:17 +0100
Date: Sat, 2 Mar 2024 19:38:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v8 3/8] net: phy: Add helper to set EEE Clock
 stop enable bit
Message-ID: <b8fab5f0-5918-47e6-b17d-5ca0514467cc@lunn.ch>
References: <20240301100153.927743-1-o.rempel@pengutronix.de>
 <20240301100153.927743-4-o.rempel@pengutronix.de>
 <d550b591-cd83-4ac6-8fd5-f5e0e2ad71d9@gmail.com>
 <ZeNhGURTEfzwhikL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeNhGURTEfzwhikL@shell.armlinux.org.uk>

> That depends who is going to do that work. If it's individual driver
> maintainers, then I think we want this to go in along with this series
> so that we don't end up with individual driver maintainers having to
> carry this patch, and submissions ending up with multiple copies of
> this patch or depending on other maintainers submissions.
> 
> On the other hand, if someone is going to go through all the network
> drivers and update them as one series, then it probably makes more
> sense to move this to that series.

When i did this work, i did convert all drivers to the new API, and
then dropped the old API. There are too many patches for a single
series, so it makes sense to put the API in place along with one
driver conversion to show how it works, then a second series
converting all the remaining drivers, and then a cleanup series.

	Andrew

