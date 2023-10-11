Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152377C51B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346355AbjJKLU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345956AbjJKLT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:19:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B53C6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40651b22977so11504905e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697023162; x=1697627962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPwBFtd40HLyGqXLen0KbaY9uN71oHhwHjqBqDa/Amo=;
        b=iVKe1O2hh6mtDRMq/avX8IsREhNQZ5Cd46lRcv874rzX8ZgNazQuovcQAkvFKrWeJB
         SJwjm7Qf+Q/WQpJN1R/vdugq3ScJCmVXe0pIDU7hyeYI7y6vQ+3QW0u6c5+8MY1EzpxB
         Dkeo/7YzS5VAgGvNKB8vTxB+D7j7mk4a6Fzhakl8bL8cPH/5k+7d2ACJYbJRM1ETm4zl
         wRzimPPCk7Mifj31I81F6wM9GQk4HAJfn8IZ6UItR0yjNOuCAwWeytbrPkFHgNspdMSZ
         ILmZedft4+YImQDIvmuyCUptiZFrcsLu9lG/mSph8lsAK5LUhPdf4tYCL4IEYQG07FME
         GmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023162; x=1697627962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPwBFtd40HLyGqXLen0KbaY9uN71oHhwHjqBqDa/Amo=;
        b=nICgC+feR7jE/UpcrqZ2DMmWa5ubZv9UNVlSNwv42tjFvpgYRAjdEopOQ7myda+lu/
         3Zwjh1By587LBqV6NQMJFXBLIsmJm+jriYjnWIMCpMrylM4MSwv0Z/TCi+XhaJTqJLsq
         FsYs+xGKw0LSHi6WW3E/9K7rI5BOgX1psVGkc0hCmWd5HfNtJbec1EpGvBMntzZqvdyd
         Te9BAV63wIgnW4BeG82/CW81QqhQg7nXZCUqUeANEvFNPKjMAIWiTxiqdMuOynd1H+c5
         FZN4TAt+r6Cq8fyxeqY+aYak4/bws4m3m+3ytaUHVdh5AVXrIKksDjGTXWe6NROx10KW
         q44g==
X-Gm-Message-State: AOJu0Yx6iXLcRYArREzUlftGtpdXV6zBjXdXzOVQcsgzwGH9tH8rnCGt
        d/Xzijjo13r+/X6t3hTntVca4Q==
X-Google-Smtp-Source: AGHT+IExnIHp9l/UnaTbrZ3Z3/Wvq+vo4xX0Z23oITLpc5cVbubkCxO0IQd8/NJP5tC/mEAiM4RIRw==
X-Received: by 2002:a05:600c:1d18:b0:404:72f9:d59a with SMTP id l24-20020a05600c1d1800b0040472f9d59amr18737359wms.0.1697023161691;
        Wed, 11 Oct 2023 04:19:21 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm18945715wmm.30.2023.10.11.04.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:19:21 -0700 (PDT)
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
        Evan Green <evan@rivosinc.com>, Conor Dooley <conor@kernel.org>
Subject: [PATCH v1 08/13] riscv: add ISA extension probing for Zihintntl
Date:   Wed, 11 Oct 2023 13:14:33 +0200
Message-ID: <20231011111438.909552-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011111438.909552-1-cleger@rivosinc.com>
References: <20231011111438.909552-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add probing for Zihintntl ISA extension[1] that was ratified in commit
0dc91f5 ("Zihintntl is ratified") in riscv-isa-manual[2].

[1] https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view
[2] https://github.com/riscv/riscv-isa-manual/commit/0dc91f505e6d

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 35f00401afc8..1f09b8b3da2a 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -76,6 +76,7 @@
 #define RISCV_ISA_EXT_ZVKT		58
 #define RISCV_ISA_EXT_ZFH		59
 #define RISCV_ISA_EXT_ZFHMIN		60
+#define RISCV_ISA_EXT_ZIHINTNTL		61
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 9ee7814641a4..136e90263ba2 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -169,6 +169,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
 	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
+	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
-- 
2.42.0

