Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4236E806928
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377106AbjLFIJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377031AbjLFIJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:09:44 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA440D41
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:09:50 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c66418decaso1760348a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 00:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701850190; x=1702454990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pIpUFLzpCT8QDWNeKsRiOFIfK00T0l+KbsCecbFYJw=;
        b=AlH7iRxrqh87YYDZtxg4cll3+Kf/V1zvRRRIStM3Ih/d9Va//p1QVVdjVTtuTD1h96
         Wx6VYSqrPa1F7Bt+A6S/7kGffzO83ZQX6DAr5dMbjT5IjRQOc+jld8VMHcpj9/nt2am8
         R0DpVdr2zMRfa8irprxHpoEaz9vHLVLw5gcZAailcNze1Nxze0nG2yUB4h53XDs8rBT0
         Ycy8tEE8hjR58QxI5vXmMxDs/KQTSx7d3p4j3gObrX26EBcCpEH8Vy5KGPiFUXBuN4gf
         fRMpLrVB9kGMHTxjqnuYhsXDG6C9P0Zg4KSBtZG6rRVS17EJN1InrQcbbtFdOhqPy6AM
         D59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850190; x=1702454990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pIpUFLzpCT8QDWNeKsRiOFIfK00T0l+KbsCecbFYJw=;
        b=D2+nC2kcjiAqHbXun267KZExuwU1PY+GK8psW+EjLHK07FCAo9jQQnMgEOAnCOquvs
         Tw3TN/ZyVl8Tj25nsWowHmb8z5raRqE2OyBGapH7/7roHy5/lrC/b85B1FKwQ332pEsb
         5HTNXlwgmcMEwXMNTOWSFu3P2yUKTP1PtJm3eRaEzLI1w0GsZmenWktEXTuQqDqo0+t2
         8tjwC0HW82rEmd2BpgrMLi/S1gvnxzKwMFNb+g3HTcYw3ZiRaLFSl69yde3aMh6R9K1f
         pq/J4Yj6JMQQg/Wcn5NEyhxVfl7pKXiqW7Lfk3N+w1XtNLJ5+R8FD3YzMKynqCQl+xSA
         015A==
X-Gm-Message-State: AOJu0Ywmlr9zvPq6m80dIQfM9TXNHUkI/nb7lLYbPgDLFXc2qBCpvVDZ
        4yxHEyYPzh1s7E/jr0YbChXg4g==
X-Google-Smtp-Source: AGHT+IEldF6NX4UdDsjXNYhsE6P1JkJbILpm78gIrKcVPLzHcmb7S4JEk4u7SzdUVicpnDM1Ua9f6g==
X-Received: by 2002:a05:6a20:a296:b0:18b:556b:6d54 with SMTP id a22-20020a056a20a29600b0018b556b6d54mr173291pzl.55.1701850190073;
        Wed, 06 Dec 2023 00:09:50 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:92e9:8fb4:700:680])
        by smtp.gmail.com with ESMTPSA id bd11-20020a170902830b00b001d0d312bc2asm1208668plb.193.2023.12.06.00.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:09:49 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 06 Dec 2023 00:09:24 -0800
Subject: [PATCH v8 4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-th1520_mmc_dts-v8-4-69220e373e8f@baylibre.com>
References: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com>
In-Reply-To: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701850181; l=1125;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=yYq9cxJ0lp7+Eh78pcwxzBZNnaFwpVwT9d+26rl94NA=;
 b=jb8cqdanu6l93Jt+/zm1d32I4d8zOII7x4Qcm78W4yozsuLULYbPulbeM3HeDuy8xujWKAlu1
 +CIVjtZVPG4DWogtFtk7DWr68Pb8l0gdFp+jKqI0Ni+kiynhHX+9F9u
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add emmc node properties for the eMMC device and add sdio0 node
properties for the microSD slot. Set the frequency for the sdhci
reference clock.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi      | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index a802ab110429..1365d3a512a3 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -29,6 +29,10 @@ &apb_clk {
 	clock-frequency = <62500000>;
 };
 
+&sdhci_clk {
+	clock-frequency = <198000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
@@ -36,3 +40,19 @@ &uart_sclk {
 &dmac0 {
 	status = "okay";
 };
+
+&emmc {
+	bus-width = <8>;
+	max-frequency = <198000000>;
+	mmc-hs400-1_8v;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&sdio0 {
+	bus-width = <4>;
+	max-frequency = <198000000>;
+	status = "okay";
+};

-- 
2.34.1

