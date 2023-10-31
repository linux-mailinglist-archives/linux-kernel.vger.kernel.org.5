Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5D7DC884
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjJaIj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjJaIjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:39:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E345918F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:38:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b7f3f470a9so3606659a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698741495; x=1699346295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28DXBAYX1XRtP2wWeR8rEQtVtlzWFlh45fzZ3wUwj5Y=;
        b=eA9m+CUvm1HqM496Wb7XJXTX8jdqPpS1zzBpe4cZteYx43SrFTfz/uM6oPLZ0u/a63
         9ATe395o4autr7RBpEsAXKaeSk6gYROtRg/gK1O5Ba7IvcXf1OiYkI9AQfV6zxGUA3MR
         E8GzsqXqumCveOn0ZtFo7ij4BmM9VTLpuHA7cqJN3NopCUDRvZENLz7v5EBgPFRFs/kh
         129PhNGECELk0BR3BmTcbTm6knTL94mig8IXUg9Zw99TmYLGvlq4yLgIa1SJjy1dMXaW
         swL0T/UM5gRN68WCr/LJXuzeSQRV6BDRGdyukNuFj3JsD9v39Cf2qUwQNStIUPnqRKSM
         T9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698741495; x=1699346295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28DXBAYX1XRtP2wWeR8rEQtVtlzWFlh45fzZ3wUwj5Y=;
        b=qsjNETAzbdkXlgld/ZrAaZdfHw/JdJHIbp7QVEbRGHLZ/Sdd9DledD3ye1dYHjWrge
         k02elEmudGzYPWvhs+KVisnwz8VA2DkNp2KT+nhkt4kWWvXf/KPnv9j0WkUBcvEd6WwR
         ceKyzt5GCCOwX0V2bipNHF6SOfbMzQm8HspM09Rf03wVMaaoh5HD+A5x6YfCPtUcvxU9
         Mq+hAM+U7IOCiE8lYYTKMFVVgOyb3Zcz1kup89JsOtzVVP4V0jFgxcm5ImhFZCQ0Uzbb
         Xgab0jcrpBVuk9RV9i75QKUe3B5qwDHYjo50Bw+2Sx7ndpn5H8WlHBzZR5YUb0XQpqWU
         bhhQ==
X-Gm-Message-State: AOJu0YxV5wjen8JVV4bITAxOxyPell8EPtgI/hHzNb7nuAbYvI0ttRHf
        jFTyaOfeYTX0c2aG9c28aOfuRA==
X-Google-Smtp-Source: AGHT+IHxkBTG12jtDz6LskO7p7yf/0lY5uSyZBd4OmXP62L9S3rUvHiBXN4T9B04oSxoA88vrWaQJw==
X-Received: by 2002:a05:6a20:7f87:b0:15b:c800:48af with SMTP id d7-20020a056a207f8700b0015bc80048afmr12323973pzj.23.1698741495120;
        Tue, 31 Oct 2023 01:38:15 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:d7db:fc6b:2721:a9be? (2403-580d-82f4-0-d7db-fc6b-2721-a9be.ip6.aussiebb.net. [2403:580d:82f4:0:d7db:fc6b:2721:a9be])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090282ca00b001c1f4edfb9csm792534plz.173.2023.10.31.01.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 01:38:14 -0700 (PDT)
Message-ID: <2974aa13-796c-49ef-bef7-fd7f3f9b7f49@tweaklogic.com>
Date:   Tue, 31 Oct 2023 19:08:08 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <20231028162025.4259f1cc@jic23-huawei>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20231028162025.4259f1cc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>> +static struct iio_event_spec apds9306_event_spec_als[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_RISING,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_FALLING,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> This matches an entry above for type. Don't have separate entries.
>> +	},
>> +};
>> +
>> +static struct iio_event_spec apds9306_event_spec_clear[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +};
>> +
>> +#define APDS9306_CHANNEL(_type) \
>> +	.type = _type, \
>> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | \
>> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | \
>> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> 
> Scale on the intensity channel is interesting...  What are the units?
> There tend not to be any well defined units for intensity (as opposed
> to illuminance).  There may be gain on the signal, but it won't be in untils
> that map directly to a scale userspace should apply.  This is one of the
> rare reasons for using the HARDWARE_GAIN element of the ABI.
> 
> A tricky corner however as relationship between raw value and hardwaregain
> is not tightly defined (as it can be really weird!)
Hi Jonathan,

Thank you for taking time for reviewing and clearing all my tiny doubts and
queries especially for the dt and versioning part. Much appreciated.

In the above case, should I not expose scale for the "clear" channel? Rather,
how should I expose the "clear" channel to userspace?

Regards,
Subhajit Ghosh

> 
>> +
>> +static struct iio_chan_spec apds9306_channels_without_events[] = {
>> +	{
>> +		APDS9306_CHANNEL(IIO_LIGHT)
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +	}, {
>> +		APDS9306_CHANNEL(IIO_INTENSITY)
>> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.modified = 1,
>> +	},
>> +};
> 


