Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C537CEBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjJRXYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRXXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:23:51 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABCB116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:23:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5859a7d6556so5577042a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697671429; x=1698276229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnkqkc8e9j4DGQOzGoypqZ4/Iy9gsHg7tmNLbGbn02Y=;
        b=KXQtJrJ7FN8yY2G255q9jE1lEqKCsLLM4q76ekLK3iUoAmkRw7IBV77PBiBslFb3t8
         splYxx0KO2yN9QRVuViuD+VfhQHU5Z4kUyB10EWdfdEC5B1m4BfQ5ncEi1hbNMV3Vd+G
         os6AXll9bYEyOZCEFdQp7diYmfyv3UtxeoO54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697671429; x=1698276229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qnkqkc8e9j4DGQOzGoypqZ4/Iy9gsHg7tmNLbGbn02Y=;
        b=d/v6fRjDZy7NroV9PWabkgqm+yNRSL9hoTAqUhNo9582rCeN7Gw6a5qr8YZVbzvi+l
         cnTMuirwYqDnvQ0r6mQmUXG8h3PZHfwUTrhZF0LvoSDDKgQ8gDVjuf1ntG/owUcYCoH4
         Kg10apIXRvVyUqjD0khUncLa+9cLtQ+e0uRakkILpdb84Zs011MCxgGunzlIGLHYx0oe
         8OKBNeoMFPu71qU3zvXbXtATJP9np/FTri3++ieeXkhTwBvn0icTEe+y9twSkWV26D8j
         hMneIklHE3FVyjmqx/WGgsubJzn8ZfTFHVQXqWlTKReYNVNOi5gOvGDrn9BtgfRvzzwS
         rUVg==
X-Gm-Message-State: AOJu0YwW54JzKHVbw9tYeHoH2H4YUDXXmcQTnGSlwXWS7fL50Sy67iQu
        49ennQ8aqRDntneGrES0P7utCw==
X-Google-Smtp-Source: AGHT+IHHX3aQ+yqfmXGZ+WtEexij2u+WnfCIaHUu3krGyxt4WZkcg4YBtdx7EVHad4e0VUegntsFTg==
X-Received: by 2002:a05:6a21:1444:b0:16b:e46e:1246 with SMTP id oc4-20020a056a21144400b0016be46e1246mr549725pzb.30.1697671429185;
        Wed, 18 Oct 2023 16:23:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902d3cc00b001acae9734c0sm465446plb.266.2023.10.18.16.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:23:48 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:23:47 -0700
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
Message-ID: <202310181623.FB6FA17@keescook>
References: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:53:03PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect mdiodev->modalias to be NUL-terminated based on its usage with
> strcmp():
> |       return strcmp(mdiodev->modalias, drv->name) == 0;
> 
> Moreover, mdiodev->modalias is already zero-allocated:
> |       mdiodev = kzalloc(sizeof(*mdiodev), GFP_KERNEL);
> ... which means the NUL-padding strncpy provides is not necessary.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
