Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B581A7CE259
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjJRQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjJRQJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:09:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D6D12A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:09:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12435C433C7;
        Wed, 18 Oct 2023 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645342;
        bh=4MR7iDZ+ixMX3Hkqy8fTKzN7HrpxuhyU6baJRTI8kUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xu0yRV8xDJ2jramzFaTKjJu286TbqXgRtm6Fnu6t/XIWQN67j4ZKJzisW2q9Xc+43
         aJP9Clv7ivguDYTQHxjOOg/UJX5LkCg35QqWSOk1mRuBGg4Ce8MxOKRICXSTUxQrFD
         Z40rGO35IXupws5F9Y5gw5++KTerH/+BA213yF1MxOmm8HnglybT/1Mp2CJQeC2Ox6
         /K6wEwD7y/RXAUVJvasd/7I7i5569LnWUiB7OBB9nj2O8wtl16qcrf6WQnu7LHd/8r
         KCUYy6pEUiOMQx3fr0Dj+JxVLpZsI9C8CU2Ai/yYzsrCpleBTM3FBS+0Kf8RtHn68Q
         +JZA55NQnJxww==
Date:   Wed, 18 Oct 2023 18:08:55 +0200
From:   Simon Horman <horms@kernel.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH net-next v2 08/11] net/mlx5: devlink health: use retained
 error fmsg API
Message-ID: <20231018160855.GT1940501@kernel.org>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-9-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017105341.415466-9-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 12:53:38PM +0200, Przemek Kitszel wrote:
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

...

> @@ -288,52 +206,31 @@ int mlx5e_health_rsc_fmsg_dump(struct mlx5e_priv *priv, struct mlx5_rsc_key *key

Hi Przemek,

The code above this hunk looks like this:

        do {
                cmd_err = mlx5_rsc_dump_next(mdev, cmd, page, &size);
                if (cmd_err < 0) {
                        err = cmd_err;

clang-16 W=1 warns that err, which is used as the return value of the
function, will be uninitialised if the loop never hits this condition.

Smatch also warns about this.

>  			goto destroy_cmd;
>  		}
>  
> -		err = mlx5e_health_rsc_fmsg_binary(fmsg, page_address(page), size);
> -		if (err)
> -			goto destroy_cmd;
> -
> +		mlx5e_health_rsc_fmsg_binary(fmsg, page_address(page), size);
>  	} while (cmd_err > 0);
>  
>  destroy_cmd:
>  	mlx5_rsc_dump_cmd_destroy(cmd);
> -	end_err = devlink_fmsg_binary_pair_nest_end(fmsg);
> -	if (end_err)
> -		err = end_err;
> +	devlink_fmsg_binary_pair_nest_end(fmsg);
>  free_page:
>  	__free_page(page);
>  	return err;
>  }

...
