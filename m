Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2669D7BBBC6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjJFPc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjJFPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C879E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696606335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4MSm45CD+B8Ts8r+zCzgFvGdfeJ47qZ1DiMag7ZlFs=;
        b=bKzhwCfuRBDizUpjLWt8eutjxFS1M9R4g76W1EavZPu3Llp885o8C9SQYdDJX4iH6JBjoR
        eOsiSnFwt7MwyBNOUPb3d64pTTs3oEbLQ/BDC/0cnkLg3wv+MZEQpag8/p5sUSYWqzJKRT
        498eauz+DGQgs4GCy0S3vXzU/ic4Ekw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-guvXbc0oOAiSzeq8Ic2xVQ-1; Fri, 06 Oct 2023 11:32:13 -0400
X-MC-Unique: guvXbc0oOAiSzeq8Ic2xVQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5334e22b2dbso2067226a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 08:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606332; x=1697211132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4MSm45CD+B8Ts8r+zCzgFvGdfeJ47qZ1DiMag7ZlFs=;
        b=C59asMlA4Af+3OWDbOEfIVth8aq9SWDSdU1rzMMD6tqvbykf5I2fAH05NlN891SuW1
         8Hsoup9LZ6iu8XH6YrC4minH67lbHxe1JS8RIAApTN0+S4s36aCYAJpEWJW2FQUjOyhc
         htjtQ6iUtER+hy8TYAl75oRj0+KIzObTKtJhtQemHPo3roXZg63X6sWwvyGj5rEYYy6G
         IGNPI2+hblEv9ezzp7y9xI4f8/uEo3evTW58gZGzCp9L/mwd/bLOd26CCvouijYdrfBf
         Ux21Cwv/VEScotWzldxXBYJ1Ny2n6t6/ZDY/ZTcG/TFCYdaQW8IyyaCv39/+zzYUhOaU
         D2RQ==
X-Gm-Message-State: AOJu0YwEnNAexPI01IVuKCNONCbBJRa0tn5qwZSSAv+IpNHw8wtfCeYh
        ANAeEHpm5GQbRgGSP57QZ23uA1rbd+V5+aEMC8eMAI6hAtGPAp4JrZKHGJSb1FIdcEUkvBAsSLf
        2S1Gd91WmqCZj5q47wxWI5W5F
X-Received: by 2002:a05:6402:160b:b0:530:bad5:248e with SMTP id f11-20020a056402160b00b00530bad5248emr7836036edv.3.1696606332336;
        Fri, 06 Oct 2023 08:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpviVAJbQGnfe0nVTVD5V7XvPwwyBgdlKmAXW0GbRgo33Ry60JGCnaiAZ0u1wNWfUkHrKjYA==
X-Received: by 2002:a05:6402:160b:b0:530:bad5:248e with SMTP id f11-20020a056402160b00b00530bad5248emr7836018edv.3.1696606332058;
        Fri, 06 Oct 2023 08:32:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id w22-20020aa7dcd6000000b00536e03f62bcsm2750081edu.59.2023.10.06.08.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 08:32:11 -0700 (PDT)
Message-ID: <9ebb5ae0-2ec0-198c-3843-e44ce84493d2@redhat.com>
Date:   Fri, 6 Oct 2023 17:32:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wireless: Replace open coded
 acpi_match_device()
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
References: <20231006152739.3495671-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231006152739.3495671-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/6/23 17:27, Andy Shevchenko wrote:
> Replace open coded acpi_match_device() in asus_wireless_add().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fixed compilation error
>  drivers/platform/x86/asus-wireless.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
> index abf01e00b799..8b9a0dde34e3 100644
> --- a/drivers/platform/x86/asus-wireless.c
> +++ b/drivers/platform/x86/asus-wireless.c
> @@ -148,13 +148,9 @@ static int asus_wireless_add(struct acpi_device *adev)
>  	if (err)
>  		return err;
>  
> -	for (id = device_ids; id->id[0]; id++) {
> -		if (!strcmp((char *) id->id, acpi_device_hid(adev))) {
> -			data->hswc_params =
> -				(const struct hswc_params *)id->driver_data;
> -			break;
> -		}
> -	}
> +	id = acpi_match_device(device_ids, adev);
> +	if (id)
> +		data->hswc_params = (const struct hswc_params *)id->driver_data;
>  	if (!data->hswc_params)
>  		return 0;

Thanks, but the error checking looks a bit weird now. How about:

	id = acpi_match_device(device_ids, adev);
	if (!id)
 		return 0;

	data->hswc_params = (const struct hswc_params *)id->driver_data;

That seems to better convey what the code's intention is.

Regards,

Hans

p.s.

This driver really should be converted to not be an acpi_driver
instead it should bind to the instantiated platform_device
for the adev, but that would require someone with actual
hw access to test the conversion ...



