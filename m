Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E80792AA3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbjIEQki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353879AbjIEI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:28:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0EECCF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:27:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4018af103bcso14249535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693902474; x=1694507274; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZOJVeABpFpne+4zxTVbLhiPldIS4DZuhrgZSQO5xhg=;
        b=C7jRPpvPWdKNofhdUtxIkmuetQa24LV+ISujOD1s0qovUmBNySN/gzmGe7K50ny1EO
         dMqdwWj3WkwqwPHF9Q9HS1osrF2/whi54U9+wviKwCRqYRMFUL2vOBq2bk0/JWUNUppb
         JVDL8WbeCxGgO2VclnkxO1yXxQ57ve+5ASmo7o2haJBuLp1kIRt9l3DMZCpJcsqv38If
         Ivf5BwtycJQzfh9qPqug81e+x064j/ARInbhzd8nW87vMel7Deg+na53fa5Nec8INQL9
         bMBNNUmCPK1s5GOBERoMYnh3yZ2fnq6P3kaYXJPIYD0pNJnYWj/q2Fpgv6S/I4x0q4pf
         aylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693902474; x=1694507274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZOJVeABpFpne+4zxTVbLhiPldIS4DZuhrgZSQO5xhg=;
        b=CGQSVF4lVB+tZfhc2DPTCd35KGTOnFPlHLgH3yDFwUBpfNSItfW38sSxYQki8O26HG
         EO+lnM1vfMiTYU2brbpQakQZWIMyJ3wSL5/gDhl2l4h/RnmaKodJeZeTIY2l12ADZIEl
         lG8Flx3bAu8MBBC54RuvjU88IMujhnHWqPXPW8/aqlxr1zXlOPyR7bJZ5g8m5JmqWC+S
         lWC8JBLVips21aSL0JVXHM46nTlKbBJYfv1FkwEs3PG1eUDQFCkdDkj/WCLDLvrZgOW4
         jNXEo5zHnrGa2ZH5Zb3ef5ZVs2nZCfBHUrtSGF/YJ+kpi0FFb6+KaIxH+LLXVoj6eQNU
         zXag==
X-Gm-Message-State: AOJu0YxqE0pPI5Fc33PzDwYYnOkHGo4fsST0uLAdvAJxLvCmF7i/9wrQ
        0r2s8qryDwCaaFVpRtlLwKnGRg==
X-Google-Smtp-Source: AGHT+IG/8oMolQYl3peTlkwkusxIIAHFH1Y84dqOJM5uxINZi5NFn9P2rlDqHiO5pvuSl/HD1+tYoQ==
X-Received: by 2002:a05:600c:4656:b0:401:b24b:8279 with SMTP id n22-20020a05600c465600b00401b24b8279mr12036182wmo.1.1693902474406;
        Tue, 05 Sep 2023 01:27:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003feff926fc5sm16206338wmd.17.2023.09.05.01.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 01:27:53 -0700 (PDT)
Date:   Tue, 5 Sep 2023 11:27:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH v2] spi: bcm2835: reduce the abuse of the GPIO API
Message-ID: <527c52aa-e9c6-41d5-a60d-60d79ab94439@kadam.mountain>
References: <20230901111548.12733-1-brgl@bgdev.pl>
 <CACRpkdYLcOZQ9r46aBwesh-H392C_0AWC8n2ikuwUknfEhoNNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYLcOZQ9r46aBwesh-H392C_0AWC8n2ikuwUknfEhoNNA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 02:15:39PM +0200, Linus Walleij wrote:
> On Fri, Sep 1, 2023 at 1:15 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Currently the bcm2835 SPI driver uses functions that are available
> > exclusively to GPIO providers as a way to handle a platform quirk. Let's
> > use a slightly better alternative that avoids poking around in GPIOLIB's
> > internals and use GPIO lookup tables.
> >
> > Link: https://www.spinics.net/lists/linux-gpio/msg36218.html
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> > +#include <linux/cleanup.h>
> (...)
> > -       struct gpio_chip *chip;
> > +       struct gpiod_lookup_table *lookup __free(kfree) = NULL;
> 
> Whoa!
> This is really neat.

Yeah.  I like this stuff.  It should fix a lot of issues.  In some ways
I prefer this kind of clean up to devm_ managed resources.

> As noted, it will confuse static checkers at no end, but they just have
> to adopt. (CC to Dan C if he now runs into this.)

I think I updated Smatch to parse this correctly.  I've tested on this
patch and it seems to work okay.  There probably will be some fall out
in weird corners of Smatch.  Let me know if you see any problems.

regards,
dan carpenter

