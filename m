Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2F7EC349
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbjKONI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKONI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:08:57 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5C6120
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:08:53 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cc44736f2so42091161cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700053733; x=1700658533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00ATIXVFBGhxLdhohuNcYTvt+T04SzCwSceArLs8rqI=;
        b=Vm7WabX2L9VJ4kqJcr331iVd9N4UGiHnPmSaHejKrEyaXN4Jhi5cUhJ5KAZ/P0eCaH
         bLsvoAAf8O3H056aKiYJ1P9/y86IiXCMRiJVlrJke6QYuyHvHHqx6pdGqFvW3PvEAIXO
         BFUzTuvCiAwtAPoeVvcOvVCh1AhvaawGzHutodxTEyYruNQ0GzkqpTlb9Hdg35yh608q
         QV3Cwq7uVN+hwT2mcTMSQTJsRL2v9vpvhIEh4+3L4+csxPUSgkReoFKBXCgm1RReKsYo
         1GihYJGayig9Y4Orf3R+OspAROtoeg2pjAB0YxweE+2UCEJ3tqNX4LB0rIyNCE9qn2IO
         w43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053733; x=1700658533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00ATIXVFBGhxLdhohuNcYTvt+T04SzCwSceArLs8rqI=;
        b=NzIAymUIZ0Zxv4muFcZY3byKNEgcQhCPCDZ/OfylNYMIt4BEzEjr0dgpUBoAc/ldJ6
         8nDTYlJ7zIQMgnXwC1rwz6vrKWSdcK78ekOdfT827uw0fzlauYc7PqGouVdPPWWRiGht
         VKLpbjYUjt0DWlRWjzcTaDvY++iSVasZ0+rg+oq8O/mqKV2DixFr3UiW2SM6X6MWM9Vi
         HbftKrGA2Gcmt5v6CLJsBbpsIkyFjTo22x+U0IqL+vv9VNIJRRzu76bq3NVoG1iIijZd
         FDKQG34z3kFXtdRPxOdjxmWcD1Oly+E0RBkmfA3yf6l0gQZkuyut3KFEIvyyE8MrdD9W
         wPFw==
X-Gm-Message-State: AOJu0Ywe7kOIXnc2vEjX0WzEm72xLoi7LuKQiZW1eGXj//fyFCEP+pGg
        aEyq+htmzQMrHb7u4oClGmiQEQ==
X-Google-Smtp-Source: AGHT+IEQT8wvSMBcf62eIW3F4aWMFp+D1AcNgOdwSNIkKMd6dhgIMdRVnWgsbwXwQE6Nult31piXLQ==
X-Received: by 2002:ac8:5e4d:0:b0:41c:bf67:37bb with SMTP id i13-20020ac85e4d000000b0041cbf6737bbmr6541560qtx.59.1700053732829;
        Wed, 15 Nov 2023 05:08:52 -0800 (PST)
Received: from krzk-bin.. ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id fp3-20020a05622a508300b00417dd1dd0adsm3549129qtb.87.2023.11.15.05.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:08:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Introduce ExynosAutov920 SoC and SADK board
Date:   Wed, 15 Nov 2023 14:08:41 +0100
Message-Id: <170005362858.21132.4200897251821879805.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115095609.39883-1-jaewon02.kim@samsung.com>
References: <CGME20231115095852epcas2p21e067efe75275c6abd2aebf04c5c6166@epcas2p2.samsung.com> <20231115095609.39883-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Nov 2023 18:55:56 +0900, Jaewon Kim wrote:
> ExynosAutov920[1] is ARMv8-based automotive-oriented SoC.
> This SoC is the next generation of exynosautov9 and AE(Automotive Enhanced)
> IPs are used for safety.
> 
> This patchset is the minimal set for ExynosAutov920 SoC and SADK board.
> Currently, ramdisk console is available and Clock, UFS, and USI will be
> added after this patchset.
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: soc: samsung: exynos-sysreg: add exynosautov920 sysreg
        https://git.kernel.org/krzk/linux/c/20862a23260a3ab76ea5b425f93967d0683b28a2
[02/12] dt-bindings: soc: samsung: exynos-pmu: add exynosautov920 compatible
        https://git.kernel.org/krzk/linux/c/705672285530cd513b5549f96f92b2a9fcd63017
[03/12] dt-bindings: soc: samsung: usi: add exynosautov920-usi compatible
        https://git.kernel.org/krzk/linux/c/7a5e832d05025a3679d0fcd60584e6e946a3e358
[04/12] dt-bindings: serial: samsung: add exynosautov920-uart compatible
        https://git.kernel.org/krzk/linux/c/9433b8d8d35bd0b17d6e0df76ec135dd2fe63e7c
[05/12] dt-bindings: pwm: samsung: add exynosautov920 compatible
        https://git.kernel.org/krzk/linux/c/d2d9e80a0ba6b1f507c14d6d8e2b833a474744d3
[06/12] <DIFFERENT TREE>
[07/12] dt-bindings: arm: samsung: Document exynosautov920 SADK board binding
        https://git.kernel.org/krzk/linux/c/8bd05d4a86d5e1cec35dc7b8d1a5c0d925ecde1e
[08/12] dt-bindings: hwinfo: samsung,exynos-chipid: add exynosautov920 compatible
        https://git.kernel.org/krzk/linux/c/92b022550ae55527b4ce8f8cae7863857c7b795a
[09/12] soc: samsung: exynos-chipid: add exynosautov920 SoC support
        https://git.kernel.org/krzk/linux/c/beea67c7c2ef161c6ee7ef4e39d842fc0be3995c
[10/12] <NOT APPLIED>
[11/12] arm64: dts: exynos: add initial support for exynosautov920 SoC
        https://git.kernel.org/krzk/linux/c/1a035f71803af961fa72264d22716b5b5b85fdc1
[12/12] arm64: dts: exynos: add minimal support for exynosautov920 sadk board
        https://git.kernel.org/krzk/linux/c/a0282075cf5e6abc6d8cae89c1d5fedeb8f32c49

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
