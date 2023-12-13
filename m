Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB49812139
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442746AbjLMWLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLMWLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:11:21 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D29C;
        Wed, 13 Dec 2023 14:11:27 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ba2dd905f9so313433b6e.2;
        Wed, 13 Dec 2023 14:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702505487; x=1703110287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgTgho1a4LA/XjrrePxUmui9LuYj0rwstzK1KGu7248=;
        b=IMOdCTBYRRbRReNvThP/IthfKDyEycuBWJ2p5+YXsrp6tIPSvBf1h4tn3PPsU2obm7
         UpTMqDdTQTW5MmKHd6Wo0FCc/O6JLWLVruzay5/RxcI9R1FfbGZ3oRi6+uIAQChboBIl
         2aKolWYZQXhD0aK3W4mTou0lyLy9JQhQN05xk+XOE7toUrc4pa8usbnqI8zNs9Ye21Dt
         fIABmmUfThbUT0YTunzXrzJ5G3oOempjphTxm/Z+jlIC+ZnAPBn8NwTnn3XQ317CPC/x
         kjnp3Dz97l/rSuQpycw2PVcAKZ8b8psKCN3QEucCIq8Kh47X9qKkyO4hKvFyOznEXQgw
         hVsw==
X-Gm-Message-State: AOJu0YyHyH+Hc8OFkS2RtWR5Zz0F8PLl4ABVbKUmEcvgplWCFFo9+5Pm
        ZB3JHFt3pTmCiJjq1RHSCQ==
X-Google-Smtp-Source: AGHT+IHX5L5W/V5kcRHCZGCX9tUxlzQHF1lIwCR9ERJ7ag6EqOQsYnbBD4efejagEgtQrlmcp0mZLw==
X-Received: by 2002:a05:6808:6493:b0:3ba:667:9e4f with SMTP id fh19-20020a056808649300b003ba06679e4fmr7673479oib.113.1702505486877;
        Wed, 13 Dec 2023 14:11:26 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bh20-20020a056808181400b003b83c516e62sm3102354oib.51.2023.12.13.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:11:26 -0800 (PST)
Received: (nullmailer pid 2156812 invoked by uid 1000);
        Wed, 13 Dec 2023 22:11:24 -0000
Date:   Wed, 13 Dec 2023 16:11:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Paul Barker <paul.barker@sancloud.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 2/6] arm: arm64: dts: Enable cros-ec-spi as wake source
Message-ID: <20231213221124.GB2115075-robh@kernel.org>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.2.I274b2d2255eb539cc9d251c9d65a385cc4014c79@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110009.v1.2.I274b2d2255eb539cc9d251c9d65a385cc4014c79@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:00:20AM -0700, Mark Hasemeyer wrote:
> The cros_ec driver currently assumes that cros-ec-spi compatible device
> nodes are a wakeup-source even though the wakeup-source property is not
> defined.

If a device knows it is wakeup capable, why do you need a property too?
I haven't looked closely enough, but it smells like after patch 6, these 
properties would be required for wakeup? That would be an ABI break.

Rob
