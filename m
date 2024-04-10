Return-Path: <linux-kernel+bounces-138434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E434689F12D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9E11C21B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E815ADAA;
	Wed, 10 Apr 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V77AW2D6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D882837B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749717; cv=none; b=lYdZsmkN2oI6LmzuMI2GAqqZwa35BVL2cW/02POPEvUj3RPayu08vAVSpCzIcC9USUK79ZQfJiRTkReeMm8aRdtJzCVKV+b+PB/VRDCAmZrfxu3bTExYs8P6MQgN5cbQYusMF9Dt4Cv0k/5t/05zWbGfkPywxFmdZISbircreJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749717; c=relaxed/simple;
	bh=KSk84KldP3i/N39dUMXd2SrMF4EJlh8o6xnwO4yPJHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TM+P3s8iGT0SuibVZfho+hmm/I7wbzhITN6+vjYlK+t5w01ikPcqLH48xS/397HdHAleWpi81ryPJBpLvUl6lGxOgafEarlJBDLOow60QCTWOxGM1vcoL1paG/YomG3V46YmPwq6OPqHHBDz0Bf6+i2fD14mCIqLw7OTJ8/9r5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V77AW2D6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712749714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Hgz+WKKNpX8kuTtB/qmB4UwO1pKBtPOgiyiwsLQlcQ=;
	b=V77AW2D6feltAtJSGG4LXacn4rpPiFJ7Rx3WrMuWcMYpdBInwqcPBlMGiSDgIZNWr5qp+J
	vZCbaXuJOndaMl/m1rzBcApsVBr7kCe4I5IXuvg0BOJBccw9WO8x5KD1nXhO3rsGIsYxcw
	PkRK3kCZNlmZWGFsZRLpA4i0clrH8RU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-zCzRxK9UPZq2FsMWa5qBhQ-1; Wed, 10 Apr 2024 07:48:33 -0400
X-MC-Unique: zCzRxK9UPZq2FsMWa5qBhQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51b00fc137so303296366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712749712; x=1713354512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hgz+WKKNpX8kuTtB/qmB4UwO1pKBtPOgiyiwsLQlcQ=;
        b=UxtwOiZi8Ycdx2AszCnvMtDYCRACF8xVLdF7INu9uESyUXq/I8ezijxh0ShuunmgDx
         iJq5hanUjciooCYz+SZ4mKjrsl44ZdfzApl94b7eh6Nd3xkfkk+hYNyqQSMRMVVWV/zD
         OhWrh2ctQgFHXRJdQtQldLEuhjiXc0BalQcBLjhHjPVMrM8zc50BkFShcSa8mI8aJzoP
         d7TcP+2C058udhTXzv2kTaQ0Ga55EBB+Id4CvWG2JgJz7teU0Gqmk33ALvg2jn03iF+1
         ejnIETt3sGlPlLhJkOm2AI4wLeXskMlP84ZUqnTxCF7gy8LKQmpkfnfAD70tGbn5804H
         JfCg==
X-Forwarded-Encrypted: i=1; AJvYcCUFpsCm2+AZpmLXXtm6vw4HlA27rZ2/I3t1sM3sg4rSNq69CG9z+LceabtegsnqzduLQaTGNW5EuoIYGP+RAMkg6BiYxNedGSL/WGmy
X-Gm-Message-State: AOJu0YwtQrEAgDteg62Zri+dSBGJm/BmtNAbWd2JTMAh034PgvADLi+E
	yRpJ7qdm2sEMJjfKBqiMeT5m0omDDRFx0f5vpHcSK25NlktANPBYga6aYaeU7ojgQFZAvEieGm0
	TUoZVgoeaKHrCznrd7uU8Zbtj9gOKsMz/7K/25LTuxnrFO2/pERCzqmJUxDGDmw==
X-Received: by 2002:a17:906:66c8:b0:a4e:4e76:5fc7 with SMTP id k8-20020a17090666c800b00a4e4e765fc7mr1634794ejp.65.1712749712021;
        Wed, 10 Apr 2024 04:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkcmmuuLNmbHAa9veWZrKrdL2BsI5D3agKppJCjJD/xmaktuasqemf2nxiHYY8y1tBaQo+9g==
X-Received: by 2002:a17:906:66c8:b0:a4e:4e76:5fc7 with SMTP id k8-20020a17090666c800b00a4e4e765fc7mr1634772ejp.65.1712749711612;
        Wed, 10 Apr 2024 04:48:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b00a51cdf560b9sm4433981ejb.37.2024.04.10.04.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 04:48:31 -0700 (PDT)
Message-ID: <d330e0fa-fc50-4920-9000-c6343f5f101b@redhat.com>
Date: Wed, 10 Apr 2024 13:48:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] media: v4l: Don't turn on privacy LED if streamon
 fails
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
Cc: tomi.valkeinen@ideasonboard.com,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Umang Jain <umang.jain@ideasonboard.com>, linux-kernel@vger.kernel.org
References: <20240410114712.661186-1-sakari.ailus@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240410114712.661186-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/10/24 1:47 PM, Sakari Ailus wrote:
> Turn on the privacy LED only if streamon succeeds. This can be done after
> enabling streaming on the sensor.
> 
> Fixes: b6e10ff6c23d ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 4c6198c48dd6..012b757eac9f 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -412,15 +412,6 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  	if (WARN_ON(!!sd->enabled_streams == !!enable))
>  		return 0;
>  
> -#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> -	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> -		if (enable)
> -			led_set_brightness(sd->privacy_led,
> -					   sd->privacy_led->max_brightness);
> -		else
> -			led_set_brightness(sd->privacy_led, 0);
> -	}
> -#endif
>  	ret = sd->ops->video->s_stream(sd, enable);
>  
>  	if (!enable && ret < 0) {
> @@ -428,9 +419,20 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  		ret = 0;
>  	}
>  
> -	if (!ret)
> +	if (!ret) {
>  		sd->enabled_streams = enable ? BIT(0) : 0;
>  
> +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> +		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
> +			if (enable)
> +				led_set_brightness(sd->privacy_led,
> +						   sd->privacy_led->max_brightness);
> +			else
> +				led_set_brightness(sd->privacy_led, 0);
> +		}
> +#endif
> +	}
> +
>  	return ret;
>  }
>  


