Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A57A8A64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjITRPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjITRPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:15:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A93A3;
        Wed, 20 Sep 2023 10:15:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so2594958a12.0;
        Wed, 20 Sep 2023 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695230139; x=1695834939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BA/1TKZ7fFQpqXSbCVNQn/zfVi+d+HyfuxOxnEyY4I=;
        b=DHjVpv+1ChsbOTMGB5Dpmk1oEXNskx0m3PcnR6OoHgandUGBYN7ZHi0TmbctauPWHB
         xFVmItXu0HbroXn9j7pjRvlHZ+8agcIzy5opp8BjoVxeDs9fqrVvUAKzfXlvvV1423CZ
         OL4NZe6Ct83k/CCPiKtK0AO4i+cNXqCdBv9kqZ/v7HKxnG90TTYam6HPz6xLo06x23RU
         iZyw/7jlfesMjvUWgFbba4V2qv9Cwz2NctA0eq4t0x+2XsLN1560rjdxokwUP7EoZB3j
         WtX5EXwKSG3wN30XUGVOFFP/S19GwhGYDSLba+8HTxe0t7MKoA3ihF422ouLgHov0sGn
         Mnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230139; x=1695834939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BA/1TKZ7fFQpqXSbCVNQn/zfVi+d+HyfuxOxnEyY4I=;
        b=utlnOUQ1LGIwFIq9x0XX7Xig4HLuo2AOaSmfKiSWXxNHScCLUSu78UtcsHkBLanv3X
         m2KGQVCSln8wkNFj+sk7aUskrm6j0eDk9Ku4NC1DI775vH2iZ8Pc7ny+38xUnAWrOidj
         2ehyqg4MDTchwIrqPkLIor28uHvtsGuNtYZqLkVX/iUvhhVwxZanPVKcpHJ5Hi/NgWLR
         doQ5ph+x/MJvVmWHpVW3HAGkWRzyPuHXudZYbNYy+0qQfhFtTz8GlZr0xI1KtKnckTh6
         dg2ElDOcn7/9AWOgHPrazCLPlMgYj8xjTkOxWyXcBXdzrVAB6UgW0sn/DjpKrktUfuiC
         kIOg==
X-Gm-Message-State: AOJu0YzW9Os3fAO64JplOm6mdIPftC3kJc7up0/3lvkvtkgN0teojZdR
        RomGy0zcVrcYoOjNl+fUUAg=
X-Google-Smtp-Source: AGHT+IEQhqAdu9sZQ70y0DS8nngdK+Mk0pkfbWS4qneo1KxLRSZ3qBsiVtqIu4sC8i/YErZyL1rzjQ==
X-Received: by 2002:a17:906:3147:b0:993:eee4:e704 with SMTP id e7-20020a170906314700b00993eee4e704mr4288238eje.38.1695230139300;
        Wed, 20 Sep 2023 10:15:39 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id lx12-20020a170906af0c00b00988f168811bsm9649634ejb.135.2023.09.20.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:15:38 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH RFC v2 07/37] drm/connector: hdmi: Add HDMI compute clock helper
Date:   Wed, 20 Sep 2023 19:15:37 +0200
Message-ID: <1967070.usQuhbGJ8B@jernej-laptop>
In-Reply-To: <20230920-kms-hdmi-connector-state-v2-7-17932daddd7d@kernel.org>
References: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
 <20230920-kms-hdmi-connector-state-v2-7-17932daddd7d@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime!

Dne sreda, 20. september 2023 ob 16:35:22 CEST je Maxime Ripard napisal(a):
> A lot of HDMI drivers have some variation of the formula to calculate
> the TMDS character rate from a mode, but few of them actually take all
> parameters into account.
> 
> Let's create a helper to provide that rate taking all parameters into
> account.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_connector.c | 31 +++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h     |  5 +++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index b01cb4783ea6..4c1af97971bb 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2944,6 +2944,37 @@ void drm_connector_update_privacy_screen(const struct drm_connector_state *conne
>  }
>  EXPORT_SYMBOL(drm_connector_update_privacy_screen);
>  
> +/**
> + * drm_connector_hdmi_compute_mode_clock() - Computes the TMDS Character Rate
> + * @mode: Display mode to compute the clock for
> + * @bpc: Bits per character
> + * @fmt: Output Pixel Format used
> + *
> + * Returns the TMDS Character Rate for a given mode, bpc count and output format.
> + *
> + * RETURNS:
> + * The TMDS Character Rate, in Hertz
> + */
> +unsigned long long
> +drm_connector_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> +				      unsigned int bpc,
> +				      enum hdmi_colorspace fmt)
> +{
> +	unsigned long long clock = mode->clock * 1000ULL;
> +
> +	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
> +		clock = clock * 2;
> +
> +	if (fmt == HDMI_COLORSPACE_YUV422)
> +		bpc = 8;

I think you're missing YUV420 handling, which needs half of clock speed. But
this is a thing of HDMI2.

Best regards,
Jernej

> +
> +	clock = clock * bpc;
> +	do_div(clock, 8);
> +
> +	return clock;
> +}
> +EXPORT_SYMBOL(drm_connector_hdmi_compute_mode_clock);
> +
>  int drm_connector_set_obj_prop(struct drm_mode_object *obj,
>  				    struct drm_property *property,
>  				    uint64_t value)
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index a66cb4e35d7b..d74e9c64ee88 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -38,6 +38,7 @@ struct drm_connector_helper_funcs;
>  struct drm_modeset_acquire_ctx;
>  struct drm_device;
>  struct drm_crtc;
> +struct drm_display_mode;
>  struct drm_encoder;
>  struct drm_panel;
>  struct drm_property;
> @@ -2115,6 +2116,10 @@ void drm_connector_attach_privacy_screen_properties(struct drm_connector *conn);
>  void drm_connector_attach_privacy_screen_provider(
>  	struct drm_connector *connector, struct drm_privacy_screen *priv);
>  void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
> +unsigned long long
> +drm_connector_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> +				      unsigned int bpc,
> +				      enum hdmi_colorspace fmt);
>  
>  /**
>   * struct drm_tile_group - Tile group metadata
> 
> 




