Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D358C7B2739
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjI1VL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjI1VLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC0A19D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695935465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Gf4p1uEJwB77Lm6SIy/Ej2I7eFhDlgmjpD+naFs9dg=;
        b=jTvKB0kE15oDzn/PL9XS+2gjA/+t4GEXLrt9JsOf/9FTfRKQ6z1h78bDs7SbZewJzvpEqX
        3WWytU9k+JxKhcesI41UtpBIKiTxmuWn+KaRCHD5xTLWIdytiRl1hxybTS9dp5PXMshf/5
        1BSOLRWfUuPxv7aywZAOQx6RKStJdLU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-l9WMQy0xNBq9AP_Gzya2nw-1; Thu, 28 Sep 2023 17:11:04 -0400
X-MC-Unique: l9WMQy0xNBq9AP_Gzya2nw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32006e08483so10308575f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935462; x=1696540262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Gf4p1uEJwB77Lm6SIy/Ej2I7eFhDlgmjpD+naFs9dg=;
        b=FGn3F2F5MwvIVjejvX65rzQVyG2Idmjd6uMuKYsmGaA9VbEElesGed//EsgqhejMNH
         HgdqFj6MdTdCstgwlCFcrYDAwaENLxHTB0lFpxQ1cNqMGLZAk8eTrql2s07hpfJfIdZj
         GEpnjggzXtaAnxkDd825aPKXqIv+c0ed0p6/U5CfTlr0LM3Bm/tI7QHRNb48Byo9Hc6z
         bOI8XzZHJ9W5D4oOntcdOyb5rNhQ4suYoisWhDZJZUrt62qPFQGK1Z2eQsO/jbOIRP2g
         KfLB+fNcw4C8yNmwB74O/hYnxZ24+FxYyAWsssBgk8c3F0iDR4UMKqWUgifDZ7+SivZE
         Sw7A==
X-Gm-Message-State: AOJu0YyZs8TicFhvBRGD8Bs8qvNhKFBOMBahi/3fsQevYQWVipidmFCF
        5kYW1r4pui2GBszxSjYAj8pOIqmDaSzevFxczthe29kGayS30BXf3Hf1w/nGOHr79APGzOWpYz/
        PdlGzSOGUWrKzmnwe7wKJZp0DWhTahT5QrTU=
X-Received: by 2002:a5d:54ca:0:b0:314:748:d59d with SMTP id x10-20020a5d54ca000000b003140748d59dmr2212291wrv.27.1695935462481;
        Thu, 28 Sep 2023 14:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTcZDViznOS+Z5kDGH34AfAZ0fPb2Xiok4ghYy5tNixFUnuBdOf7r8LmYNPrNGXn3bR/aJjQ==
X-Received: by 2002:a5d:54ca:0:b0:314:748:d59d with SMTP id x10-20020a5d54ca000000b003140748d59dmr2212275wrv.27.1695935462140;
        Thu, 28 Sep 2023 14:11:02 -0700 (PDT)
Received: from [10.10.158.202] ([213.144.205.82])
        by smtp.gmail.com with ESMTPSA id o5-20020a056000010500b0031ddf6cc89csm20014940wrx.98.2023.09.28.14.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 14:11:01 -0700 (PDT)
Message-ID: <c95d672e-1ec1-c901-602c-f472f57b65c3@redhat.com>
Date:   Thu, 28 Sep 2023 23:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirk for One Mix 2S
Content-Language: en-US
To:     Kai Uwe Broulik <foss-linux@broulik.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20230928193558.2228730-1-foss-linux@broulik.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230928193558.2228730-1-foss-linux@broulik.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/28/23 21:35, Kai Uwe Broulik wrote:
> The One Mix 2S is a mini laptop with a 1200x1920 portrait screen
> mounted in a landscape oriented clamshell case. Because of the too
> generic DMI strings this entry is also doing bios-date matching.
> 
> Signed-off-by: Kai Uwe Broulik <foss-linux@broulik.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

drm-misc maintainers, I'm currently traveling can
one of you push this to drm-misc-fixes please?

Regards,

Hans




> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 0cb646cb04ee..cc9a9099faaf 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -38,6 +38,14 @@ static const struct drm_dmi_panel_orientation_data gpd_micropc = {
>  	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
>  };
>  
> +static const struct drm_dmi_panel_orientation_data gpd_onemix2s = {
> +	.width = 1200,
> +	.height = 1920,
> +	.bios_dates = (const char * const []){ "03/04/2019",
> +		NULL },
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> +};
> +
>  static const struct drm_dmi_panel_orientation_data gpd_pocket = {
>  	.width = 1200,
>  	.height = 1920,
> @@ -401,6 +409,14 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
>  		},
>  		.driver_data = (void *)&lcd800x1280_rightside_up,
> +	}, {	/* One Mix 2S (generic strings, also match on bios date) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
> +		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
> +		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
> +		},
> +		.driver_data = (void *)&gpd_onemix2s,
>  	},
>  	{}
>  };

