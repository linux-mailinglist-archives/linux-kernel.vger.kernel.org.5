Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7683B7F6C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjKXHKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjKXHKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:10:32 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D6D10F3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:10:37 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1f9e6a49bd2so320162fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809836; x=1701414636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQhHGwPmQ4TCzhQ9rEz5VPF8mnM3VrFDuBPe9IkpS1Y=;
        b=dz+muue8lZwwIfj3n9g6aEtHhtaY7QPswJGNa27H0Uh/HKBbKS+oKCRjBi2dsUnlgS
         3ykUbk+nLWEnhXM3MVdP4Uew+4r/qcxA1tLMO40kUNQs08lj2yvlrQJWUtDJIiKI+bIK
         UUE1mZEUJE9p87AVH6aSTTRye0uPzq2z5+v1Fw77a8Lii9JjqhGtOiRhQtJAaJ6InpTq
         ULdKwRYwFJ4TNxJLSLe9VqdJywhHdbZUltymnLgJESpCmWU/Lr8iFcNa2AFbxAGQT3+y
         JwheetW7ksexM+v3ipeD0ISMHeAgs8gwFAcYngfXhU5qL/67xEa78k0y9Y3VLklBA5cF
         xlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809836; x=1701414636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQhHGwPmQ4TCzhQ9rEz5VPF8mnM3VrFDuBPe9IkpS1Y=;
        b=ImC3/adP+LwIlf3939XJlfH4zDPqC6bZMEf8AsoxoY1w1cJ4FMgMbvTkQ/fpMoma/J
         JgU1slN/pMfeGWSVbR7mmsmrmAps5eB5DOk79Ww2zZTL9GyAO2aSC2pcDiJJwp/jFuFX
         KR55Ve19SuLU+RLCFRsecCLnqaPfsV5d6WKe/lEJtYxJQVuQJKn8FKpleTVNqcReInpG
         yqKglLCE8j0PcFE7j0rMbbksYMoyjbyRya9hUUjCiDpStSgybE6nzwhf0xuruDmIxZMV
         3IeDbz6P7xkPr8l41f2vL6vLoTHjggyy+7PbDSzSdxrJdTLOOtuj6S8qZiC0oVGsmYuO
         P/SA==
X-Gm-Message-State: AOJu0YwGrwRShbXgObOVHUEpUPeOZaqxA22AoXX9Mxuk9S23QB4T2qNo
        Oh6ONILNjAU0rWX2WwACuNurHw==
X-Google-Smtp-Source: AGHT+IGvJOScqEUs5x/NC1+xkb/+ZzFxNOvJHJDnrqYvAj8EJtKq+m+RbFE9B8BNRcDqThajOtvZdA==
X-Received: by 2002:a05:6870:4729:b0:1f9:d22e:6339 with SMTP id b41-20020a056870472900b001f9d22e6339mr801112oaq.23.1700809836602;
        Thu, 23 Nov 2023 23:10:36 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:36 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 3/5] tty/serial: Add RISC-V SBI debug console based earlycon
Date:   Fri, 24 Nov 2023 12:39:03 +0530
Message-Id: <20231124070905.1043092-4-apatel@ventanamicro.com>
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

We extend the existing RISC-V SBI earlycon support to use the new
RISC-V SBI debug console extension.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 27 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 732c893c8d16..1f2594b8ab9d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -87,7 +87,7 @@ config SERIAL_EARLYCON_SEMIHOST
 
 config SERIAL_EARLYCON_RISCV_SBI
 	bool "Early console using RISC-V SBI"
-	depends on RISCV_SBI_V01
+	depends on RISCV_SBI
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
index 27afb0b74ea7..0162155f0c83 100644
--- a/drivers/tty/serial/earlycon-riscv-sbi.c
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -15,17 +15,38 @@ static void sbi_putc(struct uart_port *port, unsigned char c)
 	sbi_console_putchar(c);
 }
 
-static void sbi_console_write(struct console *con,
-			      const char *s, unsigned n)
+static void sbi_0_1_console_write(struct console *con,
+				  const char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 	uart_console_write(&dev->port, s, n, sbi_putc);
 }
 
+static void sbi_dbcn_console_write(struct console *con,
+				   const char *s, unsigned int n)
+{
+	int ret;
+
+	while (n) {
+		ret = sbi_debug_console_write(s, n);
+		if (ret < 0)
+			break;
+
+		s += ret;
+		n -= ret;
+	}
+}
+
 static int __init early_sbi_setup(struct earlycon_device *device,
 				  const char *opt)
 {
-	device->con->write = sbi_console_write;
+	if (sbi_debug_console_available)
+		device->con->write = sbi_dbcn_console_write;
+	else if (IS_ENABLED(CONFIG_RISCV_SBI_V01))
+		device->con->write = sbi_0_1_console_write;
+	else
+		return -ENODEV;
+
 	return 0;
 }
 EARLYCON_DECLARE(sbi, early_sbi_setup);
-- 
2.34.1

