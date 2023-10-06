Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED61C7BB78D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjJFM2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJFM2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:28:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C96CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:28:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312EDC433C7;
        Fri,  6 Oct 2023 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696595297;
        bh=3SAB/z4JQ4yxIUvay/XIvVc0hYSL/L+0t04LAbPkpLk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WPDPrQ9+pRgzQfUM0f3fFkybB7R/kGWvExeuUXVpngubEpgHTnWMQb4rVb9tP+ycF
         oItjTvm8E6AsrpKfvQVvlFwQDKjqczh/KzYSw5jlwd11vR+E8m8YBKb9ibvgkFcck7
         lQteEFVfKoH+wpZXut06j4jpEPYHSeaFGahTYyqeqFpDgCIwzK1hjaRTJsna4HJCyn
         m6f6zvVO8XVwLn+KJ8uoSAykfCgSy+Bocz6WGQbGmln35r9fG0dU20R5OgWthwMxRy
         /90WvZrhMPr+QXc0Qn+xycU0S+4jgplvxN45zloqlpqBbMcHKrAu3FZ+6yddfSaSY0
         Xflvv0YmEq7pQ==
Message-ID: <f6eb4bfc-e8f5-491b-8b3b-4cb9eed79483@kernel.org>
Date:   Fri, 6 Oct 2023 15:28:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 2/4] net: ethernet: ti: am65-cpsw: add mqprio
 qdisc offload in channel mode
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
        srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230927072741.21221-1-rogerq@kernel.org>
 <20230927072741.21221-3-rogerq@kernel.org>
 <20231001065554.GH92317@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231001065554.GH92317@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/10/2023 09:55, Simon Horman wrote:
> On Wed, Sep 27, 2023 at 10:27:39AM +0300, Roger Quadros wrote:
> 
> ...
> 
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
>> +	ret = pm_runtime_get_sync(common->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(common->dev);
>> +		return ret;
>> +	}
>> +
>> +	if (!num_tc) {
>> +		am65_cpsw_reset_tc_mqprio(ndev);
>> +		goto exit_put;am65_cpsw_iet_commit_preemptible_tcs
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
> 
> Hi,
> 
> I don't think it is worth respinning just because of this, but
> there seems to be a 'y' missing from the end of the line above.

Now that there will be  a re-spin. I'll fix this. Thanks!

> 
>> +	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
>> +	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
>> +	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
>> +	 * assume that Queue_n gets mapped to header_priority_n. We can then
>> +	 * set the switch priority in pn_tx_pri_map.
>> +	 */
> 
> ...

-- 
cheers,
-roger
