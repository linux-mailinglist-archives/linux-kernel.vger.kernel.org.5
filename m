Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4363B7DE5C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbjKASGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344838AbjKASGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:06:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9D109
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:06:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0B8C433C7;
        Wed,  1 Nov 2023 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698861997;
        bh=cexp7OpKEA32RruTUdanP7PapdvWad0hJbmtmuTAg0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLCKe72s2lfOvER5bby0FbuwGE55Y6ZSZzMwwSNwXHVSVOgTa9vrOX5oYloUo+SrW
         62zrt8WGN2xfJTX7exR4sMx5uaNKzFN48me4saV0B/W/vllzRiSIxMqlQag0JEfqDP
         sti701EMJdb+RnJiOsnR1lukntkvQ7CjtVLxOS3s=
Date:   Wed, 1 Nov 2023 19:06:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ben Whitten <ben.whitten@gmail.com>
Subject: Re: [PATCH] regmap: prevent noinc writes from clobbering cache
Message-ID: <2023110124-semisoft-negligee-aea1@gregkh>
References: <20231101142926.2722603-2-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101142926.2722603-2-ben.wolsieffer@hefring.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 10:29:27AM -0400, Ben Wolsieffer wrote:
> Currently, noinc writes are cached as if they were standard incrementing
> writes, overwriting unrelated register values in the cache. Instead, we
> want to cache the last value written to the register, as is done in the
> accelerated noinc handler (regmap_noinc_readwrite).
> 
> Fixes: cdf6b11daa77 ("regmap: Add regmap_noinc_write API")
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> ---
>  drivers/base/regmap/regmap.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 234a84ecde8b..ea6157747199 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -1620,17 +1620,19 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
>  	}
>  
>  	if (!map->cache_bypass && map->format.parse_val) {
> -		unsigned int ival;
> +		unsigned int ival, offset;
>  		int val_bytes = map->format.val_bytes;
> -		for (i = 0; i < val_len / val_bytes; i++) {
> -			ival = map->format.parse_val(val + (i * val_bytes));
> -			ret = regcache_write(map,
> -					     reg + regmap_get_offset(map, i),
> -					     ival);
> +
> +		/* Cache the last written value for noinc writes */
> +		i = noinc ? val_len - val_bytes : 0;
> +		for (; i < val_len; i += val_bytes) {
> +			ival = map->format.parse_val(val + i);
> +			offset = noinc ? 0 : regmap_get_offset(map, i / val_bytes);
> +			ret = regcache_write(map, reg + offset, ival);
>  			if (ret) {
>  				dev_err(map->dev,
>  					"Error in caching of register: %x ret: %d\n",
> -					reg + regmap_get_offset(map, i), ret);
> +					reg + offset, ret);
>  				return ret;
>  			}
>  		}
> -- 
> 2.42.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
