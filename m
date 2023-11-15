Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8772B7ED5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbjKOVUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:20:46 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF46E9B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:20:42 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1f4a9dd83d6so44423fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700083242; x=1700688042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JG4fql6FN6eLKMP7zbsfChcI3MiqU8LxZjWGPH8plw=;
        b=BZz2CaD20o1eWIl/KpUV6UiFxn2tDXVw9v9LKh6FofF9VxjLEIaasFDINXk9Jlb33V
         ZIOWlijKjZX+GFZZ/G5u5Y5Y6mFtfHJ6kHEZHZ0JY/ahke8343AQFlZUj0M13sPwJMag
         cjKhQe/MyEQ16TtvOsF2XexzjpY7KwSHC/o73yTV7eGDJ69k0pPVlobepunfFN2kP/iK
         riyXoQb6SoFsKrsxzDfC+YkWQpt4N69f+0iYUTtau3BnnumcddTJ7cmgzwFX6koEISGe
         cJK0zm8OVs3zXh+Ei5Iaa2yxLQBbAv2UHIIEnX1+fubbMbqXw9UjTMvCb4m6zsi+uxqN
         btHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700083242; x=1700688042;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7JG4fql6FN6eLKMP7zbsfChcI3MiqU8LxZjWGPH8plw=;
        b=M22B9/Uo2DGq/iYjjEDLXmjVec1p5hzirB8G1WWxVu/aezHKjpG2Jap05rXJ8pG81f
         8kR6gu3yroCkeG9BGIkaaEtTJJ93LHj7oQMEawMYqKBLo8dtHJXFZC+o9btxj3/z6Rim
         7sf/+JCa3eMTThWOVdOObv9HJTOHGotfz2YB1RBhcwlj6pwe4nmBJVrB0kZ10K3X4k5y
         NPuoa5ZgRcIcn1ArN5D2oOSuIvmFpitw2Ar9sRYKCnG5XOg1bO+12D639BcLbBQVAGwA
         kGE5GK6AZ7DSpUXJ9TE0ngrc7D9YM02r0c1t4Z0HqaDEs0rPSYU8XpflNczUh/WG5Id7
         9WSQ==
X-Gm-Message-State: AOJu0YxN7SKl8zeDcvs/XDim8N6pItsqAGH7onsOHKAQD50hBqi9u8eT
        P1xtVwG2SfPlwm5Kv1K5HnJgnfQB4g==
X-Google-Smtp-Source: AGHT+IHeeeKhPKvWxCmpe9ba3/cnSmX0znCVUVUwl7rKYPhI8PSBSCTVzgkf2GvJM1Jxa94VEXipGg==
X-Received: by 2002:a05:6870:c49:b0:1ef:9f6c:3df1 with SMTP id lf9-20020a0568700c4900b001ef9f6c3df1mr17357684oab.14.1700083241954;
        Wed, 15 Nov 2023 13:20:41 -0800 (PST)
Received: from serve.minyard.net ([47.189.89.62])
        by smtp.gmail.com with ESMTPSA id wh6-20020a056871a68600b001e12bb81363sm1949489oab.35.2023.11.15.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:20:41 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:8a7b:e73c:ae8:33e4])
        by serve.minyard.net (Postfix) with ESMTPSA id E885B1800BD;
        Wed, 15 Nov 2023 21:20:40 +0000 (UTC)
Date:   Wed, 15 Nov 2023 15:20:39 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Rob Herring <robh@kernel.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ipmi: si: Use device_get_match_data()
Message-ID: <ZVU2J7phOPuTPe21@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20231115210230.3744198-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115210230.3744198-1-robh@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 03:02:29PM -0600, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.

Sorry, this is now queue for 6.8.

-corey

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/char/ipmi/ipmi_si_platform.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> index c3d8ac7873ba..cd2edd8f8a03 100644
> --- a/drivers/char/ipmi/ipmi_si_platform.c
> +++ b/drivers/char/ipmi/ipmi_si_platform.c
> @@ -11,10 +11,11 @@
>  
>  #include <linux/types.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/acpi.h>
>  #include "ipmi_si.h"
>  #include "ipmi_dmi.h"
> @@ -224,7 +225,6 @@ MODULE_DEVICE_TABLE(of, of_ipmi_match);
>  
>  static int of_ipmi_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *match;
>  	struct si_sm_io io;
>  	struct resource resource;
>  	const __be32 *regsize, *regspacing, *regshift;
> @@ -237,10 +237,6 @@ static int of_ipmi_probe(struct platform_device *pdev)
>  
>  	dev_info(&pdev->dev, "probing via device tree\n");
>  
> -	match = of_match_device(of_ipmi_match, &pdev->dev);
> -	if (!match)
> -		return -ENODEV;
> -
>  	if (!of_device_is_available(np))
>  		return -EINVAL;
>  
> @@ -269,7 +265,7 @@ static int of_ipmi_probe(struct platform_device *pdev)
>  	}
>  
>  	memset(&io, 0, sizeof(io));
> -	io.si_type	= (unsigned long) match->data;
> +	io.si_type	= (enum si_type)device_get_match_data(&pdev->dev);
>  	io.addr_source	= SI_DEVICETREE;
>  	io.irq_setup	= ipmi_std_irq_setup;
>  
> -- 
> 2.42.0
> 
