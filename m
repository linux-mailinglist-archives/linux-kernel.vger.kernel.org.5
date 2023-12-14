Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20AA812C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443516AbjLNKEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443478AbjLNKEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:04:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CC291
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:04:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93319C433C8;
        Thu, 14 Dec 2023 10:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702548281;
        bh=5xiTNTnoHneS2djHnlvMPZzDBmc5bGUzo0jg6374Fxo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UMtkVzAnKFo0CO1904K8hr7NxZXtrJi+X8XnY6B+vZE62FHOEYWxv8V2H24vnQCOe
         rFy6JR8GCg7l2se6T/H1n3FPkDFg2viYa4z2OyC7XASwD4dd/xGsDwxdx4ZYYk3X5D
         B53+Rl3NJtRgvTA4d+J0TeZiDD9y0KVVN+9tnAdCz8AmjnoZxK1ntwtGYu+x0us3ji
         kDc0H4Aru5E/5RtE/oe4fplpjXV6fRpMp84kwrgxcVuEgfWA1gfYoNSsDUDj6VOlj9
         8K5RrV+VU8S1S+lhhdYFrjzYIPX/XxKOVDMJunnaz6UNFvJDwSHIwqkClz5CXoQG/Y
         iecA+OqKv/B8g==
Message-ID: <e637fe93-692d-48b1-9cb9-11719f8c90c3@kernel.org>
Date:   Thu, 14 Dec 2023 12:04:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 11/11] net: ethernet: ti: am65-cpsw: Fix
 get_eth_mac_stats
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-12-rogerq@kernel.org>
 <20231213135435.czao6wjighpskcvz@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231213135435.czao6wjighpskcvz@skbuf>
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



On 13/12/2023 15:54, Vladimir Oltean wrote:
> On Wed, Dec 13, 2023 at 01:07:21PM +0200, Roger Quadros wrote:
>> We do not support individual stats for PMAC and EMAC so
>> report only aggregate stats.
>>
>> Fixes: 67372d7a85fc ("net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool")
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> Changelog:
>>
>> v8: initial commit
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> index d2baffb05d55..35e318458b0c 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>> @@ -671,6 +671,9 @@ static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
>>  
>>  	stats = port->stat_base;
>>  
>> +	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
>> +		return;
>> +
>>  	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
>>  	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
>>  	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
>> -- 
>> 2.34.1
>>
> 
> Fixes are only fixes if they address a visible issue. And the blamed
> commit is the one that made the issue visible - the same one that
> "git bisect" would lead to - not necessarily the commit that introduced
> the code being changed.
> 
> If you look at net/ethtool/stats.c, it will only accept ETHTOOL_MAC_STATS_SRC_AGGREGATE
> for drivers that don't support the MAC Merge layer.
> 
> 	if ((src == ETHTOOL_MAC_STATS_SRC_EMAC ||
> 	     src == ETHTOOL_MAC_STATS_SRC_PMAC) &&
> 	    !__ethtool_dev_mm_supported(dev)) {
> 		NL_SET_ERR_MSG_MOD(info->extack,
> 				   "Device does not support MAC merge layer");
> 		ethnl_ops_complete(dev);
> 		return -EOPNOTSUPP;
> 	}

Got it.

> 
> So, there was nothing broken in commit 67372d7a85fc ("net: ethernet:
> am65-cpsw: Add standard Ethernet MAC stats to ethtool").
> 
> The first broken commit is when you add support for get_mm(), such that
> __ethtool_dev_mm_supported() returns true.
> 
> And because you don't add bugs in the code just to fix them later in the
> series, you need to order the patches such that all the dependencies for
> get_mm() are in place before the get_mm() support is added.
> 
> Translated to your case, this patch must not be 11/11, and it must have
> the Fixes: tag dropped, and it must explain in the commit message that
> it is preparatory work.

OK. I take care of this in next spin. Thanks.
> 
> --
> pw-bot: changes-requested

-- 
cheers,
-roger
