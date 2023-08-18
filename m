Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFB078061A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbjHRHFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358111AbjHRHFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:05:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8086430D1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:05:04 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qWtXL-00045m-7q; Fri, 18 Aug 2023 09:04:47 +0200
Message-ID: <96898dbb-3fdf-7a74-ae80-f18ae2244f50@pengutronix.de>
Date:   Fri, 18 Aug 2023 09:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 3/3] drm/panel-simple: allow LVDS format override
Content-Language: en-US, de-DE
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        patchwork-jzi@pengutronix.de, kernel@pengutronix.de,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523-simplepanel_support_nondefault_datamapping-v4-0-e6e7011f34b5@pengutronix.de>
 <20230523-simplepanel_support_nondefault_datamapping-v4-3-e6e7011f34b5@pengutronix.de>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <20230523-simplepanel_support_nondefault_datamapping-v4-3-e6e7011f34b5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

do you have any input on this for me?

Best regards
Johannes

On 7/28/23 16:16, Johannes Zink wrote:
> Some panels support multiple LVDS data mapping formats, which can be
> used e.g. run displays on jeida-18 format when only 3 LVDS lanes are
> available.
> 
> Add parsing of an optional data-mapping devicetree property, which also
> touches up the bits per color to match the bus format.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> 
> ---
> 
> Changes:
> 
>    v3 -> v4: - worked in Dan's feedback (thanks for reviewing my work):
>                  - return with a proper error in case the call to
> 		  panel_simple_override_nondefault_lvds_datamapping()
> 		  fails
>                  - drop the unneeded and ambiguous ret variable
> 
>    v2 -> v3: - worked in Laurent's review findings (thanks for reviewing
>                my work):
> 	        - extract fixing up the bus format to separate
> 		  function
> 		- only call function on LVDS panels
> 		- fix typos found by Laurent
> 		- simplified error handling
> 
>    v1 -> v2: - fix missing unwind goto found by test robot
>                Reported-by: kernel test robot <lkp@intel.com>
>                Reported-by: Dan Carpenter <error27@gmail.com>
>                Link: https://lore.kernel.org/r/202304160359.4LHmFOlU-lkp@intel.com/
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 53 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 4badda6570d5..3a164931093e 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -40,6 +40,7 @@
>   #include <drm/drm_edid.h>
>   #include <drm/drm_mipi_dsi.h>
>   #include <drm/drm_panel.h>
> +#include <drm/drm_of.h>
>   
>   /**
>    * struct panel_desc - Describes a simple panel.
> @@ -549,6 +550,51 @@ static void panel_simple_parse_panel_timing_node(struct device *dev,
>   		dev_err(dev, "Reject override mode: No display_timing found\n");
>   }
>   
> +static int panel_simple_override_nondefault_lvds_datamapping(struct device *dev,
> +							     struct panel_simple *panel)
> +{
> +	int ret, bpc;
> +
> +	ret = drm_of_lvds_get_data_mapping(dev->of_node);
> +	if (ret < 0) {
> +		if (ret == -EINVAL)
> +			dev_warn(dev, "Ignore invalid data-mapping property\n");
> +
> +		/*
> +		 * Ignore non-existing or malformatted property, fallback to
> +		 * default data-mapping, and return 0.
> +		 */
> +		return 0;
> +	}
> +
> +	switch (ret) {
> +	default:
> +		WARN_ON(1);
> +		fallthrough;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> +		fallthrough;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> +		bpc = 8;
> +		break;
> +	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
> +		bpc = 6;
> +	}
> +
> +	if (panel->desc->bpc != bpc || panel->desc->bus_format != ret) {
> +		struct panel_desc *override_desc;
> +
> +		override_desc = devm_kmemdup(dev, panel->desc, sizeof(*panel->desc), GFP_KERNEL);
> +		if (!override_desc)
> +			return -ENOMEM;
> +
> +		override_desc->bus_format = ret;
> +		override_desc->bpc = bpc;
> +		panel->desc = override_desc;
> +	}
> +
> +	return 0;
> +}
> +
>   static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>   {
>   	struct panel_simple *panel;
> @@ -601,6 +647,13 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>   			panel_simple_parse_panel_timing_node(dev, panel, &dt);
>   	}
>   
> +	if (desc->connector_type == DRM_MODE_CONNECTOR_LVDS) {
> +		/* Optional data-mapping property for overriding bus format */
> +		err = panel_simple_override_nondefault_lvds_datamapping(dev, panel);
> +		if (err)
> +			goto free_ddc;
> +	}
> +
>   	connector_type = desc->connector_type;
>   	/* Catch common mistakes for panels. */
>   	switch (connector_type) {
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

