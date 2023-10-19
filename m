Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19847CFA30
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjJSNBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjJSNBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:01:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6AA1737
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:00:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03D1C116AC;
        Thu, 19 Oct 2023 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697720448;
        bh=UaNVdnVtS+6Y8Bshaztbg+8lEOSi39R7ycoX+4dZ6pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryaqfFw+Um1JiXJ/cvml2Ts72RDlw1VPiTE4HrJJc83VENXKHBG9V3jrfo7BzweXJ
         nCq2j6VVCnj/fo9L7NyyXpzPJ61jsS8RGDvy1SohZCp4r5eW7sBqfps7Syn2QLlMue
         fGKx4RRFnojw3NO8i3Vd10Amvrz/CG1BM0NmpN4Odh/BmiLtmYXO6OPknPTkLumujH
         6OGEkfXgW5uKna/ST3fNefqE4abgz9oIfM8MUzd7BLNqDXGN859DLI7oHfvhcU/XO9
         DkZZTCMojrif7yFjcdyqR7hAit9YA3jkQ2e7qrsOmRoRLc2Utd97u99taPCdBYm3+B
         6SGCSUFP1/uCg==
Date:   Thu, 19 Oct 2023 15:00:37 +0200
From:   Simon Horman <horms@kernel.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
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
        linux-kernel@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] devlink: retain error in struct
 devlink_fmsg
Message-ID: <20231019130037.GI2100445@kernel.org>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <20231018202647.44769-2-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018202647.44769-2-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:26:37PM +0200, Przemek Kitszel wrote:
> Retain error value in struct devlink_fmsg, to relieve drivers from
> checking it after each call.
> Note that fmsg is an in-memory builder/buffer of formatted message,
> so it's not the case that half baked message was sent somewhere.
> 
> We could find following scheme in multiple drivers:
>   err = devlink_fmsg_obj_nest_start(fmsg);
>   if (err)
>   	return err;
>   err = devlink_fmsg_string_pair_put(fmsg, "src", src);
>   if (err)
>   	return err;
>   err = devlink_fmsg_something(fmsg, foo, bar);
>   if (err)
> 	return err;
>   // and so on...
>   err = devlink_fmsg_obj_nest_end(fmsg);
> 
> With retaining error API that translates to:
>   devlink_fmsg_obj_nest_start(fmsg);
>   devlink_fmsg_string_pair_put(fmsg, "src", src);
>   devlink_fmsg_something(fmsg, foo, bar);
>   // and so on...
>   devlink_fmsg_obj_nest_end(fmsg);
> 
> What means we check error just when is time to send.
> 
> Possible error scenarios are developer error (API misuse) and memory
> exhaustion, both cases are good candidates to choose readability
> over fastest possible exit.
> 
> Note that this patch keeps returning errors, to allow per-driver conversion
> to the new API, but those are not needed at this point already.
> 
> This commit itself is an illustration of benefits for the dev-user,
> more of it will be in separate commits of the series.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

...

> @@ -1027,14 +934,12 @@ int devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,

Hi Przemek,

The line before this hunk is:

		err = devlink_fmsg_binary_put(fmsg, value + offset, data_size);

And, as of this patch, the implementation of
devlink_fmsg_binary_pair_nest_start() looks like this:

int devlink_fmsg_binary_put(struct devlink_fmsg *fmsg, const void *value,
                            u16 value_len)
{
        if (!fmsg->putting_binary)
                return -EINVAL;

        return devlink_fmsg_put_value(fmsg, value, value_len, NLA_BINARY);
}

Which may return an error, if the if condition is met, without setting
fmsg->err.

>  		if (err)
>  			break;
>  		/* Exit from loop with a break (instead of
> -		 * return) to make sure putting_binary is turned off in
> -		 * devlink_fmsg_binary_pair_nest_end
> +		 * return) to make sure putting_binary is turned off
>  		 */
>  	}
>  
> -	end_err = devlink_fmsg_binary_pair_nest_end(fmsg);
> -	if (end_err)
> -		err = end_err;

Prior to this patch, the value of err from the loop above was preserved,
unless devlink_fmsg_binary_pair_nest_end generated an error.

> +	err = devlink_fmsg_binary_pair_nest_end(fmsg);

But now it looks like this is only the case if fmsg->err corresponds to err
when the loop was exited.

Or in other words, the err returned by devlink_fmsg_binary_put()
is not propagated to the caller if !fmsg->putting_binary.

If so, is this intentional?

> +	fmsg->putting_binary = false;
>  
>  	return err;
>  }
> -- 
> 2.38.1
> 
