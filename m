Return-Path: <linux-kernel+bounces-52364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5118F849723
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DCB289619
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E7134A9;
	Mon,  5 Feb 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMgcCBNT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075F12E71
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127147; cv=none; b=RD7MXHD4V0/LActNq6uv5ZCAqfYmhwHpaHOf+MXaDpNJt8ms/byx/72QI30mxX184lR5mw1jzfbAPuwSuEld1B13c9Stic4+wSgBOTPRlQOc0jmN5QxLKZwFf/WTT7qFICpRGkQG6EewaeQSwZfm4P76ZCIgQO9yHG4YgvUwSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127147; c=relaxed/simple;
	bh=b92Et2DKhcyog6J47YUJMcwyYAegyfdYl6Uh+aPv74A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8P6VAxzqlfxCqgz49RAJv0xOC+onblqNix4lZWZ7fmYWMNKoDDxhEUxZhus4G30S1R6A2PMuwmVgh0lErqbDVPNGRln+RBdIN1Civ85pJbHlkJgVijeYhtW4W1Uc0m+1tfZ7ceYAz6W314BtKrP9UAMh4Q76JpDKS9ITKZBURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMgcCBNT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707127144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwyUnWvLJnNe+bRoKls+n+VgwPZLrmW2ivHplJ0jsYA=;
	b=jMgcCBNTFv/g6x15aa4HSljlgGqIHXmZCM0pBcDvuZ5Zas3wBuC21iDDcOIBge+Dr68nNc
	+OhCyWE2y5Shl8mGNtuI3r1SpF4LbuhKlhtiqHix0MtVWQsN1Zc3REhebKFnbzehyDmZrx
	lv53SEv75NmZ4yKI1RKoqmTuGBo5PbQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-AGEzIErtM3K2unqLQyI46A-1; Mon, 05 Feb 2024 04:59:02 -0500
X-MC-Unique: AGEzIErtM3K2unqLQyI46A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2cb0d70d6cso261895066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127141; x=1707731941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwyUnWvLJnNe+bRoKls+n+VgwPZLrmW2ivHplJ0jsYA=;
        b=kjogxZJ5Sdkb4E4hYlbCwpmyYu3bqa0bQDjN+sey/SDP9CsGOCu6ZGrGLpqmxv4uBi
         dgSPPxmljKsR1nO+EIKKfgjBfFUNSGjvTnicLPNdWuBh9LcqdNzFnoxr5Y2fnLYRn7gv
         IsNoAz1dgVo3lgf4e2nKwyjbf8Cwzm3UMeQmGuG9clIoC7v+eDBH9+W9/SQd8f+XGgTv
         71/wqt2IP0lQnOCaaL3SSRqIHe8BXyOECaTOh22euv4SXrx9e0coqMrOl4Qgm+OO4/y+
         ecWI3gN1mjKg364WOG0x0mWhw0+b1HxUPd1ruNiDi1yn5LTpDkUASQEfz8YxNJ/D/LR4
         1xjw==
X-Gm-Message-State: AOJu0Yz0ZcDvEaTovMcwa5Y9yTNbaabpCWj2eAuEcIMCo/CE/gZ63LOc
	2WL77JdSQlezs7YPpDAr2PndkH5iPDV5MDiieGBSaenTIVhDheRQdX9Rd6SGBX2g73GK1SE97HW
	alEuia/ihybSxiHfTGAl35fZklJt89Rd+RnzGvL4mmiyqhmQID7VsHgnIJXaseKu5EmVss807
X-Received: by 2002:a17:906:f45:b0:a36:6c96:3161 with SMTP id h5-20020a1709060f4500b00a366c963161mr6602681ejj.32.1707127141450;
        Mon, 05 Feb 2024 01:59:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaOuMXQHjbiVv15+3zhGNVefDvpBZQA2OmktX9TqIOWU0uCVEdS/Him5BHzAhb8OfC5Md9qg==
X-Received: by 2002:a17:906:f45:b0:a36:6c96:3161 with SMTP id h5-20020a1709060f4500b00a366c963161mr6602660ejj.32.1707127141073;
        Mon, 05 Feb 2024 01:59:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbmR08Gr4n2NVg2c2voT6qsslhwvbpLNUuX3+9zcQ0UKxxCe2NORxePOnvdjaxqz05hZREihbacA+Hjs9M4ENNvC9Fu959Gz4tG7MmU/kNJsWkTH2EhTzLMrkkKRsFt4vgqHM/LWALD1cvwxq+HGlEj5FkTN7ZxyLHAtox2IZxJ8oPlUZ3/kTdl2DY4iyfgrGcum7Nrw==
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a20-20020a170906671400b00a34d0a865ecsm4078151ejp.163.2024.02.05.01.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 01:59:00 -0800 (PST)
Message-ID: <47253c5e-4ec3-4794-9cd3-c7aeb95fb5c7@redhat.com>
Date: Mon, 5 Feb 2024 10:59:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] power: supply: test-power: implement charge_behaviour
 property
Content-Language: en-US, nl
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
 <20240204-power_supply-charge_behaviour_prop-v1-2-06a20c958f96@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240204-power_supply-charge_behaviour_prop-v1-2-06a20c958f96@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/4/24 18:26, Thomas Weißschuh wrote:
> To validate the special formatting of the "charge_behaviour" sysfs
> property add it to the example driver.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/test_power.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
> index 0d0a77584c5d..4da0420996c9 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -123,6 +123,14 @@ static int test_power_get_battery_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		val->intval = battery_current;
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE:
> +		val->intval = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
> +			    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
> +			    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
> +		break;
>  	default:
>  		pr_info("%s: some properties deliberately report errors.\n",
>  			__func__);
> @@ -156,6 +164,8 @@ static enum power_supply_property test_power_battery_props[] = {
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_CURRENT_AVG,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
>  };
>  
>  static char *test_power_ac_supplied_to[] = {
> 


