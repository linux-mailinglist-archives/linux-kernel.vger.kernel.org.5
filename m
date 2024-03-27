Return-Path: <linux-kernel+bounces-120683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6495A88DB66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F3129AA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC155024E;
	Wed, 27 Mar 2024 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3kT1zfz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5247F54
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536200; cv=none; b=SEhoIPFLBLWkii4gNybzwLqUOX5zz9yDexMg2q/MBd9knBgOn5RB98g2iWlyWw7DvNRIqvwVJRHowf6c7nXeMJbNUAB2QTH47pnrp5fJeregWRJadz2U08YijU5fJSBPPa7rTkieMsFZxGUy08kVT/Awq1tuhMk3rmpqDpylrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536200; c=relaxed/simple;
	bh=7MAZ1oJYx2he2O/U2IQ1vXCKiFiHly3gLB+lXSIflb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThXmDdj4OJnVMqzN6vNClfBpXiIWXdWqvDY+/WxeawFfGY7XRD6/2vaWn/l1aaFn8E2+gH8vKn9fvjM7RFOrP4XxPgxTzc2vacxcH3a9csOfzkspjIXT3NoUfkcH7MVq1s0FD+XdjpxjKogCsfqqFuMTARIzth2jfgZW08531Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3kT1zfz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711536198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFsd9d7Gos7i1/b5V+OTo42Y7I+kMeOk7bouc9bj640=;
	b=M3kT1zfzI3MT8mJgGzfjGGOdiLPq7bUKdZQ8Eu0+MB7/7/iIfKi1S4Jl26/D9FUTNukKe7
	BUp0za1sXNAK9sh/X8ifzr7I8+BrkiiGO3Cxxsr2nQDH1TdbCMB5f5WmpOr826zDoZHYDb
	zDk1Sgo2+babLPLxzs4bOeyTbbfipmg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-pKho5eaNPHiIDmxDcS1w2g-1; Wed, 27 Mar 2024 06:43:15 -0400
X-MC-Unique: pKho5eaNPHiIDmxDcS1w2g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4751d193caso171152666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711536194; x=1712140994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFsd9d7Gos7i1/b5V+OTo42Y7I+kMeOk7bouc9bj640=;
        b=FGN/4norh4zblHJa4it1BqiapvLj2AhDaLvqkYtRXvfslHSGl3//ckxl/GgeiYw4Tu
         v80fFz0tiXAAcYfJEKA95MWpKmRxcb7JAPplt6+TXjX3Pk8hPLpoxrgbIyVp2jSlptWu
         HaeMLmCVlmFfbbpaQVM73WFIjwhEYldmtX4DdfyPUOuwg5Dw81WncT1JTftFQLbBt3U7
         f34FBDBxgFvNIPbZg2jDfyuJ87pQWR/DH3UkyyreMZIqJ0nwX9JX5UYUiCJ7S5Dw8WHp
         SixtoVlekYq6b2sJ/ppj4ZZG19Lyw89Hy8Bh3P9hGvZ0RUc9pEK/ghec4IZfQp2c8FjK
         2pDg==
X-Forwarded-Encrypted: i=1; AJvYcCW7zkWlal0uueLXklfIURYmcRPfSJYra+PFTFN5tw611qOahuBTNFbFROkbkfrvFqnkoeyXiaqno+H8SI6gQEJAXZ/x7Yv24ddsWcMy
X-Gm-Message-State: AOJu0Ywhbjtqt3yju6BaLABrKsmTsFYIlgr53wfhMPMpfw4TZdzXBzmu
	DgHGvxTfSS7Hb2YvTIHdY5hnx2jMsO7AbN0AAHoskphTYWDaJNkG2GziXA1Crw/qk/DdpTStWpl
	u1n7LAbYDhcjb1jIHsoKZtBVmS35hVD22lbEJowMb8dg6rGdkJzu77/YfLkJBlQ==
X-Received: by 2002:a17:906:b310:b0:a4d:ff60:23e with SMTP id n16-20020a170906b31000b00a4dff60023emr1355419ejz.11.1711536194208;
        Wed, 27 Mar 2024 03:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/F3TWm576rM7znpuR1Ur2IS4OPqOiCggxfDxScn/bJpxRgIpLeOjAepMa+WykCQOkbHV5jA==
X-Received: by 2002:a17:906:b310:b0:a4d:ff60:23e with SMTP id n16-20020a170906b31000b00a4dff60023emr1355408ejz.11.1711536193870;
        Wed, 27 Mar 2024 03:43:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090663d100b00a468bcde79bsm5311110ejk.109.2024.03.27.03.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:43:13 -0700 (PDT)
Message-ID: <9e035ae4-cb07-4f84-8336-1a0050855bea@redhat.com>
Date: Wed, 27 Mar 2024 11:43:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] power: supply: core: fix charge_behaviour
 formatting
Content-Language: en-US, nl
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-3-8ebb0a7c2409@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-3-8ebb0a7c2409@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 3/3/24 4:31 PM, Thomas Weißschuh wrote:
> This property is documented to have a special format which exposes all
> available behaviours and the currently active one at the same time.
> For this special format some helpers are provided.
> 
> However the default property logic in power_supply_sysfs.c is not using
> the helper and the default logic only prints the currently active
> behaviour.
> 
> Adjust power_supply_sysfs.c to follow the documented format.
> 
> There are currently two in-tree drivers exposing charge behaviours:
> thinkpad_acpi and mm8013.
> thinkpad_acpi is not affected by the change, as it directly uses the
> helpers and does not use the power_supply_sysfs.c logic.
> 
> As mm8013 does not set implement desc->charge_behaviours.
> the new logic will preserve the simple output format in this case.

Since patch 1/3 now drops the charge behaviours from mm8013 I believe
these 2 paragraphs should be replaced with:

"""
thinkpad_acpi. is the only in-tree drivers currently exposing charge
behaviours. thinkpad_acpi is not affected by the change, as it directly
uses the helpers and does not use the power_supply_sysfs.c logic.
"""

> Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/power/supply/power_supply_sysfs.c | 20 ++++++++++++++++++++
>  include/linux/power_supply.h              |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 10fec411794b..a20aa0156b0a 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -271,6 +271,23 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> +						  struct power_supply *psy,
> +						  union power_supply_propval *value,
> +						  char *buf)
> +{
> +	int ret;
> +
> +	ret = power_supply_get_property(psy,
> +					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +					value);
> +	if (ret < 0)
> +		return ret;

power_supply_show_property() has already called power_supply_get_property()
before calling this, so this call can be dropped. At which point
power_supply_show_charge_behaviour() becomes just a wrapper around
power_supply_charge_behaviour_show() and thus can be dropped itself.

And then ... (continued below).

> +
> +	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
> +						  value->intval, buf);
> +}
> +
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf) {
> @@ -303,6 +320,9 @@ static ssize_t power_supply_show_property(struct device *dev,
>  		ret = power_supply_show_usb_type(dev, psy->desc,
>  						&value, buf);
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		ret = power_supply_show_charge_behaviour(dev, psy, &value, buf);

replace this line with:

		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
							 value.intval, buf);

Making this patch a nice simple patch :)

Regards,

Hans




> +		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret = sysfs_emit(buf, "%s\n", value.strval);
>  		break;
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index c0992a77feea..a50ee69503bf 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -242,6 +242,7 @@ struct power_supply_config {
>  struct power_supply_desc {
>  	const char *name;
>  	enum power_supply_type type;
> +	u8 charge_behaviours;
>  	const enum power_supply_usb_type *usb_types;
>  	size_t num_usb_types;
>  	const enum power_supply_property *properties;
> 


