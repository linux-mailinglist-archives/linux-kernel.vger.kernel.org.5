Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73587CC460
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjJQNQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjJQNPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC726ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-407acb21f27so736095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548542; x=1698153342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2m+45j3rbdaE2NY5Ol9kX9V97sFwlFvtbz4uSqqCuM=;
        b=ComVT4RglsIdNqywtVJS5Xicunw98kWgC3QgQOl67r8wz5l50QaQQNivyIux9OSGPJ
         ptUs/R6spZLljlX3hZHi9ySrk2d1FQR210DUIfEtPjJwaUbvZ/hwDJxsEWns6F/eP9t4
         0R/XkGHdTjj4n363g45uerHPqTYxYQJlOpVSQyTkiaqBAUEl2wAl+k9JpCj3Km+OpJxN
         0fzRRYwxhv0PITyl0MzHm1ijLr1PGVx+G8B43Xg0Kk/BMw3glkC9OIT+11tC34SoSQfb
         K2KXkJmOc6wdX0df4EL8VCT3XyNF6caMIExbzQr3ullS2KN5Ge/CqHJsVFRHvnhodwFZ
         OTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548542; x=1698153342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2m+45j3rbdaE2NY5Ol9kX9V97sFwlFvtbz4uSqqCuM=;
        b=RMjChhsZ4Qpv2r7tclC5HDjklFVQrCQThNM1g7f/6Fii4vG6TFbNttC/+OqmQuZcMf
         g+ONRp/mJWNWdmXG8BJYcUqUaG99NupM6in2YjA7ooE6v8hu9O8gqZINgxv0YTmZ9Csx
         Ngv/W/dSBQRijs30m/kfTbfQnpK4P7Y7vo6n67EuN/9ywjtVFk0+vCUHonGq9mCyqQE4
         6qS17G9UbzY7Q2fRrJ+y7MXKP2pT70uJXcLhrMgAFWglkbQze4uu5IMzz6GhQL/GlQAq
         zRFL9UPYIw1evYT0L5sjNaqC/jC4MMpDdjP7w0jfxTSTVy0CkDKYk0Ui/Rdc8Mz2ACfX
         +hxA==
X-Gm-Message-State: AOJu0YwFIZp3fBv1RX2vfV4Q00LCzVcFKP6gKS9+n7J+CiLwaihm1hud
        Vtrx9Aqv34PhKqFuIo7Vf+A8fQ==
X-Google-Smtp-Source: AGHT+IGl5sTERYXS8gZHY5M+sSNt7WnBezruA/vUWy9wkpbAVX1cnbpzCqcAtWiC4jzRoXD25NnTVg==
X-Received: by 2002:a05:600c:929:b0:405:39bb:38a8 with SMTP id m41-20020a05600c092900b0040539bb38a8mr1653730wmp.2.1697548541300;
        Tue, 17 Oct 2023 06:15:41 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:40 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: [PATCH v2 15/19] riscv: hwprobe: export Zvfh[min] ISA extensions
Date:   Tue, 17 Oct 2023 15:14:52 +0200
Message-ID: <20231017131456.2053396-16-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131456.2053396-1-cleger@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export Zvfh[min] ISA extension[1] through hwprobe.

Link: https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/riscv/hwprobe.rst       | 8 ++++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_riscv.c         | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index 9c909e0d5316..782ac26cb92a 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -146,6 +146,14 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTNTL`: The Zihintntl extension version 1.0
        is supported as defined in the RISC-V ISA manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFH`: The Zvfh extension is supported as
+       defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
+       ("Remove draft warnings from Zvfh[min]").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFHMIN`: The Zvfhmin extension is supported as
+       defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
+       ("Remove draft warnings from Zvfh[min]").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index dc4eaa978ad1..79407010952a 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -52,6 +52,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZFH		(1 << 26)
 #define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 27)
 #define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 28)
+#define		RISCV_HWPROBE_EXT_ZVFH		(1 << 29)
+#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 30)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 84daaf6ed4a1..8d6edd721627 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -185,6 +185,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			CHECK_ISA_EXT(ZVKSED);
 			CHECK_ISA_EXT(ZVKSH);
 			CHECK_ISA_EXT(ZVKT);
+			CHECK_ISA_EXT(ZVFH);
+			CHECK_ISA_EXT(ZVFHMIN);
 		}
 
 		if (has_fpu()) {
-- 
2.42.0

