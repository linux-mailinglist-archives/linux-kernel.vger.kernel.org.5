Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CF97AED19
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjIZMpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjIZMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:45:22 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECFDC9;
        Tue, 26 Sep 2023 05:45:15 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35142c4cbbdso11101845ab.0;
        Tue, 26 Sep 2023 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695732315; x=1696337115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8GtOh0Ea37C8rlqo/82aa01wybzYgEjYTXnLH9cgHo=;
        b=FP08doYd+cMWA49N6cyDx8aRkrh9Cl3pM3Nq+uh4nUnQhXXwGLNJ9ucCAheUUZWvxW
         1+Gm/ZUR7IEA3RvXhrF3JyrsHWHXqyRodQxvwRNrnJsQosp2PalX1FWkCRKUI5DUi8np
         g72MWIQMlQI3xe/pAUkYW713YsySY+ThYUrl7ez7mLcVwuc4C2E0VTYOtKYWld3yHUoO
         YSqhJl10KVQrzGJsKSY/KojSMg91tD4Gec/LmuaHBk1L+3R0BQQFW4KuNr+7yJ5ArAgx
         agPfU/SFychya6YwG+SP53o8dGmxe4EaYrc7ZqeCy4z46fWa/ijuOLV7jyjba9OpTEjn
         foyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695732315; x=1696337115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8GtOh0Ea37C8rlqo/82aa01wybzYgEjYTXnLH9cgHo=;
        b=ewU3uvMVhohLoxpClV6cxMoQjFI1FeY6R9s8azgzxI1yQlIqqAwuIAC9RhELOJKzMA
         95eCo7uL/7M6lA+o5JUsCZILVKcxTMbfCpxMXZq0bjqyv4pAvXnbpzUDPWnUdu8ne7ze
         Tr5wkLNruRRaLtBWyBAdLEOyW7bUJRbBCLtc45Urs3UDGrp6rcVwpUPs/RBlCR2JUcB9
         MD6tTEyTNgv47qplvZ1T8C8oAcYwlR5GOHcVay0JQ6p0nOfFGFBkPhutFp0QYPuWAk7H
         kPM+PifKAL3GGvPsy4QgX0iyrfMoOfTYgl3PJLaK3pOUA3nZvTBSd3VXs5GfCj7h//km
         BiiA==
X-Gm-Message-State: AOJu0YykIMqSAAtOZ/Zi/QbVF4KR3l9J7M00i09D0ltp6eAhVIex1RqU
        L3V77oG4KFu3xGH587xfEWA3+1OVKYU=
X-Google-Smtp-Source: AGHT+IGOkGqvY6ZKVWlX8YrrjA6IKC/U4gLUzFzY2FohU7Dfm+rQoM3VnISIWiO8CisnCPcCLwc0nA==
X-Received: by 2002:a05:6e02:2149:b0:34a:a4a5:3f93 with SMTP id d9-20020a056e02214900b0034aa4a53f93mr12753468ilv.5.1695732315064;
        Tue, 26 Sep 2023 05:45:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a17-20020a056638005100b0043a180a7a94sm3321904jap.121.2023.09.26.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 05:45:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Sep 2023 05:45:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] sbsa_gwdt: Calculate timeout with 64-bit math
Message-ID: <bcc41311-075c-44fe-b0f7-30564d7ac58c@roeck-us.net>
References: <7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 02:02:36AM -0700, Darren Hart wrote:
> Commit abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> introduced new timer math for watchdog revision 1 with the 48 bit offset
> register.
> 
> The gwdt->clk and timeout are u32, but the argument being calculated is
> u64. Without a cast, the compiler performs u32 operations, truncating
> intermediate steps, resulting in incorrect values.
> 
> A watchdog revision 1 implementation with a gwdt->clk of 1GHz and a
> timeout of 600s writes 3647256576 to the one shot watchdog instead of
> 300000000000, resulting in the watchdog firing in 3.6s instead of 600s.
> 
> Force u64 math by casting the first argument (gwdt->clk) as a u64. Make
> the order of operations explicit with parenthesis.
> 
> Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> Reported-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: <stable@vger.kernel.org> # 5.14.x

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sbsa_gwdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index fd3cfdda4949..76527324b63c 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -153,14 +153,14 @@ static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
>  	timeout = clamp_t(unsigned int, timeout, 1, wdd->max_hw_heartbeat_ms / 1000);
>  
>  	if (action)
> -		sbsa_gwdt_reg_write(gwdt->clk * timeout, gwdt);
> +		sbsa_gwdt_reg_write((u64)gwdt->clk * timeout, gwdt);
>  	else
>  		/*
>  		 * In the single stage mode, The first signal (WS0) is ignored,
>  		 * the timeout is (WOR * 2), so the WOR should be configured
>  		 * to half value of timeout.
>  		 */
> -		sbsa_gwdt_reg_write(gwdt->clk / 2 * timeout, gwdt);
> +		sbsa_gwdt_reg_write(((u64)gwdt->clk / 2) * timeout, gwdt);
>  
>  	return 0;
>  }
> -- 
> 2.41.0
> 
