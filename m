Return-Path: <linux-kernel+bounces-63539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D2E8530F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EAD1F24CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6714207B;
	Tue, 13 Feb 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvtyyZJ7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30550405D8;
	Tue, 13 Feb 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828668; cv=none; b=iUL3l9ctyOzIn1pwTi+nfZlsY10RWdiYG8jHE8fD9+mwZQXZ6UTVmsrQgMtB7ZIUyWnMQiUuLKaTkag4Z31WuCr8K0cYJi5NTqDfe1/5wGfmWLDeEM98jyS05S75i1h8nojxqhdU36dPbQmHkpkHhAHpwuj/w7KKfa8oXqp8jmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828668; c=relaxed/simple;
	bh=cgc6WEo6KiUkTPoF8lda8b4oPP94RffhPHS5Dx9J9go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZzyC82AIVBTTBMiXswI9JQEJwn8xf8pY0Mg7S/7Kxfvlq+tbDeRizmGOtCvWxQ6FmhtafcbYGFUL9vincsvDKzD+/Ecov3gHBnzMSIAujcXtwPMcyfM5oK+GIP2+94CI0zA1pCR4GnLGTtm1W7xZG7Wn6XPVv2jDPn/3bXWPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvtyyZJ7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707828667; x=1739364667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cgc6WEo6KiUkTPoF8lda8b4oPP94RffhPHS5Dx9J9go=;
  b=hvtyyZJ7kyyDGuQ2e9he86CgmHj59pL0nQ9DwQ5Dlm7iK8fwZSuDKLAK
   EltcLMDJ3AkkaSzuAw2P9S5JYc77leigUYisFqTP9No5HIkLXCVXIjLSI
   /Fdv7EgjTji/UhPNe4YfITWmVw+kAr4eKm77oG+5sjYAxgKnAEG6mAQe8
   f0bfFn0AT3FzfarWjGYKWwxvIVhgAYh7EvCcvjdSqPaupeBo4Ieblm2qA
   fB8ikb+xZmlKFhstEaasjzkG79LYdQx5mVzIDT9oWoziD/FOyfIr01PVx
   LjHvO5YSzwiPW17cjvD/LfQlt2U3a9h5RUFQu1SgHeL601OqJELSHMru4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5650567"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="5650567"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:51:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2832183"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:51:03 -0800
Date: Tue, 13 Feb 2024 13:50:59 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Karthik Sundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de, jiri@resnulli.us, rjarry@redhat.com,
	aharivel@redhat.com, vchundur@redhat.com, cfontain@redhat.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH v3] ice: Add get/set hw address for VFs using devlink
 commands
Message-ID: <ZctlswYbV1RHU2ip@mev-dev>
References: <20240209100912.82473-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209100912.82473-1-ksundara@redhat.com>

On Fri, Feb 09, 2024 at 03:39:12PM +0530, Karthik Sundaravel wrote:
> Changing the MAC address of the VFs are not available
> via devlink. Add the function handlers to set and get
> the HW address for the VFs.
> 
> Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 86 +++++++++++++++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> index 80dc5445b50d..7ed61b10312c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> @@ -1576,6 +1576,89 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
>  	devlink_port_unregister(&pf->devlink_port);
>  }
>  
> +/**
> + * ice_devlink_port_get_vf_mac_address - .port_fn_hw_addr_get devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_get operation
> + * Return: zero on success or an error code on failure.
> + */
> +
> +static int ice_devlink_port_get_vf_mac_address(struct devlink_port *port,
> +					       u8 *hw_addr, int *hw_addr_len,
> +					       struct netlink_ext_ack *extack)
> +{
> +	struct devlink_port_attrs *attrs = &port->attrs;
> +	struct devlink_port_pci_vf_attrs *pci_vf;
> +	struct devlink *devlink = port->devlink;
> +	struct ice_pf *pf;
> +	struct ice_vf *vf;
> +	int vf_id;
> +
> +	pf = devlink_priv(devlink);
> +	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
> +		pci_vf = &attrs->pci_vf;
> +		vf_id = pci_vf->vf;
> +	} else {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf id");
> +		return -EADDRNOTAVAIL;
> +	}
> +	vf = ice_get_vf_by_id(pf, vf_id);
You need to call ice_put_vf(vf); when you finish with vf.

This way to get vf pointer is fine, I wonder if it can be done using
container_of on port variable. Jake, what do you think?
CC: Jacob Keller

> +	if (!vf) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
> +		return -EINVAL;
> +	}
> +	ether_addr_copy(hw_addr, vf->dev_lan_addr);
> +	*hw_addr_len = ETH_ALEN;
> +	return 0;
> +}
> +
> +/**
> + * ice_devlink_port_set_vf_mac_address - .port_fn_hw_addr_set devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_set operation
> + * Return: zero on success or an error code on failure.
> + */
> +static int ice_devlink_port_set_vf_mac_address(struct devlink_port *port,
> +					       const u8 *hw_addr,
> +					       int hw_addr_len,
> +					       struct netlink_ext_ack *extack)
> +{
> +	struct net_device *netdev = port->type_eth.netdev;
Is it PF netdev?

> +	struct devlink_port_attrs *attrs = &port->attrs;
> +	struct devlink_port_pci_vf_attrs *pci_vf;
> +	u8 mac[ETH_ALEN];
> +	int vf_id;
> +
> +	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
> +		pci_vf = &attrs->pci_vf;
> +		vf_id = pci_vf->vf;
> +	} else {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf id");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	if (!netdev) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to get the netdev");
> +		return -EADDRNOTAVAIL;
> +	}
> +	ether_addr_copy(mac, hw_addr);
> +
> +	return ice_set_vf_mac(netdev, vf_id, mac);
> +}
> +
> +static const struct devlink_port_ops ice_devlink_vf_port_ops = {
> +	.port_fn_hw_addr_get = ice_devlink_port_get_vf_mac_address,
> +	.port_fn_hw_addr_set = ice_devlink_port_set_vf_mac_address,
> +};
> +
>  /**
>   * ice_devlink_create_vf_port - Create a devlink port for this VF
>   * @vf: the VF to create a port for
> @@ -1611,7 +1694,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>  	devlink_port_attrs_set(devlink_port, &attrs);
>  	devlink = priv_to_devlink(pf);
>  
> -	err = devlink_port_register(devlink, devlink_port, vsi->idx);
> +	err = devlink_port_register_with_ops(devlink, devlink_port,
> +					     vsi->idx, &ice_devlink_vf_port_ops);
>  	if (err) {
>  		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
>  			vf->vf_id, err);
> -- 
> 2.39.3 (Apple Git-145)
> 

