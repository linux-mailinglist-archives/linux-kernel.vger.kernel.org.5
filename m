Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF23A7619FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGYNaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjGYNaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F02319BD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690291760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YzaB62IfAWaKjr40MIeUKzOgDRHbKPqjxnRlUir3NLA=;
        b=fSI21d1KDwtRpn/frJm6PunJhxk6MTmcjri6IySwAXuvsHFe0XGuFt0CqzGKgw1a8bPLV/
        j1/9anjOz2TjDNzJ+v67+P04vHJku5rF5WwyJ4ZQXbzwShkdp8zYFdL9QrABRf1p+9pu7o
        wGPfLh06sypfv/MyFk5ezla+smNBPIM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-mAUKZBIQMbS3s37rtQAhhg-1; Tue, 25 Jul 2023 09:29:18 -0400
X-MC-Unique: mAUKZBIQMbS3s37rtQAhhg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b97f342349so30683261fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291756; x=1690896556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzaB62IfAWaKjr40MIeUKzOgDRHbKPqjxnRlUir3NLA=;
        b=jOeDUafgR+IYnh22sd80N0HpHEn53P8GgD/d7VtbsY1QQRL3Gxn41qjRSweWV2jF50
         61GCdnuXbuO71narddZyKzVtgTGQGef6bSvnsKE3n8lEZ4QBsvqmhT2/unEz/unCconi
         /4yVhhFQac2SXaiCzLZTauPDqgIhbZrSIRUkmbrJfOiFABLK0pSBfDuXaTpoGdCL/TOv
         vtQSut8lHHix5/W5VAvLunIBr1ACP/GBkveM5fGvLSUovL+QejCHlv+wetLfP7zD2C5z
         a61awh9wVxLaLLcFwbleU3BxJRUrXny5XARSnrYgeAWKcmkMwv2B5YXLJSXD6FgxuBfF
         w4vA==
X-Gm-Message-State: ABy/qLY7a0eImME8rf7lC52Rzg5Hdo06n6RSvoltUncXLxGg9t64Kzhk
        G+D7Mg8g5IO7FTFr1g1qaHqqx/3VQzaetYdCn8mY5GedKoUx1UKe6d/pW14Oeomo9yxWJpcUTbz
        pf6oQi7iwHrilV8nbynex64srvObQzwa8
X-Received: by 2002:a19:6755:0:b0:4f8:5bf7:db05 with SMTP id e21-20020a196755000000b004f85bf7db05mr7629943lfj.27.1690291756658;
        Tue, 25 Jul 2023 06:29:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGw2c86Cn66zy4bQqoIKumKm0BfA80x2pk+JYd9dSrQcwOhbJEgPVS2pMMZ19DB8JETCR0Yig==
X-Received: by 2002:a19:6755:0:b0:4f8:5bf7:db05 with SMTP id e21-20020a196755000000b004f85bf7db05mr7629939lfj.27.1690291756351;
        Tue, 25 Jul 2023 06:29:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7ce0f000000b0052238bc70ccsm2145750edv.89.2023.07.25.06.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 06:29:15 -0700 (PDT)
Message-ID: <1a018895-6bc6-2816-8cc9-cc6a7106ebc1@redhat.com>
Date:   Tue, 25 Jul 2023 15:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] platform/x86/intel/hid: Add HP Dragonfly G2 to VGBS
 DMI quirks
Content-Language: en-US, nl
To:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Alex Hung <alexhung@gmail.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230716183213.64173-1-maxtram95@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230716183213.64173-1-maxtram95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/16/23 20:32, Maxim Mikityanskiy wrote:
> HP Elite Dragonfly G2 (a convertible laptop/tablet) has a reliable VGBS
> method. If VGBS is not called on boot, the firmware sends an initial
> 0xcd event shortly after calling the BTNL method, but only if the device
> is booted in the laptop mode. However, if the device is booted in the
> tablet mode and VGBS is not called, there is no initial 0xcc event, and
> the input device for SW_TABLET_MODE is not registered up until the user
> turns the device into the laptop mode.
> 
> Call VGBS on boot on this device to get the initial state of
> SW_TABLET_MODE in a reliable way.
> 
> Tested with BIOS 1.13.1.
> 
> Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/intel/hid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
> index 5632bd3c534a..afa16520b363 100644
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -150,6 +150,12 @@ static const struct dmi_system_id dmi_vgbs_allow_list[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go"),
>  		},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite Dragonfly G2 Notebook PC"),
> +		},
> +	},
>  	{ }
>  };
>  

