Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223CC761B98
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGYO06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjGYO0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:26:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAAE19B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:26:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98e011f45ffso822096466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690295180; x=1690899980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=09FVJw5uGEFALDgJ9/ima3WpNtVeSrdlarakpdricl8=;
        b=U3MYmd2ZmoBYDkWYMIZPMAcx/MgUDc21SIjy1UfhukUcPL+MoFOW8Ya2Ie/KXNv0X7
         uJwxCcs0M5XZl7Wov3gt69kBoN1ejzyceCLaGjInEOMLsrMKXiYnG/+kR1QgIPglcD80
         f3z7gd+DHKvJnlVmyC1Lq1wMiQaZMt0V7a+vzEdGlX9wTnL6xfvHXLIjph+en9EjFjNa
         JpDRDf3RBeZd7Gq5hxEz8zlIutfX4ut58rYLM5j4Z3tpdWE274xJkeyW0iaL0yJ2kS6D
         B6JgAuTGZH5LAgXniQf9I4NzG9GmKZtapxULVks40o449/mA4PyOIbyuWvKxJOPVwIbu
         WDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295180; x=1690899980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09FVJw5uGEFALDgJ9/ima3WpNtVeSrdlarakpdricl8=;
        b=HlQ824k4iy9n8wzqAGdYwnWQnLomjGR+S5PkPGB0/y6qkcnejgyZVrSjs6lgZz8MQl
         +P8kGhB+u7WP9oEpOPFYy3QG4gg18ClsUvoZNkxBNVP61L2y4PJNGtPM5lf3ZHQs2UUU
         Hor26hRP4zZdiGskQjgdTWCG3Fy5iMeoX9zfPV194CqDMkB93a+HsH8S5YkP//E9k7Rc
         qaTNrG5InTAoLHmPE5eKJFeSYOz2OUgrXJHBqusZie1wUQOkCY/C4nzZx6NINov2iMNM
         I8z9wg0SJmGAJyY9C3e1PwQn6FGLRVdGjzzpKYQJxosHfm6fYcE45ovh1/+1s+d0DXmB
         M87w==
X-Gm-Message-State: ABy/qLZNErainUKmpBtt0vPV+jYDAHCXrmxj8XSuBx5xKEU3wqvKsoKR
        oFbwmcurF1iDETwys4FMaXOOJw==
X-Google-Smtp-Source: APBJJlHfnYLDPWqwQX72iSv1fq6zL4FiOGn3e9/BX8Em8yYfsX1EMEFFDvH338vqV97ROpWmyBNYSQ==
X-Received: by 2002:a17:907:60c6:b0:99b:b505:eede with SMTP id hv6-20020a17090760c600b0099bb505eedemr1147775ejc.65.1690295180535;
        Tue, 25 Jul 2023 07:26:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id lg26-20020a170906f89a00b00992b50fbbe9sm8242980ejb.90.2023.07.25.07.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:26:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: rockchip: rk3399: switch to enable-gpios
Date:   Tue, 25 Jul 2023 16:26:15 +0200
Message-Id: <20230725142616.157405-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recommended name for enable GPIOs property in regulator-gpio is
enable-gpios.  This is also required by bindings:

  rk3399-gru-bob.dtb: ppvar-sd-card-io: Unevaluated properties are not allowed ('enable-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 23bfba86daab..c9bf1d5c3a42 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -250,7 +250,7 @@ ppvar_sd_card_io: ppvar-sd-card-io {
 		pinctrl-0 = <&sd_io_pwr_en &sd_pwr_1800_sel>;
 
 		enable-active-high;
-		enable-gpio = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
 		gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x1>,
 			 <3000000 0x0>;
-- 
2.34.1

