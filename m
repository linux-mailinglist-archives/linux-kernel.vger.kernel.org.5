Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F1A76562B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjG0Oo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjG0Oo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:44:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E22130E1;
        Thu, 27 Jul 2023 07:44:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso1871821e87.1;
        Thu, 27 Jul 2023 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690469061; x=1691073861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mk9QO1bKZiIQkt31EU6v0cWU3DnzKcyZ55zrIVFVXQ=;
        b=IpK1iC7NS9CiKwi/w4XI87n1ZJtnTpYFgLP4DvzS2jI6I+/4q4WLVOQbUdat2O/JSJ
         rSvY4KagbrRNh45MAb3OiMvA6TEobPpT93XcPOuwNxkZwkHRk2RkePF70naYd4zkx09I
         w67L2Cort7+WjNnw+1Eiz+T5YDPa9uVnPzEbIYbg+5Ve2ggsopJhpdRGPNd/TJ0qKcrY
         2nGgNPzvUSlWWU5cffyypJbGm4SVfdSQT+hJE3Lp5t61JHgOaSegV98A6aQIy2GYfAvi
         7LOfIgCo/NEM+NOycT9CMd4O0HYDd6/3ZTAMasTtcqpn8lU+vU/mDqInP8ODtj57q+DZ
         khaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690469061; x=1691073861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mk9QO1bKZiIQkt31EU6v0cWU3DnzKcyZ55zrIVFVXQ=;
        b=gyxkXnzjXVhA3fv5em6+oSg46WpfNENxxv+MTnxX9eR/FFkgNBY+3aBSO82a9oezLJ
         EHMIWeY5Kx8G68OWa3LPTSqWJSeiYl8VXB1Anq4RhrDaV99BogPZr7wBSoE3YEUft2o2
         p+XPJG4lbtCsJFAV0XRLuQjqSofn8VO8/U2e6WLLBJCAPIE6IbXn8yl2Agg1pRlaXlDe
         mKep92rF7+rj1LQHWBXeGmsdsZd0VkoFMTkyk2B2xa4YzY66sQyD8FfVqlJBFo8xkM9L
         SQ+5YQOnjzjP0+N19I3NuPU1rnMVeplsBFoU7E0GYdVv/shGGvAgZqVrp4TwoY3u30ox
         7F9A==
X-Gm-Message-State: ABy/qLbY93S5Ec9h6oyHbJuuNPRM051bNGjx2/xugrgRW31lkL1pH6OU
        ID28N7rJABx+7qOwatuS/Oo=
X-Google-Smtp-Source: APBJJlFzT6s3SyADMOTPk6sW46OAgAY1F3TERUhdvCNgcDBfNJL+HaDuFPlWuv9By+p26FUAur2QMQ==
X-Received: by 2002:a05:6512:15a4:b0:4fb:be3c:d8b7 with SMTP id bp36-20020a05651215a400b004fbbe3cd8b7mr2268062lfb.51.1690469061262;
        Thu, 27 Jul 2023 07:44:21 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090629d400b00992e14af9b9sm846080eje.134.2023.07.27.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:44:20 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: tegra: drop incorrect maxim,disable-etr in Smaug
Date:   Thu, 27 Jul 2023 16:44:16 +0200
Message-ID: <169046903884.2751933.4445869430176134815.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725142638.157449-1-krzysztof.kozlowski@linaro.org>
References: <20230725142638.157449-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>


On Tue, 25 Jul 2023 16:26:38 +0200, Krzysztof Kozlowski wrote:
> There is no "maxim,disable-etr" property (but there is
> maxim,enable-etr), neither in the bindings nor in the Linux driver:
> 
>   tegra210-smaug.dtb: regulator@1c: Unevaluated properties are not allowed ('maxim,disable-etr' was unexpected)
> 
> 

Applied, thanks!

[1/1] arm64: dts: tegra: drop incorrect maxim,disable-etr in Smaug
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
