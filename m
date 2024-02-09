Return-Path: <linux-kernel+bounces-59725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7180984FAF5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A081C22CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F9F7E115;
	Fri,  9 Feb 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T24otnsd"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC333CF1;
	Fri,  9 Feb 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499328; cv=none; b=YAZz51+mrUPIxljQEXjL8rqMKLev/KN263JspJf7i2a7x+sFVxw2RTPBbb2zcdWvjDYNGAKcFDzKp0M/AVZdbFpCwtnj3bOgQ5gYgAbIJvqzpnLyB59BEZ8rq1drAOlVWBmarn5JxQlJdtL6xVOWE70iZByWlur0MTsFkWHtiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499328; c=relaxed/simple;
	bh=GvNaJK5ljpQbOqfI0p5J6r8yHDGpxvTZoHYkkpCZC8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKEuD1uI8nZAxR4CIoo3OPpLzWIq47kfjENBPq9YhnxXf33eCIKLmYriA7owI1p+o7OxiiYFTART/KC40FMRQwie5mvCKMpfTUa9ESz+4e2l8cc+da5MKqlzo+aUxZstopHL52py8JQs3Hn4x+QWi2iIcn/RZtBNR0Xzr96V14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T24otnsd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sVp7UY52Y4b7t6Q3ujXsKkcnNhultIY8iO3JnmoDB6k=; b=T24otnsdeZimqkppbPjzeRuwLQ
	0OXKfjSyLMecnMUs4BohqhYh/x/Obuy5XfvUF4+gLyM0vywr/AybBFB3KPxWlong2Qhxw5oNPWzHe
	NHExnE2gbJkVouSX4M/+MiGRqmY22OL3vPMihIQehzgjCKB1GrdqwLedKD99RVCcbcNE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYUZf-007P8o-7b; Fri, 09 Feb 2024 18:22:03 +0100
Date: Fri, 9 Feb 2024 18:22:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: Re: [PATCH net] net: sysfs: Fix /sys/class/net/<iface> path for
 statistics
Message-ID: <b448862e-591f-42ac-81e5-b4a37bc5bac5@lunn.ch>
References: <20240209095520.252555-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209095520.252555-1-leitao@debian.org>

On Fri, Feb 09, 2024 at 01:55:18AM -0800, Breno Leitao wrote:
> The Documentation/ABI/testing/sysfs-class-net-statistics documentation
> is pointing to the wrong path for the interface.  Documentation is
> pointing to /sys/class/<iface>, instead of /sys/class/net/<iface>.
> 
> Fix it by adding the `net/` directory before the interface.
> 
> Fixes: 6044f9700645 ("net: sysfs: document /sys/class/net/statistics/*")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

