Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4D7E8F62
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjKLJpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:45:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F332D77;
        Sun, 12 Nov 2023 01:45:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C05C433C7;
        Sun, 12 Nov 2023 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699782334;
        bh=OB/TnIUPp8h8xH68B7wjC4cmDf3tWH563iHB+jmZzlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLosm4TwwZoY2bJ+rW5VRYe0hJiWvYBuZYkqYZBW658Q3BsWFPT+vKDGC/KPt+IM7
         nFVoyCaaG7BWW+yFKXy+mrWVq8mQe91e4dHwikc4CvXjZzM9cGX5GSsCM7kEnrChc7
         0mLJ8e2lHGUq8/ebxcGVmVNQmSuSu5OdRmJyO0xAPOaD/omKwqNZHJnoVhy4jo6TUC
         URiDNqwSJ6J7NwFDumtTT1XkerWIv0dYnNEdQ2GXsKmkmcagGCCUb4rL7U5G7v2rMP
         gnf581OhMHFylepHTE3bJARq7/wwCTCDhz67gM6/tJQblEzJm5EAHqwd7vEWWPHjcd
         90nlGLDhe+PsQ==
Date:   Sun, 12 Nov 2023 09:45:24 +0000
From:   Simon Horman <horms@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net,v4, 1/3] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Message-ID: <20231112094524.GF705326@kernel.org>
References: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
 <1699627140-28003-2-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699627140-28003-2-git-send-email-haiyangz@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 06:38:58AM -0800, Haiyang Zhang wrote:
> The rtnl lock also needs to be held before rndis_filter_device_add()
> which advertises nvsp_2_vsc_capability / sriov bit, and triggers
> VF NIC offering and registering. If VF NIC finished register_netdev()
> earlier it may cause name based config failure.
> 
> To fix this issue, move the call to rtnl_lock() before
> rndis_filter_device_add(), so VF will be registered later than netvsc
> / synthetic NIC, and gets a name numbered (ethX) after netvsc.
> 
> Cc: stable@vger.kernel.org
> Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

