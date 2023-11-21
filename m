Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2A7F2B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjKULDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjKULDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:03:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42560D4B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:02:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56219C433C7;
        Tue, 21 Nov 2023 11:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700564576;
        bh=qbBQQ+xTLVRxtOoCnyW5Y0nAas6xySFxXREpgHxH8qs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f2KGQbZCx+OedcFxXRR0i87UB4T9cFhhz594mg3lSpd9gsyIsejPTLqrSKVbpa6ga
         HQ9dN/oZpOnRb2cM1gagQa4KotGW62FOn9B2gO+jvwHTB3dwswwUnwIeBWeLYIHs+r
         Ay42VnSH9deh7MYQhKZFoTnfvlrb34KZQ57AoXcN8W+MZydgw5UBxk8J4+XCyK+R3b
         M7ER8OnGmfczrCBU2LK4oDbb1unqTsxFfrEAL3/krgjGsjIL6wX3uVvIyWuEKjc9MU
         ICRPU8FqKk2Gws5+j6G897ghZQXGE9K3DvVPmW+zYhjBjTmnrKMzJTQp0y0/REnTng
         +91K3ZtlQAt5A==
Message-ID: <eeea995b-a294-4a46-aa3e-93fc2b274504@kernel.org>
Date:   Tue, 21 Nov 2023 13:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 6/7] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-7-rogerq@kernel.org>
 <20231120232620.uciap4bazypzlg3g@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231120232620.uciap4bazypzlg3g@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/11/2023 01:26, Vladimir Oltean wrote:
> On Mon, Nov 20, 2023 at 04:01:46PM +0200, Roger Quadros wrote:
>> Changelog:
>>
>> v6:
>> - get mutex around am65_cpsw_iet_commit_preemptible_tcs() in
>>   am65_cpsw_iet_change_preemptible_tcs()
>> - use "preemption" instead of "pre-emption"
>> - call am65_cpsw_setup_mqprio() from within am65_cpsw_setup_taprio()
>> - Now works with kselftest except the last test which fails
>>
>> root@am62xx:~/kselftest# ./run_kselftest.sh -t net/forwarding:ethtool_mm.sh
>> # TEST: Manual configuration with verification: eth0 to eth1          [ OK ]
>> # TEST: Manual configuration with verification: eth1 to eth0          [ OK ]
>> # TEST: Manual configuration without verification: eth0 to eth1       [ OK ]
>> # TEST: Manual configuration without verification: eth1 to eth0       [ OK ]
>> # TEST: Manual configuration with failed verification: eth0 to eth1   [ OK ]
>> # TEST: Manual configuration with failed verification: eth1 to eth0   [ OK ]
>> # Warning: Stopping lldpad.service, but it can still be activated by:
>> #   lldpad.socket
>> # TEST: LLDP                                                          [FAIL]
>> #       eth0 pMAC TX is not active
> 
> Interesting, but why?
> 
> Could you disable all tests except the one that fails, then re-run with
> verbose shell output, spawn a child interactive shell right after the
> command that fails, run it by hand without the grep (copying it from the
> verbose output just one line above) and see what output it gives,
> compared to what it should?
> 
> diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> index 39e736f30322..2340051742b6 100755
> --- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> +++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> @@ -2,12 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  ALL_TESTS="
> -	manual_with_verification_h1_to_h2
> -	manual_with_verification_h2_to_h1
> -	manual_without_verification_h1_to_h2
> -	manual_without_verification_h2_to_h1
> -	manual_failed_verification_h1_to_h2
> -	manual_failed_verification_h2_to_h1
>  	lldp
>  "
>  
> @@ -170,6 +164,8 @@ lldp()
>  {
>  	RET=0
>  
> +	set -x
> +
>  	systemctl start lldpad
>  
>  	# Configure the interfaces to receive and transmit LLDPDUs
> @@ -185,6 +181,10 @@ lldp()
>  
>  	lldptool -i $h1 -t -n -V addEthCaps | \
>  		grep -q "Preemption capability active"
> +
> +	set +x
> +	bash
> +
>  	check_err "$?" "$h1 pMAC TX is not active"
>  
>  	lldptool -i $h2 -t -n -V addEthCaps | \
> 
> You have the openlldp compiled from the master branch so that it has
> preemption/MAC merge support, right? We just "require_command lldptool"
> but we don't probe for this functionality, as opposed to tc and ethtool.

Yes I'm using openlldp master.

So I just dumped the "ethtool --show-mm" right before the "lldptool -i $h1 -t -n -V addEthCaps"
and this is what I see

# MAC Merge layer state for eth0:
# pMAC enabled: on
# TX enabled: off
# TX active: off
# TX minimum fragment size: 252
# RX minimum fragment size: 124
# Verify enabled: off
# Verify time: 10
# Max verify time: 134
# Verification status: DISABLED
# 
# MAC Merge layer state for eth1:
# pMAC enabled: on
# TX enabled: off
# TX active: off
# TX minimum fragment size: 124
# RX minimum fragment size: 124
# Verify enabled: off
# Verify time: 10
# Max verify time: 134
# Verification status: DISABLED
# 
# Additional Ethernet Capabilities TLV
#       Preemption capability supported
#       Preemption capability not enabled
#       Preemption capability not active
#       Additional fragment size: 3 (252 octets)
# Additional Ethernet Capabilities TLV
#       Preemption capability supported
#       Preemption capability not enabled
#       Preemption capability not active
#       Additional fragment size: 1 (124 octets)
# Warning: Stopping lldpad.service, but it can still be activated by:
#   lldpad.socket
# TEST: LLDP                                                          [FAIL]


If I add the following lines at the beginning of lldp() routine,
then it works.

lldp()
{
        RET=0

+        ethtool --set-mm $h1 tx-enabled on verify-enabled on
+        ethtool --set-mm $h2 tx-enabled on verify-enabled on
...
}

Is lldp supposed to turn on tx-enabled and verify-enabled for us
or it is test scritps responsibility?

The test fails later at "addFragSize 0", but that is because we don't
support RX fragment size 60 due to errata.
If I skip that test then all the rest of the tests pass.

> 
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> index b9e1d568604b..6af00640e99c 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> @@ -740,6 +741,157 @@ static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
>>  	return 0;
>>  }
>>  
>> +static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>> +			    struct netlink_ext_ack *extack)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
>> +	struct am65_cpsw_iet *iet = &port->qos.iet;
>> +	u32 val, add_frag_size;
>> +	int err;
>> +
>> +	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
>> +	if (err)
>> +		return err;
>> +
>> +	mutex_lock(&priv->mm_lock);
>> +
>> +	if (cfg->pmac_enabled) {
>> +		/* change TX & RX FIFO MAX_BLKS as per TRM recommendation */
>> +		if (!iet->original_max_blks)
>> +			iet->original_max_blks = readl(port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
>> +
>> +		writel(AM65_CPSW_PN_TX_RX_MAX_BLKS_IET,
>> +		       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
>> +	} else {
>> +		/* restore RX & TX FIFO MAX_BLKS */
>> +		if (iet->original_max_blks) {
> 
> else {
> 	if ()
> }
> 
> can be written as
> 
> else if () {
> }

ok.

> 
>> +			writel(iet->original_max_blks,
>> +			       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
>> +		}
>> +	}
>> +
>> +	am65_cpsw_port_iet_rx_enable(port, cfg->pmac_enabled);
>> +	am65_cpsw_port_iet_tx_enable(port, cfg->tx_enabled);
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	if (cfg->verify_enabled) {
>> +		val &= ~AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
>> +		/* Reset Verify state machine. Verification won't start here.
>> +		 * Verification will be done once link-up.
>> +		 */
>> +		val |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
>> +	} else {
>> +		val |= AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
>> +		/* Clear LINKFAIL to allow verify/response packets */
>> +		val &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
>> +	}
>> +
>> +	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
>> +	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +
>> +	/* verify_timeout_count can only be set at valid link */
>> +	if (cfg->verify_time > 0)
>> +		port->qos.iet.verify_time_ms = cfg->verify_time;
>> +	else
>> +		port->qos.iet.verify_time_ms = 10;
>> +
>> +	/* enable/disable preemption based on link status */
>> +	am65_cpsw_iet_commit_preemptible_tcs(port);
>> +
>> +	mutex_unlock(&priv->mm_lock);
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> index 60f625e1350b..8443c13c9ff6 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> @@ -4,9 +4,11 @@
>>   *
>>   * quality of service module includes:
>>   * Enhanced Scheduler Traffic (EST - P802.1Qbv/D2.2)
>> + * Interspersed Express Traffic (IET - P802.3br/D2.0)
>>   */
>>  
>>  #include <linux/pm_runtime.h>
>> +#include <linux/units.h>
> 
> If this was ordered alphabetically, u comes after t.
> 

ok.

>>  #include <linux/time.h>
>>  #include <net/pkt_cls.h>
>>  
>> @@ -259,6 +266,196 @@ static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
>>  	return ret;
>>  }
>>  
>> +static int am65_cpsw_iet_set_verify_timeout_count(struct am65_cpsw_port *port)
>> +{
>> +	int verify_time_ms = port->qos.iet.verify_time_ms;
>> +	int link_speed = port->qos.link_speed;
>> +	u32 val;
>> +
>> +	if (WARN_ON(link_speed == SPEED_UNKNOWN))
>> +		return -ENODEV;
>> +
>> +	/* The number of wireside clocks contained in the verify
>> +	 * timeout counter. The default is 0x1312d0
>> +	 * (10ms at 125Mhz in 1G mode).
>> +	 */
>> +	val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
>> +
>> +	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
>> +	val *= verify_time_ms;		/* count for timeout ms */
>> +	if (link_speed < SPEED_1000)
>> +		val <<= 1;	/* FIXME: Is this correct? */
> 
> Is there any way to find out and remove the FIXME? Like running the
> selftest at SPEED_100?

I will give this a try.

> 
>> +
>> +	if (val > AM65_CPSW_PN_MAC_VERIFY_CNT_MASK)
>> +		return -EINVAL;
>> +
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_VERIFY);
>> +
>> +	return 0;
>> +}
>> +
>> +/* CPSW does not have an IRQ to notify changes to the MAC Merge TX status
>> + * (active/inactive), but the preemptible traffic classes should only be
>> + * committed to hardware once TX is active. Resort to polling.
>> + */
>> +void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
>> +{
>> +	u8 preemptible_tcs = 0;
> 
> I don't think the zero-initialization helps, since the value is later
> unconditionally overwritten.

OK, will drop it.

> 
>> +	int err;
>> +	u32 val;
>> +
>> +	if (port->qos.link_speed == SPEED_UNKNOWN)
>> +		return;
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
>> +	if (!(val & AM65_CPSW_PN_CTL_IET_PORT_EN))
>> +		return;
>> +
>> +	/* update common IET enable */
>> +	am65_cpsw_iet_common_enable(port->common);
>> +
>> +	/* update verify count */
>> +	err = am65_cpsw_iet_set_verify_timeout_count(port);
>> +	if (err) {
>> +		netdev_err(port->ndev, "couldn't set verify count: %d\n", err);
>> +		return;
>> +	}
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	if (!(val & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)) {
>> +		err = am65_cpsw_iet_verify_wait(port);
>> +		if (err)
>> +			return;
>> +	}
>> +
>> +	preemptible_tcs = port->qos.iet.preemptible_tcs;
>> +	am65_cpsw_iet_set_preempt_mask(port, preemptible_tcs);
>> +}

-- 
cheers,
-roger
