Return-Path: <linux-kernel+bounces-47747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76A84524C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA87C1F238C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B723C158D78;
	Thu,  1 Feb 2024 08:01:06 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8C3B182;
	Thu,  1 Feb 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774466; cv=none; b=VmnJKoZqolUKZsQUyz3KWXUzr+Bw7p1MB24qnErQ+UMxAHhpFNQ9G7J/824S6Seqx0m7pbcCGVO3G2Ieu2TAzE6p9EZj+5Gs1Qi/IBULX/wSKHUc2Sk/VSKWXdTVpnb+M38/Sc4Y8fsau/Rd50AYiXvGMoRw8drWKVCzSlKL+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774466; c=relaxed/simple;
	bh=kS9DYB4BEmc66Mc51nkbeAZk5TYUzacr2iWVxMq1DIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtVRDBSVk3pnK84KKiylh57BQ/WETBnvO5zCe3z0SYKM6oq7NMjiEr3svBc9ioQVFKlStU0UJwNOpKvwon15ruzPJQRRQEU8OVyY4AwyS1hEcqlxAz2ZY7bkNP5nqhMaH4jtZXv3SjKfphVotbOHsVRP22MTr9rUP2GItBrUVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af685.dynamic.kabel-deutschland.de [95.90.246.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 371B861E5FE01;
	Thu,  1 Feb 2024 09:00:15 +0100 (CET)
Message-ID: <943270a2-3125-4767-b4e7-2852b0f8ea94@molgen.mpg.de>
Date: Thu, 1 Feb 2024 09:00:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] ice: Add get/set hw address for VF
 representor ports
To: Jiri Pirko <jiri@resnulli.us>
Cc: ksundara@redhat.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rjarry@redhat.com,
 aharivel@redhat.com, cfontain@redhat.com, vchundur@redhat.com
References: <20240131080847.30614-1-ksundara@redhat.com>
 <64c36525-9177-48b1-abbb-c69dbdeb6d79@molgen.mpg.de>
 <ZbtK6PwsYLosTem8@nanopsycho>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZbtK6PwsYLosTem8@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jiri,


Am 01.02.24 um 08:40 schrieb Jiri Pirko:
> Wed, Jan 31, 2024 at 05:15:46PM CET, pmenzel@molgen.mpg.de wrote:

[…]

>> Am 31.01.24 um 09:08 schrieb karthiksundaravel:
>>> Changing the mac address of the VF representor ports are not
>>
>> Do you mean “is not possible”?
>>
>>> available via devlink. Add the function handlers to set and get
>>> the HW address for the VF representor ports.
>>
>> How did you test this? It’d be great if you documented it.
>>
>>> Signed-off-by: karthiksundaravel <ksundara@redhat.com>
>>
>> Is “karthiksundaravel” the official spelling of your name. If not, you can
>> change it with
>>
>>     git config --global user.name "Your Name"
>>     git commit -s --amend --author="Your Name <ksundara@redhat.com>"
>>
>>> ---
>>>    drivers/net/ethernet/intel/ice/ice_devlink.c | 134 ++++++++++++++++++-
>>>    1 file changed, 132 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>>> index 80dc5445b50d..56d81836c469 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>>> @@ -9,6 +9,8 @@
>>>    #include "ice_eswitch.h"
>>>    #include "ice_fw_update.h"
>>>    #include "ice_dcb_lib.h"
>>> +#include "ice_fltr.h"
>>> +#include "ice_tc_lib.h"
>>>    static int ice_active_port_option = -1;
>>> @@ -1576,6 +1578,134 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
>>>    	devlink_port_unregister(&pf->devlink_port);
>>>    }
>>> +/**
>>> + * ice_devlink_port_get_vf_mac_address - .port_fn_hw_addr_get devlink handler
>>> + * @port: devlink port structure
>>> + * @hw_addr: Mac address of the port
>>> + * @hw_addr_len: length of mac address
>>
>> Mac/mac is spelled differently. (Also below.)
>>
>>> + * @extack: extended netdev ack structure
>>> + *
>>> + * Callback for the devlink .port_fn_hw_addr_get operation
>>> + * Return: zero on success or an error code on failure.
>>> + */
>>> +
>>> +static int ice_devlink_port_get_vf_mac_address(struct devlink_port *port,
>>> +					       u8 *hw_addr, int *hw_addr_len,
>>> +					       struct netlink_ext_ack *extack)
>>> +{
>>> +	struct net_device *netdev = port->type_eth.netdev;
>>> +
>>> +	if (!netdev || !netdev->dev_addr)
>>> +		return -EADDRNOTAVAIL;
>>> +
>>> +	ether_addr_copy(hw_addr, netdev->dev_addr);
>>> +	*hw_addr_len = ETH_ALEN;
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * ice_devlink_port_set_vf_mac_address - .port_fn_hw_addr_set devlink handler
>>> + * @port: devlink port structure
>>> + * @hw_addr: Mac address of the port
>>> + * @hw_addr_len: length of mac address
>>> + * @extack: extended netdev ack structure
>>> + *
>>> + * Callback for the devlink .port_fn_hw_addr_set operation
>>> + * Return: zero on success or an error code on failure.
>>> + */
>>> +static int ice_devlink_port_set_vf_mac_address(struct devlink_port *port,
>>> +					       const u8 *hw_addr,
>>> +					       int hw_addr_len,
>>> +					       struct netlink_ext_ack *extack)
>>> +{
>>> +	struct devlink *devlink = port->devlink;
>>> +	struct net_device *netdev = port->type_eth.netdev;
>>> +	struct ice_pf *pf = devlink_priv(devlink);
>>> +	struct ice_vsi *vsi = *pf->vsi;
>>> +	struct ice_hw *hw = &pf->hw;
>>> +	struct device *dev = ice_pf_to_dev(pf);
>>> +	u8 old_mac[ETH_ALEN];
>>> +	u8 flags = 0;
>>> +	const u8 *mac = hw_addr;
>>> +	int err;
>>> +
>>> +	if (!netdev)
>>> +		return -EADDRNOTAVAIL;
>>> +
>>> +	if (!is_valid_ether_addr(mac))
>>> +		return -EADDRNOTAVAIL;
>>> +
>>> +	if (ether_addr_equal(netdev->dev_addr, mac)) {
>>> +		dev_dbg(dev, "already using mac %pM\n", mac);
>>> +		return 0;
>>> +	}
>>> +
>>> +	if (test_bit(ICE_DOWN, pf->state) ||
>>> +	    ice_is_reset_in_progress(pf->state)) {
>>> +		dev_err(dev, "can't set mac %pM. device not ready\n", mac);
>>> +		return -EBUSY;
>>> +	}
>>> +
>>> +	if (ice_chnl_dmac_fltr_cnt(pf)) {
>>> +		dev_err(dev, "can't set mac %pM. Device has tc-flower filters, delete all of them and try again\n",
>>> +			mac);
>>> +		return -EAGAIN;
>>> +	}
>>> +
>>> +	netif_addr_lock_bh(netdev);
>>> +	ether_addr_copy(old_mac, netdev->dev_addr);
>>> +	/* change the netdev's MAC address */
>>
>> The comment seems redundant.
>>
>>> +	eth_hw_addr_set(netdev, mac);
>>> +	netif_addr_unlock_bh(netdev);
>>> +
>>> +	/* Clean up old MAC filter. Not an error if old filter doesn't exist */
>>> +	err = ice_fltr_remove_mac(vsi, old_mac, ICE_FWD_TO_VSI);
>>> +	if (err && err != -ENOENT) {
>>> +		err = -EADDRNOTAVAIL;
>>> +		goto err_update_filters;
>>> +	}
>>> +
>>> +	/* Add filter for new MAC. If filter exists, return success */
>>> +	err = ice_fltr_add_mac(vsi, mac, ICE_FWD_TO_VSI);
>>> +	if (err == -EEXIST) {
>>> +		/* Although this MAC filter is already present in hardware it's
>>> +		 * possible in some cases (e.g. bonding) that dev_addr was
>>> +		 * modified outside of the driver and needs to be restored back
>>> +		 * to this value.
>>> +		 */
>>> +		dev_dbg(dev, "filter for MAC %pM already exists\n", mac);
>>> +		return 0;
>>> +	} else if (err) {
>>> +		/* error if the new filter addition failed */
>>
>> The comment seems redundant.
>>
>>> +		err = -EADDRNOTAVAIL;
>>> +	}
>>> +
>>> +err_update_filters:
>>> +	if (err) {
>>> +		dev_err(dev, "can't set MAC %pM. filter update failed\n", mac);
>>> +		netif_addr_lock_bh(netdev);
>>> +		eth_hw_addr_set(netdev, old_mac);
>>> +		netif_addr_unlock_bh(netdev);
>>> +		return err;
>>> +	}
>>> +
>>> +	dev_dbg(dev, "updated MAC address to %pM\n", netdev->dev_addr);
>>
>> Should it be level info?
>>
>>> +
>>> +	/* write new MAC address to the firmware */
>>> +	flags = ICE_AQC_MAN_MAC_UPDATE_LAA_WOL;
>>> +	err = ice_aq_manage_mac_write(hw, mac, flags, NULL);
>>> +	if (err) {
>>> +		dev_err(dev, "can't set MAC %pM. write to firmware failed error %d\n",
>>> +			mac, err);
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct devlink_port_ops ice_devlink_vf_port_ops = {
>>> +	.port_fn_hw_addr_get = ice_devlink_port_get_vf_mac_address,
>>> +	.port_fn_hw_addr_set = ice_devlink_port_set_vf_mac_address,
>>> +};
>>> +
>>>    /**
>>>     * ice_devlink_create_vf_port - Create a devlink port for this VF
>>>     * @vf: the VF to create a port for
>>> @@ -1611,7 +1741,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>>>    	devlink_port_attrs_set(devlink_port, &attrs);
>>>    	devlink = priv_to_devlink(pf);
>>> -	err = devlink_port_register(devlink, devlink_port, vsi->idx);
>>> +	err = devlink_port_register_with_ops(devlink, devlink_port,
>>> +					     vsi->idx, &ice_devlink_vf_port_ops);
>>>    	if (err) {
>>>    		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
>>>    			vf->vf_id, err);
>>> @@ -1620,7 +1751,6 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>>>    	return 0;
>>>    }
>>> -
>>
>> Unrelated whitespace change.
>>
>>>    /**
>>>     * ice_devlink_destroy_vf_port - Destroy the devlink_port for this VF
>>>     * @vf: the VF to cleanup
>>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> Paul. It looks a bit weird you put in multiple comments that require
> changes and then the Reviewed-by tag. Usually, you put the tag only if
> you are 100% happy with the patch as it is.

Sorry about that. I will keep this in mind.

> It is also weird you put in a tag in this case when the patch
> is completely wrong, as I pointed out in my first reply. Did you miss
> it?

Yes, I missed it. (I disabled threading in Mozilla Thunderbird. I am 
going to change that again. Sorry about that.)


Kind regards,

Paul

