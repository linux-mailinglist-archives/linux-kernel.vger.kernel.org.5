Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C07B59AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbjJBSJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbjJBSJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:09:37 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583EFE6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:09:32 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7740aa4b545so5016285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1696270171; x=1696874971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enn49m+u5BPouPPBFnWi7pFBr5eL70bjzUn/Jw/Gb7Y=;
        b=HHtLE6vmiVllenD1IX/lgUR1bLRlIYV3pBff/Gk27zEUhvJ4XCBUxKCvacxvoljU5K
         HZO9iO79+GEulntOGytvFW82H10Q1j0jtsOUXDRWbWCaUHDZ3rwisJ3gvH1kMiF0M+2G
         ntg5ygDn70CJZSXs/uLtnLD3qRFESpUpVnutNFkgOiPebrkAa0GEg/DZtcTtq82LyiLw
         YHBXBr9rH5eepXXbJl6cWGJM5bCUwWtny3a+pYGrOKFsroOu+fWIpQqspvqe0cxdGBVN
         L7fleh+kme6yxKnWErZMa4fJk2a7JZLHJFzmDdvqGuc1SaOCX5RygSj8r7tnSaO8EpHH
         No9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696270171; x=1696874971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enn49m+u5BPouPPBFnWi7pFBr5eL70bjzUn/Jw/Gb7Y=;
        b=lugLxID7iD3fG8GIQojnphNWVQbv3Gcot7U9v2dBFpE/RTLN4cmfBhyXtj8i7H5wCd
         JZmHfxwCKDDMcN/aNqMUOwKz7/ZtYnPcNZNn2pJubFnCrsfGoQDwcEJvh0FX+YBOBTXi
         fUxhR8hqaqIqcbL9hxzuTm5FVquAiZVHa+1lFaFgiuFZ9JJqIICTdS5hAT1xga2X2UEO
         qUr95iWaXSxdwCVASGDdoDIuvzGavEkNUbHPNg19FUCCdRYne9r5q2U4pBubSgLpaG++
         Q9VC+mDIdKvpY87FsB1nlL6ZhNEPx2CC+vgukuFy4ZQoV19SNCaxhyF/5dXnbQqzxz0R
         J9Kg==
X-Gm-Message-State: AOJu0YzyAHg1/LcrlDi5VvuPlm9Ivu600MiNXYL17pfo1DIKozAERrZz
        DZv1wpgf+WasjNqpRmJZVmDzpA==
X-Google-Smtp-Source: AGHT+IGbm3hPu5C1IxAYRUSQ0N1W5PEJBkC2q3LNchbtHI/lAgmYwg34UKKjCKKoqU3EXFfTTbBBDQ==
X-Received: by 2002:a05:620a:294f:b0:775:8fcd:3b03 with SMTP id n15-20020a05620a294f00b007758fcd3b03mr11795348qkp.3.1696270171210;
        Mon, 02 Oct 2023 11:09:31 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id w15-20020ae9e50f000000b0077423f849c3sm7390255qkf.24.2023.10.02.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:09:30 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 2/2] ARM: dts: stm32: add pwrcfg clock for stm32f4/7
Date:   Mon,  2 Oct 2023 14:08:54 -0400
Message-ID: <20231002180854.1603452-3-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231002180854.1603452-1-ben.wolsieffer@hefring.com>
References: <20231002180854.1603452-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the circular dependency between syscon and clock initialization
has been resolved, we can add the clock that drives the pwrcfg syscon to
the device tree.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 arch/arm/boot/dts/st/stm32f429.dtsi | 1 +
 arch/arm/boot/dts/st/stm32f746.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f429.dtsi b/arch/arm/boot/dts/st/stm32f429.dtsi
index 8efcda9ef8ae..7c9a9133cc86 100644
--- a/arch/arm/boot/dts/st/stm32f429.dtsi
+++ b/arch/arm/boot/dts/st/stm32f429.dtsi
@@ -665,6 +665,7 @@ spi6: spi@40015400 {
 		pwrcfg: power-config@40007000 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x40007000 0x400>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(PWR)>;
 		};
 
 		ltdc: display-controller@40016800 {
diff --git a/arch/arm/boot/dts/st/stm32f746.dtsi b/arch/arm/boot/dts/st/stm32f746.dtsi
index d1802efd067c..cc8177466a51 100644
--- a/arch/arm/boot/dts/st/stm32f746.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746.dtsi
@@ -510,6 +510,7 @@ pwm {
 		pwrcfg: power-config@40007000 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x40007000 0x400>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(PWR)>;
 		};
 
 		crc: crc@40023000 {
-- 
2.42.0

