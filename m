Return-Path: <linux-kernel+bounces-98976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8CD8781C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6C0287724
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F1405EC;
	Mon, 11 Mar 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XX1eeywU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11143FB8F;
	Mon, 11 Mar 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167905; cv=none; b=a4TA104WfCF71bw3jZXJAE8VwKNHleJVwp1AQXVVQ9ZBxP3MHg84xZJ8jnfXBBTgGRl9iVDIgwJD7qL4shc7MNqKt02X9QOmtkqllm6nVXcGYw0lumX9qNp5nUyaB2JULkLiKtUtaqIE98g73qKmE+ha2ikeGbe5WzzcNXAGOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167905; c=relaxed/simple;
	bh=oUNvmy0XwhwFNoI9rEMwHFRE7b5rGc5LDIq9FMmUvxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPdxXDcWeRmbF2soCP1dcu0dnXoBRlERqI57zYa3N20Xa/4prSszL7UrIPCkMGsaGLuoFT8g40tUOGrwJm4PvAcnaB8GEavWBfqrJzllFFuOTHhDyiiRRkCqpBA8wT7LnoUuNqE+ATRRtRd57bkPKeyBP0q6536gCIoM3es0dRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XX1eeywU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B13BA9QCdeALZoTVpZL3pPUk9+ARVc7Y9epMABvugvo=; b=XX1eeywU964yOZpmresHozn1RP
	h/Gqy0Bzp/cWGdeLeMFkoIl3Bibn0O9DBNn4AUBn4YC2EiKBOIFpHuGbnIRE1iGYswDAgbOT3ocKk
	5F3z2oKkw4NzGX5qaLkO6P9dVpWp5P9/BTWHeSh33kMxvcZszUsWA+iTJrhoMsnihItA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rjgnf-009yTX-0Y; Mon, 11 Mar 2024 15:38:47 +0100
Date: Mon, 11 Mar 2024 15:38:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: taras.chornyi@plvision.eu, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kory.maincent@bootlin.com,
	thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: marvell: prestera: force good base mac
Message-ID: <1518680f-c0b1-4dc8-be05-bd099064ac56@lunn.ch>
References: <20240311135112.2642491-1-enachman@marvell.com>
 <20240311135112.2642491-4-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311135112.2642491-4-enachman@marvell.com>

On Mon, Mar 11, 2024 at 03:51:12PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Since each switchport MAC address uses the switch base mac address
> and adds the physical port number to it,
> Force the last byte of the switch base mac address to be at
> least 128, so when adding to it, we will not wrap around the
> previous (more significant) mac address byte, resulting in a
> warning message.

It is not clear to me what the real problem is here. Does the hardware
require that the MAC addresses always have the same upper 5 bytes?

	Andrew

