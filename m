Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34C8782A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjHUNcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjHUNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12779D1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692624692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4wxv/avDlDhDoec6XFHqI1b4YUTQ1Kranoms8ixAYc=;
        b=ReMmCPTAUs23bweUa3x064lzCGTz+LZ81+Wn4Ctluj/yVUspEQi6AAWrt/hDfrPzdXPGOJ
        5QQhINayJ26ygPxdoNTy3wH/bsrqmIqur5agR2nGZIE5hjo1VRxB0XCkv2IAvVvDaO8/B0
        7O547eVQKKvzd74wHULUZwI9amMt2Kk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Y4YdtumjPluK0_Ijm2ELjg-1; Mon, 21 Aug 2023 09:31:30 -0400
X-MC-Unique: Y4YdtumjPluK0_Ijm2ELjg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bcf6ae8e1so224473766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692624689; x=1693229489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4wxv/avDlDhDoec6XFHqI1b4YUTQ1Kranoms8ixAYc=;
        b=a9QUunmf4XKkkfZMikGWlYSiHcJ73Ym1j7QS9P6S74v4tnoa/4fc1Z1Vb18a0z+eVi
         QUto1WjC6I1zJQjivIEINbDqC7M6NjTVjJuNVh/XQsHXXarXFB06Q8LBJex74Jtk6R9e
         GoNCKKWXLzYs+58Q7WC3txQETBeEmIHTt1pqFmUVJBWnmbwGIxE7GWhqt4nplulw0tzs
         EEvUVvVAMVulmjpiYbhLefqWLGpfyFHg8tN/+d6SHlpe8iPiRTKI/SseorC1RadPO0l/
         L8u3b0W0vnQmYXPsbxmb5Xu8MWHXYqVxfv/s335cQJhEjX9hZ00osQu9WL8cMzBZNWyg
         JH7w==
X-Gm-Message-State: AOJu0YyKcSvYwVKrZpCHDej2zJIKfK705Fi77Tw4eMYnkZwtqQpqMb3s
        cFvkLqrWNrEEixvkVz+nlvMwH/JBdTTg1uisrbu6CHfCUZXraLR0jQwQo7ggDvnfOw02HczBdjT
        MDQoyPJ3IQy1kNmIKuiXmhAtw
X-Received: by 2002:a17:907:a075:b0:993:e752:1a71 with SMTP id ia21-20020a170907a07500b00993e7521a71mr4525399ejc.9.1692624689602;
        Mon, 21 Aug 2023 06:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUS+VZ2P3ROasIGo9h5cG0v6G3pPO8eybFoZbxVbEWk3WhrKt835Icxxq0nBI5i4n4/66tdw==
X-Received: by 2002:a17:907:a075:b0:993:e752:1a71 with SMTP id ia21-20020a170907a07500b00993e7521a71mr4525382ejc.9.1692624689292;
        Mon, 21 Aug 2023 06:31:29 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id jp23-20020a170906f75700b00989828a42e8sm6484448ejb.154.2023.08.21.06.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 06:31:28 -0700 (PDT)
Message-ID: <18e99ff7-27a8-8a6d-146a-e0525a2f6fc2@redhat.com>
Date:   Mon, 21 Aug 2023 15:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Fixes: a23870110a38 ("asus-wmi: add support for showing
 middle fan RPM")
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230815014209.44903-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230815014209.44903-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

The Fixes: tag goes into the Signed-off-by block, not in the Subject.

I have fixed this up while merging this:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




On 8/15/23 03:42, Luke D. Jones wrote:
> After the addition of the mid fan custom curve functionality various
> incorrect behaviour was uncovered. This commit fixes these areas.
> 
> - Ensure mid fan attributes actually use the correct fan ID
> - Correction to a bit mask for selecting the correct fan data
> - Refactor the curve show/store functions to be cleaner and and
>   match each others layout
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 78 ++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index d14d0ea9d65f..14ee43c61eb2 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -2902,9 +2902,8 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
>  {
>  	struct fan_curve_data *curves;
>  	u8 buf[FAN_CURVE_BUF_LEN];
> -	int fan_idx = 0;
> +	int err, fan_idx;
>  	u8 mode = 0;
> -	int err;
>  
>  	if (asus->throttle_thermal_policy_available)
>  		mode = asus->throttle_thermal_policy_mode;
> @@ -2914,13 +2913,6 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
>  	else if (mode == 1)
>  		mode = 2;
>  
> -	if (fan_dev == ASUS_WMI_DEVID_GPU_FAN_CURVE)
> -		fan_idx = FAN_CURVE_DEV_GPU;
> -
> -	if (fan_dev == ASUS_WMI_DEVID_MID_FAN_CURVE)
> -		fan_idx = FAN_CURVE_DEV_MID;
> -
> -	curves = &asus->custom_fan_curves[fan_idx];
>  	err = asus_wmi_evaluate_method_buf(asus->dsts_id, fan_dev, mode, buf,
>  					   FAN_CURVE_BUF_LEN);
>  	if (err) {
> @@ -2928,9 +2920,17 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
>  		return err;
>  	}
>  
> -	fan_curve_copy_from_buf(curves, buf);
> +	fan_idx = FAN_CURVE_DEV_CPU;
> +	if (fan_dev == ASUS_WMI_DEVID_GPU_FAN_CURVE)
> +		fan_idx = FAN_CURVE_DEV_GPU;
> +
> +	if (fan_dev == ASUS_WMI_DEVID_MID_FAN_CURVE)
> +		fan_idx = FAN_CURVE_DEV_MID;
> +
> +	curves = &asus->custom_fan_curves[fan_idx];
>  	curves->device_id = fan_dev;
>  
> +	fan_curve_copy_from_buf(curves, buf);
>  	return 0;
>  }
>  
> @@ -2960,7 +2960,7 @@ static struct fan_curve_data *fan_curve_attr_select(struct asus_wmi *asus,
>  {
>  	int index = to_sensor_dev_attr(attr)->index;
>  
> -	return &asus->custom_fan_curves[index & FAN_CURVE_DEV_GPU];
> +	return &asus->custom_fan_curves[index];
>  }
>  
>  /* Determine which fan the attribute is for if SENSOR_ATTR_2 */
> @@ -2969,7 +2969,7 @@ static struct fan_curve_data *fan_curve_attr_2_select(struct asus_wmi *asus,
>  {
>  	int nr = to_sensor_dev_attr_2(attr)->nr;
>  
> -	return &asus->custom_fan_curves[nr & FAN_CURVE_DEV_GPU];
> +	return &asus->custom_fan_curves[nr & ~FAN_CURVE_PWM_MASK];
>  }
>  
>  static ssize_t fan_curve_show(struct device *dev,
> @@ -2978,13 +2978,13 @@ static ssize_t fan_curve_show(struct device *dev,
>  	struct sensor_device_attribute_2 *dev_attr = to_sensor_dev_attr_2(attr);
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  	struct fan_curve_data *data;
> -	int value, index, nr;
> +	int value, pwm, index;
>  
>  	data = fan_curve_attr_2_select(asus, attr);
> +	pwm = dev_attr->nr & FAN_CURVE_PWM_MASK;
>  	index = dev_attr->index;
> -	nr = dev_attr->nr;
>  
> -	if (nr & FAN_CURVE_PWM_MASK)
> +	if (pwm)
>  		value = data->percents[index];
>  	else
>  		value = data->temps[index];
> @@ -3027,23 +3027,21 @@ static ssize_t fan_curve_store(struct device *dev,
>  	struct sensor_device_attribute_2 *dev_attr = to_sensor_dev_attr_2(attr);
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  	struct fan_curve_data *data;
> +	int err, pwm, index;
>  	u8 value;
> -	int err;
> -
> -	int pwm = dev_attr->nr & FAN_CURVE_PWM_MASK;
> -	int index = dev_attr->index;
>  
>  	data = fan_curve_attr_2_select(asus, attr);
> +	pwm = dev_attr->nr & FAN_CURVE_PWM_MASK;
> +	index = dev_attr->index;
>  
>  	err = kstrtou8(buf, 10, &value);
>  	if (err < 0)
>  		return err;
>  
> -	if (pwm) {
> +	if (pwm)
>  		data->percents[index] = value;
> -	} else {
> +	else
>  		data->temps[index] = value;
> -	}
>  
>  	/*
>  	 * Mark as disabled so the user has to explicitly enable to apply a
> @@ -3156,7 +3154,7 @@ static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point8_temp, fan_curve,
>  			       FAN_CURVE_DEV_CPU, 7);
>  
>  static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_pwm, fan_curve,
> -			       FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 0);
> +				FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 0);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_pwm, fan_curve,
>  			       FAN_CURVE_DEV_CPU | FAN_CURVE_PWM_MASK, 1);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_pwm, fan_curve,
> @@ -3209,40 +3207,40 @@ static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point8_pwm, fan_curve,
>  			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 7);
>  
>  /* MID */
> -static SENSOR_DEVICE_ATTR_RW(pwm3_enable, fan_curve_enable, FAN_CURVE_DEV_GPU);
> +static SENSOR_DEVICE_ATTR_RW(pwm3_enable, fan_curve_enable, FAN_CURVE_DEV_MID);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_temp, fan_curve,
> -			       FAN_CURVE_DEV_GPU, 0);
> +			       FAN_CURVE_DEV_MID, 0);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_temp, fan_curve,
> -			       FAN_CURVE_DEV_GPU, 1);
> +			       FAN_CURVE_DEV_MID, 1);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_temp, fan_curve,
> -			       FAN_CURVE_DEV_GPU, 2);
> +			       FAN_CURVE_DEV_MID, 2);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point4_temp, fan_curve,
> -			       FAN_CURVE_DEV_GPU, 3);
> +			       FAN_CURVE_DEV_MID, 3);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point5_temp, fan_curve,
> -			       FAN_CURVE_DEV_GPU, 4);
> +			       FAN_CURVE_DEV_MID, 4);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point6_temp, fan_curve,
> -			       FAN_CURVE_DEV_GPU, 5);
> +			       FAN_CURVE_DEV_MID, 5);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point7_temp, fan_curve,
> -			       FAN_CURVE_DEV_GPU, 6);
> +			       FAN_CURVE_DEV_MID, 6);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point8_temp, fan_curve,
> -			       FAN_CURVE_DEV_GPU, 7);
> +			       FAN_CURVE_DEV_MID, 7);
>  
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_pwm, fan_curve,
> -			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 0);
> +			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 0);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_pwm, fan_curve,
> -			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 1);
> +			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 1);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_pwm, fan_curve,
> -			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 2);
> +			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 2);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point4_pwm, fan_curve,
> -			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 3);
> +			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 3);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point5_pwm, fan_curve,
> -			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 4);
> +			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 4);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point6_pwm, fan_curve,
> -			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 5);
> +			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 5);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point7_pwm, fan_curve,
> -			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 6);
> +			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 6);
>  static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point8_pwm, fan_curve,
> -			       FAN_CURVE_DEV_GPU | FAN_CURVE_PWM_MASK, 7);
> +			       FAN_CURVE_DEV_MID | FAN_CURVE_PWM_MASK, 7);
>  
>  static struct attribute *asus_fan_curve_attr[] = {
>  	/* CPU */

