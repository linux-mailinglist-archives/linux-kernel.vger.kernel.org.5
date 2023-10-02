Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1767B4FD1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjJBKAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjJBKAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:00:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EB4CCC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696240818; x=1727776818;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jMA1qUgRZBOCtACv4+9yAge9XIVyKwYlEPTNSzbXWqE=;
  b=dm6VLiOGgzntUw8bcL4ckY5qW2+zuXhN6Q1qZmdK0+PNEFyS2I4vxtQW
   8fdYJY7qLqp76Wlis01S0gUV4Jhcp/uWYr5l5993UWdo6GQVMEF+0+H3L
   gO0k5tzENvlWWPTfYiocBz2bS/6kttaxw28eWwCnCOMTM5+Xkq61fYNvB
   5dfysFXYu8IGo0g+MnPXTJESix1sfOik6JE4IgY96qqnxJXkn3ubEYKWm
   RMA9jwaHqEiony1icU9Z8gpWevUOsXrmTthJyxsdIc+nXNeLSQZ+QiTnD
   oLHuFo5hrrGr/6b/v9ip2XWcGoJyfEXybe3CpbGqSx3O6BKojTXWtAnvH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="382518896"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382518896"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 03:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081595161"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1081595161"
Received: from svandens-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.151])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 03:00:14 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Pablo Ceballos <pceballos@google.com>,
        Ankit K Nautiyal <ankit.k.nautiyal@intel.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Pablo Ceballos <pceballos@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, imre.deak@linux.intel.com
Subject: Re: [PATCH v3] drm/i915/display/lspcon: Increase LSPCON mode settle
 timeout
In-Reply-To: <20230816045654.833973-1-pceballos@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230816045654.833973-1-pceballos@google.com>
Date:   Mon, 02 Oct 2023 13:00:05 +0300
Message-ID: <87r0mdgx96.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023, Pablo Ceballos <pceballos@google.com> wrote:
> This is to eliminate all cases of "*ERROR* LSPCON mode hasn't settled",
> followed by link training errors. Intel engineers recommended increasing
> this timeout and that does resolve the issue.
>
> On some CometLake-based device designs the Parade PS175 takes more than
> 400ms to settle in PCON mode. 100 reboot trials on one device resulted
> in a median settle time of 440ms and a maximum of 444ms. Even after
> increasing the timeout to 500ms, 2% of devices still had this error. So
> this increases the timeout to 800ms.
>
> Signed-off-by: Pablo Ceballos <pceballos@google.com>

Please file the issue at [1] as requested before, and reference it in
the commit message.

[1] https://gitlab.freedesktop.org/drm/intel/-/issues/new

> ---
>
> V2: Added more details in the commit message
> V3: Only apply the increased timeout if the vendor is Parade
>
> drivers/gpu/drm/i915/display/intel_lspcon.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
> index bb3b5355a0d9..b07eab84cc63 100644
> --- a/drivers/gpu/drm/i915/display/intel_lspcon.c
> +++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
> @@ -153,6 +153,24 @@ static enum drm_lspcon_mode lspcon_get_current_mode(struct intel_lspcon *lspcon)
>  	return current_mode;
>  }
>  
> +static u32 lspcon_get_mode_settle_timeout(struct intel_lspcon *lspcon)
> +{
> +	u32 timeout_ms = 400;

Please use plain int for plain numbers. There's nothing u32 about this.

> +
> +	/*
> +	 * On some CometLake-based device designs the Parade PS175 takes more
> +	 * than 400ms to settle in PCON mode. 100 reboot trials on one device
> +	 * resulted in a median settle time of 440ms and a maximum of 444ms.
> +	 * Even after increasing the timeout to 500ms, 2% of devices still had
> +	 * this error. So this sets the timeout to 800ms.
> +	 */
> +	if (lspcon->vendor == LSPCON_VENDOR_PARADE)
> +		timeout_ms = 800;
> +
> +	return timeout_ms;

All of the above is just

	return lspcon->vendor == LSPCON_VENDOR_PARADE ? 800 : 400;

BR,
Jani.

> +}
> +
> +
>  static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
>  					     enum drm_lspcon_mode mode)
>  {
> @@ -167,7 +185,8 @@ static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
>  	drm_dbg_kms(&i915->drm, "Waiting for LSPCON mode %s to settle\n",
>  		    lspcon_mode_name(mode));
>  
> -	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 400);
> +	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode,
> +		 lspcon_get_mode_settle_timeout(lspcon));
>  	if (current_mode != mode)
>  		drm_err(&i915->drm, "LSPCON mode hasn't settled\n");

-- 
Jani Nikula, Intel
