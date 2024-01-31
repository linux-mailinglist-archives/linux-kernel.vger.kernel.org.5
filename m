Return-Path: <linux-kernel+bounces-46255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E2E843D17
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3A51C29944
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86F6BB26;
	Wed, 31 Jan 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcGYPJ3i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410AD6A34B;
	Wed, 31 Jan 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697838; cv=none; b=mZZxgg9c3cxFFwe6QxgBE1bdZP1qygWzo/gBRGHcLxYRckgL/xvfxw/3l1FVX2udT57HuNSYRiCeuGqWVbg39cLCstCOqDEtKZ+KMfJ/rtVIYfbQPE6/e607GOSXffKdMr62+8xMDRUyzhF0CAtYyxNYQBRf6HS0qRAP33z77ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697838; c=relaxed/simple;
	bh=GMHh/yDFgs8E7du6dshuQUH8e/3SPnyzYtKxUfHT/jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3Ah1gKxVtmqN01+gIffUQieVV6UtQObTIqPDFJkorEhwXzqGtr4G1RiHmobjJLaee364KIkBUGSDmddpovf9sxb4wB0Xp66OFarjAP7SzFMVdHnfZuVRQi84uJGVMpBLyGJj/YKqpTUSqj+ShnilY0IGaaD5r6NeW5L2bRMON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcGYPJ3i; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706697837; x=1738233837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMHh/yDFgs8E7du6dshuQUH8e/3SPnyzYtKxUfHT/jQ=;
  b=AcGYPJ3ideWaN1qV5YGqvAC6dh/0sBRfUKNN22Y9V1Qct6qtAeaffA30
   /kX3k0jhKMb6U7cv9kRVIkuQMOXeGnNYLS54MeFv67aJ/StYRKJiBQjxJ
   t83D5XhFrI0nGtqacKmHiE5p7MQ6pfQTTyHVPN/cE3jFixd39ZjhTgPxJ
   uDrcsLtlyP1sAVy0fDnOd7WatHLzBghCNVZ5EQ8C4hY1B6dEvdxekxLKM
   zWi7Zp9emf6Ea5aCZyqfzibNvgAbZCV/gOVCoXaSLvY+t6f3MLNjCspxO
   LSKwuJi2FoYh0Fy8zBLiM6ZyB9W7INEgH/fr+wBzjVWlQ0Xe81XJjRIDF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10316962"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10316962"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4121359"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:43:53 -0800
Date: Wed, 31 Jan 2024 11:43:44 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: karthiksundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rjarry@redhat.com, aharivel@redhat.com, vchundur@redhat.com,
	cfontain@redhat.com
Subject: Re: [PATCH] ice: Add get/set hw address for VF representor ports
Message-ID: <ZbokUx7myZ1bVWLL@mev-dev>
References: <20240131080847.30614-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131080847.30614-1-ksundara@redhat.com>

On Wed, Jan 31, 2024 at 01:38:47PM +0530, karthiksundaravel wrote:
> Changing the mac address of the VF representor ports are not
> available via devlink. Add the function handlers to set and get
> the HW address for the VF representor ports.
> 
> Signed-off-by: karthiksundaravel <ksundara@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 134 ++++++++++++++++++-
>  1 file changed, 132 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> index 80dc5445b50d..56d81836c469 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> @@ -9,6 +9,8 @@

As Jiri already wrote, you are not changing MAC of VF in your code. Try
to look at ice_set_vf_mac in ice_sriov.c. In current implementation you
nedd to set new MAC value for VF and reset it. You shouldn't use PF VSI.

Pointer to VF you can get from representor struct (through parent VSI).

You shouldn't manage the rules during MAC changing, as in switchdev
slow-path there shouldn't be VF MAC rules. It can be problematic as user
already can have MAC + sth rule (which also needs to be change). I will
leave it to user (most probably the MAC change happens before adding any
rules).

In few days we will send patchset for subfunction support where the
subfunction MAC chaning is implementing from devlink API. I will add you
to the CC.

Thanks for working on it, it is a gap in our solution.

Thanks,
Michal

