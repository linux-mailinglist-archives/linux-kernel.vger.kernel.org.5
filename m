Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFF47F9477
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjKZRPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKZRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:15:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B96FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:15:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042C9C433C8;
        Sun, 26 Nov 2023 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701018911;
        bh=guVv+SEh7voPe2lgiNwr2YxQ6n/2ttB7Jl8kD59Z9ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+aU8f2Idan4hvme0PSqL3UB30oSCZAmsROFTkYB/x0oz55+PioQdveGhsSpyB+Gg
         Ao02FxaGghJ3KJ9k6uMouBvIG+e6m5I9yhuCU6LuLmWqcADv4G8U8eL4aJkNDC+YIQ
         XTdpCGoRdeH4I8wO8UqaqbCwhVMaWBYwsOawfO8tEhgNcuMfGhJg/uhgMqpa8yrtzh
         ZhwqGJa8nuLGjvB2npGydeEeoFvI7a4ppFq1Bcimv+M0bu6Ha+Qc4etfv5GmVwf+4a
         RySa2qmCM4qyuWUPqwNhsyDGpZsf/s6mepEecEp6iJr8e1PdDanUDJI/K1kawrvGQW
         4xrhLrBAWJLZw==
Date:   Sun, 26 Nov 2023 17:15:04 +0000
From:   Simon Horman <horms@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v1 2/4] RDMA/mana_ib: create and process EQ events
Message-ID: <20231126171504.GC84723@kernel.org>
References: <1700709010-22042-1-git-send-email-longli@linuxonhyperv.com>
 <1700709010-22042-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700709010-22042-3-git-send-email-longli@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 07:10:08PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Before the software can create an RDMA adapter handle with SoC, it needs to
> create EQs for processing SoC events from RDMA device. Because MSI-X
> vectors are shared between MANA Ethernet device and RDMA device, this
> patch adds support to share EQs on MSI-X vectors and creates management
> EQ for RDMA device.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

...

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c

...

> -static void mana_gd_deregiser_irq(struct gdma_queue *queue)
> +static void mana_gd_deregister_irq(struct gdma_queue *queue)
>  {
>  	struct gdma_dev *gd = queue->gdma_dev;
>  	struct gdma_irq_context *gic;
>  	struct gdma_context *gc;
>  	struct gdma_resource *r;
>  	unsigned int msix_index;
> +	struct gdma_queue *eq;
>  	unsigned long flags;
> +	struct list_head *p;
>  
>  	gc = gd->gdma_context;
>  	r = &gc->msix_resource;
> @@ -505,14 +507,24 @@ static void mana_gd_deregiser_irq(struct gdma_queue *queue)
>  	if (WARN_ON(msix_index >= gc->num_msix_usable))
>  		return;
>  
> +	spin_lock_irqsave(&r->lock, flags);
> +
>  	gic = &gc->irq_contexts[msix_index];
> -	gic->handler = NULL;
> -	gic->arg = NULL;
> +	list_for_each_rcu(p, &gic->eq_list) {
> +		eq = list_entry(p, struct gdma_queue, entry);

Hi Long Li,

Sparse complains a bit about this construction:

 .../gdma_main.c:513:9: error: incompatible types in comparison expression (different address spaces):
 .../gdma_main.c:513:9:    struct list_head [noderef] __rcu *
 .../gdma_main.c:513:9:    struct list_head *
 .../gdma_main.c:513:9: error: incompatible types in comparison expression (different address spaces):
 .../gdma_main.c:513:9:    struct list_head [noderef] __rcu *
 .../gdma_main.c:513:9:    struct list_head *

Perhaps using list_for_each_entry_rcu() is appropriate here.


> +		if (queue == eq) {
> +			list_del(&eq->entry);
> +			synchronize_rcu();
> +			break;
> +		}
> +	}
>  
> -	spin_lock_irqsave(&r->lock, flags);
> -	bitmap_clear(r->map, msix_index, 1);
> -	spin_unlock_irqrestore(&r->lock, flags);
> +	if (list_empty(&gic->eq_list)) {
> +		gic->handler = NULL;
> +		bitmap_clear(r->map, msix_index, 1);
> +	}
>  
> +	spin_unlock_irqrestore(&r->lock, flags);
>  	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
>  }
>  

...
