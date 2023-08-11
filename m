Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A08777932A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbjHKPcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjHKPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BA330CA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F09B766180
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD266C433C8;
        Fri, 11 Aug 2023 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691767967;
        bh=8nt9DTFqGIU4xkjW653vHfuilV4mMlbe76FwKDCFnK8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E3Ets5VjHBo2BMsplQol40tRgn91TgXVibqUuahKKPmjALG2/onhb+31vxyG2cnyC
         NpMyX8gXi47s4ru/SyuOaanYwmwP0whvEr0LDHfrF3etUL99SQx86rCTs3vf6RoyR/
         0Pr+o7vw4t1oBTuc14+JGcj4Y/rWRl+WDE2pOSbYqQxFpt9zBIeQFVTqz4xHx7pGjr
         9bLVmeOyyZXIywmi0aTFcoLsQmeIk0LVBGbH1YF2cw5vz/LkZmxwpRdYQ1ue9MJG5g
         kIGQbVNXS3m9pa9BBWGD/OGRMLSS7tl5x1uT7BZwXeel7JFYNcXD1K+BXVsAUzhfR5
         TlS4kYDeXN0Lw==
Message-ID: <a8a47866-ba29-9d5b-459d-ecdb2e89935c@kernel.org>
Date:   Fri, 11 Aug 2023 18:32:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption
 MAC Merge support
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
        srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230810152538.138718-1-rogerq@kernel.org>
 <ZNYDZkjuFjF7n3VV@vergenet.net>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ZNYDZkjuFjF7n3VV@vergenet.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 11/08/2023 12:46, Simon Horman wrote:
> On Thu, Aug 10, 2023 at 06:25:38PM +0300, Roger Quadros wrote:
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
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> 
> Hi Roger,
> 
> some minor feedback from my side.
> 
> ...
> 
>> +static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
>> +{
>> +	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
>> +	u32 port_ctrl, cmn_ctrl, iet_ctrl, iet_status, verify_cnt;
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
>> +	u32 add_frag_size;
>> +
>> +	mutex_lock(&priv->mm_lock);
>> +
>> +	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +	cmn_ctrl = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
> 
> cmn_ctrl appears to be set but not used.
> Is this intentional?

No. It is stale code.
> 
>> +	port_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
>> +
>> +	state->tx_enabled = !!(iet_ctrl & AM65_CPSW_PN_IET_MAC_PENABLE);
>> +	state->pmac_enabled = !!(port_ctrl & AM65_CPSW_PN_CTL_IET_PORT_EN);
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
>> +
>> +	/* Errata i2208: RX min fragment size cannot be less than 124 */
>> +	state->rx_min_frag_size = 124;
>> +
>> +	/* FPE active if common tx_enabled and verification success or disabled (forced) */
>> +	state->tx_active = state->tx_enabled &&
>> +			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
>> +			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
>> +	state->verify_enabled = !(iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY);
>> +
>> +	verify_cnt = AM65_CPSW_PN_MAC_GET_VERIFY_CNT(readl(port->port_base +
>> +							   AM65_CPSW_PN_REG_IET_VERIFY));
> 
> Likewise, verify_cnt appears to be set but not used.

Will remove it.
> 
>> +	state->verify_time = port->qos.iet.verify_time_ms;
>> +	state->max_verify_time = am65_cpsw_iet_get_verify_timeout_ms(AM65_CPSW_PN_MAC_VERIFY_CNT_MASK,
>> +								     port);
>> +	mutex_unlock(&priv->mm_lock);
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
> 
> nit: should this function be static?
> 
>> +{
>> +	port->qos.iet.preemptible_tcs = preemptible_tcs;
>> +	am65_cpsw_iet_commit_preemptible_tcs(port);
>> +}
>> +
>> +void am65_cpsw_iet_link_state_update(struct net_device *ndev)
> 
> Ditto

Yes, both need to be static.
Thanks for review!

-- 
cheers,
-roger
