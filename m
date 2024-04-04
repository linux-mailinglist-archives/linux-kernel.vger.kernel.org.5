Return-Path: <linux-kernel+bounces-131616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E12898A26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC2B1F2E08C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4A12A16C;
	Thu,  4 Apr 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gREY8H90"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB412129E7A;
	Thu,  4 Apr 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240997; cv=none; b=YaY9PpeEAK+fnByZ/aai/Kuj1rmRcqtKtMhJwmxU0itKZuGgskn6BRdxelTm16da5EhIkweRfOJYsW+j7cU5szVVg3Ifjit6E/zw0BwakR8qHlSh/ZB3xipwkLfsqUH3kDM6CO+tx4lau515BM160TpekPjbcIvbjrRLatCQ1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240997; c=relaxed/simple;
	bh=f831aytugWfSJLv8/vfupSjvp+1G04SDk23IqBQlRGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHJst7ypCnfXmqZknCMX2BNOvc0ejOBFMxl61LdM0T9+H/+JSlftZOcz1C9iD29XeMsi16+BBV3bbKIjPMBg8mPPc4TJqyVbx996qh2Unl6fDBwvsBwzI/s8ogny7Cjxo0BH+mht1K/LKi0RwXg6dwmFjNHgBKPttgnuKOJ6zUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gREY8H90; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BDfFkZXbPaRRoHXv5I3wj3Y0/s85fQUp7KkdnH3y+fw=; b=gREY8H90oNDzwCqzRhJ8fieRSV
	yZx+sv696SWIBlbouHkdFUqLZ9RLQXx+zfNSXIn3OZGhy4idEaxbkYHwaAQPG6a+s3nduo3pJJQYN
	wsvfO2WHjp0OtVsgCYFvLWiiado6GdUR7qm3v1fyTXGetRrQClQWKTu2BT/WNITanrbc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsO66-00CBvQ-Qg; Thu, 04 Apr 2024 16:29:46 +0200
Date: Thu, 4 Apr 2024 16:29:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mor Nagli <mor.nagli@solid-run.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Message-ID: <1692b2fc-9c62-42ac-a9e8-d843ec932722@lunn.ch>
References: <20240404-mv88e6xxx-truncate-busid-v2-1-69683f67008b@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-mv88e6xxx-truncate-busid-v2-1-69683f67008b@solid-run.com>

> +	} else if (err >= MII_BUS_ID_SIZE) {
> +		/* If generated bus id is truncated, names in sysfs
> +		 * may collide. Insert a special numeric suffix to mark
> +		 * truncation and avoid name collisions.
> +		 */
> +		err = snprintf(NULL, 0, "...!-%d", trunc);
> +		if (err < 0)
> +			return err;

It took me a while to figure out what this was doing. Rather than err,
maybe add a new variable postfix_len, to give a clue that this is used
to determine how long the post fix is, and so how much needs to be
truncated from the end of the string to make room for it.

	Andrew

