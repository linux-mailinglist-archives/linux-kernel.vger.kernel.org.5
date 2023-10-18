Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB47CE260
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjJRQLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjJRQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:11:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEA69F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:11:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDD5C433C7;
        Wed, 18 Oct 2023 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645462;
        bh=yDdmQ0V9wvojaQKv5dZ7J8a15nZOMdq7QItSFt0CGnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUYLIsGy9I5+Z1057HBBPPERkRSfihNd9Jnqdd/Z2PVzwdx9SgBmx+28ScsxQnKVd
         EefQEji/0T7rWRsI9Z6xX3abBEBbYZDOwKOqwfxGPrfrm/nfkRZEdExYq6tNZo19D3
         v3/kQ4U0RdMaRgXVhSEd7QvzIkwEQrpe4ABwTqpKt5Lu3WDYysPlzO7QFK5iKl7H5J
         TISUG5h0Cu2GrLhQIUNBDbLwlpU+Ec/MwLLhiargMfuqCptfLYZZV6VR8rzH7TKC7T
         d2SPz9PK/I62E8OviKsMY+MNF3kf9aAy/iiT/mnISKvtpzH9qVZg4ZxOgevlHqMzpA
         ckVXH7gi6ImnQ==
Date:   Wed, 18 Oct 2023 18:10:55 +0200
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
        Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 11/11] devlink: convert most of
 devlink_fmsg_*() to return void
Message-ID: <20231018161055.GU1940501@kernel.org>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-12-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017105341.415466-12-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 12:53:41PM +0200, Przemek Kitszel wrote:

...

> diff --git a/net/devlink/health.c b/net/devlink/health.c
> index 3858a436598e..f4a6de576b6c 100644
> --- a/net/devlink/health.c
> +++ b/net/devlink/health.c
> @@ -566,17 +566,15 @@ static int devlink_health_do_dump(struct devlink_health_reporter *reporter,
>  	if (!reporter->dump_fmsg)
>  		return -ENOMEM;
>  
> -	err = devlink_fmsg_obj_nest_start(reporter->dump_fmsg);
> -	if (err)
> -		goto dump_err;
> +	devlink_fmsg_obj_nest_start(reporter->dump_fmsg);
>  
>  	err = reporter->ops->dump(reporter, reporter->dump_fmsg,
>  				  priv_ctx, extack);
>  	if (err)
>  		goto dump_err;
>  
> -	err = devlink_fmsg_obj_nest_end(reporter->dump_fmsg);
> -	if (err)
> +	devlink_fmsg_obj_nest_end(reporter->dump_fmsg);
> +	if (reporter->dump_fmsg->err)

Hi Przemek,

Smatch warns that err is not set to an error value here.

>  		goto dump_err;
>  
>  	reporter->dump_ts = jiffies;

...
