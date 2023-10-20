Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F167D0965
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376455AbjJTHWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376515AbjJTHW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:22:29 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9517171F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:22:22 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2e4107f47so376703b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697786542; x=1698391342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y40VDpa5tFn1F2iuJCGX0eAdf56bF4H2v7CDU5J7JlM=;
        b=Y/dSv7M87ohdmZ4awy0HHKLeA+scxM7mt0K3NdBG6B7PFHtFqgnuE5MD8/oAVDJwbP
         oYhoDehf1vfzRuNR2JBJatfKHKmrs/7Px/ImZpPIYO7q1/2JZI+tHFbFQ8aLcVT4ShOg
         HdkKk8JMTSOd/kDrEvdPWrTHf/VS0wkP1s9/qX/Dl2mae+8xJ6w2s91cGLE1pzAY/dMN
         LVTmx5+PGF3DCSSMvqqnSf3CD4TdcDp+8xoB63mSrSiiI5MepK5YpxBWPGXE+SoAsiaQ
         1bvuV3UjZHF3/WoE5reUxLbIwjGDgvhEcEQAQ58K3JRfQJueyvr9zfmpJXJlPo6bJcKC
         /c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786542; x=1698391342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y40VDpa5tFn1F2iuJCGX0eAdf56bF4H2v7CDU5J7JlM=;
        b=TDnf4vzza5jVrKKYUNrChU4LHV4+ZXiDt0/rBfard5dZU75a+e6NHA0DG3ejEiAk93
         TFKbxsv1HuTa1pstDhGFx8MglqpBYeo6HEJqPhZJjWm6DaOD71BgofLNUb/D+cxI4qVO
         alqQFfp1d5p9MB6/Q6Qs/asSIE8aYNJOoMicbtud8ovb/KkHw3ckOe2ZZwP508fRMArw
         U6q+aWSLcmhW7KTNTJCaL26AvKMmDBITr/6T8qTmyinaKjiCBnH+xyH6bqCg1KrkEU+u
         oOSt2+qixJcGEDnj7e2D1E/6617mlZPZfvlOgKfek3y9bXlqlHr2LKejwcP98TLV9zAL
         30BA==
X-Gm-Message-State: AOJu0Yx0s+E3/J6MQydgnxL/bz3Tea7JyzCDDUUcknP2WAs/ivcbn3tp
        QOD4KUR1XDWkpoE9CjnGGN9Qxg==
X-Google-Smtp-Source: AGHT+IEUQYK4G0+aPnRjUR077ELz4RoscN7PlFXPrhd3l1/3Dp5w/UYmiQBCTNoQsdXF4g9TKR4q0g==
X-Received: by 2002:a05:6808:55:b0:3af:d7dc:a47e with SMTP id v21-20020a056808005500b003afd7dca47emr1067018oic.42.1697786541699;
        Fri, 20 Oct 2023 00:22:21 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.83.81])
        by smtp.gmail.com with ESMTPSA id v12-20020a63f20c000000b005b32d6b4f2fsm828204pgh.81.2023.10.20.00.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 00:22:21 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 7/9] tty/serial: Add RISC-V SBI debug console based earlycon
Date:   Fri, 20 Oct 2023 12:51:38 +0530
Message-Id: <20231020072140.900967-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020072140.900967-1-apatel@ventanamicro.com>
References: <20231020072140.900967-1-apatel@ventanamicro.com>
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

We extend the existing RISC-V SBI earlycon support to use the new
RISC-V SBI debug console extension.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 32 +++++++++++++++++++++----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index bdc568a4ab66..cec46091a716 100644
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
index 27afb0b74ea7..c21cdef254e7 100644
--- a/drivers/tty/serial/earlycon-riscv-sbi.c
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -15,17 +15,41 @@ static void sbi_putc(struct uart_port *port, unsigned char c)
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
+	phys_addr_t pa = __pa(s);
+
+	if (IS_ENABLED(CONFIG_32BIT))
+		sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
+			  n, lower_32_bits(pa), upper_32_bits(pa), 0, 0, 0);
+	else
+		sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
+			  n, pa, 0, 0, 0, 0);
+}
+
 static int __init early_sbi_setup(struct earlycon_device *device,
 				  const char *opt)
 {
-	device->con->write = sbi_console_write;
-	return 0;
+	int ret = 0;
+
+	if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
+	    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
+		device->con->write = sbi_dbcn_console_write;
+	} else {
+		if (IS_ENABLED(CONFIG_RISCV_SBI_V01))
+			device->con->write = sbi_0_1_console_write;
+		else
+			ret = -ENODEV;
+	}
+
+	return ret;
 }
 EARLYCON_DECLARE(sbi, early_sbi_setup);
-- 
2.34.1

