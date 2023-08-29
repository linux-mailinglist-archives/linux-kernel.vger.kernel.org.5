Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D669678CEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjH2VmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbjH2Vlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:41:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A2E0;
        Tue, 29 Aug 2023 14:41:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so16181005e9.1;
        Tue, 29 Aug 2023 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693345295; x=1693950095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exdlEf3k7LeYR4ajbKpOej9+b285T0rqRyVgSYWARbk=;
        b=USm5Ql5bJhTc8capswOv9BNNOTizoVXOGbETlD4KBaC/ImUNFGu1N1wVOUus4lwo7N
         ZI5PM+QvNSVLAKVLQH29R+55rWTdN0mQHjTqYXxyyy5jrS4NDDFfblgGN/sOfVIZAJwY
         xfvLbIRB7NYS6Cm2Xeh2P2utcJjd1fMFzh+sGDswwjkqQv7miUnZ+UDPdsjXwqztPw36
         XlIAdZhLec/cGJH4zzpFDl8hPkoeM/DwSlHIlCkbmnpHpTXsDmVVZnXsSJlsGHEEMUXl
         C/ZUSHoTCBxEZDt2rt91bxQhCUs+qW4tA87lcfCA/pCARcavICN6aOq/Zbrosh+6JedG
         dHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693345295; x=1693950095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exdlEf3k7LeYR4ajbKpOej9+b285T0rqRyVgSYWARbk=;
        b=B0s/sLwjHFtsQAxYBzAJKa8REOAQJYjJe1aBTdlkrfjB4t+d5y/pyUAwU+1+4rSqlQ
         nvUYNJtS5XuG9UCKhVnA34WWLjiRb682U7DeeE7Di+xMrncTmQvQyKJBBbD4ZLdkH1Oi
         YRKm7Dvwld0th47c5tztkg+bwDhQH4xj4tnza/1naJQBWrQlpWRhguzveynX7bzJ4JjI
         WU45HJDmiep7syPwb1SETeDFAsmNaQCSf0yKPeqM0tlLJI9BCXz8Kwfc5NxwhRsy2dt8
         5LbOM322a0rmztzw1MwhQcKc3NGt3vV3P0qN4eu/simTWe3MUvPDvHexlG+bkvbnUb8c
         /ifA==
X-Gm-Message-State: AOJu0Yyf1wRwPRFoDFp0bOU4/5+I/OjbphlBvWEo0s/ldArVgXip4n/S
        RPC/tFt1JKlM+wOzumCxcEjw+9p/cQ==
X-Google-Smtp-Source: AGHT+IGnlr1vTV/+QlEDeV+UpRL6uvyvaiQRu8JW07ZFl+zNxakisE+XjMqlkfRB4mCpXbK0PYJDsQ==
X-Received: by 2002:a5d:49c1:0:b0:319:8427:d221 with SMTP id t1-20020a5d49c1000000b003198427d221mr255182wrs.62.1693345294844;
        Tue, 29 Aug 2023 14:41:34 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:84d2:f616:9527:dd98])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b0052228721f84sm6113428eds.77.2023.08.29.14.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:41:34 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 1/4] ARM: dts: rockchip: Add SRAM node for RK3128
Date:   Tue, 29 Aug 2023 23:40:03 +0200
Message-ID: <20230829214004.314932-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829214004.314932-2-knaerzche@gmail.com>
References: <20230829214004.314932-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3128 SoCs have 8KB of SRAM.
Add the respective device tree node for it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index b63bd4ad3143..3a0856973795 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -76,6 +76,14 @@ xin24m: oscillator {
 		#clock-cells = <0>;
 	};
 
+	imem: sram@10080000 {
+		compatible = "mmio-sram";
+		reg = <0x10080000 0x2000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x10080000 0x2000>;
+	};
+
 	pmu: syscon@100a0000 {
 		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
 		reg = <0x100a0000 0x1000>;
-- 
2.42.0

