Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2BD7EB1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjKNON5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjKNONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:13:46 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F53F114
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:41 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d15bdd5abso10573406d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971220; x=1700576020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keCbZUlhJhR2ZwXU737WvxpdBzfAu930SEAq7brrB2I=;
        b=l6CokWOZqVrzhHF+vsc+H+M4KEZVPhFAXq1iUfvErmv5zCfyovHSAIL+Rlo4LZ0gDo
         8aBy6NEZnjc9KUnSw6kEjJHUIJl6N8DmZfwG6gJIpCGbGI1WaDE/vYVLX9iTmfk9H70e
         R1HGVciQjnfc9KVBGmQiv0bF0bK1U1CvbgVLxQ0C4g137F2wtJkRR+AnWt+1xCTUZn5j
         NjDBvw5fQxNhuyJjLa5lQBhLcf5lGGOsJ4bwnOxl2KbUTUQon4KWB4CXnoOZEm/PMapT
         Vacr5Iuy4oWjhiAyWxZI0QC7/Shg9YqoQ1SrZyileAY/eq+uJoYKllY92gQAwUKbpVE8
         jdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971220; x=1700576020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keCbZUlhJhR2ZwXU737WvxpdBzfAu930SEAq7brrB2I=;
        b=SXVB9aypX3raYLFQ0oLlu231HljaqXldfJ8Q7Xm2lt/q9Re3oFQYoAn3cjTVjXMIfM
         5oZk5m2A/iZJSMlQUPjdBMQlxwHv+lR9+H+wvhXPGqQXtV8fLyrmlD/X6JrZMzFYzTIE
         0874BgWHYNXWKsOWuwXxeNFs0fAjDHXfjsbfBd1FU/Y/JSu/llINVcFa5AiiEBtr7Ieu
         dBApKS/kkeQOGNRvc4sg8M2olODyClDMsfLsQ2Gn+4rPuNV2HnZPlvmCPXJSey4fVVTX
         q83Gs9SadNpa108PH/PMjs+3Mnjt8pq64w8oDeHQWeVljis/txib3ViLIvE9q7VyOXXf
         EJ2Q==
X-Gm-Message-State: AOJu0YxTK0CbJrQGo4ANi6EgqwbaQjqEMmIoFyNTrtaEeBzXUJZe9JpO
        7rnfCw0oznwBaLa92ut+G84cBg==
X-Google-Smtp-Source: AGHT+IH/a2FfbthDBterj2ExvRydm8PsEE46bPyI6vhg+6wuJOSTbSR3GQBAEKTJRnI4P9fwyid4gg==
X-Received: by 2002:a05:6214:5ec5:b0:66d:1178:8729 with SMTP id mn5-20020a0562145ec500b0066d11788729mr2432438qvb.0.1699971220091;
        Tue, 14 Nov 2023 06:13:40 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:39 -0800 (PST)
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
        Samuel Ortiz <sameo@rivosinc.com>,
        Jerry Shih <jerry.shih@sifive.com>
Subject: [PATCH v4 07/20] riscv: hwprobe: export vector crypto ISA extensions
Date:   Tue, 14 Nov 2023 09:12:43 -0500
Message-ID: <20231114141256.126749-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114141256.126749-1-cleger@rivosinc.com>
References: <20231114141256.126749-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export Zv* vector crypto ISA extensions that were added in "RISC-V
Cryptography Extensions Volume II" specification[1] through hwprobe.
This adds support for the following instructions:

- Zvbb: Vector Basic Bit-manipulation
- Zvbc: Vector Carryless Multiplication
- Zvkb: Vector Cryptography Bit-manipulation
- Zvkg: Vector GCM/GMAC.
- Zvkned: NIST Suite: Vector AES Block Cipher
- Zvknh[ab]: NIST Suite: Vector SHA-2 Secure Hash
- Zvksed: ShangMi Suite: SM4 Block Cipher
- Zvksh: ShangMi Suite: SM3 Secure Hash
- Zvknc: NIST Algorithm Suite with carryless multiply
- Zvkng: NIST Algorithm Suite with GCM.
- Zvksc: ShangMi Algorithm Suite with carryless multiplication
- Zvksg: ShangMi Algorithm Suite with GCM.
- Zvkt: Vector Data-Independent Execution Latency.

Zvkn and Zvks are ommited since they are a superset of other extensions.

Link: https://drive.google.com/file/d/1gb9OLH-DhbCgWp7VwpPOVrrY6f3oSJLL/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 30 +++++++++++++++++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++++++
 arch/riscv/kernel/sys_riscv.c         | 13 ++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 3a18a31e32c3..a08fcd899b6d 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -110,6 +110,36 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZKT` The Zkt extension is supported, as defined
        in version 1.0 of the Scalar Crypto ISA extensions.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVBB`: The Zvbb extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVBC`: The Zvbc extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKB`: The Zvkb extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKG`: The Zvkg extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKNED`: The Zvkned extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKNHA`: The Zvknha extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKNHB`: The Zvknhb extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKSED`: The Zvksed extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKSH`: The Zvksh extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVKT`: The Zvkt extension is supported as
+       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 624abd5cde29..89628a76ca04 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -40,6 +40,16 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
 #define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
 #define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
+#define		RISCV_HWPROBE_EXT_ZVBB		(1 << 17)
+#define		RISCV_HWPROBE_EXT_ZVBC		(1 << 18)
+#define		RISCV_HWPROBE_EXT_ZVKB		(1 << 19)
+#define		RISCV_HWPROBE_EXT_ZVKG		(1 << 20)
+#define		RISCV_HWPROBE_EXT_ZVKNED	(1 << 21)
+#define		RISCV_HWPROBE_EXT_ZVKNHA	(1 << 22)
+#define		RISCV_HWPROBE_EXT_ZVKNHB	(1 << 23)
+#define		RISCV_HWPROBE_EXT_ZVKSED	(1 << 24)
+#define		RISCV_HWPROBE_EXT_ZVKSH		(1 << 25)
+#define		RISCV_HWPROBE_EXT_ZVKT		(1 << 26)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 43aa66e71418..9bbcd7334d96 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -173,6 +173,19 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZKSED);
 		EXT_KEY(ZKSH);
 		EXT_KEY(ZKT);
+
+		if (has_vector()) {
+			EXT_KEY(ZVBB);
+			EXT_KEY(ZVBC);
+			EXT_KEY(ZVKB);
+			EXT_KEY(ZVKG);
+			EXT_KEY(ZVKNED);
+			EXT_KEY(ZVKNHA);
+			EXT_KEY(ZVKNHB);
+			EXT_KEY(ZVKSED);
+			EXT_KEY(ZVKSH);
+			EXT_KEY(ZVKT);
+		}
 #undef EXT_KEY
 	}
 
-- 
2.42.0

