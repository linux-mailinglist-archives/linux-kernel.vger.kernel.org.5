Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DDC80EA1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbjLLLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLLQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:16:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C80B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:16:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E855FC433C8;
        Tue, 12 Dec 2023 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702379766;
        bh=uYwwLlsIzQYDAj0R5783tUUQONQgc91PncKROKCTvL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClmUQ5Sy0FxUMQx8S4IKnViITsSypmc+mECTKMc5IgH3dGZNb0fp1CiuIK/GlpFXc
         Vq+lycJe/grle9iUp9xrNWRJBAbM9ZSZUoxhIDWmcvZ5OCx5qQBADbMioF/yTgoHvj
         u6EPVXKqqQWKYG+sDOlOB65sAl3p9fx+8Juawu6i+ISIjsC1Kt8HyBEGVLkrLrnef5
         T/hjZw78hPygBbXIGovEdcFUpQuzsHMVwsDXW5qnVQ4vVMsH/rrCQt31SYt5K/5qYx
         VUtY24tOiA0U/cdr65Y1M/fp8lbtQgqXRY9Mf+YNPsoIV6/IRQCbW944WE+2uM5+hq
         m/S4XQMSDOA6w==
Date:   Tue, 12 Dec 2023 11:16:01 +0000
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
        jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
        lcherian@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] octeontx2-af: Fix multicast/mirror group
 lock/unlock issue
Message-ID: <20231212111601.GY5817@kernel.org>
References: <20231212091558.49579-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212091558.49579-1-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 02:45:58PM +0530, Suman Ghosh wrote:
> As per the existing implementation, there exists a race between finding
> a multicast/mirror group entry and deleting that entry. The group lock
> was taken and released independently by rvu_nix_mcast_find_grp_elem()
> function. Which is incorrect and group lock should be taken during the
> entire operation of group updation/deletion. This patch fixes the same.
> 
> Fixes: 51b2804c19cd ("octeontx2-af: Add new mbox to support multicast/mirror offload")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> @@ -6306,6 +6310,13 @@ int rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
>  		return err;
>  
>  	mcast_grp = &nix_hw->mcast_grp;
> +
> +	/* If AF is requesting for the deletion,
> +	 * then AF is already taking the lock
> +	 */
> +	if (!req->is_af)
> +		mutex_lock(&mcast_grp->mcast_grp_lock);
> +
>  	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
>  	if (!elem)

Hi Suman,

Does mcast_grp_lock need to be released here?
If so, I would suggest a goto label, say unlock_grp.

>  		return NIX_AF_ERR_INVALID_MCAST_GRP;
> @@ -6333,12 +6344,6 @@ int rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
>  	mutex_unlock(&mcast->mce_lock);
>  
>  delete_grp:
> -	/* If AF is requesting for the deletion,
> -	 * then AF is already taking the lock
> -	 */
> -	if (!req->is_af)
> -		mutex_lock(&mcast_grp->mcast_grp_lock);
> -
>  	list_del(&elem->list);
>  	kfree(elem);
>  	mcast_grp->count--;
> @@ -6370,9 +6375,20 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
>  		return err;
>  
>  	mcast_grp = &nix_hw->mcast_grp;
> +
> +	/* If AF is requesting for the updation,
> +	 * then AF is already taking the lock
> +	 */
> +	if (!req->is_af)
> +		mutex_lock(&mcast_grp->mcast_grp_lock);
> +
>  	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
> -	if (!elem)
> +	if (!elem) {
> +		if (!req->is_af)
> +			mutex_unlock(&mcast_grp->mcast_grp_lock);
> +
>  		return NIX_AF_ERR_INVALID_MCAST_GRP;
> +	}
>  
>  	/* If any pcifunc matches the group's pcifunc, then we can
>  	 * delete the entire group.
> @@ -6383,8 +6399,11 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
>  				/* Delete group */
>  				dreq.hdr.pcifunc = elem->pcifunc;
>  				dreq.mcast_grp_idx = elem->mcast_grp_idx;
> -				dreq.is_af = req->is_af;
> +				dreq.is_af = 1;
>  				rvu_mbox_handler_nix_mcast_grp_destroy(rvu, &dreq, NULL);
> +				if (!req->is_af)
> +					mutex_unlock(&mcast_grp->mcast_grp_lock);
> +
>  				return 0;
>  			}
>  		}
> @@ -6467,5 +6486,8 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
>  
>  done:

I think it would be good to rename this label, say unlock_mce;

>  	mutex_unlock(&mcast->mce_lock);

Add a new label here, say unlock_grp;
And jump to this label whenever there is a need for the mutex_unlock() below.

> +	if (!req->is_af)
> +		mutex_unlock(&mcast_grp->mcast_grp_lock);
> +
>  	return ret;
>  }
> -- 
> 2.25.1
> 
