Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A62A7A73B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjITHJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjITHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:09:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31CA90
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:09:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942D2C433C8;
        Wed, 20 Sep 2023 07:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695193751;
        bh=NQsmncYKZ6Bvzvqjwb0lz1WJq9j9DPdUwVIN26wMP4M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZdPPwKMCr3tNw51hiNGxLF3uEZP0Yr7jvRX5wH+9t8Br2XHowgxEq5BiZZfuByAoj
         nttmdqzmTP14T/VTgR51pknSbUvTNBjjlBTTP3k+Qo+oAKClIklRzKo+DJ7ARdVUyh
         gXNefo61/hZ5HmF3EibgcRKDQs015B/lHDJPYM0ZUtXGQdd4ozeI7k5vpUk7U3tLRA
         cWxHY8uCW0NGyA5i0Qm6THjMaTqBsmrWtoOF6AKE+CnVH+fml4+FBFEo9bF3bgh+13
         QEG3O4veED6JhGu68srMKnfIO4DvIrR8IBAJX4QsfhXFL/lpDjHN4EqMhGJDYHsrkH
         SLfYkT20Apo6g==
Message-ID: <7c05ec2c-fe13-5324-f537-4f12697d1566@kernel.org>
Date:   Wed, 20 Sep 2023 10:09:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload
 in channel mode
To:     Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, vladimir.oltean@nxp.com
Cc:     horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.rog
References: <20230918075358.5878-1-rogerq@kernel.org>
 <ba0063d31a926b1775fe98e56b15976b4d8726cd.camel@redhat.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ba0063d31a926b1775fe98e56b15976b4d8726cd.camel@redhat.com>
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

Hi Paolo,

On 19/09/2023 14:32, Paolo Abeni wrote:
> On Mon, 2023-09-18 at 10:53 +0300, Roger Quadros wrote:
>> @@ -937,3 +918,296 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
>>  		       host->port_base + AM65_CPSW_PN_REG_PRI_CIR(tx_ch));
> 
> [...]
> 
>> +static int am65_cpsw_mqprio_verify_shaper(struct am65_cpsw_port *port,
>> +					  struct tc_mqprio_qopt_offload *mqprio)
>> +{
>> +	u64 min_rate_total = 0, max_rate_total = 0;
>> +	u32 min_rate_msk = 0, max_rate_msk = 0;
>> +	bool has_min_rate, has_max_rate;
>> +	int num_tc, i;
>> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
>> +	struct netlink_ext_ack *extack = mqprio->extack;
> 
> Please, respect the reverse x-mas tree order.
> 
>> +
>> +	if (!(mqprio->flags & TC_MQPRIO_F_SHAPER))
>> +		return 0;
>> +
>> +	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE)
>> +		return 0;
>> +
>> +	has_min_rate = !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
>> +	has_max_rate = !!(mqprio->flags & TC_MQPRIO_F_MAX_RATE);
>> +
>> +	if (!has_min_rate && has_max_rate) {
>> +		NL_SET_ERR_MSG_MOD(extack, "min_rate is required with max_rate");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (!has_min_rate)
>> +		return 0;
>> +
>> +	num_tc = mqprio->qopt.num_tc;
>> +
>> +	for (i = num_tc - 1; i >= 0; i--) {
>> +		u32 ch_msk;
>> +
>> +		if (mqprio->min_rate[i])
>> +			min_rate_msk |= BIT(i);
>> +		min_rate_total +=  mqprio->min_rate[i];
>> +
>> +		if (has_max_rate) {
>> +			if (mqprio->max_rate[i])
>> +				max_rate_msk |= BIT(i);
>> +			max_rate_total +=  mqprio->max_rate[i];
>> +
>> +			if (!mqprio->min_rate[i] && mqprio->max_rate[i]) {
>> +				NL_SET_ERR_MSG_FMT_MOD(extack,
>> +						       "TX tc%d rate max>0 but min=0\n",
>> +						       i);
>> +				return -EINVAL;
>> +			}
>> +
>> +			if (mqprio->max_rate[i] &&
>> +			    mqprio->max_rate[i] < mqprio->min_rate[i]) {
>> +				NL_SET_ERR_MSG_FMT_MOD(extack,
>> +						       "TX tc%d rate min(%llu)>max(%llu)\n",
>> +						       i, mqprio->min_rate[i],
>> +						       mqprio->max_rate[i]);
>> +				return -EINVAL;
>> +			}
>> +		}
>> +
>> +		ch_msk = GENMASK(num_tc - 1, i);
>> +		if ((min_rate_msk & BIT(i)) && (min_rate_msk ^ ch_msk)) {
>> +			NL_SET_ERR_MSG_FMT_MOD(extack,
>> +					       "TX min rate limiting has to be enabled sequentially hi->lo tx_rate_msk%x\n",
>> +					       min_rate_msk);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if ((max_rate_msk & BIT(i)) && (max_rate_msk ^ ch_msk)) {
>> +			NL_SET_ERR_MSG_FMT_MOD(extack,
>> +					       "TX max rate limiting has to be enabled sequentially hi->lo tx_rate_msk%x\n",
>> +					       max_rate_msk);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	min_rate_total *= 8;
>> +	min_rate_total /= 1000 * 1000;
>> +	max_rate_total *= 8;
>> +	max_rate_total /= 1000 * 1000;
> 
> For consistency with other code doing the same algebra, you could use a
> single statement for both '*' and '/'. You could also add an helper for
> that conversion, as there are multiple use-case already.
> 
>> +
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
>> +
>> +	p_mqprio->shaper_en = 1;
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
> No need to wrap the above statement on multiple lines.
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
>> +
>> +	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio);
>> +	if (ret)
>> +		goto exit_put;
>> +
>> +	netdev_set_num_tc(ndev, num_tc);
>> +
>> +	/* Multiple Linux priorities can map to a Traffic Class
>> +	 * A Traffic Class can have multiple contiguous Queues,
>> +	 * Queues get mapped to Channels (thread_id),
>> +	 *	if not VLAN tagged, thread_id is used as packet_priority
>> +	 *	if VLAN tagged. VLAN priority is used as packet_priorit
>> +	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
>> +	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
>> +	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
>> +	 * assume that Queue_n gets mapped to header_priority_n. We can then
>> +	 * set the switch priority in pn_tx_pri_map.
>> +	 */
>> +
>> +	for (tc = 0; tc < num_tc; tc++) {
>> +	 /* For simplicity we assign the same priority (TCn) to all queues
>> +	  * of a Traffic Class.
>> +	  */
> 
> Please align the comment with the relevant code.
> 
> [...]
> 
>> +diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
>> index 0cc2a3b3d7f9..5431fbf8b6e0 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
>> @@ -9,6 +9,7 @@
>>  #include <net/pkt_sched.h>
>>  
>>  struct am65_cpsw_common;
>> +struct am65_cpsw_port;
>>  
>>  struct am65_cpsw_est {
>>  	int buf;
>> @@ -16,6 +17,12 @@ struct am65_cpsw_est {
>>  	struct tc_taprio_qopt_offload taprio;
>>  };
>>  
>> +struct am65_cpsw_mqprio {
>> +	struct tc_mqprio_qopt_offload mqprio_hw;
>> +	u64 max_rate_total;
>> +	unsigned shaper_en:1;
> 
> Perhaps 'bool' instead?

Thanks for the review. I'll fix them in next revision.

-- 
cheers,
-roger
