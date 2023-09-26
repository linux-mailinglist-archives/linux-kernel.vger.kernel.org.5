Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA8D7AEA89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjIZKiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIZKiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE6E120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695724636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amtbUNp0H39hgF4fPl/rM1/q01FMWTvKuIItlSfZPcA=;
        b=A1Id4b7MUre14DyJAwNfdP5eRG8jXEqIyeDEBSOwQ+LJbQYZvXwKHIKijfHMJ7nlDFpKv0
        4qSUfI0KzOMY9ugf9DKa6p3Ad1ij6WQ9gskRYRzh2fcO/lechftCMBQSNrbNAupNwEaJ2d
        yXUpJu9IHYKgWPaIPDRt/hBwuzsUGcU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-OVk_U8wvN9y7X6XpvRWeRQ-1; Tue, 26 Sep 2023 06:37:13 -0400
X-MC-Unique: OVk_U8wvN9y7X6XpvRWeRQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c0165b5c5cso118242571fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695724632; x=1696329432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amtbUNp0H39hgF4fPl/rM1/q01FMWTvKuIItlSfZPcA=;
        b=hWGR1h/9CDUJvBFBYJdSZOH6subcEZnGRfF3J8kFV5npNzhOvmyzifOy1MrKHe7X/X
         xHvERXi1VMXL2U0zoxaPx2Lw7WN6XYH1Te83aN74mQexEcYwD4qx/UdGAmh4Q8oj5xiH
         29Astf5CQLJecBllcsxcx8EpuopllLlf/DMSbsiRmGDoWD+/lkVcktLWNv4j4FxhHBYp
         b3r2GGb6nfNZchofwiF29/KtIsfOGydqtJ65XYR25b58ysiGnVX1YtqGkBaFUDqYU0dS
         aSox4H8IJy28F5hfTFdaYDIgO5osJvRdvMBehE6s9eAOi7cpomjTMGgVLOKCJubDt/Oe
         WrzA==
X-Gm-Message-State: AOJu0Yw2nHC/Gn31fwtiwTR/HgLYPOzGry8YNWZmhOAxnE7FHEYBsK07
        dg1wFg69irw5nRuWyE2Jl7o/VWviZcMj8SZQYB/qZ+VGSlgW29diDxHfOEONqfYwqYz8scoyLte
        Z3M9A5YMumTK2EaKE9Z7qLn0x
X-Received: by 2002:a05:651c:cd:b0:2bf:7894:a490 with SMTP id 13-20020a05651c00cd00b002bf7894a490mr7641456ljr.38.1695724631806;
        Tue, 26 Sep 2023 03:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG087HBTZT0weeyCRbCw+TeuKtRQ7HNrAKhsjjvFmhIm7P8VwPbjcWh0wDeMEdSE4gG/KTR/Q==
X-Received: by 2002:a05:651c:cd:b0:2bf:7894:a490 with SMTP id 13-20020a05651c00cd00b002bf7894a490mr7641443ljr.38.1695724631501;
        Tue, 26 Sep 2023 03:37:11 -0700 (PDT)
Received: from [192.168.1.217] ([109.37.154.108])
        by smtp.gmail.com with ESMTPSA id q6-20020a1709060e4600b0099bd6026f45sm7500175eji.198.2023.09.26.03.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 03:37:10 -0700 (PDT)
Message-ID: <fbcf0fee-b97d-8f47-9df4-44bc1b475144@redhat.com>
Date:   Tue, 26 Sep 2023 12:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Input: i8042 - add quirk for Lenovo ThinkPad T14 Gen 1
Content-Language: en-US
To:     Jonathan Denose <jdenose@chromium.org>, linux-input@vger.kernel.org
Cc:     Jonathan Denose <jdenose@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Takashi Iwai <tiwai@suse.de>,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-kernel@vger.kernel.org
References: <20230925163313.1.I55bfb5880d6755094a995d3ae44c13810ae98be4@changeid>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230925163313.1.I55bfb5880d6755094a995d3ae44c13810ae98be4@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/25/23 23:33, Jonathan Denose wrote:
> The ThinkPad T14 Gen 1 touchpad works fine except that clicking
> and dragging by tapping the touchpad or depressing the touchpad
> do not work. Disabling PNP for controller setting discovery enables
> click and drag without negatively impacting other touchpad features.
> 
> Signed-off-by: Jonathan Denose <jdenose@google.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> 
>  drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> index 1724d6cb8649d..c487047d878cd 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -830,6 +830,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		},
>  		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
>  	},
> +	{
> +		/* Lenovo ThinkPad T14 Gen 1*/
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "20S0002UUS")
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
> +	},
>  	{
>  		/* Lenovo ThinkPad Twist S230u */
>  		.matches = {

