Return-Path: <linux-kernel+bounces-52152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFBE8494A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A296D1C221EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308910A1B;
	Mon,  5 Feb 2024 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhzXzhdL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521C11705;
	Mon,  5 Feb 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118681; cv=none; b=QKX5xPlEigZT88mIRvE+J5PztaF/bMC5iQOlBkzaL5d7svUY/CBDrGz64KBEDJDygYGD6iuVRMV9BuhhUx1iEfboBqDeSMs/WVGMugOLtq21caFQPcZPABo8iIundygdqstcIHicIbFws6/XasElkfvy4BcGSZZz6tUVcWiESIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118681; c=relaxed/simple;
	bh=8y4SOWN1mmTsTxBFewxWIapH42Wz+9Mm5QGvzz6fXQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ern/bsoWZCBkZZugsoVtn72rLgwNVldu+pOnbT+7eCgMnf6W63/5Zu4cZT9wdotNup1JXaVCbyXgsIxkp+HzNInkoR5WDBlH18xdDDRub3cC43v3u7oMVXn+VJd2539GIeerS/VbyvgiIly7Qw3I5vM+Ekzg4KQyZCBM7OW4gzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhzXzhdL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707118680; x=1738654680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8y4SOWN1mmTsTxBFewxWIapH42Wz+9Mm5QGvzz6fXQQ=;
  b=YhzXzhdLvsAUZYYwctfXe9BNnWnJ0RJ8RXIWQNk9TFmvZskCnPjvBPiK
   cLO5igmfklyw1i6Wl8Hs2bc9Lcbv7qxZX4wbEy6oKh+00P85p4UO4sGaI
   UuPstzqY7iPVtvFLrJgGJMJih7utwO2EFkS/ywaGq5+1kvz7g2I/SkQYQ
   M4NxSG+aHF33UoBvf9HqA9slz7sNtWL0q1kLd2U0OsXAoXaSfbJgGAOg/
   7OEjMK7wQAW7QS9eaDT9lvhYISV+KT+swaF8ggjSWOcumkTrY4BPudj0W
   VqcFcXLeVPrwPerS4mZTHXPKCw1EytzX8BJNmhffKOeXA8tihI/0K+npV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="4263076"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4263076"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 23:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="31741571"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 23:37:57 -0800
Date: Mon, 5 Feb 2024 08:37:48 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] Use KMEM_CACHE instead of kmem_cache_create
Message-ID: <ZcCQTPUoeqUeiQsN@mev-dev>
References: <20240205072013.427639-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205072013.427639-1-chentao@kylinos.cn>

On Mon, Feb 05, 2024 at 03:20:07PM +0800, Kunwu Chan wrote:
> As Jiri Pirko suggests, 
You can add a suggested-by tag.

> I'm using a patchset to cleanup the same issues in the 'net' module.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
>
What about rest of the kmem_cache_create in net folder? (ex. fib_trie)

> Some cache names are changed to be the same as struct names. 
> This change is recorded in the changelog for easy reference.
> It's harmless cause it's used in /proc/slabinfo to identify this cache.
> 
> Kunwu Chan (6):
>   net: kcm: Simplify the allocation of slab caches
>   ip6mr: Simplify the allocation of slab caches in ip6_mr_init
>   ipmr: Simplify the allocation of slab caches
>   ipv4: Simplify the allocation of slab caches in ip_rt_init
>   tcp: Simplify the allocation of slab caches
>   ipv6: Simplify the allocation of slab caches
> 
>  net/ipv4/ipmr.c    |  5 +----
>  net/ipv4/route.c   |  5 ++---
>  net/ipv4/tcp.c     | 14 ++++----------
>  net/ipv6/ip6_fib.c |  6 ++----
>  net/ipv6/ip6mr.c   |  5 +----
>  net/kcm/kcmsock.c  |  8 ++------
>  6 files changed, 12 insertions(+), 31 deletions(-)
> 
> -- 
> 2.39.2

Changes looks fines, thanks
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
for whole series.

Thanks,
Michal

