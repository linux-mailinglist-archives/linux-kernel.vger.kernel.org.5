Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172CC7F5DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbjKWLaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbjKWLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:30:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C701D8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:30:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4534C433C8;
        Thu, 23 Nov 2023 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700739058;
        bh=IOa9OityNaBhSpstc8WvzosAvSBf/uFZGnrASVhy710=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faZcmP2b5PC9zP424hnDWQtr7U9YRwgPr7Z4UuPKO6rnzqZlkhqWEYNesDjET1I0O
         E7mA5vYFKLC2Kn3PA2j5o9zLHZRAYQc9Bsiry6mOUSC7LYWXFP9uOSOzcMEUD+hzgQ
         k2AwkZa5UY1dcaz9T99C63SnwlFDgisZiDNCgaukkcCEyWaYz2HuoDqANElqgyUcN2
         JEJSy40vyfT3YXZx1Ajr03GmM879W820wL3KWC8hDqJ/tbLfEto2XrzdoBBc6yu0jl
         yrlKzOgbBu9hgQhlnULbNbesS3uRh6SYQq2hYsFm/pyzQXKXMLlBoBmZPJ7o6quNRu
         m5Dq2PSKQNwIw==
Date:   Thu, 23 Nov 2023 11:30:55 +0000
From:   Lee Jones <lee@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cs42l43: Correct SoundWire port list
Message-ID: <20231123113055.GE1243364@google.com>
References: <20231113150220.1472294-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113150220.1472294-1-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023, Charles Keepax wrote:

> Two ports are missing from the port list. Also the attempt to list
> them by function is rather misguided, there is nothing in the hardware
> that fixes a particular port to one function. Fix the missing ports
> and change to just listing them by the DPx naming scheme that is used
> throughout the rest of the driver.
> 
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/cs42l43-sdw.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mfd/cs42l43-sdw.c b/drivers/mfd/cs42l43-sdw.c
> index 7392b3d2e6b96..6d67020396fb5 100644
> --- a/drivers/mfd/cs42l43-sdw.c
> +++ b/drivers/mfd/cs42l43-sdw.c
> @@ -18,11 +18,13 @@
>  #include "cs42l43.h"
>  
>  enum cs42l43_sdw_ports {
> -	CS42L43_DMIC_DEC_ASP_PORT = 1,
> -	CS42L43_SPK_TX_PORT,
> -	CS42L43_SPDIF_HP_PORT,
> -	CS42L43_SPK_RX_PORT,
> -	CS42L43_ASP_PORT,
> +	CS42L43_DP1 = 1,
> +	CS42L43_DP2,
> +	CS42L43_DP3,
> +	CS42L43_DP4,
> +	CS42L43_DP5,
> +	CS42L43_DP6,
> +	CS42L43_DP7,
>  };

This is starting to look a little redundant now.

I'm not sure if this is better, but it sure takes up less room:

#define CS42L43_SDW_PORT(port) port

>  static const struct regmap_config cs42l43_sdw_regmap = {
> @@ -55,9 +57,9 @@ static int cs42l43_read_prop(struct sdw_slave *sdw)
>  	prop->use_domain_irq = true;
>  	prop->paging_support = true;
>  	prop->wake_capable = true;
> -	prop->source_ports = BIT(CS42L43_DMIC_DEC_ASP_PORT) | BIT(CS42L43_SPK_TX_PORT);
> -	prop->sink_ports = BIT(CS42L43_SPDIF_HP_PORT) |
> -			   BIT(CS42L43_SPK_RX_PORT) | BIT(CS42L43_ASP_PORT);
> +	prop->source_ports = BIT(CS42L43_DP1) | BIT(CS42L43_DP2) |
> +			     BIT(CS42L43_DP3) | BIT(CS42L43_DP4);
> +	prop->sink_ports = BIT(CS42L43_DP5) | BIT(CS42L43_DP6) | BIT(CS42L43_DP7);
>  	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
>  	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY |
>  			      SDW_SCP_INT1_IMPL_DEF;
> @@ -78,11 +80,8 @@ static int cs42l43_read_prop(struct sdw_slave *sdw)
>  		dpn[i].max_word = 24;
>  		i++;
>  	}
> -	/*
> -	 * All ports are 2 channels max, except the first one,
> -	 * CS42L43_DMIC_DEC_ASP_PORT.
> -	 */
> -	dpn[CS42L43_DMIC_DEC_ASP_PORT].max_ch = 4;
> +	/* All ports are 2 channels max, except the first one. */
> +	dpn[CS42L43_DP1].max_ch = 4;
>  
>  	nval = hweight32(prop->sink_ports);
>  	prop->sink_dpn_prop = devm_kcalloc(dev, nval, sizeof(*prop->sink_dpn_prop),
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
