Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B17F6C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjKXHKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbjKXHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:10:35 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7AD10F8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:10:41 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6cd0963c61cso886212a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809841; x=1701414641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e69UQ6T+Z7CNLXUZDcGOS0SOuMoPgQwIsqXvR77gEM=;
        b=KgA9XAS8b7ne4H2F86yT9mlby7sXhpU4oQ9fnCaHFw6aKqBDgbiJYw2LwBPCr9lMcT
         WU2D71DWa2/4i8sourHqU280RsyMYu2bj6i4rRD4ysNe9eWt5qzdYxM6rCqJ9ifD3jas
         smoimi5b5z2LjnMehSKbX9eDX2xNaqn6R5oc2bOYhHTihq85mRxtQ/w1CwLB20piSmTN
         YeLpZNueQPwMUAyJW5wBhFsDJTFAZNASVwN7Ay1Hjl/iYsowro22NZD2pVrIm5XZ2cJr
         pVxitvfAIZ/rqNBwZJkwd35kzkR15P35eW3krXB2Bd4BOG/g5f1wLMB/LflXalWAI7JI
         V+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809841; x=1701414641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5e69UQ6T+Z7CNLXUZDcGOS0SOuMoPgQwIsqXvR77gEM=;
        b=Yfep/BakqvuqhvFba1qMMIgCsckKFnv/1bDdCpRuuKsavaji7aqA6piMhvbWkOSVG8
         JhuLoMScQM+RlvBfs9yVmnYavRQp2kVFp3pBeu1DaBqblQp+VeGZDNIGJyQEoiG0Djxl
         WYLnJGJrqFkzk5rQWAV4t5u7ddaie+8l4kBZoWin0jOIq85Cn7EFN5Mt1n07SUAZGF0n
         981YT7UxL5fDl6vswKUhjEZhtCLJ8znQClk2W//9Qmx5P/ukezDHc3IaTzJTxb4zT0+h
         8mPoyEEs02Jj5zHDVeNS2Pv1bGi80WSFp1okP3F3QTGhmGPhe/YQu/WJsla2Sh3rcfvO
         Gmnw==
X-Gm-Message-State: AOJu0Yyhr52cu9dRxSO8Eh7QrvORmiJMZ3S7/T0fT/qsNvaAmO6WtYJg
        tTBPJ8vMQY2QaEPiQTme+k065w==
X-Google-Smtp-Source: AGHT+IGpCaOs051rva99tydJYiLxp2JmCAggGxrs3iHMIIeR5K0qZKOeN66AGmBC8Za809GQ8lm4oQ==
X-Received: by 2002:a05:6871:453:b0:1f4:dd99:b07 with SMTP id e19-20020a056871045300b001f4dd990b07mr2011442oag.49.1700809840700;
        Thu, 23 Nov 2023 23:10:40 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:40 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 4/5] tty: Add SBI debug console support to HVC SBI driver
Date:   Fri, 24 Nov 2023 12:39:04 +0530
Message-Id: <20231124070905.1043092-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124070905.1043092-1-apatel@ventanamicro.com>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atishp@rivosinc.com>

RISC-V SBI specification supports advanced debug console
support via SBI DBCN extension.

Extend the HVC SBI driver to support it.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/tty/hvc/Kconfig         |  2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c | 37 ++++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 4f9264d005c0..6e05c5c7bca1 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -108,7 +108,7 @@ config HVC_DCC_SERIALIZE_SMP
 
 config HVC_RISCV_SBI
 	bool "RISC-V SBI console support"
-	depends on RISCV_SBI_V01
+	depends on RISCV_SBI
 	select HVC_DRIVER
 	help
 	  This enables support for console output via RISC-V SBI calls, which
diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
index 31f53fa77e4a..2f3571f17ecd 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -39,21 +39,44 @@ static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
 	return i;
 }
 
-static const struct hv_ops hvc_sbi_ops = {
+static const struct hv_ops hvc_sbi_v01_ops = {
 	.get_chars = hvc_sbi_tty_get,
 	.put_chars = hvc_sbi_tty_put,
 };
 
-static int __init hvc_sbi_init(void)
+static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int count)
 {
-	return PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_ops, 16));
+	return sbi_debug_console_write(buf, count);
 }
-device_initcall(hvc_sbi_init);
 
-static int __init hvc_sbi_console_init(void)
+static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
 {
-	hvc_instantiate(0, 0, &hvc_sbi_ops);
+	return sbi_debug_console_read(buf, count);
+}
+
+static const struct hv_ops hvc_sbi_dbcn_ops = {
+	.put_chars = hvc_sbi_dbcn_tty_put,
+	.get_chars = hvc_sbi_dbcn_tty_get,
+};
+
+static int __init hvc_sbi_init(void)
+{
+	int err;
+
+	if (sbi_debug_console_available) {
+		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_dbcn_ops, 256));
+		if (err)
+			return err;
+		hvc_instantiate(0, 0, &hvc_sbi_dbcn_ops);
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI_V01)) {
+		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_v01_ops, 256));
+		if (err)
+			return err;
+		hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
+	} else {
+		return -ENODEV;
+	}
 
 	return 0;
 }
-console_initcall(hvc_sbi_console_init);
+device_initcall(hvc_sbi_init);
-- 
2.34.1

