Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83C3765D80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjG0UjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0UjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:39:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B652D45;
        Thu, 27 Jul 2023 13:39:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686c06b806cso1099551b3a.2;
        Thu, 27 Jul 2023 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690490359; x=1691095159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zyITX45GpTXogJEYiZE6OHZHfNoVROM05QVwzgFFXYA=;
        b=QJEMg4MLxn+7tFi87dopB1hZODqle5ugHUWYODjrVyV+DhqzI30Eus2HYksloZQ4yd
         CgxytAd8QEs2JEIbfCv2NI5vy9kOkZOni8GJmLEdo9/5lpbbhFt5dsYqeKOVdUsImLC+
         qLYjUJ993nDinpi98+B8mfcIN43wEX1hDb2tpm3s4lDz5lT3mFGnK9u2Q1/2Af1TNEl6
         Zhqd0RGKhYPfKAaVw5uF0eg9djhnW6p1Hhz87Mriy5melImdvRye9X1Wjv/CaD2w3GaO
         l5oPwm0FwNaBIA4U4RzVyFagjzwxg0xEZKQUUDpc0oZpttBnkPYrI8KoE2AKRI8wKc18
         MCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690490359; x=1691095159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyITX45GpTXogJEYiZE6OHZHfNoVROM05QVwzgFFXYA=;
        b=ZnlmvDV9V/OLnQl5ja4Jp5ltCckUFbrhxbwRbrEu/FmeJf0fLH7By7CGCe5/BOaNX1
         En4fxqzmZoAnzN/Fo3WPcR5+KUSQ/5e56d8c1j8yrmDcezCuPQcrVk+53PLu5FTaK4OK
         b8q2aFQ8yyeU+Munso1ltLQAslz/6X9dQL9ZMkZv9DwgOiU21OrAdKQBCjaoSlAfXsYZ
         INU+SjW7SfFpmHzCrwjTezREn68e15TweBXKSlqLBWTCLV4hThX/OH6GVvZ+23JdEZ3g
         XcO6RM13jK3n8G17y6hGOTC349Sgi7KCAtAJN309Trgjigc1K/Y5ci9Vr7E6+wW3OcQf
         9tIw==
X-Gm-Message-State: ABy/qLagmLB/GADj/0T9Ff7ctrIZkAG7qQxGmG0pBsOoi2V7SSyuGWwT
        Hdo2mqM4NlBDBhMPK7wslcBV6b4sqII=
X-Google-Smtp-Source: APBJJlH1lJRrzhf5NSYBO/uT93iCsBwZhWljDil9fKues7o5iNj42FFroJfdizBjNUSJKJhu386rrw==
X-Received: by 2002:a05:6a20:7f88:b0:133:c9f0:ce66 with SMTP id d8-20020a056a207f8800b00133c9f0ce66mr216658pzj.18.1690490359329;
        Thu, 27 Jul 2023 13:39:19 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9b75:ab53:f898:d12d])
        by smtp.gmail.com with ESMTPSA id s12-20020a62e70c000000b00686bf824b3bsm1865233pfh.136.2023.07.27.13.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:39:18 -0700 (PDT)
Date:   Thu, 27 Jul 2023 13:39:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH] Input: ads7846 - don't set ABS_PRESSURE when min == max
Message-ID: <ZMLV9BVxHx3jlE5R@google.com>
References: <20230727-ads7846-pressure-v1-1-fa74c7680191@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727-ads7846-pressure-v1-1-fa74c7680191@skidata.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, Jul 27, 2023 at 05:19:57PM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> When the optional fields "pressure_min" and "pressure_max" are not set,
> both fall back to 0, which results to the following libinput error:
> 
> ADS7846 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE
> 
> Avoid it by only setting ABS_PRESSURE if the values differ.

What is the benefit of silently continuing without reporting pressure on
models that do support pressure readings, vs. using libinput's errors as
signal to adjust DT?

> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  drivers/input/touchscreen/ads7846.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index faea40dd66d0..2535424a5630 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1281,7 +1281,7 @@ static int ads7846_probe(struct spi_device *spi)
>  			pdata->y_min ? : 0,
>  			pdata->y_max ? : MAX_12BIT,
>  			0, 0);
> -	if (ts->model != 7845)
> +	if (ts->model != 7845 && pdata->pressure_min != pdata->pressure_max)
>  		input_set_abs_params(input_dev, ABS_PRESSURE,
>  				pdata->pressure_min, pdata->pressure_max, 0, 0);
>  
> 
> ---
> base-commit: 451cc82bd11eb6a374f4dbcfc1cf007eafea91ab
> change-id: 20230727-ads7846-pressure-05edfb01887f
> 
> Best regards,
> -- 
> Benjamin Bara <benjamin.bara@skidata.com>
> 

Thanks.

-- 
Dmitry
