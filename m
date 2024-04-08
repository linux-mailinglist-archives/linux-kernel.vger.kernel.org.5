Return-Path: <linux-kernel+bounces-135456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E989C362
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C211C2208E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BDC85653;
	Mon,  8 Apr 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4iwjG6Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A37CF34
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583281; cv=none; b=kr5gJ9uSIZA2cJhI0OPFtILo6RSzeB6DYQR62HCmnLd/rNqvuWCFfUR34FHZuo1CseUcXs/bu61om2XnOb3elc1DBM3MyxNVYjM4XJBtc9hN07TXMHtmHT0mCwuzsU1fJ0Wx9Eocfr5K9k0ldzzISnllQeUq+ftP7LLnWFiHRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583281; c=relaxed/simple;
	bh=S/zEAmwI4UPHeaCuRBnml8vzh/J/dOoKEJ8+9TWOXYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIUyfJ4mkgASDAGk8Q8XUTdw/UXc4QywRikFwrWj6j7tfgwvCk8JU7/4cnPZiGlN9H4shAloH0AUwJCuA6Bc/12GKWkD5XNqqcWMIctoIPFYnu0Zie9Ew5JeO8Y4OGobqyceobumqaLMITk4JmwJ4UWDo+ICJk7LguY1/ss7Vh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4iwjG6Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712583278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LuUwyTIFNAAmDTH2Rd92jK7L5iSQ6LqiXDS++XcJumA=;
	b=J4iwjG6YBu86xcMhZ2wcxO7XI5muSjx7Zzd2G4A+wVzBmH0MPlMh36yLBZXkZ1P5V7REz3
	YY8WAnwftIAki1x0OEiKs6nAXTa//ALqKAmmSnib9+23xspxEAra4glWLVJlomEjWu61cG
	ecA8Uu8LpMhJnmYboQSuosorUjcoaIs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-MO3eFGxyP_WlPb9UlVztHw-1; Mon, 08 Apr 2024 09:34:36 -0400
X-MC-Unique: MO3eFGxyP_WlPb9UlVztHw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5193fab7e5so258749166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 06:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712583275; x=1713188075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuUwyTIFNAAmDTH2Rd92jK7L5iSQ6LqiXDS++XcJumA=;
        b=jKqj+Ah55RYoU2z7QbXEN8YC9/l49QB0X0r9aCvStf5LlgO3Idn7ZKh4nNj6A45a0q
         O/7KCPbDaB5TUJas4NRY1YahC5F5NLFhk9pENLq53WpMdTXhqnuuFxA9uKz6pn0h69gw
         3aqGvA2F38hFoVW7QC8c/zHC9DBW/Ix9KgOJ/B945jhiVkB+G7RrhTbHSZY0U3JaWaWv
         dtLERQ4Qw42hqsmkyDmXBgIs0Z2KDhNfOZCHno4kB64MIsr7T7lqSNTzScyMz6RIfhrL
         XvVqMTAKV6AtFNJB6Y7W+pQIGDZ2rcrPEnxJZAKOUmmKwBs0xD4MUCOzTxo1G1UzPnxg
         9fFA==
X-Forwarded-Encrypted: i=1; AJvYcCUf6kHx3Zcdhtnbgkv9hC2IrnLuNXGgUjrIK6RAHLq3lnNmrEzfkQNh4dRiPGn0GKFKDw7UXEMgbrO5Ur2oFJx7CKDxzpQqwL/sKY6A
X-Gm-Message-State: AOJu0YzocMCr/JYFbJNqdK8dG8NmHHa+iTkvo1XwDQU6DklvywvDURPK
	Ih78/4J2tL42UoE95hysZymxyASjl9F5/GTLEmJKQr3eC3JBdDZcqmHV2byVKcHxo77hVuGrPz6
	gwOxX5zAeFP/5C15MUO+mBiAvuyFXdidhKaxVd/LjPFWNsnEjKO7S9uL588sxrA==
X-Received: by 2002:a17:907:7208:b0:a51:ae39:d385 with SMTP id dr8-20020a170907720800b00a51ae39d385mr5939678ejc.1.1712583275573;
        Mon, 08 Apr 2024 06:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAfO/S8cCOmMgZdHRlghf1andXZ7MuDfRNwmNMAo7kZApWUtB7UFaFA6lrh5BsCl7NnBhuuQ==
X-Received: by 2002:a17:907:7208:b0:a51:ae39:d385 with SMTP id dr8-20020a170907720800b00a51ae39d385mr5939658ejc.1.1712583275203;
        Mon, 08 Apr 2024 06:34:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kh21-20020a170906f81500b00a51d073da7esm1846284ejb.82.2024.04.08.06.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 06:34:34 -0700 (PDT)
Message-ID: <4d757662-a0a9-4c79-98b8-eb54503ed9fc@redhat.com>
Date: Mon, 8 Apr 2024 15:34:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: surface_temp: Add support for sensor names
To: Maximilian Luz <luzmaximilian@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
 <20240330112409.3402943-3-luzmaximilian@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240330112409.3402943-3-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/30/24 12:24 PM, Maximilian Luz wrote:
> From: Ivor Wanders <ivor@iwanders.net>
> 
> The thermal subsystem of the Surface Aggregator Module allows us to
> query the names of the respective thermal sensors. Forward those to
> userspace.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Co-developed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/hwmon/surface_temp.c | 112 +++++++++++++++++++++++++++++------
>  1 file changed, 95 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwmon/surface_temp.c b/drivers/hwmon/surface_temp.c
> index 48c3e826713f6..7a2e1f638336c 100644
> --- a/drivers/hwmon/surface_temp.c
> +++ b/drivers/hwmon/surface_temp.c
> @@ -17,6 +17,27 @@
>  
>  /* -- SAM interface. -------------------------------------------------------- */
>  
> +/*
> + * Available sensors are indicated by a 16-bit bitfield, where a 1 marks the
> + * presence of a sensor. So we have at most 16 possible sensors/channels.
> + */
> +#define SSAM_TMP_SENSOR_MAX_COUNT 16
> +
> +/*
> + * All names observed so far are 6 characters long, but there's only
> + * zeros after the name, so perhaps they can be longer. This number reflects
> + * the maximum zero-padded space observed in the returned buffer.
> + */
> +#define SSAM_TMP_SENSOR_NAME_LENGTH 18
> +
> +struct ssam_tmp_get_name_rsp {
> +	__le16 unknown1;
> +	char unknown2;
> +	char name[SSAM_TMP_SENSOR_NAME_LENGTH];
> +} __packed;
> +
> +static_assert(sizeof(struct ssam_tmp_get_name_rsp) == 21);
> +
>  SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_get_available_sensors, __le16, {
>  	.target_category = SSAM_SSH_TC_TMP,
>  	.command_id      = 0x04,
> @@ -27,6 +48,11 @@ SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_temperature, __le16, {
>  	.command_id      = 0x01,
>  });
>  
> +SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_name, struct ssam_tmp_get_name_rsp, {
> +	.target_category = SSAM_SSH_TC_TMP,
> +	.command_id      = 0x0e,
> +});
> +
>  static int ssam_tmp_get_available_sensors(struct ssam_device *sdev, s16 *sensors)
>  {
>  	__le16 sensors_le;
> @@ -54,12 +80,37 @@ static int ssam_tmp_get_temperature(struct ssam_device *sdev, u8 iid, long *temp
>  	return 0;
>  }
>  
> +static int ssam_tmp_get_name(struct ssam_device *sdev, u8 iid, char *buf, size_t buf_len)
> +{
> +	struct ssam_tmp_get_name_rsp name_rsp;
> +	int status;
> +
> +	status =  __ssam_tmp_get_name(sdev->ctrl, sdev->uid.target, iid, &name_rsp);
> +	if (status)
> +		return status;
> +
> +	/*
> +	 * This should not fail unless the name in the returned struct is not
> +	 * null-terminated or someone changed something in the struct
> +	 * definitions above, since our buffer and struct have the same
> +	 * capacity by design. So if this fails blow this up with a warning.
> +	 * Since the more likely cause is that the returned string isn't
> +	 * null-terminated, we might have received garbage (as opposed to just
> +	 * an incomplete string), so also fail the function.
> +	 */
> +	status = strscpy(buf, name_rsp.name, buf_len);
> +	WARN_ON(status < 0);
> +
> +	return status < 0 ? status : 0;
> +}
> +
>  
>  /* -- Driver.---------------------------------------------------------------- */
>  
>  struct ssam_temp {
>  	struct ssam_device *sdev;
>  	s16 sensors;
> +	char names[SSAM_TMP_SENSOR_MAX_COUNT][SSAM_TMP_SENSOR_NAME_LENGTH];
>  };
>  
>  static umode_t ssam_temp_hwmon_is_visible(const void *data,
> @@ -83,33 +134,47 @@ static int ssam_temp_hwmon_read(struct device *dev,
>  	return ssam_tmp_get_temperature(ssam_temp->sdev, channel + 1, value);
>  }
>  
> +static int ssam_temp_hwmon_read_string(struct device *dev,
> +				       enum hwmon_sensor_types type,
> +				       u32 attr, int channel, const char **str)
> +{
> +	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
> +
> +	*str = ssam_temp->names[channel];
> +	return 0;
> +}
> +
>  static const struct hwmon_channel_info * const ssam_temp_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(chip,
>  			   HWMON_C_REGISTER_TZ),
> -	/* We have at most 16 thermal sensor channels. */
> +	/*
> +	 * We have at most SSAM_TMP_SENSOR_MAX_COUNT = 16 thermal sensor
> +	 * channels.
> +	 */
>  	HWMON_CHANNEL_INFO(temp,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT,
> -			   HWMON_T_INPUT),
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
>  	NULL
>  };
>  
>  static const struct hwmon_ops ssam_temp_hwmon_ops = {
>  	.is_visible = ssam_temp_hwmon_is_visible,
>  	.read = ssam_temp_hwmon_read,
> +	.read_string = ssam_temp_hwmon_read_string,
>  };
>  
>  static const struct hwmon_chip_info ssam_temp_hwmon_chip_info = {
> @@ -122,6 +187,7 @@ static int ssam_temp_probe(struct ssam_device *sdev)
>  	struct ssam_temp *ssam_temp;
>  	struct device *hwmon_dev;
>  	s16 sensors;
> +	int channel;
>  	int status;
>  
>  	status = ssam_tmp_get_available_sensors(sdev, &sensors);
> @@ -135,6 +201,18 @@ static int ssam_temp_probe(struct ssam_device *sdev)
>  	ssam_temp->sdev = sdev;
>  	ssam_temp->sensors = sensors;
>  
> +	/* Retrieve the name for each available sensor. */
> +	for (channel = 0; channel < SSAM_TMP_SENSOR_MAX_COUNT; channel++) {
> +		if (!(sensors & BIT(channel)))
> +			continue;
> +
> +		status = ssam_tmp_get_name(sdev, channel + 1,
> +					   ssam_temp->names[channel],
> +					   SSAM_TMP_SENSOR_NAME_LENGTH);
> +		if (status)
> +			return status;
> +	}
> +
>  	hwmon_dev = devm_hwmon_device_register_with_info(&sdev->dev,
>  			"surface_thermal", ssam_temp, &ssam_temp_hwmon_chip_info,
>  			NULL);


