Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7269680CAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbjLKNWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:22:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08B0C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:22:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DC5C433C8;
        Mon, 11 Dec 2023 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702300942;
        bh=kMg/GXuAw0NwjiwcG9lf2WoRc4TxLCeq2bQHpKvPkLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8V92woZX3BPHpaqYPqwZL7XLYYtjzRIj3wFUbj9x0jxILnQvZpYgWvKOYjbcpMI4
         Tniti74WD7uNwuGe1iALxBuof8tOulSwKPQkYGzaKHkA/0S6TffsrQiTlPxnG8h/BX
         /25UQi/TwADNf58AaJBQHI2bbOtG6TbwWJnpBmrsLL9jiufF0qyiTfUffqII5FlPdh
         VL8Ixj3f7d6gU0FYNeinZNPXWETtzbGoKgvwnSVcnFGGjBFgpZfJ3NmSScwf1N1KOx
         adT+dKv/MFQ1BAfwPI+EiOBtJ+V40Va0htKkSDzWVroZbclUoYuCTLCBwu4Br7sccQ
         55EskjMXlUcAQ==
Date:   Mon, 11 Dec 2023 15:22:17 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Daniel Vacek <neelx@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/ipoib: No need to hold the lock while printing the
 warning
Message-ID: <20231211132217.GF4870@unreal>
References: <20231211131051.1500834-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211131051.1500834-1-neelx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 02:10:50PM +0100, Daniel Vacek wrote:
> Signed-off-by: Daniel Vacek <neelx@redhat.com>

Please fill some text in commit message.

Thanks

> ---
>  drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> index 5b3154503bf4..ae2c05806dcc 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> @@ -536,17 +536,17 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
>  	multicast = ib_sa_join_multicast(&ipoib_sa_client, priv->ca, priv->port,
>  					 &rec, comp_mask, GFP_KERNEL,
>  					 ipoib_mcast_join_complete, mcast);
> -	spin_lock_irq(&priv->lock);
>  	if (IS_ERR(multicast)) {
>  		ret = PTR_ERR(multicast);
>  		ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\n", ret);
> +		spin_lock_irq(&priv->lock);
>  		/* Requeue this join task with a backoff delay */
>  		__ipoib_mcast_schedule_join_thread(priv, mcast, 1);
>  		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
>  		spin_unlock_irq(&priv->lock);
>  		complete(&mcast->done);
> -		spin_lock_irq(&priv->lock);
>  	}
> +	spin_lock_irq(&priv->lock);
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 
