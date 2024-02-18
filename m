Return-Path: <linux-kernel+bounces-70446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6023F8597EE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630971C20944
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B426EB5D;
	Sun, 18 Feb 2024 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4XEwo+D0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1A335D8;
	Sun, 18 Feb 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708275937; cv=none; b=p0qK4xyF9bFkwRgE6VIFIytkMMwEDusivPcfepi/f1xXk4hgnZ2X46oe/VszJKti8oHgJZ6FB5NO9UOBWlfKTic/SPyhP/aVjasW1ncSQ1CST//0wUfMg15rz3X2hapAiAxO9DvpQnaNlspwMOW8P0FZLkVd38KJn2j2NVhcCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708275937; c=relaxed/simple;
	bh=WEt0ZSBB/wSMLcKR7tYm2xx702SIKxALBV7kapfv/6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1W8FUxsKjOIH+DEMc/GTmHQSbXr0OgGwMibYMlHsiIxHI1BjT8Yu8R4cjzkR2AgJU36/8gBiDp3iH4xz+StvXkz3OHDTcM/R841Lu5MQiwhgKPBM99g/g+IQdDQyAHuHB3qd0D/7Yc3v5j6OK4e8YoCUaqrF4B4YQHKW3b0DXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4XEwo+D0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JoiEVod0eganWp4ZBFaZnk8w/7QLOEnGwHWEOsbmutY=; b=4XEwo+D0jkMjh7s/d3gm/tF4or
	7iCQGJSQHUP0mfnG0hX8uq3ros/DfVnbu37RRz5boTOdAMghq6WGa0zMIzF4sPK81ZcrLSGXrYYKi
	6jr9bbk1/t+OfUb8l4y6zQgifrxUOaQJSqUn0iSMNQASPeNfkJti2RrgxgSCgxIKkIZM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbkbl-0088Gu-W6; Sun, 18 Feb 2024 18:05:41 +0100
Date: Sun, 18 Feb 2024 18:05:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 net-next 09/14] net: phy: marvell-88q2xxx: add cable
 test support
Message-ID: <9c1bc1fa-a009-4653-a772-d771fcd67515@lunn.ch>
References: <20240218075753.18067-1-dima.fedrau@gmail.com>
 <20240218075753.18067-10-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218075753.18067-10-dima.fedrau@gmail.com>

On Sun, Feb 18, 2024 at 08:57:46AM +0100, Dimitri Fedrau wrote:
> Add cable test support for Marvell 88Q222x devices. Reported distance
> granularity is 1m.
> 
> 1m cable, open:
>   Cable test started for device eth0.
>   Cable test completed for device eth0.
>   Pair A code Open Circuit
>   Pair A, fault length: 1.00m
> 
> 1m cable, shorted:
>   Cable test started for device eth0.
>   Cable test completed for device eth0.
>   Pair A code Short within Pair
>   Pair A, fault length: 1.00m
> 
> 6m cable, open:
>   Cable test started for device eth0.
>   Cable test completed for device eth0.
>   Pair A code Open Circuit
>   Pair A, fault length: 6.00m
> 
> 6m cable, shorted:
>   Cable test started for device eth0.
>   Cable test completed for device eth0.
>   Pair A code Short within Pair
>   Pair A, fault length: 6.00m
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

