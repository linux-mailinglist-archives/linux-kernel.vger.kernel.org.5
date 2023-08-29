Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5178CEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjH2VnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjH2Vma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:42:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B37CD3;
        Tue, 29 Aug 2023 14:42:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5008faf4456so7773389e87.3;
        Tue, 29 Aug 2023 14:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693345336; x=1693950136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaPRCFGOdGoFBcv5kpNjOOGyC2mwPb8qr7pQmrJEubs=;
        b=ZN+iIKXyvQHtKJQcpmbquEsYcod1f5iOCkPx3GP+rwpZgSpMqlTAUcmkpC1EAq/qOD
         ZqZHXybafn5G+lhDhPlYF0mtYYOwG54ppX0xAP8s5qW5rMW7UqI7dHH2qqnuMcwj6ZQE
         6SeE8ZD4rvTX1MFEU3/9z9YDr/Go+kjAKg1ZKdpIUeyMsP8UCbHW7LEUtISM7CXWiPFl
         YNJJCNV6nnbDMUX1f6cdUK5A2g19Ov/QPH3l+Bla3uaXp59WR8630LXXIlpoljItijaJ
         3slMh5ddGg3KKqdYQ2VhSVBMrqQhxUxHmhqr4DDVX7TwSlu/ymcjhWQl7e1y++lUbB0k
         xE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693345336; x=1693950136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaPRCFGOdGoFBcv5kpNjOOGyC2mwPb8qr7pQmrJEubs=;
        b=TacCEBcODQwJ9FI5/9sSUI3KduhdO1N7yRDEbPMcw2GLrH0bQspsZ3v1GZUUUEQzQm
         4Wq/euIvWndrDUQyixN4d2Xld23eZnvvEUcdHlwexKpjagiI1pq2HuT25eW0BSwwM6tE
         yCTOjzvj7KBSzM3wstc/ojdollGZPIIic6hZesrItcC21tWqgW+b1V/sGFvuRTsKQrVJ
         2zBMrNd4G4HXOdKwrnSrmiPJn1fK0bedx5XvgrB8prXawuWlLthEHxxDruE5oU2yFeRi
         j3VlSfB2CEA1FYleNkLqzxbIBrdHWUGOCcAfCtYhf87joEx3VL0fCbMVt1x1CzQbV5cc
         Yd2Q==
X-Gm-Message-State: AOJu0YytsrNKsdxH538Wh416C9YXyKCR3IKVuKLx+IhcqoW/5tGQGAKA
        Y+sIMqdFS6r20QW1z0d70PKURmXA3w==
X-Google-Smtp-Source: AGHT+IHvZchRUXOYbVMxqhQXem4nDQeO6sU4KBR+SsnU9mPMYX0bOxIaJ3lsV5VOGNvuJ0DWCsg9jw==
X-Received: by 2002:ac2:5b1d:0:b0:500:bb99:69a9 with SMTP id v29-20020ac25b1d000000b00500bb9969a9mr96761lfn.64.1693345336520;
        Tue, 29 Aug 2023 14:42:16 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:84d2:f616:9527:dd98])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b0052228721f84sm6113428eds.77.2023.08.29.14.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:42:16 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 3/4] ARM: dts: rockchip: Enable SMP bring-up for RK3128
Date:   Tue, 29 Aug 2023 23:40:07 +0200
Message-ID: <20230829214004.314932-8-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829214004.314932-2-knaerzche@gmail.com>
References: <20230829214004.314932-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For bring-up of the non-boot cpu cores the enable-method for RK3036 can be
re-used.
This adds a (small) chunk of SRAM for execution of the SMP trampoline code
and the respective enable-method property to the cpus.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 2778049003a1..877854dd765d 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -27,6 +27,7 @@ arm-pmu {
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "rockchip,rk3036-smp";
 
 		cpu0: cpu@f00 {
 			device_type = "cpu";
@@ -86,6 +87,11 @@ imem: sram@10080000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0x10080000 0x2000>;
+
+		smp-sram@0 {
+			compatible = "rockchip,rk3066-smp-sram";
+			reg = <0x00 0x10>;
+		};
 	};
 
 	pmu: syscon@100a0000 {
-- 
2.42.0

