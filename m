Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5417A73D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjITHT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjITHTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:19:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E6FCA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:19:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37707C433C7;
        Wed, 20 Sep 2023 07:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695194358;
        bh=WyO9M//XrozD9V7TnomV/MSTgBlPqTOV4kfhlkxyjSU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U+YO+seSaVhGE61tbw7daKIcwHsvtGx6VsQenbdtEZ77Rmrr0voTBoP7zvXToLX5p
         8h8qn6gk0nul2EC9kuw8FTVswGOmVSVqIkK+rW9n8MTh7YQWlEjVNdVxcxmHCUAWY3
         gHyLknMIgdQQP+Lu9GQQT0riUjYtZ6X5LfOJPq5uiUbtCzxkIPS/h4fmUaCO+NBq6E
         hCtyMJxOABL4mwaJX6HXJLxbgRg6yDuiCBrayvBkdDPuypU5P0lDwc6SlHs7EhbVyl
         uLq6ZqbALxmJiC1qzwR/gq0ZLWpCXlVkomuyrLntgNIkEVYmpGTdP6ZyLb5praUKFy
         3tXT1Dw2+aMiA==
Message-ID: <79bd4b5b-7ea8-4a3b-d098-9aecd43b1675@kernel.org>
Date:   Wed, 20 Sep 2023 10:19:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload
 in channel mode
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, s-vadapalli@ti.com,
        srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rogerq@kernel.rog
References: <20230918075358.5878-1-rogerq@kernel.org>
 <20230918075358.5878-1-rogerq@kernel.org>
 <20230919124703.hj2bvqeogfhv36qy@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230919124703.hj2bvqeogfhv36qy@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On 19/09/2023 15:47, Vladimir Oltean wrote:
> Hi Roger,
> 
> On Mon, Sep 18, 2023 at 10:53:58AM +0300, Roger Quadros wrote:
>> -int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>> -			       void *type_data)
>> -{
>> -	switch (type) {
>> -	case TC_QUERY_CAPS:
>> -		return am65_cpsw_tc_query_caps(ndev, type_data);
>> -	case TC_SETUP_QDISC_TAPRIO:
>> -		return am65_cpsw_setup_taprio(ndev, type_data);
>> -	case TC_SETUP_BLOCK:
>> -		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
>> -	default:
>> -		return -EOPNOTSUPP;
>> -	}
>> -}
>> -
>> -void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
>> -{
>> -	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> -
>> -	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>> -		return;
>> -
>> -	am65_cpsw_est_link_up(ndev, link_speed);
>> -	port->qos.link_down_time = 0;
>> -}
>> -
>> -void am65_cpsw_qos_link_down(struct net_device *ndev)
>> -{
>> -	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> -
>> -	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>> -		return;
>> -
>> -	if (!port->qos.link_down_time)
>> -		port->qos.link_down_time = ktime_get();
>> -
>> -	port->qos.link_speed = SPEED_UNKNOWN;
>> -}
>> -
> 
> Could you split the code movement to a separate change?

OK.

> 
>> +	if (port->qos.link_speed != SPEED_UNKNOWN) {
>> +		if (min_rate_total > port->qos.link_speed) {
>> +			NL_SET_ERR_MSG_FMT_MOD(extack, "TX rate min %llu exceeds link speed %d\n",
>> +					       min_rate_total, port->qos.link_speed);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (max_rate_total > port->qos.link_speed) {
>> +			NL_SET_ERR_MSG_FMT_MOD(extack, "TX rate max %llu exceeds link speed %d\n",
>> +					       max_rate_total, port->qos.link_speed);
>> +			return -EINVAL;
>> +		}
>> +	}
> 
> Link speeds can be renegotiated, and the mqprio offload can be installed
> while the link is down. So this restriction, while honorable, has limited
> usefulness.

For link down case it won't run those checks, but I get your point.
I'll drop these checks.

> 
>> +
>> +	p_mqprio->shaper_en = 1;
> 
> s/1/true/
> 
>> +	p_mqprio->max_rate_total = max_t(u64, min_rate_total, max_rate_total);
>> +
>> +	return 0;
>> +}
>> +
>> +static void am65_cpsw_reset_tc_mqprio(struct net_device *ndev)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
>> +	struct am65_cpsw_common *common = port->common;
>> +
>> +	p_mqprio->shaper_en = 0;
> 
> s/0/false/
> 
>> +	p_mqprio->max_rate_total = 0;
>> +
>> +	am65_cpsw_tx_pn_shaper_reset(port);
>> +	netdev_reset_tc(ndev);
>> +	netif_set_real_num_tx_queues(ndev, common->tx_ch_num);
>> +
>> +	/* Reset all Queue priorities to 0 */
>> +	writel(0,
>> +	       port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
> 
> What exactly needs pm_runtime_get_sync()? This writel() doesn't?

Good catch. In my tests, the network interface was up so controller
was already active. But we will need to do a pm_runtime_get_sync()
if all network interfaces of the controller are down.

So, I will need to move the pm_runtime_get_sync() call before
am65_cpsw_reset_tc_mqprio();

> 
>> +}
>> +
>> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
>> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
>> +	struct am65_cpsw_common *common = port->common;
>> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
>> +	int tc, offset, count, ret, prio;
>> +	u8 num_tc = qopt->num_tc;
>> +	u32 tx_prio_map = 0;
>> +	int i;
>> +
>> +	memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
>> +
>> +	if (!num_tc) {
>> +		am65_cpsw_reset_tc_mqprio(ndev);
>> +		return 0;
>> +	}
>> +
>> +	ret = pm_runtime_get_sync(common->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(common->dev);
>> +		return ret;
>> +	}

-- 
cheers,
-roger
