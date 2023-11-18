Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C97EFD7C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346439AbjKRDjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346435AbjKRDjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:39:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CA8D7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:39:38 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28398d6c9f3so1206963a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700278778; x=1700883578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUknxwWYXkt9C2M9pb/Z3CUGPfJIBZQMgmHAhH/xaf8=;
        b=IHinz0gC9R+tzPymiH/JYDJhkA1wbhQAUTXtmV8pyHSzPlZAcwIeDTK5Fi0FYCDuFY
         BPf7XkCaBf4DpJeDsDjEEyjA6mxsD7olqrLUy63PqC8wKgBRbjQhJ+U3dC0EXS5Dj/6n
         OHsJFVQFL1HfPjTBhISf7TH4K/0T1eJX1ZuZn/VUggTkINKUWUuljbxT9/E39owHOTJl
         6wcinfSZw9yz+cAX28qCKoGn54+4TpNa0HwpYgtOpgNnKwRWJPRiJA5lF8du9u/jpLeN
         id4pvq9Ju4CZfzrqJZQ1tBRXiELsF4fxDCVm/h798hhGQo6dFnUJx2fbUclpc/0jQjxv
         e69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278778; x=1700883578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUknxwWYXkt9C2M9pb/Z3CUGPfJIBZQMgmHAhH/xaf8=;
        b=ZuHqPJdCvH0HHEtQ7u7Ieaa4HkxhyyegpOpuyTlszZ5g0OsBBqjSxcSNKEe6ywTh1X
         pktni5Aq4QFMvW1Y5DFlQeH6BTjkJ23GnwUC51FbC5Y+bypmDivLLdvLqNCHw9gPLEAW
         0FHOYCZdbkrJCvNClZc+OtbhSPCp6HYWPwARdjAs2h0M9RHAWuSJkhed/KQQoQ+3mQMs
         SJCs8p0KhQFCHzaju1wNyG76tiWqMXk6LcRG7KSXEPz072dxrNx8HafDc/ngWTyX/bOG
         Leq0AqGRbWY/Na6QpSexnJTNVXxw/+3JjBGCZ3I3vWFQPX6k9XdXZNVjjdQMBxRtmYrf
         L/dA==
X-Gm-Message-State: AOJu0YxLlZDfZ63SxzT/ww9zDChs5OSu03K3aG/Aw90/lbrovWpysuvf
        UzMh+d5Gb8jjIm9M1URlIgpjPQ==
X-Google-Smtp-Source: AGHT+IGETYioNALUjNhz6JIS+eO7DP/jwO69X1kH6NZN6oXPpq2gEGKYxgt01iCN0WIJkFYPAiCO9A==
X-Received: by 2002:a17:90b:1e02:b0:27d:7887:ddc5 with SMTP id pg2-20020a17090b1e0200b0027d7887ddc5mr1729418pjb.32.1700278778017;
        Fri, 17 Nov 2023 19:39:38 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.108])
        by smtp.gmail.com with ESMTPSA id cz8-20020a17090ad44800b00280fcbbe774sm2053823pjb.10.2023.11.17.19.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:39:37 -0800 (PST)
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
Subject: [PATCH v4 2/5] RISC-V: Add SBI debug console helper routines
Date:   Sat, 18 Nov 2023 09:08:56 +0530
Message-Id: <20231118033859.726692-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118033859.726692-1-apatel@ventanamicro.com>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let us provide SBI debug console helper routines which can be
shared by serial/earlycon-riscv-sbi.c and hvc/hvc_riscv_sbi.c.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h |  5 +++++
 arch/riscv/kernel/sbi.c      | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 66f3933c14f6..ee7aef5f6233 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -334,6 +334,11 @@ static inline unsigned long sbi_mk_version(unsigned long major,
 }
 
 int sbi_err_map_linux_errno(int err);
+
+extern bool sbi_debug_console_available;
+int sbi_debug_console_write(unsigned int num_bytes, phys_addr_t base_addr);
+int sbi_debug_console_read(unsigned int num_bytes, phys_addr_t base_addr);
+
 #else /* CONFIG_RISCV_SBI */
 static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1; }
 static inline void sbi_init(void) {}
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 5a62ed1da453..73a9c22c3945 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -571,6 +571,44 @@ long sbi_get_mimpid(void)
 }
 EXPORT_SYMBOL_GPL(sbi_get_mimpid);
 
+bool sbi_debug_console_available;
+
+int sbi_debug_console_write(unsigned int num_bytes, phys_addr_t base_addr)
+{
+	struct sbiret ret;
+
+	if (!sbi_debug_console_available)
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_32BIT))
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
+				num_bytes, lower_32_bits(base_addr),
+				upper_32_bits(base_addr), 0, 0, 0);
+	else
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
+				num_bytes, base_addr, 0, 0, 0, 0);
+
+	return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value;
+}
+
+int sbi_debug_console_read(unsigned int num_bytes, phys_addr_t base_addr)
+{
+	struct sbiret ret;
+
+	if (!sbi_debug_console_available)
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_32BIT))
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
+				num_bytes, lower_32_bits(base_addr),
+				upper_32_bits(base_addr), 0, 0, 0);
+	else
+		ret = sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_READ,
+				num_bytes, base_addr, 0, 0, 0, 0);
+
+	return ret.error ? sbi_err_map_linux_errno(ret.error) : ret.value;
+}
+
 void __init sbi_init(void)
 {
 	int ret;
@@ -612,6 +650,11 @@ void __init sbi_init(void)
 			sbi_srst_reboot_nb.priority = 192;
 			register_restart_handler(&sbi_srst_reboot_nb);
 		}
+		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
+		    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
+			pr_info("SBI DBCN extension detected\n");
+			sbi_debug_console_available = true;
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.34.1

