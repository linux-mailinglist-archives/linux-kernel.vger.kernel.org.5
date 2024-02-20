Return-Path: <linux-kernel+bounces-73038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBAB85BC80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308601F2452A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5E369DE4;
	Tue, 20 Feb 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7ZSNEpJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD76996E;
	Tue, 20 Feb 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433120; cv=none; b=FF7jk6kr/SxFpoKPB1hLeOVTNudoi0NC4sZw2B1OBXCmPbuXSnkZIjMDdELaibUAwM3nAuJ4DxRO1J8Odp1xN5WzzV0DzuIBVZxc8YFWkzIEXrUcIkb/FRExducGwNBEen0KHjXKYXIrrvTRSY0WB3DXaCKNDhnMlNR0yyHvN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433120; c=relaxed/simple;
	bh=JhjxLdnaB4JpbsSkExyQ7bYUCHruGBoELFCOkxWIJME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxXiuQYliAQR5BZfoZCbc3uINCWvfYXH8yAqiB956MaEiwZnPBOuov8vo3j6bbLDFsBtdbo75vEwOMth0IoVWa10IiG9qb88L33IDBGRbIWnzgrP+bxDf8RZphJi5fgkT37eHzl1YUZEecJa2dH0WeVL5LFio8vjVu1Yhm4/2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7ZSNEpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7C4C433C7;
	Tue, 20 Feb 2024 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708433120;
	bh=JhjxLdnaB4JpbsSkExyQ7bYUCHruGBoELFCOkxWIJME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7ZSNEpJjkgsCYVtx+BeEDUh6j3zQKyFqK+GygFmIsNCpQly9K8qxBjtCizd8K8me
	 OSYxcUMqOsCoAj+GIajvIgGMqYeMioiuAZ0M0QgrmxY8gMuRYgqzRwralCi6ctrDVl
	 SiOtpaxlXxFH8T6IsxpypqFEMhsYZm6LEHseE+FpdBAuFu24ixRc5a1pTI+QZ/gB+S
	 b3he6E9ZSwO/WOHUwK77eRTisG4oNHay6XHcwjUhuJd1yIyutv+DOTfAapTNo+T5Hi
	 CVwc1BOSQw+1VFkS19QEIPaB/cRtMIOnjgbBWM12EU2J4w3DFe3jj3rpx40jkrA6b2
	 Ev16jFJEOtTaw==
Date: Tue, 20 Feb 2024 12:45:16 +0000
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
Subject: Re: [PATCH net-next v4 7/9] net: intel: igb: Use linkmode helpers
 for EEE
Message-ID: <20240220124516.GD40273@kernel.org>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-7-71f13b7c3e60@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-keee-u32-cleanup-v4-7-71f13b7c3e60@lunn.ch>

On Sun, Feb 18, 2024 at 11:07:04AM -0600, Andrew Lunn wrote:
> Make use of the existing linkmode helpers for converting PHY EEE
> register values into links modes, now that ethtool_keee uses link
> modes, rather than u32 values.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <horms@kernel.org>


