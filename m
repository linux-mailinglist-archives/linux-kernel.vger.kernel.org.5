Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91537CB366
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjJPTkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjJPTkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:40:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C99483
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:40:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso2049151b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697485235; x=1698090035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQFTLx6lL9piu3dv38VdL4w+p0nVGoMb9c1/6eC3yiQ=;
        b=JFBRa4yc8NxgPzIk01FNkLklJ3SRJzpOYuDLCtpjkZcsFi5ZYDzqQ+8LBZGKmh8rdo
         AkDA+dPFKmZOynR/akS8psLjVGixASnNHppG0MWqBiFjLRFV2WsZLFcW5vW9kL39KadD
         SAzZ3j2xojje1z+2odWHxCZ5c6J6WsCpfBJu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697485235; x=1698090035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQFTLx6lL9piu3dv38VdL4w+p0nVGoMb9c1/6eC3yiQ=;
        b=DkBLXw4Szt9kufSu/uJcXx0oUSqF1XVhI6YRfXnMJRF94p3Y5PFwT75lT5Mo21qz2E
         3rgoEipXjbh6saW2DkncF+Q8L3TL1bSsHyYjZdraYrDf2akLLZSEpwGqBDB4IUNN2Kwe
         m0OFMcr3j0R0i0Ps6MNnhgr4mwwx23CPM2AeltWgQIJ6+1dkIXY0tIbpuNtOLkz1IEZT
         Z5f1voHVj06YN1dCJewZ6YQMf2LpkqxnvDTj6dHxQEFteQRwzBl6TaxMpD3b/TxJEuIs
         +NmKUzbrOtljYSfkWsWUbihasJ9PGyJvO2WTu2BQgsDa5MGXQACTZ7KtZgz4Vf2N9gK7
         WYfQ==
X-Gm-Message-State: AOJu0YxX6F3vhyj7qZ8HKtBlkpJX/F7516JGTRDSUUIVqq887qNdbQyN
        RVMMuOYrY0pViSI6prng3K+Xhw==
X-Google-Smtp-Source: AGHT+IHQxVELZ8aW2aGYQADCIL4kZE43s68pDRB1UCAGJc8V/9Ii/G1xTrXPhRnoXxEDeiGfsk+CDQ==
X-Received: by 2002:a05:6a00:1a13:b0:68b:a137:373d with SMTP id g19-20020a056a001a1300b0068ba137373dmr549721pfv.17.1697485235615;
        Mon, 16 Oct 2023 12:40:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y13-20020a056a00190d00b0066a31111cc5sm275789pfi.152.2023.10.16.12.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:40:34 -0700 (PDT)
Date:   Mon, 16 Oct 2023 12:40:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Message-ID: <202310161239.2C067C04@keescook>
References: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:43:02PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> its prior assignment through snprintf:
> |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> 
> Due to this, a suitable replacement is `strscpy` [2] due to the fact
> that it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/mdio/mdio-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
> index 0fb3c2de0845..a1718d646504 100644
> --- a/drivers/net/mdio/mdio-gpio.c
> +++ b/drivers/net/mdio/mdio-gpio.c
> @@ -125,7 +125,7 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
>  	if (bus_id != -1)
>  		snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
>  	else
> -		strncpy(new_bus->id, "gpio", MII_BUS_ID_SIZE);
> +		strscpy(new_bus->id, "gpio", sizeof(new_bus->id));

struct mii_bus {
	...
        char id[MII_BUS_ID_SIZE];

Yup, looks good. (I wonder about changing to sizeof() in the snprintf()
above it, but for a strscpy() refactor, I think this is fine.)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
