Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0D77EC254
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbjKOMdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343773AbjKOMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:33:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4F2181
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700051619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrPNslDrMY7m1tDumPEwDQvgzout2mMlTxUBYUYIwO0=;
        b=BV/n1SbWER/BKEP+eyMKYhEQpSszaoNlcnFb/EUmuv/ibsZc6bC5N0zatdr7xw20f52+yE
        C2MKxE8X/OkBzpgfMMpVNerQPcSSyFuQoBs7McOqhsDMvCCiVa2TstGlhWrWq5mL2UqGLI
        TxxWA6QQEhIWgmNBwXBw8ssqS7fV9gE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-hwdFwajDNlOoq0rdsFTKEA-1; Wed, 15 Nov 2023 07:33:38 -0500
X-MC-Unique: hwdFwajDNlOoq0rdsFTKEA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9e293cd8332so495081766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700051616; x=1700656416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrPNslDrMY7m1tDumPEwDQvgzout2mMlTxUBYUYIwO0=;
        b=qrSQFsCjAm9PQEDQs/ZVMHSPluK2qKjgy0OZcdmJVC83MiWnU0yuaFuniVK+Kr9/Me
         r6NBiqZKowlUF8ef4Nl9oVW/LSkp+EAUgNqG7kJvBecpIi2dlerSe8oiA+UOD3nkLYC6
         14UDA1PLvEFTA1yon8iwdLiQ2XJ9UXCrAU4zcr+nkdvMgFdWyDz+HDO+9y5E+vWdL74z
         E7DQC8WrSbao4OeJuChuZ3FTkofELqoJjkYXhlDh/BAvK8Ff7fMIEc4REaY/5FlRb6Oc
         29YpnqAojbK+ZQH6pvP9FegRMO2suj2s7q0k7DyhK1PdnrDkngdxaM1hxPfJFz95UtRx
         7AxQ==
X-Gm-Message-State: AOJu0YxCT/Zdza3O3gzX+ZRpsaQ8FklbUF+gwSAZk77w82h5EYAfm3QJ
        RHHJ0RtwdC+aTsBlMfmvsoLX6Q/84ZiLzANAZNI3CloyxMYf50dXjO5J2ZFdEcvmVvcj1H5akh7
        kr8gdyoB4337TB7vyWP6aaXHsQb+PC5ko
X-Received: by 2002:a17:906:7943:b0:9d3:e48f:30d3 with SMTP id l3-20020a170906794300b009d3e48f30d3mr12801108ejo.31.1700051616751;
        Wed, 15 Nov 2023 04:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4fquotqG98jWvfw+RAwbmZhkUa4jPdcgq6KvvFGBu1xeKVXwuXb+Av+yC9Rrmjhc30DETfg==
X-Received: by 2002:a17:906:7943:b0:9d3:e48f:30d3 with SMTP id l3-20020a170906794300b009d3e48f30d3mr12801092ejo.31.1700051616504;
        Wed, 15 Nov 2023 04:33:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m16-20020a1709060d9000b009be14e5cd54sm7027542eji.57.2023.11.15.04.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 04:33:35 -0800 (PST)
Message-ID: <70f12e96-0fcc-4954-8507-27cf5e15a3b2@redhat.com>
Date:   Wed, 15 Nov 2023 13:33:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel-orientation-quirks: add Lenovo Legion Go
Content-Language: en-US, nl
To:     Brenton Simpson <brentons+appsforartists@google.com>
Cc:     Allen Ballway <ballway@chromium.org>,
        Patrick Thompson <ptf@google.com>,
        Jared Baldridge <jrb@expunge.us>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org,
        Brenton Simpson <appsforartists@google.com>
References: <20231114233859.274189-1-appsforartists@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231114233859.274189-1-appsforartists@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brenton,

On 11/15/23 00:38, Brenton Simpson wrote:
> The Legion Go has a 2560x1600 portrait screen, with the native "up" facing the right controller (90° CW from the rest of the device).
> 
> Signed-off-by: Brenton Simpson <appsforartists@google.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

But I cannot merge it because your "From:" which is <brentons+appsforartists@google.com> and the email address which you have used for your Signed-off-by: <appsforartists@google.com> do not match.

And I have no idea which one of those 2 addresses actually works / is yours. I suspect the From: is the right one though ?

Also you have forgotten to Cc: dri-devel@lists.freedesktop.org so this patch is not available in the drm patchwork instance.

Can you please send a v2 fixing both issues ?

Regards,

Hans




> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index d5c1529..3d92f66 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -336,6 +336,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
>  		},
>  		.driver_data = (void *)&lcd1200x1920_rightside_up,
> +	}, {	/* Lenovo Legion Go 8APU1 */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
>  	}, {	/* Lenovo Yoga Book X90F / X90L */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),

