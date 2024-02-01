Return-Path: <linux-kernel+bounces-47716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F7D8451AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928D61F22E85
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB17D157E9D;
	Thu,  1 Feb 2024 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpXfMLag"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC72B9D1;
	Thu,  1 Feb 2024 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706770536; cv=none; b=diDomLMEuM8w12Xh5WGaQmW41Pz0uZbWu5ABzdS4YgvpFUn3ZR/KNte8nnHvqe9K7pOirxeYp4ADf0614NWDhJ/cWGtqYgF17Y9ojLPkRNHgmR6N0/p0ZcrkFTPg5K/G7MwVT40//66KEKRMRoyujXNxtkI4hAYhVWSBSlk402o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706770536; c=relaxed/simple;
	bh=k85R9HmB4RP7ktbABdRSoIpDMqKQO80Ei14Lpu87/+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja1FNDzJ+2IaPEIoosedmgG93pMaBJWzFDJUm9Lm7cmspRUX8/Sbudx11ldw/ki6WjBOHtnGx5rYfm6wnRoQ0AixEXaUfk2XVUpJ1pEe1GvlQ69JWzNEuvRTz+6+XMA5gdRqUOGxHB81qG+NdwVFGBg78PPuP8N4NKikgnnUjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpXfMLag; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706770535; x=1738306535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k85R9HmB4RP7ktbABdRSoIpDMqKQO80Ei14Lpu87/+Q=;
  b=VpXfMLagTGnxQ8Dx0UuejXIrHIeA8JnXy4XaOXD9a59uWSSwiHaP5z7C
   XXMf3lOUVU/93mNt2UUoyQ32jrc9r1DcTA5Mo6ZRQtIZCL+kVerLgUJNm
   9BkWfEXZQYt0Mtr7ohp03PAKw8z/o+77gNXbQRt9PjlUlE9YSmBDc8Jte
   C1WX5sbGhk10rrDe84hb498gK/3Zl/FdCC/KFNd0r/Uw4ImtvPbeqZkIL
   B32M1TED4evIxHfurmt1k9wYFjOaX8e1ZZRYP2jG8ZXaxDhRX3pfIgsGJ
   S8+YV9rxYAZxyarS+pKzRqnu1UXjjbB4oIVxrNzVh2vQH3eXfuUFe7PVd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10928131"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10928131"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 22:55:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4330273"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 22:55:29 -0800
Date: Thu, 1 Feb 2024 07:55:26 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: karthiksundaravel <ksundara@redhat.com>, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, rjarry@redhat.com,
	aharivel@redhat.com, vchundur@redhat.com, cfontain@redhat.com
Subject: Re: [PATCH] ice: Add get/set hw address for VF representor ports
Message-ID: <ZbtAXuLtrhrbYjEw@mev-dev>
References: <20240131080847.30614-1-ksundara@redhat.com>
 <ZbokUx7myZ1bVWLL@mev-dev>
 <Zbo2RJErBsD0Sc_z@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbo2RJErBsD0Sc_z@nanopsycho>

On Wed, Jan 31, 2024 at 01:00:04PM +0100, Jiri Pirko wrote:
> Wed, Jan 31, 2024 at 11:43:44AM CET, michal.swiatkowski@linux.intel.com wrote:
> >On Wed, Jan 31, 2024 at 01:38:47PM +0530, karthiksundaravel wrote:
> >> Changing the mac address of the VF representor ports are not
> >> available via devlink. Add the function handlers to set and get
> >> the HW address for the VF representor ports.
> >> 
> >> Signed-off-by: karthiksundaravel <ksundara@redhat.com>
> >> ---
> >>  drivers/net/ethernet/intel/ice/ice_devlink.c | 134 ++++++++++++++++++-
> >>  1 file changed, 132 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >> index 80dc5445b50d..56d81836c469 100644
> >> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> >> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >> @@ -9,6 +9,8 @@
> >
> >As Jiri already wrote, you are not changing MAC of VF in your code. Try
> >to look at ice_set_vf_mac in ice_sriov.c. In current implementation you
> >nedd to set new MAC value for VF and reset it. You shouldn't use PF VSI.
> >
> >Pointer to VF you can get from representor struct (through parent VSI).
> 
> What if it is in a different host? Would you still be able to change the
> mac?
> 

In current VF MAC changing implementation yes, because it is done by
resetting the VF. After the reset new MAC will be sent via virtchnl.
But I think resetting VF may be incorrect here, as it leads to reset
also port representor.

> 
> >
> >You shouldn't manage the rules during MAC changing, as in switchdev
> >slow-path there shouldn't be VF MAC rules. It can be problematic as user
> >already can have MAC + sth rule (which also needs to be change). I will
> >leave it to user (most probably the MAC change happens before adding any
> >rules).
> 
> Rules are on the representor, not the VF, correct? Seems unrelated to
> me.
> 

I pointed it out because it was in the code. Rules added on representor
points to corresponding VF. My point was that there shouldn't be any
changes to rules after changing MAC.

> 
> >
> >In few days we will send patchset for subfunction support where the
> >subfunction MAC chaning is implementing from devlink API. I will add you
> >to the CC.
> >
> >Thanks for working on it, it is a gap in our solution.
> >
> >Thanks,
> >Michal
> >

