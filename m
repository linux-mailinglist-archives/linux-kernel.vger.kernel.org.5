Return-Path: <linux-kernel+bounces-83889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECCF869FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7C12869F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309A14E2D0;
	Tue, 27 Feb 2024 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCABcWH4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9151C4D;
	Tue, 27 Feb 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060541; cv=none; b=MrFvVAtjBnnh4zxUONYEM+tSF50CKltixkp0Im4JBW1utt8eEoaXK0KJ6YrywLl+g4LKT4Fa4YtFNP9zw2dJO12u9zdlz9YeBelRFgZaBSemAzlbN11f6evY6a50VvbbcQCKFe7CRRRxIH1/9uOpA+ALXKW8eR0KDn1a6+5ApDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060541; c=relaxed/simple;
	bh=TwoGPBjM/mv8KwmBYJWDjdvYp9iuHArnd5e29nlNt0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DimKSbr8/gCBmzr5nTRQ/GR+EUNZ2Jewa1A0ieU24XAz/THeIVSNPOoVIac+F3jz4DuPx/HGG+HEy86IOWaHSSb7wvJZkhXNp0tGYC5bk2NUk8iqI/kD9/PfJUehSYXklcTNMfINS/9DHfPIQgkt1IitBtNhxpT8WRkCWOSFs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCABcWH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DECC433F1;
	Tue, 27 Feb 2024 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709060541;
	bh=TwoGPBjM/mv8KwmBYJWDjdvYp9iuHArnd5e29nlNt0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCABcWH4q30saGgnE5D70vm7c9c75T/eiWyVywquOylUysdFWJHfFxErvXX36e/2f
	 CUIaP0vM+qiQ0Ev7Xx5aDveoLetLL/vS0jdnmxpnjE0dK7pBxG+2GOD0h3LUwIN3IA
	 XV1Ti01bvBmskP3laLJn588FPKzmW6yv/fk0wPZUkvIwHE/iVklrtj09yCK+44AZaX
	 /2InBVLUApSE9vHY+71KbpiWzCdhPPPL5vWa7XUDzae+VbwMX9f38GR3G8lrzo1zpx
	 aJJPO6v4T9qqeT/hBhE1nujWqD9OndMEUYkGM41jGopy6v1W7rl64LszkHUTbAc8d2
	 nIdT3XAyp1JwA==
Date: Tue, 27 Feb 2024 19:02:16 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v5 4/9] net: ethernet: ixgbe: Convert EEE to use
 linkmodes
Message-ID: <20240227190216.GL277116@kernel.org>
References: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
 <20240226-keee-u32-cleanup-v5-4-9e7323c41c38@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-keee-u32-cleanup-v5-4-9e7323c41c38@lunn.ch>

On Mon, Feb 26, 2024 at 07:29:10PM -0600, Andrew Lunn wrote:
> Convert the tables to make use of ETHTOOL link mode bits, rather than
> the old u32 SUPPORTED speeds. Make use of the linkmode helps to set
> bits and compare linkmodes. As a result, the _u32 members of keee are
> no longer used, a step towards removing them.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <horms@kernel.org>


