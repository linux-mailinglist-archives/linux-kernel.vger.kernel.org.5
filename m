Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0287B8042
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbjJDNLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDNLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:11:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB1B98;
        Wed,  4 Oct 2023 06:11:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E438BC433C7;
        Wed,  4 Oct 2023 13:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696425107;
        bh=siX93/m9hk1N1zT9g0DoJx25MsV21pxMygnh0PRczAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFq47BavBbfGaR+VlduyVs/WF3d+Fqa/zzazKNmOrkvelOde1Ggdug0fAZUEcQzt8
         6WW/anpby0kWPROJLOkeLV8dxT3IZTmLpFYHxaHqGOmLLieiKebPbvzm0wlKPOnWG0
         vA15t9OEHnNVNmFRWknBjy4wUIP04rLg7oqnFnls=
Date:   Wed, 4 Oct 2023 15:11:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] soundwire: fix initializing sysfs for same devices on
 different buses
Message-ID: <2023100426-purebred-cabbie-ae19@gregkh>
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 03:02:43PM +0200, Krzysztof Kozlowski wrote:
> If same devices with same device IDs are present on different soundwire
> buses, the probe fails due to conflicting device names and sysfs
> entries:
> 
>   sysfs: cannot create duplicate filename '/bus/soundwire/devices/sdw:0:0217:0204:00:0'
> 
> The link ID is 0 for both devices, so they should be differentiated by
> bus ID.  Add the bus ID so, the device names and sysfs entries look
> like:
> 
>   sdw:1:0:0217:0204:00:0 -> ../../../devices/platform/soc@0/6ab0000.soundwire-controller/sdw-master-1/sdw:1:0:0217:0204:00:0
>   sdw:3:0:0217:0204:00:0 -> ../../../devices/platform/soc@0/6b10000.soundwire-controller/sdw-master-3/sdw:3:0:0217:0204:00:0
> 
> Fixes: 7c3cd189b86d ("soundwire: Add Master registration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Sending as RFT, because I did not test it on that many devices and
> user-spaces.
> ---
>  drivers/soundwire/slave.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index c1c1a2ac293a..4db43ea53d47 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -39,14 +39,14 @@ int sdw_slave_add(struct sdw_bus *bus,
>  	slave->dev.fwnode = fwnode;
>  
>  	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
> -		/* name shall be sdw:link:mfg:part:class */
> -		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x",
> -			     bus->link_id, id->mfg_id, id->part_id,
> +		/* name shall be sdw:bus:link:mfg:part:class */
> +		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x",
> +			     bus->id, bus->link_id, id->mfg_id, id->part_id,
>  			     id->class_id);
>  	} else {
> -		/* name shall be sdw:link:mfg:part:class:unique */
> -		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x:%01x",
> -			     bus->link_id, id->mfg_id, id->part_id,
> +		/* name shall be sdw:bus:link:mfg:part:class:unique */
> +		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x:%01x",
> +			     bus->id, bus->link_id, id->mfg_id, id->part_id,

Shouldn't some documenation also be changed somewhere that describes the
device id?

thanks,

greg k-h
