Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4997C78DFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbjH3TSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244602AbjH3N0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9951A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693401914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFnD1m1yLujtko63yZwJAVnOy/cqW7aQ9lGmVnvKkI0=;
        b=YRBWuEc3oliDhnnc2Zwfrq3chUzMB1TUEVRB74+10nQmpZFxTuv9JYfPwtrJkMiw2zZICM
        miJU+UGobb3KeqDm0aCuADyMh3WjRsob9KnuGesx126P5tDcTVqrB9AyEtZNYDLLXolZhk
        eDdYQNP2GHlhNuZMhSFKahdW1Ql3/10=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-BBGsLkk0NdqHnfPY7EhHhA-1; Wed, 30 Aug 2023 09:25:12 -0400
X-MC-Unique: BBGsLkk0NdqHnfPY7EhHhA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a198d4d98aso407630266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401911; x=1694006711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFnD1m1yLujtko63yZwJAVnOy/cqW7aQ9lGmVnvKkI0=;
        b=Z+GQkeQwfqY9A+GJgEzvi21qYrmB2BddJoGPGBcySVmV3rZV7u1vg7aCeFwMY3JiJD
         UrmwOIrhNZWu+08ETqJcvO3omADBhkv3VorBuglvlHReRWW4QuqaBjjLav8DxSVS7QOX
         7E7CLHhzOgSQ1oAWp89vXH/YbRZ/DxGrfYnLAYOKYfSYL3VeqJSNGe1tHiSyhHT8mMdD
         H2r/99jXee6bfeWc2/UXVUpvO/Q/8hhQAY+ansO2B9tdKl9K8IxHSRF7SrxapxVJ+qGb
         Mm2g0gikDWCw23uluJ4NY5xDhLYTKHrkhpmtsnxN5jDu4JcdZzFCoxcNRnIZUGaXi7rP
         q0kQ==
X-Gm-Message-State: AOJu0YwgzjuP+2SVUC2reROBvHzdRSybdXqoq6lo6XRZU3jRIvV0yLTq
        iN4v1aZSSCE20eg3ekke7gFkt/YpSBahhQrwRGjte/HH3eRD5BbLJ5pO5ck6pQtKGaX4AF8Yw0g
        xrWYlIyElN6OUj4i7VUkDMh5oxcFt/289
X-Received: by 2002:a17:907:a07c:b0:9a5:846d:d829 with SMTP id ia28-20020a170907a07c00b009a5846dd829mr1702018ejc.18.1693401911214;
        Wed, 30 Aug 2023 06:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBVdw6KKG0vv0Oq7Kq7f5ODajPyvo+lDFA68sx6L6XsWgpLto9ykCgUvXPgSQBXx0UE1urzw==
X-Received: by 2002:a17:907:a07c:b0:9a5:846d:d829 with SMTP id ia28-20020a170907a07c00b009a5846dd829mr1702006ejc.18.1693401910925;
        Wed, 30 Aug 2023 06:25:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906229500b0099cf44adf2csm7162311eja.46.2023.08.30.06.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 06:25:10 -0700 (PDT)
Message-ID: <f6a745d2-aed4-b10d-3343-d34a364f5236@redhat.com>
Date:   Wed, 30 Aug 2023 15:25:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: corrections to egpu safety
 check
Content-Language: en-US, nl
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20230830022908.36264-1-luke@ljones.dev>
 <20230830022908.36264-2-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230830022908.36264-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 8/30/23 04:29, Luke D. Jones wrote:
> An incorrect if statement was preventing the enablement of the egpu.
> 
> Fixes: d49f4d1a30ac ("platform/x86: asus-wmi: don't allow eGPU switching if eGPU not connected")
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 9783893d2d6e..f54178d6f780 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -726,19 +726,18 @@ static ssize_t egpu_enable_store(struct device *dev,
>  		return -EINVAL;
>  
>  	err = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
> -	if (err < 0)
> -		return err;
> -	if (err < 1) {
> -		err = -ENODEV;
> -		pr_warn("Failed to set egpu disable: %d\n", err);
> +	if (err < 0) {
> +		pr_warn("Failed to get egpu connection status: %d\n", err);
>  		return err;
>  	}
>  
>  	if (asus->gpu_mux_mode_available) {
>  		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
> -		if (result < 0)
> +		if (result < 0) {
>  			/* An error here may signal greater failure of GPU handling */
> +			pr_warn("Failed to get gpu mux status: %d\n", err);

The error-code to print here should be result not err, since the error is stored in result.

I've fixed this up while merging this.

Regards,

Hans



>  			return result;
> +		}
>  		if (!result && enable) {
>  			err = -ENODEV;
>  			pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n", err);
> @@ -748,12 +747,12 @@ static ssize_t egpu_enable_store(struct device *dev,
>  
>  	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
>  	if (err) {
> -		pr_warn("Failed to set egpu disable: %d\n", err);
> +		pr_warn("Failed to set egpu state: %d\n", err);
>  		return err;
>  	}
>  
>  	if (result > 1) {
> -		pr_warn("Failed to set egpu disable (retval): 0x%x\n", result);
> +		pr_warn("Failed to set egpu state (retval): 0x%x\n", result);
>  		return -EIO;
>  	}
>  

