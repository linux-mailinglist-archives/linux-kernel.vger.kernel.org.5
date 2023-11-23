Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381467F5EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbjKWMXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbjKWMXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:23:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEBED40
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700742201; x=1732278201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QC7cpid/5csa3GQXLuq8gqKTos0lZQprxC+qxrXogYA=;
  b=m0sBHxTXjD1VRSIsvCDrIO4L428KEM39HsixMFqZNzJMRP9q+oBqS1E0
   cQMaZ0bkb+ehrPSyhVBLBtdlq7owr+5K0dXeGdaX6Y4cBasgiPIbVRTxZ
   RVHFU0RjW2tH+x+jog+n4GEX1TZQypRCXR0RLwdnxhkEMnPqaRAq+As5N
   oQcMQp9Rh7QzFbNtLzOEuqINOU/TuLMfLKaLvxtMr3g4j5ALbSWDqOHSI
   P4aaba828T+oYDKjpQqPWHyDP42ZVdqJM7iiBMsfKK/+48rY2DiHeSoWD
   Q99dOV023t7vFf7bqw+tBoZPN5i2VCaE8U0ohszaMBqudFtLqKhf8CY+5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5460799"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="5460799"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 04:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="760653019"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="760653019"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 23 Nov 2023 04:23:16 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 23 Nov 2023 14:23:16 +0200
Date:   Thu, 23 Nov 2023 14:23:16 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunwu.chan@hotmail.com
Subject: Re: [PATCH] drm/i915/display: Fix null pointer dereference in
 intel_dp_aux_wait_done and intel_dp_aux_xfer
Message-ID: <ZV9ENJIVKztrI2gs@intel.com>
References: <20231123100431.34453-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123100431.34453-1-chentao@kylinos.cn>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 06:04:31PM +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. When "intel_dp->aux.name" is NULL,
>  these error messages will trigger the null pointer dereference issue.

How did you reach that conclusion?

> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_aux.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
> index 2e2af71bcd5a..398c9064eb09 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
> @@ -67,7 +67,7 @@ intel_dp_aux_wait_done(struct intel_dp *intel_dp)
>  	if (ret == -ETIMEDOUT)
>  		drm_err(&i915->drm,
>  			"%s: did not complete or timeout within %ums (status 0x%08x)\n",
> -			intel_dp->aux.name, timeout_ms, status);
> +			intel_dp->aux.name ? intel_dp->aux.name : "", timeout_ms, status);
>  
>  	return status;
>  }
> @@ -302,7 +302,7 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
>  		if (status != intel_dp->aux_busy_last_status) {
>  			drm_WARN(&i915->drm, 1,
>  				 "%s: not started (status 0x%08x)\n",
> -				 intel_dp->aux.name, status);
> +				 intel_dp->aux.name ? intel_dp->aux.name : "", status);
>  			intel_dp->aux_busy_last_status = status;
>  		}
>  
> @@ -362,7 +362,7 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
>  
>  	if ((status & DP_AUX_CH_CTL_DONE) == 0) {
>  		drm_err(&i915->drm, "%s: not done (status 0x%08x)\n",
> -			intel_dp->aux.name, status);
> +			intel_dp->aux.name ? intel_dp->aux.name : "", status);
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -374,7 +374,7 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
>  	 */
>  	if (status & DP_AUX_CH_CTL_RECEIVE_ERROR) {
>  		drm_err(&i915->drm, "%s: receive error (status 0x%08x)\n",
> -			intel_dp->aux.name, status);
> +			intel_dp->aux.name ? intel_dp->aux.name : "", status);
>  		ret = -EIO;
>  		goto out;
>  	}
> @@ -385,7 +385,7 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
>  	 */
>  	if (status & DP_AUX_CH_CTL_TIME_OUT_ERROR) {
>  		drm_dbg_kms(&i915->drm, "%s: timeout (status 0x%08x)\n",
> -			    intel_dp->aux.name, status);
> +			    intel_dp->aux.name ? intel_dp->aux.name : "", status);
>  		ret = -ETIMEDOUT;
>  		goto out;
>  	}
> @@ -401,7 +401,7 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
>  	if (recv_bytes == 0 || recv_bytes > 20) {
>  		drm_dbg_kms(&i915->drm,
>  			    "%s: Forbidden recv_bytes = %d on aux transaction\n",
> -			    intel_dp->aux.name, recv_bytes);
> +			    intel_dp->aux.name ? intel_dp->aux.name : "", recv_bytes);
>  		ret = -EBUSY;
>  		goto out;
>  	}
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
