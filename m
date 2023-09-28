Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD21C7B17F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjI1J72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjI1J7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:59:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D95122;
        Thu, 28 Sep 2023 02:59:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EF7C433C8;
        Thu, 28 Sep 2023 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695895161;
        bh=tCj69rQ1Q5lfIC6/ivOgCugvo39cJ/EsMPYJ7RmeyFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xlytmlj91HLCEsq+Mf5zEVpHyWAClLWRMZ/ACzei++dE873OsAO2QIB2bGL9bThrA
         aSM98LEZ/pqgeffJjQVXVVxGXnOtuqKaWWHgwD4QqWL/jHmU4s3UCqfaCqtD3vU4eZ
         cgTfGNA4uQfetGFfT9/+y/cGvU9a6Fx5Mt+1dEVG3BdnCWmnE+pLI1InFT81CMZuXz
         FR2zri3pHDwEhXIqTfrbVpVdNjzDCIL1OCAJafmFnR77i7iJQh8hdBSHgJZsuygIIh
         SR0njo2nFPNopBm45+Kg/kPuF3xOP1BmnHaUwgQDhFJy7YuQMYG3oTcGNb3tBuc5g3
         rIGRa3kC3j4+g==
Date:   Thu, 28 Sep 2023 12:59:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: linux-next: manual merge of the rdma tree with the rdma-fixes
 tree
Message-ID: <20230928095916.GS1642130@unreal>
References: <20230928113851.5197a1ec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928113851.5197a1ec@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:38:51AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rdma tree got a conflict in:
> 
>   drivers/infiniband/hw/mlx5/mr.c
> 
> between commit:
> 
>   374012b00457 ("RDMA/mlx5: Fix mkey cache possible deadlock on cleanup")
> 
> from the rdma-fixes tree and commit:
> 
>   57e7071683ef ("RDMA/mlx5: Implement mkeys management via LIFO queue")
> 
> from the rdma tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/infiniband/hw/mlx5/mr.c
> index 433f96459246,b0fa2d644973..000000000000
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@@ -1025,21 -998,15 +999,21 @@@ void mlx5_mkey_cache_cleanup(struct mlx
>   	if (!dev->cache.wq)
>   		return;
>   
>  -	cancel_delayed_work_sync(&dev->cache.remove_ent_dwork);
>   	mutex_lock(&dev->cache.rb_lock);
>  +	dev->cache.disable = true;
>   	for (node = rb_first(root); node; node = rb_next(node)) {
>   		ent = rb_entry(node, struct mlx5_cache_ent, node);
> - 		xa_lock_irq(&ent->mkeys);
> + 		spin_lock_irq(&ent->mkeys_queue.lock);
>   		ent->disabled = true;
> - 		xa_unlock_irq(&ent->mkeys);
> + 		spin_unlock_irq(&ent->mkeys_queue.lock);
>  -		cancel_delayed_work_sync(&ent->dwork);
>   	}
>  +	mutex_unlock(&dev->cache.rb_lock);
>  +
>  +	/*
>  +	 * After all entries are disabled and will not reschedule on WQ,
>  +	 * flush it and all async commands.
>  +	 */
>  +	flush_workqueue(dev->cache.wq);
>   
>   	mlx5_mkey_cache_debugfs_cleanup(dev);
>   	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);

Thanks for the fix.
