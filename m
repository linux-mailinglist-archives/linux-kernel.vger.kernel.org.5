Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE77EFD80
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbjKRDj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjKRDjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:39:52 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26944170F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:39:46 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d33298f8fdso1509471a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700278785; x=1700883585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5CqYtZjogFbVXt6oNqdtFyBl6EwNFmDaHiSS35XtX0=;
        b=Ca/6T14OGl0TQlPtX1CWXh9y09HtCzxopj0NiLKPPkhsihrGCY6VuW3iJTJirP8qW2
         WYowKEzYHH+xDo9lbhcTZukRg0MA2B4QAvnKxX3d1BetuwE/kd7uE3tBI6bqwTrtyiMy
         HItjpedjgxgviQ0mWkpKC7w7Ub6qkKWRQk6Itd1jXrXPTNZqmmeSadMUs8kUU795up4/
         jfG5ttKVYh4iDO1GujAKdNyri49RSza8Cdr5Y4k8W95RyvpViFEN3Y6OPqW5UVJJdkNP
         ICfD3x02XGTD5eYRMPkCvwoRhTnJwqRI0iFgEZkS6SA9H0ZolD5HRjH1df7Tg/j6QWMi
         XIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278785; x=1700883585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5CqYtZjogFbVXt6oNqdtFyBl6EwNFmDaHiSS35XtX0=;
        b=Hw25985mpPf0AWdF8TeX68ThODKWXWAjYS7qcMOJUlNZeAIHCbsXfu2mBHttFKFtQj
         16OdpTXRwCTJpWn1J131tV8ke2mQEu2N4gBzLCjE23Gblrunb4ExZpbyML/iWwAc3rxN
         rtJuQZUGqwZ5PXIdjoKhaWBWXEDDXVU25zV60vO09vxNdCwmPZVg2JInHLhX6RFiyDS4
         gXfk4jMQyvNDwn380qxXdmVUSzvC6kreGSVENtQjFEW6DJMyq0fDgZJ9tgC6YCAWj+/Z
         Yp8g/CUGgGs5hrKuVDuVwB2IcR2YFBEJv/jpZH4bwkixXB1daIIajkW0BTZ7ZzoCmx+F
         PPBg==
X-Gm-Message-State: AOJu0YzCwsPsONj4x9Kkc5MX/B9FMbCJ9a8Jz/BvY0qWJJuTh04K0F+H
        9CnNxyreD3Yj909DC54paeAfFw==
X-Google-Smtp-Source: AGHT+IFb5EggA2BEK2LPl8TELrC4wgaMj8P7ee9t/caB/1Et1jdB4N8VOhdF9KYDfMnGJFJ+eqIzWA==
X-Received: by 2002:a05:6871:728a:b0:1e9:9867:247 with SMTP id mm10-20020a056871728a00b001e998670247mr1437835oac.47.1700278785270;
        Fri, 17 Nov 2023 19:39:45 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.108])
        by smtp.gmail.com with ESMTPSA id cz8-20020a17090ad44800b00280fcbbe774sm2053823pjb.10.2023.11.17.19.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:39:44 -0800 (PST)
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
Subject: [PATCH v4 4/5] tty: Add SBI debug console support to HVC SBI driver
Date:   Sat, 18 Nov 2023 09:08:58 +0530
Message-Id: <20231118033859.726692-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118033859.726692-1-apatel@ventanamicro.com>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/tty/hvc/hvc_riscv_sbi.c | 59 +++++++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 8 deletions(-)

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
index 31f53fa77e4a..697c981221b5 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -39,21 +39,66 @@ static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
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
+	phys_addr_t pa;
+
+	if (is_vmalloc_addr(buf)) {
+		pa = page_to_phys(vmalloc_to_page(buf)) + offset_in_page(buf);
+		if (PAGE_SIZE < (offset_in_page(buf) + count))
+			count = PAGE_SIZE - offset_in_page(buf);
+	} else {
+		pa = __pa(buf);
+	}
+
+	return sbi_debug_console_write(count, pa);
 }
-device_initcall(hvc_sbi_init);
 
-static int __init hvc_sbi_console_init(void)
+static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
 {
-	hvc_instantiate(0, 0, &hvc_sbi_ops);
+	phys_addr_t pa;
+
+	if (is_vmalloc_addr(buf)) {
+		pa = page_to_phys(vmalloc_to_page(buf)) + offset_in_page(buf);
+		if (PAGE_SIZE < (offset_in_page(buf) + count))
+			count = PAGE_SIZE - offset_in_page(buf);
+	} else {
+		pa = __pa(buf);
+	}
+
+	return sbi_debug_console_read(count, pa);
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
+	} else {
+		if (IS_ENABLED(CONFIG_RISCV_SBI_V01)) {
+			err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_v01_ops, 256));
+			if (err)
+				return err;
+			hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
+		} else {
+			return -ENODEV;
+		}
+	}
 
 	return 0;
 }
-console_initcall(hvc_sbi_console_init);
+device_initcall(hvc_sbi_init);
-- 
2.34.1

