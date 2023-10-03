Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391E67B662D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjJCKRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjJCKRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:17:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5B6A3;
        Tue,  3 Oct 2023 03:17:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B6FC433CC;
        Tue,  3 Oct 2023 10:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696328226;
        bh=BU1F0aZ2dBmGtP4Oin7uow9Zzh2Uzhr2vEEZr2qQ3u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRlQK/L9J913AV0+rRzNUGtWPbQU4fZqR0qWNtgENGKltG0MVlI4R7/BJocuvBUmW
         NtryPYQaWUiusk4i8Hn0qBMsy/ryvIZ0H3NQfBaWg9i/2YljxX7f8OfdRtdkB39ccu
         qEwzE+2sC6ZuO0++4Q5q2OyEd9fWzD4ej/1VHxYvNyi+m0LqsSQKQgANdTV5p69flw
         qsNJMLNXmoXOVOA/uLZQH5y982djM5eHt5/xtP9Ya4DO3hfj1vuXumDPFQn5IxZGDT
         /qB1ZvgxnRAqOJfDMo0khQtegvfvfLvcDIDqt+Yj+nS+EpxiI3XZM1XtQbumraoS51
         aIMpeph+Oa8zg==
Date:   Tue, 3 Oct 2023 13:17:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with the net-next
 tree
Message-ID: <20231003101701.GB51282@unreal>
References: <20231003103712.5703b5e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003103712.5703b5e0@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 10:37:12AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mlx5-next tree got a conflict in:
> 
>   include/linux/mlx5/device.h
> 
> between commit:
> 
>   ac5f395685bd ("net/mlx5: SF, Implement peer devlink set for SF representor devlink port")
> 
> from the net-next tree and commit:
> 
>   0d293714ac32 ("RDMA/mlx5: Send events from IB driver about device affiliation state")
> 
> from the mlx5-next tree.
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
> diff --cc include/linux/mlx5/device.h
> index 8fbe22de16ef,26333d602a50..000000000000
> --- a/include/linux/mlx5/device.h
> +++ b/include/linux/mlx5/device.h
> @@@ -366,7 -366,8 +366,9 @@@ enum mlx5_driver_event 
>   	MLX5_DRIVER_EVENT_UPLINK_NETDEV,
>   	MLX5_DRIVER_EVENT_MACSEC_SA_ADDED,
>   	MLX5_DRIVER_EVENT_MACSEC_SA_DELETED,
>  +	MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
> + 	MLX5_DRIVER_EVENT_AFFILIATION_DONE,
> + 	MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
>   };

Thanks a lot

>   
>   enum {


