Return-Path: <linux-kernel+bounces-130138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FEF897488
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5481F2867B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413014A4F4;
	Wed,  3 Apr 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjMMUi+r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56359B67;
	Wed,  3 Apr 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159570; cv=none; b=pX9B1lJjwJGE3mKvnSiUwPaVAJ77kfN9DRoitcm3FnuswrggoN2PVd03aC0fFzXLaeJ7VdEmRVe70csGQeaJ04CXyhiotb5n5G5OHn/3omHRNgcFb32oIrYcMMeFxvx82iQOnW+U+4G84qnWvKfRDQ4bnxIRV5OSCurTHnw65y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159570; c=relaxed/simple;
	bh=n8VXoo8G6D7dhcWhC2FJWv9XJQ3Pb6QUojEe1p2ktjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpeq95WZpUbba7Gvj0CfewvhU7phyuulOBsJZcQXsWM5BGIN9WU2NCs0X6KJxa/dGIO117pEefkJ/rh9DHz+g0O6DH5Se0mJuomWJeuZ1cGVDrxPC5ru6sLX8vt0YSBgiqTt5AQLhhu0kS1G5uvOasao1rXBXm4crmj7YX7lvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjMMUi+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97B6C433F1;
	Wed,  3 Apr 2024 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712159569;
	bh=n8VXoo8G6D7dhcWhC2FJWv9XJQ3Pb6QUojEe1p2ktjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjMMUi+rqXVRDrGMGa8BlSF9kGRtDqwL27ffwcrGT74Pd56VfIvyLgG3+Op0ljpz7
	 J7b4GLQFXLnnvE0d4wv5Ip4R/hzj7/COTuWULdZwjoJNxfW3P2dn4PNCHMVYH4eseW
	 EQFj5NKlWpvtmSOR27FutNKQAH4V7/JJLv43IXERRMFvuAQWgw3VNHmSuskXMkf6QS
	 YstuuhrUclGTCstp+B2NKvfTE+99uhdK1YcR1pyR0Z5cJrcICfe3vr69zycckgirRp
	 W8a7HK6+FhlL7v5StZi8M59ZrvRndra4PJ/kKNBTqqnt6I5f56kpPhhdn67vuk6L12
	 PyFh6KNCEmjLA==
Date: Wed, 3 Apr 2024 16:52:44 +0100
From: Simon Horman <horms@kernel.org>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 02/10] net: bridge: Always multicast_flood
 Reports
Message-ID: <20240403155244.GO26556@kernel.org>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-3-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402001137.2980589-3-Joseph.Huang@garmin.com>

On Mon, Apr 01, 2024 at 08:11:01PM -0400, Joseph Huang wrote:
> Modify the forwarding path so that IGMPv1/v2/MLDv1 Reports are always
> flooded by br_multicast_flood(), regardless of the check done
> by br_multicast_querier_exists().
> 
> This patch fixes the problems where shortly after a system boots up,
> the first couple of Reports are not handled properly in that:
> 
> 1) The Report from the Host is being flooded (via br_flood) to all
>    bridge ports, and
> 2) If the mrouter port's multicast flooding is disabled, the Reports
>    received from other hosts will not be forwarded to the Querier.
> 
> Fixes: b00589af3b04 ("bridge: disable snooping if there is no querier")
> 

There should be no blank line between Fixes and other tags.

If this is a fix, it should be targeted against net,
and likely broken out of this series.

If it is not a fix, then it should not have a Fixes tag.
Rather, you can reference a commit in the commit message text
(not tags) using something like.

Introduced by commit b00589af3b04 ("bridge: disable snooping if there is no querier")

Link: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>

..

