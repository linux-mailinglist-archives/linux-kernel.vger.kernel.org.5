Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA880AB9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574535AbjLHSHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjLHSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:07:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF11198D;
        Fri,  8 Dec 2023 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702058836; x=1733594836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k3i428SfmhgbbGxwTnZmXhIRi1dfQ6MQmf1eOjd45OQ=;
  b=YdRQYyHII0f4qsc4Bq9gdrptLdduA0Jx2+ocksGQ6SB19zcGTdUs6edi
   w8a7Js4TZuyXuBTMyPRN1HAG9o49CxVKEPEBRG+pcrpkJfvt4yYkWF3iR
   Yak5YlixWAbeJ27Omclp5qOwTiNCfqHKir64NWHVGgOpTmefbWijDwbYf
   ZERMO+eAWu5+EpByVWWMqr5ts5eele+UENASl1uniroejUY9DdFQYZ01Z
   f7XMivQ37dbb7SBUS0Tdzr7yIi4aiU/XKpZLIXvTs7KnAW3zRHvvfFXFu
   gRBJx8oc15BXBv7/EX8++aia1zkIfDhDCfILM3MCHUUHFPEcCDHD03Y94
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="425575369"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="425575369"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 10:07:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="801182284"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="801182284"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 10:07:12 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 06CC811F995;
        Fri,  8 Dec 2023 20:07:10 +0200 (EET)
Date:   Fri, 8 Dec 2023 18:07:09 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: dt-bindings: ov8856: decouple lanes and link
 frequency from driver
Message-ID: <ZXNbTUg3QrCwKBpp@kekkonen.localdomain>
References: <20231207142356.100453-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207142356.100453-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the update.

On Thu, Dec 07, 2023 at 03:23:56PM +0100, Krzysztof Kozlowski wrote:
> The data lanes and link frequency were set to match exiting Linux driver
> limitations, however bindings should be independent of chosen Linux
> driver support.
> 
> Decouple these properties from the driver to match what is actually
> supported by the hardware.
> 
> This also fixes DTS example:
> 
>   ov8856.example.dtb: camera@10: port:endpoint:link-frequencies:0: [360000000] is too short
> 
> Fixes: 066a94e28a23 ("media: dt-bindings: media: Use graph and video-interfaces schemas")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Rework approach: decouple bindings from driver instead of fixing
>    DTS example (Sakari)
> ---
>  .../devicetree/bindings/media/i2c/ov8856.yaml | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> index 57f5e48fd8e0..71102a71cf81 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> @@ -67,19 +67,22 @@ properties:
>  
>          properties:
>            data-lanes:
> -            description: |-
> -              The driver only supports four-lane operation.
> -            items:
> -              - const: 1
> -              - const: 2
> -              - const: 3
> -              - const: 4
> +            oneOf:
> +              - items:
> +                  - const: 1
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4
>  
>            link-frequencies:
>              description: Frequencies listed are driver, not h/w limitations.

This should be dropped, too.

> -            maxItems: 2
>              items:
> -              enum: [ 360000000, 180000000 ]
> +              enum: [ 1440000000, 720000000, 360000000, 180000000 ]

These frequencies are listed in the datasheet but they're just an
example---the sensor hardware isn't limited to these, the resulting
frequency on the CSI-2 bus is simply up to the external clock frequency and
PLL configuration. I'd remove the values here altogether.

>  
>          required:
>            - link-frequencies

-- 
Regards,

Sakari Ailus
