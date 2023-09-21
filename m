Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D5E7A960B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjIUQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIUQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:56:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62000AC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695315385; x=1726851385;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=oay5k/k4FowXctAo6RDPN3Ut0nEsXm0SCNAvWbRxE3Q=;
  b=g3k6jL0zql5bqcpuSupFQwg/WHNONOsHE1HKTxQXWmZpxauFJ8E0fA7V
   3bE0wz0r9RS+XoutOYDEHMo1Uc3mRRGk/UtDio2kAsoss4HEuajS7FqTG
   PhDOKy6s+LFbvmr7jNfsV2JRpJH/tNdvb9w9sIayrWtmS+kGm2K9S8Von
   nORuRcYkltq7XOSZ+qXcS6etHYLLw3YHvMWU6FlDH+vj9cJ7/gMf5548G
   N1lOL7b8Gdh1pG/Bn70EUN56I9FTG2Qp76LnlSMC7YP56GTRKOz5HIPYf
   Jc5akx5ppve2oUZS3z/J0OrpluDeQn7UKErsUsYjRYOewZzwuCZ4Gwe23
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360747602"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="360747602"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:09:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077875040"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="1077875040"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.162])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:09:13 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Xin Ji <xji@analogixsemi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     qwen@analogixsemi.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, hsinyi@chromium.org,
        bliang@analogixsemi.com, Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH] drm/bridge: Add 200ms delay to wait FW HPD status stable
In-Reply-To: <20230921091435.3524869-1-xji@analogixsemi.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230921091435.3524869-1-xji@analogixsemi.com>
Date:   Thu, 21 Sep 2023 15:09:10 +0300
Message-ID: <87leczpw2h.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023, Xin Ji <xji@analogixsemi.com> wrote:
> For the none-interrupt design(sink device is panel, polling HPD
> status when chip power on), anx7625 FW has more than 200ms HPD
> de-bounce time in FW, for the safety to get HPD status, driver
> better to wait 200ms before HPD detection after OS resume back.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 51abe42c639e..833d6d50a03d 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1464,6 +1464,9 @@ static int _anx7625_hpd_polling(struct anx7625_data *ctx,
>  	if (ctx->pdata.intp_irq)
>  		return 0;
>  
> +	/* Delay 200ms for FW HPD de-bounce */
> +	usleep_range(200000, 201000);

If you need to sleep for 200 ms, maybe use msleep instead?

BR,
Jani.

> +
>  	ret = readx_poll_timeout(anx7625_read_hpd_status_p0,
>  				 ctx, val,
>  				 ((val & HPD_STATUS) || (val < 0)),

-- 
Jani Nikula, Intel
