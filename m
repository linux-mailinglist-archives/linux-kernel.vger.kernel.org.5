Return-Path: <linux-kernel+bounces-72890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E785BA35
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B661C23C54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE94B664D2;
	Tue, 20 Feb 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5qyo3iW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8C65BDD;
	Tue, 20 Feb 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428017; cv=none; b=lnFWalvrhc13kYIK+Qe2o/U5oBust0EFhCQ3qQ3ef2nifCA3gjaeuuVan5Cim3w77A2KaLjML/Xcrw+PMCu1PrW3lWtSTVMhOmxI7NsFux+Q0bQTkLeFP0BoTbSR0VpHy4DWKt+MybCBZjLtg8AiFoGv4kyXRfq+MhbjCiSDoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428017; c=relaxed/simple;
	bh=15Ob8WElWbdYfjZM/8HQ60IBg5bEDUI+MgS67in5L3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTq3X2+4gJG00hT1dD8amKXUOUvVDbtW0rOSFSJ7PCTkasq4pxAa6coUTIF5kRtKRs0fRrHnEEV8eSmeqKrjXU9IBQwA2KnnhigphpmDxxFyFjLtKjA5hHWfOX+CH4y136hwgphTDjSQQTZiqVKXVWMqyi66THAVaRPuvTubRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5qyo3iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1415C433C7;
	Tue, 20 Feb 2024 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708428016;
	bh=15Ob8WElWbdYfjZM/8HQ60IBg5bEDUI+MgS67in5L3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5qyo3iWg8DD6ufVBIQbU8qFOTKR/yb1VcukV6VuQfHzD/JvMH58r3Z9R8oVu7uqh
	 urg3/unVgmx3G3aPAZloAEAhMzzPur5axdH7RQmdKXXId4WCtFPJixEwPrkh+4d+iN
	 CqYmBl3E6e0gV8xGfeS8/s5fblDHoxdrgdAU8kCP2kFlx/TVZ5PqlaQlWU09ISfssu
	 paES2/e16bAvW4dNAKHArVFx5ALgbyZ+v/eKjWuXo5BFUmsaFRbya3GAm8/0Kzaz8J
	 5GlcxBZPz/PKb07/HihNu1gkUNnWr3PcA6LMVABxRBALOAsDCRs48We6Z3gEwZwwjR
	 2AYoI6XnTSCeQ==
Date: Tue, 20 Feb 2024 11:18:16 +0000
From: Simon Horman <horms@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-ppp@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/12] net: usbnet: constify the struct device_type usage
Message-ID: <20240220111816.GS40273@kernel.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-1-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-device_cleanup-net-v1-1-1eb31fb689f7@marliere.net>

On Sat, Feb 17, 2024 at 05:13:23PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the wlan_type
> and wwan_type variables to be constant structures as well, placing it into
> read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>


