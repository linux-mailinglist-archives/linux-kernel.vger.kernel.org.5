Return-Path: <linux-kernel+bounces-118026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A5F88B47C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B752FB3441F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1836D1BC;
	Mon, 25 Mar 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaJkyW3k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088D6BFCC;
	Mon, 25 Mar 2024 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401585; cv=none; b=X+zM1oYHPCJjlPomL67TivPduJGHEESfVVFswkaSwIjpEW1QUohIwVTpZwoEJFTIgj38eZn6vniBz8lFQ+yhiBUqatgDdKOucXG0r+D8BWHy7+le6fsOw8+XayYrnduuRPfFZK9NS7TOgf3Ps6/uYLgWHVs5SBRl/oVDXqgXjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401585; c=relaxed/simple;
	bh=Qbas4ADbxxgE1Ks2CTqG0Srxpp+07yr4ueiXALqVkOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5DKu4/VifhLM4qujEybKYrvDqzJKr9alZ7KWUluyWk+q5HrrEezyjTd5x3EBdF1wJtO3odOaXuWnHDfFS424ktIOB6FjCf3VyDUGeXwQ37MUnGuZpkQEnKR634vqgCc03tQHHRr/LAK29sGgIugcDgbU4SwgYJgcoD6yYJFt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaJkyW3k; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711401583; x=1742937583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qbas4ADbxxgE1Ks2CTqG0Srxpp+07yr4ueiXALqVkOo=;
  b=VaJkyW3k3NeYeNq3Bltry63kwfFVuV0tI335jPEBPXbsFAym3gpguSMU
   uJPO3sNr7xX9yq5SDRQS/PINSCtYjWik5D+Lq71ZNoo1Bd+LyKe2NOjL8
   XBZd7Iw2MLIFdPMjyTYjBj4ug7GpI55RoOWmOcrhJCQku3QEv8BZWV5hU
   RkXYDokgrinGbzyyOsBVbV15eMQDRRxxGQGgJlByII5tG/tqMy9ajnPd4
   R57Kc4BQJIko1q0xBhvO1QOUN/FbK3YkbfbhjKxl2sFVZATHrgp6jbFrQ
   DRSf8+GCg9L9hhRU3DaSf+dmOkzcQEij+U0AFqQVGxEA2n4bb0DlSn/IY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17824342"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17824342"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 14:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15641537"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 14:19:40 -0700
Date: Mon, 25 Mar 2024 22:19:35 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, wojciech.drewek@intel.com,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ice: fix enabling RX VLAN filtering
Message-ID: <ZgHqZ5ebaO9VkvYx@mev-dev>
References: <20240325201901.39365-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325201901.39365-1-poros@redhat.com>

On Mon, Mar 25, 2024 at 09:19:01PM +0100, Petr Oros wrote:
> ice_port_vlan_on/off() was introduced in commit 2946204b3fa8 ("ice:
> implement bridge port vlan"). But ice_port_vlan_on() incorrectly assigns
> ena_rx_filtering to inner_vlan_ops in DVM mode.
> This causes an error when rx_filtering cannot be enabled in legacy mode.
> 
> Reproducer:
>  echo 1 > /sys/class/net/$PF/device/sriov_numvfs
>  ip link set $PF vf 0 spoofchk off trust on vlan 3
> dmesg:
>  ice 0000:41:00.0: failed to enable Rx VLAN filtering for VF 0 VSI 9 during VF rebuild, error -95
> 
> Fixes: 2946204b3fa8 ("ice: implement bridge port vlan")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
> index 80dc4bcdd3a41c..b3e1bdcb80f84d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
> @@ -26,24 +26,22 @@ static void ice_port_vlan_on(struct ice_vsi *vsi)
>  	struct ice_vsi_vlan_ops *vlan_ops;
>  	struct ice_pf *pf = vsi->back;
>  
> -	if (ice_is_dvm_ena(&pf->hw)) {
> -		vlan_ops = &vsi->outer_vlan_ops;
> -
> -		/* setup outer VLAN ops */
> -		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
> -		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
> +	/* setup inner VLAN ops */
> +	vlan_ops = &vsi->inner_vlan_ops;
>  
> -		/* setup inner VLAN ops */
> -		vlan_ops = &vsi->inner_vlan_ops;
> +	if (ice_is_dvm_ena(&pf->hw)) {
>  		vlan_ops->add_vlan = noop_vlan_arg;
>  		vlan_ops->del_vlan = noop_vlan_arg;
>  		vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
>  		vlan_ops->dis_stripping = ice_vsi_dis_inner_stripping;
>  		vlan_ops->ena_insertion = ice_vsi_ena_inner_insertion;
>  		vlan_ops->dis_insertion = ice_vsi_dis_inner_insertion;
> -	} else {
> -		vlan_ops = &vsi->inner_vlan_ops;
>  
> +		/* setup outer VLAN ops */
> +		vlan_ops = &vsi->outer_vlan_ops;
> +		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
> +		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
> +	} else {
>  		vlan_ops->set_port_vlan = ice_vsi_set_inner_port_vlan;
>  		vlan_ops->clear_port_vlan = ice_vsi_clear_inner_port_vlan;
>  	}

Thanks for fixing it.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.43.2
> 

