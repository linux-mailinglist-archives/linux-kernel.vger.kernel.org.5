Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00A7BCBED
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 05:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbjJHDgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 23:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344334AbjJHDgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 23:36:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5329ACE
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 20:36:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c4c594c0eeso2341728a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 20:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696736194; x=1697340994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O46Z79/thQ1J3qOk74OlVCEf6C6SSN1l//6jVCg8hMY=;
        b=zNmONDL/Rio2cmoS1E9S64+48isst4YaPeRvvYGG5wH4h1H5OMjyYny3I3HDVzlifD
         FxfhyKPcs35hfheaJDS0IJOhwlz3RXuElxYuAEWGafN7M76vog4AL3NByF8cdWM6eSM8
         rxeoR59SO4GH6jcIy0slkUpEX1YVAL/iCF4DIDkWK2Np+TryncKSFO649NrMbGZ7uf2q
         s3rqjavv6gkhu4kX5jxuuBlB5/2lVQ6sfDI9Y78b32qteIJfz0Q17UzBMOte2gMPr5pr
         lVZMJhDHdjkvfQhdIbQhqSRntfbK5TPR0fRlT9AxwdZ5GWPt4kNJPtls9Jc4X4O81vPZ
         YTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696736194; x=1697340994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O46Z79/thQ1J3qOk74OlVCEf6C6SSN1l//6jVCg8hMY=;
        b=gcNJ966KaREw9d+pQY8/ISYWtt17c8NUpN4c0ONb7uY1sxsCPngLq0FXM9UM13tE6T
         IaquWmi6N59fXvlj/5Xs5a5fAeHxPxN4XSd0F+A4Mwz6ssTZF3LUtJj2FoTi8wn/pRbv
         k9BfzATHZulrcTljwUokKXkqydDAWHPrcSHiLkzdXXhfYQ+7fQzf5w+zY6UvI/+C1skM
         dYsWLkU1aaqdFEpNK/gjVlRCt4yGG7JppyNrSqLn5rhVuCL42H4WoWunE5AI5B7rz3bF
         j7ZD6hAuZFU4PwI+ln83tAYjOgvNnZN1fpKVabL52l/yzvpwfNm3qk4Toj6AmBt5XIyn
         VGPA==
X-Gm-Message-State: AOJu0YwT3JrHOi1V5hjdRcpfbXnKWz0sfGc2j2RhE0WGdJ0/SdpBAW92
        BnVPbtT3bVfR5gsx15+BdGnATQ==
X-Google-Smtp-Source: AGHT+IF2WJna5aTcHCff9FDb3AFiiR1caqvPjH4/+qNmboSMrw0kS/evk2m4kO5zetYpq0utIAPz9A==
X-Received: by 2002:a9d:7a42:0:b0:6b9:4216:c209 with SMTP id z2-20020a9d7a42000000b006b94216c209mr12258669otm.12.1696736194435;
        Sat, 07 Oct 2023 20:36:34 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id c11-20020a9d684b000000b006c460c58b00sm1104080oto.2.2023.10.07.20.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 20:36:34 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] arm64: dts: exynos: Add reserved memory for pstore on E850-96
Date:   Sat,  7 Oct 2023 22:36:33 -0500
Message-Id: <20231008033633.21304-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve a 2 MiB memory region to record kmsg dumps, console, ftrace and
userspace messages. The implemented memory split allows capturing and
reading corresponding ring buffers:
  * dmesg: 6 dumps, 128 KiB each
  * console: 128 KiB
  * ftrace: 128 KiB for each of 8 CPUs (1 MiB total)
  * userspace messages: 128 KiB

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
index 8d733361ef82..d54c8fa55c09 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -59,6 +59,21 @@ memory@80000000 {
 		      <0x8 0x80000000 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		ramoops@f0000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xf0000000 0x200000>;
+			record-size = <0x20000>;
+			console-size = <0x20000>;
+			ftrace-size = <0x100000>;
+			pmsg-size = <0x20000>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
-- 
2.39.2

