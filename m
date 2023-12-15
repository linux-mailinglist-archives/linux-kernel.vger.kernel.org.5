Return-Path: <linux-kernel+bounces-843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7402F8146F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3092028490D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31D250E2;
	Fri, 15 Dec 2023 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seAHtX7i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30525567;
	Fri, 15 Dec 2023 11:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4AFC433C7;
	Fri, 15 Dec 2023 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702639883;
	bh=pA1gr9Bflwbt7y/03Z8QTnJ7HktkF26TUzAoqDrKfvk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=seAHtX7iAdUkz7Afto7ORe1lHmCgc0vX2TLHV87keSCBoisumXVj//W9e7fISQwNU
	 XEef+rv2He4Kk+ggYf/PDZ2GiYPXg8OLcHzcIG0nEqbDq8BgaZzyM6XBAbJzEuCWl+
	 hE/k55TjD46KqIAmvWUT11exzJmveK8ciXGtYru3yxG49S0MTzzvJjpE30TID1Pf1C
	 0PM4/oE/WUAhwRf+v3u4RjkG/A52SmYdomqJumoBEJv+1ASEPCFz9AS9pfJ/E7gbzK
	 G1bYKMx5MKN7wEyyBjGB3b290niR6ZFDUBVmyqo9dkQ4G5mu32u8ftjbv96Qp+s4er
	 LM0sIQSa7oFGQ==
Message-ID: <bfdc924c-ef11-48df-a097-b252bcbe17e1@kernel.org>
Date: Fri, 15 Dec 2023 13:31:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 11/11] net: ethernet: ti: am65-cpsw: Fix
 get_eth_mac_stats
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
 p-varis@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-12-rogerq@kernel.org>
 <20231213135435.czao6wjighpskcvz@skbuf>
 <e637fe93-692d-48b1-9cb9-11719f8c90c3@kernel.org>
In-Reply-To: <e637fe93-692d-48b1-9cb9-11719f8c90c3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/12/2023 12:04, Roger Quadros wrote:
> 
> 
> On 13/12/2023 15:54, Vladimir Oltean wrote:
>> On Wed, Dec 13, 2023 at 01:07:21PM +0200, Roger Quadros wrote:
>>> We do not support individual stats for PMAC and EMAC so
>>> report only aggregate stats.
>>>
>>> Fixes: 67372d7a85fc ("net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool")
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> Changelog:
>>>
>>> v8: initial commit
>>>
>>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>>> index d2baffb05d55..35e318458b0c 100644
>>> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>>> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
>>> @@ -671,6 +671,9 @@ static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
>>>  
>>>  	stats = port->stat_base;
>>>  
>>> +	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
>>> +		return;
>>> +
>>>  	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
>>>  	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
>>>  	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
>>> -- 
>>> 2.34.1
>>>
>>
>> Fixes are only fixes if they address a visible issue. And the blamed
>> commit is the one that made the issue visible - the same one that
>> "git bisect" would lead to - not necessarily the commit that introduced
>> the code being changed.
>>
>> If you look at net/ethtool/stats.c, it will only accept ETHTOOL_MAC_STATS_SRC_AGGREGATE
>> for drivers that don't support the MAC Merge layer.
>>
>> 	if ((src == ETHTOOL_MAC_STATS_SRC_EMAC ||
>> 	     src == ETHTOOL_MAC_STATS_SRC_PMAC) &&
>> 	    !__ethtool_dev_mm_supported(dev)) {
>> 		NL_SET_ERR_MSG_MOD(info->extack,
>> 				   "Device does not support MAC merge layer");
>> 		ethnl_ops_complete(dev);
>> 		return -EOPNOTSUPP;
>> 	}
> 
> Got it.
> 
>>
>> So, there was nothing broken in commit 67372d7a85fc ("net: ethernet:
>> am65-cpsw: Add standard Ethernet MAC stats to ethtool").
>>
>> The first broken commit is when you add support for get_mm(), such that
>> __ethtool_dev_mm_supported() returns true.
>>
>> And because you don't add bugs in the code just to fix them later in the
>> series, you need to order the patches such that all the dependencies for
>> get_mm() are in place before the get_mm() support is added.
>>
>> Translated to your case, this patch must not be 11/11, and it must have
>> the Fixes: tag dropped, and it must explain in the commit message that
>> it is preparatory work.
> 
> OK. I take care of this in next spin. Thanks.

Just a heads up. I have decided to merge this patch with mac-merge patch.
One less patch to deal with ;).

-- 
cheers,
-roger

