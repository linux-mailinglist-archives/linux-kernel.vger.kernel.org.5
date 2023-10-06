Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403567BB461
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjJFJj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjJFJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:39:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A034E4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:39:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso326034566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696585188; x=1697189988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GValG6j8RNZe/VVFaV+ji1MJUR/qCB/Q7tXe9d+VUds=;
        b=NWNJzmTSmzkhOZg/mKJM8BSjUm01kuuQZjpSzh1nJiJa0McDOrK2QEWDK+SdFlf9MY
         wfEgiC4NdDsaGzULbYP1FRgz6AP2CAxal2wTWTAbGCd25sZgId02fzzF9vm4gUjZuUGO
         mW2OAyE0Ugr7CSTl0imaULtoeh82RtUTKKOCGe3C8b7GVZXcpCTNWaqbcghEa3wLoCDd
         vWIj84PfR4mAjexjvTz+r0gbR52spbgq9AIM4xIyKhEXJudoGIfIOC3bnMPCCHd1W6a1
         sABj8vCgq6qexKRUMupBTJP1oCVqrk2Ow7bSTJpWX7SBumljS+DNiPs377RzJWFk41m5
         6TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696585188; x=1697189988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GValG6j8RNZe/VVFaV+ji1MJUR/qCB/Q7tXe9d+VUds=;
        b=YqRNZMVVLJW58Sqb5pO8vfcPtnt9zlBxIlGZ7SdEj7+gKaIlSeJvXTzGs84OsqySQJ
         1dATZ9eQbAuXsvYwpAgfzr++9jlUQrnH9pvMC7hvOD57VFhGy6KVttavvaBvXEeiNZB7
         xttEdRVccVAeKoTgRBqf+++3uCDWrS8ppgQNX6vQ3tU1xTGr6zaInQf5BJvjIRcqqzot
         JGJe96yP/jdt/Mje0994sfOUXaNP+oiSIiMnNXZ34Lo8+2Ji+nBsTbgX6Xnej6gs2BMv
         7L/mip4rZIDSO9J4JmMVReg61Ha4TKuMpD5nc2JTe3bT2gm3SxC7IkHiiNZfaUEjhDmc
         48Gw==
X-Gm-Message-State: AOJu0Yy5hYmBesv6E1+u88qygA/uSKr3pDu0maDBvvXnmVDzIpWIA+41
        jN4J2IOCIns641iCeVFcPRxOEw==
X-Google-Smtp-Source: AGHT+IF3Vfgt3fpYEEU1JdjAoV9ABhEWf5VbjC67mu7J86cXzN1EweHSYIV0d2PHtTSL5DORtZjjbA==
X-Received: by 2002:a17:906:19b:b0:9b6:e6ff:b20b with SMTP id 27-20020a170906019b00b009b6e6ffb20bmr6398018ejb.8.1696585188442;
        Fri, 06 Oct 2023 02:39:48 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id gx13-20020a170906f1cd00b009ad8d444be4sm2583412ejb.43.2023.10.06.02.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:39:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/2] ARM: dts: samsung: DTS for v6.7
Date:   Fri,  6 Oct 2023 11:39:43 +0200
Message-Id: <20231006093943.106002-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006093943.106002-1-krzysztof.kozlowski@linaro.org>
References: <20231006093943.106002-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-6.7

for you to fetch changes up to ef399736c3ba77fb82d778b1b7285baa65a7e079:

  ARM: dts: samsung: exynos4210: enable polling (2023-09-14 10:05:21 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v6.7

1. Switch all sound cards to generic audio-routing property, supported
   since previous release for Samsung drivers.  The old
   samsung,audio-routing property is deprecated.
2. Correct Exynos4210 thermal by using polling.  Apparently interrupts in
   Thermal Monitoring Unit are broken.

----------------------------------------------------------------
Krzysztof Kozlowski (7):
      ARM: dts: samsung: exynos4212-tab3: switch sound card to audio-routing
      ARM: dts: samsung: exynos4412-galaxy-s3: switch sound card to audio-routing
      ARM: dts: samsung: exynos4412-n710x: switch sound card to audio-routing
      ARM: dts: samsung: exynos4412-odroid: switch sound card to audio-routing
      ARM: dts: samsung: exynos5422-odroid: switch sound card to audio-routing
      ARM: dts: samsung: s5pv210-fascinate4g: switch sound card to audio-routing
      ARM: dts: samsung: s5pv210-galaxys: switch sound card to audio-routing

Mateusz Majewski (1):
      ARM: dts: samsung: exynos4210: enable polling

 arch/arm/boot/dts/samsung/exynos4210.dtsi          | 12 +++++-
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi     | 41 ++++++++++-----------
 .../arm/boot/dts/samsung/exynos4412-galaxy-s3.dtsi | 43 +++++++++++-----------
 arch/arm/boot/dts/samsung/exynos4412-n710x.dts     | 39 ++++++++++----------
 arch/arm/boot/dts/samsung/exynos4412-odroidu3.dts  | 13 +++----
 arch/arm/boot/dts/samsung/exynos4412-odroidx.dts   |  9 ++---
 .../dts/samsung/exynos5422-odroidxu3-audio.dtsi    | 19 +++++-----
 arch/arm/boot/dts/samsung/exynos5422-odroidxu4.dts |  2 +-
 arch/arm/boot/dts/samsung/s5pv210-fascinate4g.dts  | 33 ++++++++---------
 arch/arm/boot/dts/samsung/s5pv210-galaxys.dts      | 37 +++++++++----------
 10 files changed, 124 insertions(+), 124 deletions(-)
