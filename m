Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CBE80733D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442081AbjLFPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378993AbjLFPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5401BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701874865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dOg7HAEWpXF9CsdFUNxvCGFVvkmTsr7J73fSYQBJM0c=;
        b=QyjvJBeiX1E84Zvw7rTOUqT+H36yZ0Lqq+18bnnx1rZNxWBJUhgB5wzyn2399l24RscI/E
        5XX1u69uY7vnwry59540sDMUPn+pxsHj1epZCStocEJgBaQBih03qGAQiOxAxnMhXGgxXD
        oN9R5ma/aosQaXsaMVXP5DIm4wuUGc4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-d7XZzaunPCGakobKpF9_DQ-1; Wed, 06 Dec 2023 10:01:04 -0500
X-MC-Unique: d7XZzaunPCGakobKpF9_DQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1cfd84b473so105261966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701874863; x=1702479663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOg7HAEWpXF9CsdFUNxvCGFVvkmTsr7J73fSYQBJM0c=;
        b=BkuUtNRHND5Gx3QHd2lk1AcE6P3qyUs4ivlrGJqq7mycL5pvQrF8mzSZk/82G3NxHY
         eOXK0LAWka1IAPZVa6uQgvQeOwEyo9LfFl9K2hqwzFEupM4chArJqsgzoNWzr7jqr4P6
         arkMR+ahE1z2VFTopgrfb3BdSHCEELuoZ3Uk7JWIkgE3/jh4m2tn2sz/X6bqT+7Su8Kb
         +svetopQFJydsrVPlOlpI9Khaxzw5K9n/9bl6yHlxcXGKBijIHfnp9/7qhlZPTeCInUG
         7CcMhmnwDrPoRm2+ZWrMsW+H7nLXnMSzcL5TVpwjKaB3dKChint5M8CMlh5jr1cb54ic
         WYFA==
X-Gm-Message-State: AOJu0Ywyrqa/YHFVsg5qDdHWKW9W1GMEhIfA1hYRdSeXTRJH9EXibrMT
        bhO+vSQCzhZvXy/4zWMmkKau+l/fn40oCRG/C3SiIZv358j25bej3o1yGqIjk1M0Zv2+/T64zs8
        SEbFbhgx6n6kIcdG/GsbNeRSz
X-Received: by 2002:a17:906:207:b0:9ad:8a96:ad55 with SMTP id 7-20020a170906020700b009ad8a96ad55mr3351772ejd.14.1701874863013;
        Wed, 06 Dec 2023 07:01:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc2iizgPGK0ASX2Lu5JUlmiNsXLAMQISUNLo9xAMCsPCxJYJkGgUwN23XU1+bxfd5zfQWGqw==
X-Received: by 2002:a17:906:207:b0:9ad:8a96:ad55 with SMTP id 7-20020a170906020700b009ad8a96ad55mr3351759ejd.14.1701874862671;
        Wed, 06 Dec 2023 07:01:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709063e4700b00a1dc7e789fbsm31636eji.21.2023.12.06.07.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 07:01:02 -0800 (PST)
Message-ID: <81798fe5-f89e-482f-b0d0-674ccbfc3666@redhat.com>
Date:   Wed, 6 Dec 2023 16:01:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] devm-helpers: introduce devm_mutex_init
Content-Language: en-US, nl
To:     George Stark <gnstark@salutedevices.com>, pavel@ucw.cz,
        lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mazziesaccount@gmail.com, andy.shevchenko@gmail.com,
        jic23@kernel.org
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
References: <20231204180603.470421-1-gnstark@salutedevices.com>
 <20231204180603.470421-2-gnstark@salutedevices.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231204180603.470421-2-gnstark@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On 12/4/23 19:05, George Stark wrote:
> Using of devm API leads to certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() is
> extended so introduce devm_mutex_init().
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>  include/linux/devm-helpers.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
> index 74891802200d..2f56e476776f 100644
> --- a/include/linux/devm-helpers.h
> +++ b/include/linux/devm-helpers.h
> @@ -76,4 +76,22 @@ static inline int devm_work_autocancel(struct device *dev,
>  	return devm_add_action(dev, devm_work_drop, w);
>  }
>  
> +static inline void devm_mutex_release(void *res)
> +{
> +	mutex_destroy(res);
> +}
> +
> +/**
> + * devm_mutex_init - Resource-managed mutex initialization
> + * @dev:	Device which lifetime work is bound to
> + * @lock:	Pointer to a mutex
> + *
> + * Initialize mutex which is automatically destroyed when driver is detached.
> + */
> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
> +{
> +	mutex_init(lock);
> +	return devm_add_action_or_reset(dev, devm_mutex_release, lock);
> +}
> +
>  #endif

mutex_destroy() only actually does anything if CONFIG_DEBUG_MUTEXES
is set, otherwise it is an empty inline-stub.

Adding a devres resource to the device just to call an empty inline
stub which is a no-op seems like a waste of resources. IMHO it
would be better to change this to:

static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
{
	mutex_init(lock);
#ifdef CONFIG_DEBUG_MUTEXES
	return devm_add_action_or_reset(dev, devm_mutex_release, lock);
#else
	return 0;
#endif
}

To avoid the unnecessary devres allocation when
CONFIG_DEBUG_MUTEXES is not set.

Regards,

Hans




