Return-Path: <linux-kernel+bounces-160146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D888B39D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911791C21F73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D723414884A;
	Fri, 26 Apr 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDd5wni6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4213C9A3;
	Fri, 26 Apr 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141525; cv=none; b=p4H1qD/Ytott9NoQrOYT7NRTkcxl2KJTXkncSK6ZIn4GFX/tdZ8t3Y2l/iFeL+cNQiZNBsFB34/Hbu30Lr6gSKdITp50qvQk/h3uFdCX8UpN4t6xzpcUEYM9M/2AlU4r0F3MSZ5hqxRYkkjR45+pcwOnoMnLCPGMV0wF+24emFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141525; c=relaxed/simple;
	bh=YMyr1veMwYdXQZ/gIClEaA9DHhm0jkElEaC61WPYtzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJK4jwASrB0uN/k5G5ZPjqlMI0uVTzlM+8dcQRYYhLqTPwwAZe7b1PotPIFxLcyzHaPUfWda8NFsGWCwCZntaPWjemcBpDpOqgbHyjogiFmjmdTY78fTY3zYYe1vvnIis53MUPUOh01hvRUVbZUFIUX7dvr63LnIJRwgaVxkuGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDd5wni6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C88C113CD;
	Fri, 26 Apr 2024 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141524;
	bh=YMyr1veMwYdXQZ/gIClEaA9DHhm0jkElEaC61WPYtzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDd5wni64oD43gUkHMkhBdzC0KaNgvJGP6fdIUGxGE3DICubbaTO645EvcB+yelX5
	 acaQzUXZialzH8rHUfFSR7fP70M0jviJFiErQ3eZvUHZs3NZC1FkHj6cG8kOPsYfzD
	 aSpWb2CvKiBQ23epnR/BD1CML+V7WQ0K9sCz4Qbss4ekZXDquV6Plpw5IylxhHmRoP
	 2v5ldZMRvomRW2es39uwOIEQagkUOSfw0i0VRzC9SsbFAF6xNI9CjaCYEBT583JcS4
	 8YIBQh1dShJpvZgGCeZFLORPz92V15w7Xl1o6LpaclhMINZmIlWa5IUC6BK75MDAZB
	 x7lWLYhK04sWA==
Date: Fri, 26 Apr 2024 15:25:19 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 5/7] net: hns3: using user configure after
 hardware reset
Message-ID: <20240426142519.GA513047@kernel.org>
References: <20240426100045.1631295-1-shaojijie@huawei.com>
 <20240426100045.1631295-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426100045.1631295-6-shaojijie@huawei.com>

On Fri, Apr 26, 2024 at 06:00:43PM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> When a reset occurring, it's supposed to recover user's configuration.
> Currently, the port info(speed, duplex and autoneg) is stored in hclge_mac
> and will be scheduled updated. Consider the case that reset was happened
> consecutively. During the first reset, the port info is configured with
> a temporary value cause the PHY is reset and looking for best link config.
> Second reset start and use pervious configuration which is not the user's.
> The specific process is as follows:
> 
> +------+               +----+                +----+
> | USER |               | PF |                | HW |
> +---+--+               +-+--+                +-+--+
>     |  ethtool --reset   |                     |
>     +------------------->|    reset command    |
>     |  ethtool --reset   +-------------------->|
>     +------------------->|                     +---+
>     |                    +---+                 |   |
>     |                    |   |reset currently  |   | HW RESET
>     |                    |   |and wait to do   |   |
>     |                    |<--+                 |   |
>     |                    | send pervious cfg   |<--+
>     |                    | (1000M FULL AN_ON)  |
>     |                    +-------------------->|
>     |                    | read cfg(time task) |
>     |                    | (10M HALF AN_OFF)   +---+
>     |                    |<--------------------+   | cfg take effect
>     |                    |    reset command    |<--+
>     |                    +-------------------->|
>     |                    |                     +---+
>     |                    | send pervious cfg   |   | HW RESET
>     |                    | (10M HALF AN_OFF)   |<--+
>     |                    +-------------------->|
>     |                    | read cfg(time task) |
>     |                    |  (10M HALF AN_OFF)  +---+
>     |                    |<--------------------+   | cfg take effect
>     |                    |                     |   |
>     |                    | read cfg(time task) |<--+
>     |                    |  (10M HALF AN_OFF)  |
>     |                    |<--------------------+
>     |                    |                     |
>     v                    v                     v
> 
> To avoid aboved situation, this patch introduced req_speed, req_duplex,
> req_autoneg to store user's configuration and it only be used after
> hardware reset and to recover user's configuration

Hi Peiyang Wang and Jijie Shao,

In reviewing this patch it would be helpful if the diagram above could be
related to driver code.  I'm sure it is obvious enough, but I'm having a
bit of trouble.  F.e., is it hclge_tp_port_init() where "port info is
configured with a temporary value cause the PHY is reset and looking for
best link config." ?

> 
> Fixes: f5f2b3e4dcc0 ("net: hns3: add support for imp-controlled PHYs")
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 15 +++++++++------
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h   |  3 +++
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index 6eda73f1e6ad..5dc8593c97be 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -1537,6 +1537,9 @@ static int hclge_configure(struct hclge_dev *hdev)
>  			cfg.default_speed, ret);
>  		return ret;
>  	}
> +	hdev->hw.mac.req_speed = hdev->hw.mac.speed;
> +	hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
> +	hdev->hw.mac.req_duplex = DUPLEX_FULL;

I am curious to know why the initialisation of req_autoneg and req_duplex
is not:

	hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
	hdev->hw.mac.req_duplex = hdev->hw.mac.duplex

As it seems to me the value .autoneg is 0 (AUTONEG_DISABLE)
and the value of .duplex is 0 (DUPLEX_HALF).

>  	hclge_parse_link_mode(hdev, cfg.speed_ability);
>  
> @@ -3344,9 +3347,9 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
>  		return ret;
>  	}
>  
> -	hdev->hw.mac.autoneg = cmd->base.autoneg;
> -	hdev->hw.mac.speed = cmd->base.speed;
> -	hdev->hw.mac.duplex = cmd->base.duplex;
> +	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
> +	hdev->hw.mac.req_speed = cmd->base.speed;
> +	hdev->hw.mac.req_duplex = cmd->base.duplex;
>  	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
>  
>  	return 0;
> @@ -3364,9 +3367,9 @@ static int hclge_update_tp_port_info(struct hclge_dev *hdev)
>  	if (ret)
>  		return ret;
>  
> -	hdev->hw.mac.autoneg = cmd.base.autoneg;
> -	hdev->hw.mac.speed = cmd.base.speed;
> -	hdev->hw.mac.duplex = cmd.base.duplex;
> +	cmd.base.autoneg = hdev->hw.mac.req_autoneg;
> +	cmd.base.speed = hdev->hw.mac.req_speed;
> +	cmd.base.duplex = hdev->hw.mac.req_duplex;

It is unclear to me why fields of cmd are set here, cmd is a local variable
and they don't seem to be used for the rest of the function.

>  	linkmode_copy(hdev->hw.mac.advertising, cmd.link_modes.advertising);
>  
>  	return 0;

..

