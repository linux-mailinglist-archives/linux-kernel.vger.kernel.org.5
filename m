Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C67E8F5B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjKLJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:41:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95462D51;
        Sun, 12 Nov 2023 01:41:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17725C433C7;
        Sun, 12 Nov 2023 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699782085;
        bh=QbWO5jczDTWfiCBuWGRjNrmWNSsp8db3vx0cMyEInsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umeAOQNvYTTSjOARLRDC8O83rwJGdTlNbnWGhFv+AtM1FcY6KDGpu0ebt34mXyMgs
         mzx0rO291VsLcpjMPdY/+qqpyqcHiwVs4driFi4ruXjHDBpqdNxdN5x8odw4LgZ9el
         fAov68D2HIVZOwkG774JqCWgLv+hs4uA90uvqXzRa/fP023WJEH1imsbh8e4KzmJ6L
         +AVidXc0e1g+uBfpun3DIuvUPzzxkHSHSmjdtn6AXbxcCD719eeFnIGQPofdh1WPE3
         EIipNt01pq8UELRHjoKHEcBADsVRNSUSeM5S0Jy+TbrU3pKVX5K8BkYRXVenpiGCI7
         yQivqWp6ApWqw==
Date:   Sun, 12 Nov 2023 09:41:15 +0000
From:   Simon Horman <horms@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net,v4, 2/3] hv_netvsc: Fix race of
 register_netdevice_notifier and VF register
Message-ID: <20231112094115.GE705326@kernel.org>
References: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
 <1699627140-28003-3-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699627140-28003-3-git-send-email-haiyangz@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 06:38:59AM -0800, Haiyang Zhang wrote:
> If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
> but NETDEV_POST_INIT is not.
> 
> Move register_netdevice_notifier() earlier, so the call back
> function is set before probing.
> 
> Cc: stable@vger.kernel.org
> Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> ---
> v3:
>   Divide it into two patches, suggested by Jakub Kicinski.
> v2:
>   Fix rtnl_unlock() in error handling as found by Wojciech Drewek.
> ---
>  drivers/net/hyperv/netvsc_drv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 5e528a76f5f5..1d1491da303b 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2793,11 +2793,14 @@ static int __init netvsc_drv_init(void)
>  	}
>  	netvsc_ring_bytes = ring_size * PAGE_SIZE;
>  
> +	register_netdevice_notifier(&netvsc_netdev_notifier);
> +
>  	ret = vmbus_driver_register(&netvsc_drv);
> -	if (ret)
> +	if (ret) {
> +		unregister_netdevice_notifier(&netvsc_netdev_notifier);
>  		return ret;
> +	}
>  
> -	register_netdevice_notifier(&netvsc_netdev_notifier);
>  	return 0;
>  }

Hi Haiyang Zhang,

functionally this change looks good to me, thanks!

I'm wondering if we could improve things slightly by using a more idiomatic
form for the error path. Something like the following (completely untested!).

My reasoning is that this way things are less likely go to wrong if more
error conditions are added to this function later.

	...

	register_netdevice_notifier(&netvsc_netdev_notifier);

	ret = vmbus_driver_register(&netvsc_drv);
	if (ret)
		goto err_unregister_netdevice_notifier;

	return 0;

err_unregister_netdevice_notifier:
	unregister_netdevice_notifier(&netvsc_netdev_notifier);
	return ret;
}

