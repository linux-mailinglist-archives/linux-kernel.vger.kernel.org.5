Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6706080247F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 15:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjLCOYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 09:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 09:24:31 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2DDFA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 06:24:37 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 171E525A;
        Sun,  3 Dec 2023 15:23:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701613436;
        bh=tHh/dUnJ5r4RBftwQVK/y6yde5Na2FuFMRERe2LbEBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YF8/ZEIUYW4zMjjqiGudkdTkM19WuEZQS+8d25SvHsQC7i2RQ88mLNEbPe2WCpeVs
         nuGOcGfylY72p+A0bmNhMeETIpVwubqqvAYAfvdLlz0eE54RmQPpW/VrkwkTTDLhzB
         xCfYCazK5QjAALujo4Hvi8Iwl9tMZd1WfZxFBlJs=
Date:   Sun, 3 Dec 2023 16:24:41 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        freedreno@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, andersson@kernel.org,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: improve the documentation of connector hpd ops
Message-ID: <20231203142441.GA26644@pendragon.ideasonboard.com>
References: <20230920201358.27597-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920201358.27597-1-quic_abhinavk@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhinav,

Thank you for the patch (and thank to Dmitry for pinging me on IRC, this
patch got burried in my inbox).

On Wed, Sep 20, 2023 at 01:13:58PM -0700, Abhinav Kumar wrote:
> While making the changes in [1], it was noted that the documentation
> of the enable_hpd() and disable_hpd() does not make it clear that
> these ops should not try to do hpd state maintenance and should only
> attempt to enable/disable hpd related hardware for the connector.

s/attempt to //

> 
> The state management of these calls to make sure these calls are
> balanced is handled by the DRM core and we should keep it that way
> to minimize the overhead in the drivers which implement these ops.
> 
> [1]: https://patchwork.freedesktop.org/patch/558387/
> 

You could add a

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/drm/drm_modeset_helper_vtables.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index e3c3ac615909..a33cf7488737 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -1154,6 +1154,11 @@ struct drm_connector_helper_funcs {
>  	 * This operation is optional.
>  	 *
>  	 * This callback is used by the drm_kms_helper_poll_enable() helpers.
> +	 *
> +	 * This operation does not need to perform any hpd state tracking as
> +	 * the DRM core handles that maintenance and ensures the calls to enable
> +	 * and disable hpd are balanced.
> +	 *
>  	 */
>  	void (*enable_hpd)(struct drm_connector *connector);
>  
> @@ -1165,6 +1170,11 @@ struct drm_connector_helper_funcs {
>  	 * This operation is optional.
>  	 *
>  	 * This callback is used by the drm_kms_helper_poll_disable() helpers.
> +	 *
> +	 * This operation does not need to perform any hpd state tracking as
> +	 * the DRM core handles that maintenance and ensures the calls to enable
> +	 * and disable hpd are balanced.
> +	 *
>  	 */
>  	void (*disable_hpd)(struct drm_connector *connector);
>  };

-- 
Regards,

Laurent Pinchart
