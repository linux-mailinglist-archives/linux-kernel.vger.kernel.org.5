Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783E07E847A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbjKJUk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKJUk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:40:57 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95861727;
        Fri, 10 Nov 2023 12:40:53 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1efa01323b4so1410849fac.3;
        Fri, 10 Nov 2023 12:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699648853; x=1700253653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0iJFdRqfvLTCqUgEC28fOOuQc4nEg1ExrvWS4swH3k=;
        b=ol9VpSL0ikoniqBCbj0kBOy5gk+dI3hTILRY0814B6iT4OFb4hMMYCiY+eXZzYYpVZ
         ssTWSMJk1DRnQqVkEsAlUooQhmLaegdyFtdo0OmLBTrEetTKpkbQ+zsWp+lyIN6P7+wB
         H+3rexdd3PveS02Gu/26T8eK8F3m5O3TT/b1IkF/BC7awoSCv2pVYMtdQ9vKBgcC0tb1
         HA6xDHodUEhyjYDj/hpFpiyuaBO2HSqnwwpT5ddDVUGGIwvuGk5+DKtUtSNxqRMiTZYj
         2LdT6M/gAzOz5LR2pM44kVp4OCvETk7HHnaAly5ZfeS8wTC31zIg9NO5UPbV4EI3rZjW
         SJbg==
X-Gm-Message-State: AOJu0YwQgE/7hLG1SQd1LfFdtTqJRDCtmgArwq3Arl8daaPuELvQUH+3
        xVhOLwo/jChBfmdtu8aUAg==
X-Google-Smtp-Source: AGHT+IHiBM+Pj8rwIjD5f5ElWq7IEopHChL5V1l1hLXxoRScz48VE6f3ZULiu1sG34gKSMusYsFlGQ==
X-Received: by 2002:a05:6871:4105:b0:1e9:8e22:24c6 with SMTP id la5-20020a056871410500b001e98e2224c6mr331624oab.44.1699648852849;
        Fri, 10 Nov 2023 12:40:52 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y22-20020a056870725600b001ea4324364csm61318oaf.12.2023.11.10.12.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 12:40:52 -0800 (PST)
Received: (nullmailer pid 394724 invoked by uid 1000);
        Fri, 10 Nov 2023 20:40:50 -0000
Date:   Fri, 10 Nov 2023 14:40:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Daniel Vetter <daniel@ffwll.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andi Shyti <andi.shyti@kernel.org>, linux-rtc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        alsa-devel@alsa-project.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 06/17] dt-bindings: rtc: s3c-rtc: add specific
 compatibles for existing SoC
Message-ID: <169964885014.394659.16948497259010559308.robh@kernel.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
 <20231108104343.24192-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108104343.24192-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Nov 2023 11:43:32 +0100, Krzysztof Kozlowski wrote:
> Samsung Exynos SoC reuses several devices from older designs, thus
> historically we kept the old (block's) compatible only.  This works fine
> and there is no bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
> 
> Add compatibles specific to each SoC in front of all old-SoC-like
> compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I propose to take the patch through Samsung SoC (me). See cover letter
> for explanation.
> ---
>  Documentation/devicetree/bindings/rtc/s3c-rtc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

