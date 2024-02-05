Return-Path: <linux-kernel+bounces-51969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F81684921E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C881F21D19
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6C03D72;
	Mon,  5 Feb 2024 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h2jz/QQ6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCC7F;
	Mon,  5 Feb 2024 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707095044; cv=none; b=TYOWxdHSjn6AB+hCzuAJx321zNNkEknHLtU5WxFDXizE2EB+KdXrRL0+sgj+ODNMgtYvSPpjoUsaa8bAwJd4mNCNJkh+NWGBu0p7YQjtWM9hk1RQgbsbxkmRPC7NL2yextltmL0TpqY+kuXuOw+mBMMZQzZTzxJYEJn/di3p4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707095044; c=relaxed/simple;
	bh=/bfizNoZ7UhDXE3At+urAgcMm9ahQ3JAEbtiwB8hzhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRkZG+Lapxwh+3rMAYzLYLi/czvTnIuXhdPHtq6FQh0/O9yTguRlno5NABofM6D+MccUmINsDZ+G0J/DHfnL24Pj7rhc/rfGKvTqgC6YfBqBYuGGbAG17UoMv7Z1DPSlf+9blWBb0wi5mh8Xwa7llxxo5BTMmTuIiDLBCNdVxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h2jz/QQ6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ydVVpH1MXT/6v5fE3x4y0WvWdVutdQ2BrQO5Y/VShyU=; b=h2jz/QQ6GSQVIcYNEsytv/+T8T
	Qtq3S60UqS5g3ORbQWlvKKhAuF0fS/0FPLC3zTePged381H1i/aiR6XsNLniGfMaTwsx4EeM2ZF5Q
	lgfYZP31IUhQQTTVp2XYPS6qVWombRdu6+y/hFn9yBFRJTZwmMKeEl4fBUQolDmMMo0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWnOl-006zML-2k; Mon, 05 Feb 2024 02:03:47 +0100
Date: Mon, 5 Feb 2024 02:03:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH 0/8] drivers: net: Convert EEE handling to use linkmode
 bitmaps
Message-ID: <d807dd9a-5318-482b-a85a-02baccec8701@lunn.ch>
References: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>

On Sun, Feb 04, 2024 at 05:40:17PM -0600, Andrew Lunn wrote:
> EEE has until recently been limited to lower speeds due to the use of
> the legacy u32 for link speeds. This restriction has been lifted, with
> the use of linkmode bitmaps. This patchset convert some MAC drivers
> still using the old _u32 to link modes, with the aim of soon being
> able to remove the legacy _u32 members in the keee structure.
> 
> A couple of Intel drivers do odd things with EEE, setting the autoneg
> bit. It is unclear why, no other driver does, ethtool does not display
> it, and EEE is always negotiated. One patch in this series deletes
> this code. Comments on why its actually useful and should be kept are
> gratefully received.

Gerr. How many people have i said to put the tree in the Subject: And
then i forget myself :-(

net-next.

	Andrew

