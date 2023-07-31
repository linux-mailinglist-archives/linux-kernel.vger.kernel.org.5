Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB84769A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjGaOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjGaOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:51:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B2FDB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 967BB61197
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF37CC433C8;
        Mon, 31 Jul 2023 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690815113;
        bh=mfC5/hb2v4zCQ3mjrt4UNVjmevuqWeozRcHKyIGkIWI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eXqgqdQX5yNC7F/rsoOSwdMYgun78j0E915ivydlR4TpA/00u0rb5NN/YIjID96sc
         zvIVN/miW0+qVhvHo5ihAyBfPk79opezMynREI0+EehOr8OsLPqTS+yogxCSscZovw
         H0Kkex/4y13Xet3wDXTobEGZ152GYpU/wYh5NbNptc01832D5F/v2tAXsZpwurmptK
         j0eaJx5GT1Yvv9W+opqcmfnWcx7XI39uq7i/oQxaVSlBwNsZLam/z5Bb5BQGKHQ9Oy
         agn4G6uv0ERlsd1ooXozFfwTmTeE3C2mfwkCy0x/OoeYtHbUzZLJ++YNCMelDDaAFS
         CGddYGjR8yZoQ==
Message-ID: <19f2075e-9f4a-6c8d-7ef6-45258a2a9689@kernel.org>
Date:   Mon, 31 Jul 2023 17:51:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725072338.20789-1-rogerq@kernel.org>
 <20230729000127.fqwwp2j6rzyw6xth@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230729000127.fqwwp2j6rzyw6xth@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On 29/07/2023 03:01, Vladimir Oltean wrote:
> Hi Roger,
> 
> On Tue, Jul 25, 2023 at 10:23:38AM +0300, Roger Quadros wrote:
>> Add driver support for viewing / changing the MAC Merge sublayer
>> parameters and seeing the verification state machine's current state
>> via ethtool.
>>
>> As hardware does not support interrupt notification for verification
>> events we resort to polling on link up. On link up we try a couple of
>> times for verification success and if unsuccessful then give up.
>>
>> The Frame Preemption feature is described in the Technical Reference
>> Manual [1] in section:
>> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
>>
>> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
>>
>> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
>> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
> 
> Thanks for the documentation.

Thank you for the review and suggestions.

> 
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>
>> Hi,
>>
>> This is RFC because I've still not got Verification to work
> 
> What are you testing with? There's a selftest at tools/testing/selftests/net/forwarding/ethtool_mm.sh.

Currently just with ethtool --set-mm till I get the verification working.
I will also use the selftests you pointed to.

> 
>> and I'm still clueless on how to set the preemptible mask to set the
>> preemtible queues. The driver doesn't yet support MQPRIO offloading.
> 
> I'm not sure what it is that you say you're clueless about. The user
> space tooling for setting the preemptible traffic classes? You can take
> the "fp" line of arguments from the mqprio command in the selftest
> above, and transplant it to a taprio command you already have.
> 
> To avoid any confusion, please make sure that your iproute2 version has
> commit e848ef0ad5d0 ("tc/taprio: fix parsing of "fp" option when it
> doesn't appear last") applied.
> 

Thanks for the tip. I will try it out.

>>
>> Please let me know if overall approach is OK. Thanks.
>>
>> cheers,
>> -roger
>>
>>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 168 ++++++++++++++++
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 212 ++++++++++++++++----
>>  drivers/net/ethernet/ti/am65-cpsw-qos.h     |  90 +++++++++
>>  5 files changed, 440 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> index c51e2af91f69..fd2ba29ebc0b 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/pm_runtime.h>
>>  
>>  #include "am65-cpsw-nuss.h"
>> +#include "am65-cpsw-qos.h"
>>  #include "cpsw_ale.h"
>>  #include "am65-cpts.h"
>>  
>> @@ -715,6 +716,171 @@ static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
>>  	return 0;
>>  }
>>  
>> +/* enable common IET only if at least 1 port has pre-emptible queues. disable otherwise */
>> +static void am65_cpsw_iet_enable(struct am65_cpsw_common *common)
>> +{
>> +	u32 common_enable = 0;
>> +	u32 val;
>> +	int i;
>> +
>> +	for (i = 0; i < common->port_num; i++)
>> +		common_enable |= common->ports[i].qos.iet.preemptible_tcs;
>> +
>> +	val = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
>> +
>> +	if (common_enable)
>> +		val |= AM65_CPSW_CTL_IET_EN;
>> +	else
>> +		val &= ~AM65_CPSW_CTL_IET_EN;
>> +
>> +	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
>> +	common->iet_enabled = common_enable;
>> +}
> 
> I see that IET_ENABLE is global to the switch. I wonder what it controls
> exactly, since there's also a port-level IET_PORT_EN below.
> 
> Our interpretations (likely speculative both) seem to differ on how this
> should be set. Let me just say a few words about the UAPI
> (Documentation/networking/ethtool-netlink.rst and "man ethtool" would
> hold the info).
> 
> Verification should succeed regardless of whether there is any preemptible
> TC configured. The pmac-enabled knob (ETHTOOL_A_MM_PMAC_ENABLED) is
> intended to control, among other things, whether the port responds to
> verification frames from the link partner. IOW need pmac-enabled=true on
> a port, before verify-enabled=true on the link partner can work. Also,
> in the UAPI, tx-enabled=true requires pmac-enabled=true within the same
> station.
> 
> The semantically closest hardware bit for pmac-enabled seems to be
> IET_PORT_EN, and tx-enabled seems to correspond to MAC_PENABLE.

After your explanation, now, when I read the documentation again
what you say makes more sense.

> 
> Whereas IET_ENABLE seems to be a global override for all, both RX and TX.
> 
> If I'm correct, you could implicitly set/unset IET_ENABLE depending on
> whether IET_PORT_EN is set on any port, and in turn, set IET_PORT_EN
> based on pmac-enabled.

Thanks for these useful insights. I will fix this as per your suggestion
as it makes more sense. Meanwhile, I'm also waiting for confirmation from TI
on the exact behaviour of these control bits. Hopefully this will lead
to better documentation in the driver code.

> 
>> +
>> +static void am65_cpsw_iet_port_enable(struct am65_cpsw_port *port, bool enable)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
>> +	if (enable)
>> +		val |= AM65_CPSW_PN_CTL_IET_PORT_EN;
>> +	else
>> +		val &= ~AM65_CPSW_PN_CTL_IET_PORT_EN;
>> +
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_CTL);
>> +}
> 
> Not too much documentation on what this does. If it's about being able
> to process preemptible traffic on this port in general, then you are not
> correct in hooking it to tx_enabled.

Got it. I'll hook this up to pmac_enable.

> 
>> +
>> +static void am65_cpsw_iet_mac_penable(struct am65_cpsw_port *port, bool enable)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	if (enable)
>> +		val |= AM65_CPSW_PN_IET_MAC_PENABLE;
>> +	else
>> +		val &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
>> +
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +}
> 
> At least the documentation seems to be clear here that hooking this to
> tx_enabled seems to be the right thing.

Understood.
> 
>> +
>> +static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
>> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
>> +	u32 port_ctrl, cmn_ctrl, iet_ctrl, iet_status, verify_cnt;
>> +	u32 add_frag_size;
>> +
>> +	mutex_lock(&priv->mm_lock);
>> +
>> +	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	cmn_ctrl = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
>> +	port_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
>> +
>> +	state->pmac_enabled = !!(iet_ctrl & AM65_CPSW_PN_IET_MAC_PENABLE);
>> +
>> +	iet_status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
>> +
>> +	if (iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)
>> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
>> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFIED)
>> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
>> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFY_FAIL)
>> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
>> +	else
>> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
>> +
>> +	add_frag_size = AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(iet_ctrl);
>> +	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
>> +	state->rx_min_frag_size = state->tx_min_frag_size;
> 
> This is most likely wrong. You don't want rx_min_frag_size to follow tx_min_frag_size,
> because tx_min_frag_size is settable (by ethtool, openlldp etc) and rx_min_frag_size
> is not (it's an indication of what is the minimum fragment size that the port can receive).
> 
> In fact, the erratum i2208 you've linked to seems to be an RX issue, not
> a TX one. So the correct workaround seems to be to set rx_min_frag_size
> to 124, not to limit tx_min_frag_size as you've done?

Yes, you are correct. Thanks for looking into this in detail.

> 
>> +
>> +	state->tx_enabled = !!(port_ctrl & AM65_CPSW_PN_CTL_IET_PORT_EN);
>> +
>> +	/* FPE active if common IET enabled and verification success or disabled (forced) */
>> +	state->tx_active = state->tx_enabled && !!(cmn_ctrl & AM65_CPSW_CTL_IET_EN) &&
>> +			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
>> +			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
>> +	state->verify_enabled = !(iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY);
>> +
>> +	verify_cnt = AM65_CPSW_PN_MAC_GET_VERIFY_CNT(readl(port->port_base +
>> +							   AM65_CPSW_PN_REG_IET_VERIFY));
>> +	state->verify_time = port->qos.iet.verify_time_ms;
>> +	state->max_verify_time = am65_cpsw_iet_get_verify_timeout_ms(AM65_CPSW_PN_MAC_VERIFY_CNT_MASK,
>> +								     SPEED_1000);
> 
> I guess this should return the verify_timeout_ms for the current speed,
> with a fallback for SPEED_1000 if there's no link. Otherwise it may be
> wrong for other speeds and openlldp may fail trying to set it to the max.
> 

That was my intent but I clearly missed it. Will fix.

>> +
>> +	mutex_unlock(&priv->mm_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>> +			    struct netlink_ext_ack *extack)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
>> +	struct am65_cpsw_iet *iet = &port->qos.iet;
>> +	u32 val, add_frag_size;
>> +	int err;
>> +
>> +	/* Errata i2208: min fragment size cannot be less than 124 */
>> +	if (cfg->tx_min_frag_size < 124) {
>> +		netdev_err(ndev, "tx_min_fragment_size cannot be less than 124\n");
> 
> nitpick: use the extack (if the workaround is correct at all, see above)
> 

Got it.

>> +		return -EINVAL;
>> +	}
>> +
>> +	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
>> +	if (err)
>> +		return err;
>> +
>> +	mutex_lock(&priv->mm_lock);
>> +
>> +	if (cfg->tx_enabled) {
>> +		/* For IET, Change MAX_BLKS */
>> +		if (!iet->original_max_blks)
>> +			iet->original_max_blks = readl(port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
>> +
>> +		writel(AM65_CPSW_PN_TX_RX_MAX_BLKS_IET,
>> +		       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
>> +	} else {
>> +		/* restore MAX_BLKS to default */
>> +		if (iet->original_max_blks) {
>> +			writel(iet->original_max_blks,
>> +			       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
>> +		}
>> +	}
> 
> According to the documentation, it seems necessary to resize the RX FIFO
> based on pmac_enabled, not tx_enabled.

Will fix.

> 
>> +
>> +	am65_cpsw_iet_port_enable(port, cfg->tx_enabled);
>> +	am65_cpsw_iet_mac_penable(port, cfg->tx_enabled);
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
>> +	}
>> +
>> +	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
>> +	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +
>> +	/* verify_timeout_count can only be set at valid link */
>> +	port->qos.iet.verify_time_ms = cfg->verify_time;
>> +
>> +	/* iet common enable/disable */
>> +	am65_cpsw_iet_enable(port->common);
>> +
>> +	/* enable/disable pre-emption based on link status */
>> +	am65_cpsw_iet_commit_preemptible_tcs(port);
>> +
>> +	mutex_unlock(&priv->mm_lock);
>> +
>> +	return 0;
>> +}
>> +
>>  const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
>>  	.begin			= am65_cpsw_ethtool_op_begin,
>>  	.complete		= am65_cpsw_ethtool_op_complete,
>> @@ -743,4 +909,6 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
>>  	.get_eee		= am65_cpsw_get_eee,
>>  	.set_eee		= am65_cpsw_set_eee,
>>  	.nway_reset		= am65_cpsw_nway_reset,
>> +	.get_mm			= am65_cpsw_get_mm,
>> +	.set_mm			= am65_cpsw_set_mm,
>>  };
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index bebcfd5e6b57..b0e2d6773543 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -2160,6 +2160,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
>>  	ndev_priv = netdev_priv(port->ndev);
>>  	ndev_priv->port = port;
>>  	ndev_priv->msg_enable = AM65_CPSW_DEBUG;
>> +	mutex_init(&ndev_priv->mm_lock);
>> +	port->qos.link_speed = SPEED_UNKNOWN;
>>  	SET_NETDEV_DEV(port->ndev, dev);
>>  
>>  	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
>> index bf40c88fbd9b..ede3a7457e9c 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
>> @@ -145,6 +145,7 @@ struct am65_cpsw_common {
>>  	bool			pf_p0_rx_ptype_rrobin;
>>  	struct am65_cpts	*cpts;
>>  	int			est_enabled;
>> +	int			iet_enabled;
>>  
>>  	bool		is_emac_mode;
>>  	u16			br_members;
>> @@ -170,6 +171,10 @@ struct am65_cpsw_ndev_priv {
>>  	struct am65_cpsw_port	*port;
>>  	struct am65_cpsw_ndev_stats __percpu *stats;
>>  	bool offload_fwd_mark;
>> +	/* Serialize access to MAC Merge state between ethtool requests
>> +	 * and link state updates
>> +	 */
>> +	struct mutex		mm_lock;
>>  };
>>  
>>  #define am65_ndev_to_priv(ndev) \
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> index 3a908db6e5b2..ae30d5c79be8 100644
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
>>  #include <linux/time.h>
>>  #include <net/pkt_cls.h>
>>  
>> @@ -15,47 +17,176 @@
>>  #include "am65-cpts.h"
>>  #include "cpsw_ale.h"
>>  
>> -#define AM65_CPSW_REG_CTL			0x004
>> -#define AM65_CPSW_PN_REG_CTL			0x004
>> -#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
>> -#define AM65_CPSW_PN_REG_EST_CTL		0x060
>> -#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
>> -
>> -/* AM65_CPSW_REG_CTL register fields */
>> -#define AM65_CPSW_CTL_EST_EN			BIT(18)
>> -
>> -/* AM65_CPSW_PN_REG_CTL register fields */
>> -#define AM65_CPSW_PN_CTL_EST_PORT_EN		BIT(17)
>> -
>> -/* AM65_CPSW_PN_REG_EST_CTL register fields */
>> -#define AM65_CPSW_PN_EST_ONEBUF			BIT(0)
>> -#define AM65_CPSW_PN_EST_BUFSEL			BIT(1)
>> -#define AM65_CPSW_PN_EST_TS_EN			BIT(2)
>> -#define AM65_CPSW_PN_EST_TS_FIRST		BIT(3)
>> -#define AM65_CPSW_PN_EST_ONEPRI			BIT(4)
>> -#define AM65_CPSW_PN_EST_TS_PRI_MSK		GENMASK(7, 5)
>> -
>> -/* AM65_CPSW_PN_REG_FIFO_STATUS register fields */
>> -#define AM65_CPSW_PN_FST_TX_PRI_ACTIVE_MSK	GENMASK(7, 0)
>> -#define AM65_CPSW_PN_FST_TX_E_MAC_ALLOW_MSK	GENMASK(15, 8)
>> -#define AM65_CPSW_PN_FST_EST_CNT_ERR		BIT(16)
>> -#define AM65_CPSW_PN_FST_EST_ADD_ERR		BIT(17)
>> -#define AM65_CPSW_PN_FST_EST_BUFACT		BIT(18)
>> -
>> -/* EST FETCH COMMAND RAM */
>> -#define AM65_CPSW_FETCH_RAM_CMD_NUM		0x80
>> -#define AM65_CPSW_FETCH_CNT_MSK			GENMASK(21, 8)
>> -#define AM65_CPSW_FETCH_CNT_MAX			(AM65_CPSW_FETCH_CNT_MSK >> 8)
>> -#define AM65_CPSW_FETCH_CNT_OFFSET		8
>> -#define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
>> -#define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
>> -
>>  enum timer_act {
>>  	TACT_PROG,		/* need program timer */
>>  	TACT_NEED_STOP,		/* need stop first */
>>  	TACT_SKIP_PROG,		/* just buffer can be updated */
>>  };
>>  
>> +/* IET */
>> +static int am65_cpsw_iet_set_verify_timeout_count(struct am65_cpsw_port *port)
>> +{
>> +	int link_speed = port->qos.link_speed;
>> +	int verify_time_ms = port->qos.iet.verify_time_ms;
> 
> nitpick: gratuitous reverse xmas tree rule breakage

OK.

> 
>> +	u32 val;
>> +
>> +	if (link_speed == SPEED_UNKNOWN) {
>> +		netdev_err(port->ndev, "%s called without active link\n", __func__);
>> +		return -ENODEV;
>> +	}
> 
> I guess you can use a simple WARN_ON() for code paths like this where it
> is obvious that it can't trigger.

Makes sense.

> 
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
> What indication do you have that you should do this shift?

I got this from an old internal patch. I need to check internally if
this is the right thing to do.

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
>> +unsigned int am65_cpsw_iet_get_verify_timeout_ms(u32 count, int link_speed)
>> +{
>> +	unsigned int timeout_ms;
>> +	u32 val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
>> +
>> +	if (link_speed == SPEED_UNKNOWN)
>> +		return -EINVAL;
>> +
>> +	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
>> +
>> +	timeout_ms = count / val;
>> +
>> +	if (link_speed < SPEED_1000)
>> +		timeout_ms >>= 1;	/* FIXME: Is this correct? */
>> +
>> +	return timeout_ms;
>> +}
>> +
>> +static int am65_cpsw_iet_verify_wait(struct am65_cpsw_port *port)
>> +{
>> +	u32 ctrl, status;
>> +	int try;
>> +
>> +	ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	/* Clear MAC_PENABLE */
>> +	ctrl &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
>> +	writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +
>> +	try = 20;
>> +	do {
>> +		/* Set MAC_PENABLE and Clear MAC_LINKFAIL bit to start Verify. */
>> +		ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +		ctrl &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
>> +		ctrl |= AM65_CPSW_PN_IET_MAC_PENABLE;
>> +		writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +
>> +		msleep(port->qos.iet.verify_time_ms);
>> +
>> +		status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
>> +		if (status & AM65_CPSW_PN_MAC_VERIFIED)
>> +			return 0;
>> +
>> +		if (status & AM65_CPSW_PN_MAC_VERIFY_FAIL) {
>> +			netdev_dbg(port->ndev,
>> +				   "MM MAC verify failed, trying again");
> 
> nitpick: one of the Ms in MM stands for MAC already

OK.
> 
>> +			/* Reset the verify state machine by writing 1
>> +			 * to LINKFAIL and 0 to MAC_PENABLE
>> +			 */
>> +			ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +			ctrl &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
>> +			ctrl |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
>> +			writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +			continue;
>> +		}
>> +
>> +		if (status & AM65_CPSW_PN_MAC_RESPOND_ERR) {
>> +			netdev_err(port->ndev, "MM MAC respond error");
>> +			return -ENODEV;
>> +		}
>> +
>> +		if (status & AM65_CPSW_PN_MAC_VERIFY_ERR) {
>> +			netdev_err(port->ndev, "MM MAC verify error");
>> +			return -ENODEV;
>> +		}
>> +	} while (try-- > 0);
>> +
>> +	netdev_info(port->ndev, "MM MAC verify timeout");
>> +	return -ETIMEDOUT;
> 
> What error messages are you getting here? Timeout or an actual response
> from hardware?

So far just timeout. I must be doing something wrong but I'll figure it
out soon. I have a working reference example from older TI release
so I know the hardware works. Just that it is using private flags
to enable the MM feature.

> 
>> +}
>> +

<snip>

-- 
cheers,
-roger
