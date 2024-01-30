Return-Path: <linux-kernel+bounces-43848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C684197F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E39728AB09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C7A36AE7;
	Tue, 30 Jan 2024 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgcXvTwg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A3364C6;
	Tue, 30 Jan 2024 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582640; cv=none; b=BpMQtE0gvw1dkQMfhPnH6SSuZNB1uowY8ptANtsX3rZ9/pYkb4otmu6AUDDZRPfVWhHhQIgO2gebOYSk0yGjK7jEI453jEp0YUOwOfUhL7c23zF8Qm2+yagOwnMC/LaDppbNIlIpnO6/lo+A9I94E2CcPLqLB0iKxsa2VpF+qcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582640; c=relaxed/simple;
	bh=ubCKWnZsunLpK7T4k/fDNTnKB29T+6wnKi0+ohAnxek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gh/Xzf81EYL1RkVYJFrNIz9PaXJg9Vw0U3AuST/oCoBPiJNwAhebc5FvEVE7TvoupUrU2cCvyAqvOHOuHGKdqv94HTsxXqtrkuJk3F2WvPvpZQrLxKL5VImQDj6TeK9hj0NDnCJj2xMD5GNbOuzG7lxlOoeNyNmXnbN9F3BMhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgcXvTwg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706582639; x=1738118639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ubCKWnZsunLpK7T4k/fDNTnKB29T+6wnKi0+ohAnxek=;
  b=YgcXvTwgQJcRhOTSjlNEv955dlo1fZwswgXaSxnYArLLy1pTVF41FyBm
   /nD0j+/yhFAQILrZv8GNJtl4ByPAAdj60KP4xJ7Oib9gydWopknS589A9
   S7hN+88WKLiT37YN32+Mk4QQq7hTt5U5AvLYIryPfzAY20BEndotfMuJd
   rlEGQlvktwZbqg0maeTaokzE++JHw8Tkv9AyVkb1BE4PkWh7pv05sSLUX
   Ik8u9iHz3IpdYXNw+HTF3jrzMh0XCeqT3FMeqVissW+f6CYgTkmHii8yX
   E9UHCpw7fT6RTothKaqt992B039dPwv5BF1uK6oCi023t5FNFckEOO3Lr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9790962"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9790962"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="788043181"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="788043181"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:43:57 -0800
Date: Mon, 29 Jan 2024 18:45:21 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Aristeu Rozanski <aris@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	lili.li@intel.com
Subject: Re: [PATCH 0/2] EDAC/{igen6,i10nm}: Add EDAC support for two Intel
 CPUs
Message-ID: <20240130024521.GA14663@ranerica-svr.sc.intel.com>
References: <20240129062040.60809-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129062040.60809-1-qiuxu.zhuo@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Jan 29, 2024 at 02:20:38PM +0800, Qiuxu Zhuo wrote:
> Both patches solely add CPU IDs for EDAC support.
> 
> - Part1: Add a new Alder Lake-N SoC compute die ID for EDAC support.
> - Part2: Add the Grand Ridge (micro-server) CPU model ID for EDAC support.
> 
> Lili Li (1):
>   EDAC/igen6: Add one more Intel Alder Lake-N SoC support
> 
> Qiuxu Zhuo (1):
>   EDAC/i10nm: Add Intel Grand Ridge micro-server support
> 
>  drivers/edac/i10nm_base.c | 1 +
>  drivers/edac/igen6_edac.c | 2 ++
>  2 files changed, 3 insertions(+)

For the whole series,

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

