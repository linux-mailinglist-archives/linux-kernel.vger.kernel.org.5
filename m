Return-Path: <linux-kernel+bounces-93036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E638729F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522121F2AF66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E512D205;
	Tue,  5 Mar 2024 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="az7C5Nbt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E7812BEAE;
	Tue,  5 Mar 2024 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676607; cv=none; b=gVIDA/nCHeziK5euY5XLrvrqdUQCaJqW0rc5OczGJNzUodGYT12knL3oR6WgX19aFyN74kEZrB8fHGzNPkAmqin2Z3Y5mQfMjrtZBaOhucdoMt2LyRX1ai0WiOBwYTRdnV46u7jLSrPxXV9vsWTcpvHG9q5V1GnSClao02QNTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676607; c=relaxed/simple;
	bh=WDxMUNOyXV2FFp94ZE1OPJHosybU6j2MV9abgvJyXmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6hQ2vZJWlnWu/difVF3nE4JSZwvh1FUmXXC2E9+xhxtz1A5NktaUmHpzOXYCnSMq21+9zIpqBCrtXTwaxs0vC522kHK4Jg8Ac6ZZUXV+fA6FxnBI7WLp6c9NmdSWA2DIN3NxdQOwWrGzzVxCFpZ/KbqunhthIZmbcRLTVBwNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=az7C5Nbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E995DC433F1;
	Tue,  5 Mar 2024 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709676606;
	bh=WDxMUNOyXV2FFp94ZE1OPJHosybU6j2MV9abgvJyXmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=az7C5NbtIzHvbFY1k6RzXtyMA4G2ovT4iIuq2qGGFKzfSb8A466Xms9g9gAM91/Sd
	 og+XcB2nHMHjZhAznjVov+MTzwoi9/bBPr2aPvdlImEjJpCzSsmqS81OJZpHu4k18B
	 oVVNfNT/qh/v7X42qVgXBHRy8hmrEfNVHcSb+ZCs=
Date: Tue, 5 Mar 2024 22:10:02 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Wayne Chang <waynec@nvidia.com>
Cc: jonathanh@nvidia.com, thierry.reding@gmail.com, jckuo@nvidia.com,
	vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic
Message-ID: <2024030542-broker-promptly-de99@gregkh>
References: <20240305161122.1254099-1-waynec@nvidia.com>
 <20240305161122.1254099-3-waynec@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305161122.1254099-3-waynec@nvidia.com>

On Wed, Mar 06, 2024 at 12:11:22AM +0800, Wayne Chang wrote:
> This commit resolves an issue in the tegra-xudc USB gadget driver that
> incorrectly fetched USB3 PHY instances. The problem stemmed from the
> assumption of a one-to-one correspondence between USB2 and USB3 PHY
> names and their association with physical USB ports in the device tree.
> 
> Previously, the driver associated USB3 PHY names directly with the USB3
> instance number, leading to mismatches when mapping the physical USB
> ports. For instance, if using USB3-1 PHY, the driver expect the
> corresponding PHY name as 'usb3-1'. However, the physical USB ports in
> the device tree were designated as USB2-0 and USB3-0 as we only have
> one device controller, causing a misalignment.
> 
> This commit rectifies the issue by adjusting the PHY naming logic.
> Now, the driver correctly correlates the USB2 and USB3 PHY instances,
> allowing the USB2-0 and USB3-1 PHYs to form a physical USB port pair
> while accurately reflecting their configuration in the device tree by
> naming them USB2-0 and USB3-0, respectively.
> 
> The change ensures that the PHY and PHY names align appropriately,
> resolving the mismatch between physical USB ports and their associated
> names in the device tree.
> 
> Fixes: b4e19931c98a ("usb: gadget: tegra-xudc: Support multiple device modes")
> Cc: stable@vger.kernel.org

You mark patch 2/2 for stable, but not patch 1/2?  That's not going to
work well, is it?  :(

thanks,

greg k-h

