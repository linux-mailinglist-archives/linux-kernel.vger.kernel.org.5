Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C927F58C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbjKWG66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344835AbjKWG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:58:38 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194CA10F3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:58:26 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6cd1918afb2so354864a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700722706; x=1701327506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXVVh5tHQq6H+NSQA4JeCtH/rNgHUAw+NLKBVun1FJI=;
        b=VGhRI+k+plxBcZ9NjAKo1Pa3AIXjp4IxipMYWF86Cr1uZn/dpu4vysm4ntKJmUrb4f
         r5QVTvbRzpcSQvr7YjHtGeuh7fqQtzESqpSZrkVM1NAEliMIvNRAQWMLlVzciDPc8Smo
         2v9kjpRMQLicJtG3n1vtSoaZCsXN7WFJ9RTbzy8xLc4UYxZ+VqgPzbOSNRPB155/pnpH
         PotifhDVZIfwQg0l0S+fj8beoF+gnHtjMTxWNKRXU8Gdf1VQXCYnAX5XfeIjZeoMBuGz
         Db8Kc1KQF4/q19T3HJUFh7qiyC2906RKI32JEef5KN7nr6Rt7N7ENKul79nQ7UWYEA0I
         +bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700722706; x=1701327506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXVVh5tHQq6H+NSQA4JeCtH/rNgHUAw+NLKBVun1FJI=;
        b=NixS9RyIa7+uavdw8yTGMunHoZBvYRee722TUJFjP2VSNhu1jZ6a1xFydrqD+mdf6c
         lL40wbK0wL0ZlvogaF+PIrdZdtf1rdIA2LG5h6DGFx8KfAuzx7gi6QTCHftI/YLavL2q
         P1/NM1ABoSVhjJae/yCql32d/CYIQFUECtzGZlTXsB6PeovfVnGZrEacL4Zx7h8/yB3c
         sWFPQTOF8oUaKtgWFSccHiEo/0XShM8FmdDaX1P0Q0SM0aX3TAqDDV6UVFYvGXuaUAgf
         oVpo7bsGL4Iv5+TwAlu9CEZM4B6wJuEzC5P3CtXbuUWcGQP3evUyLcTk3XRmVksaN3Tc
         9xhw==
X-Gm-Message-State: AOJu0YybQizTxVtC+2C8GAgpc4el4IdiubDSlO9iQPcX4b24Iu8K5T8/
        ExfMwJI0/vZpxCjeLAbr4SLsIg==
X-Google-Smtp-Source: AGHT+IHjXbEiIjdrtzBQes9pWsmlDe44Anh7ZX4igq4dgVqzJwwbqJ+5ff/GxnQby0i2Dm9GfBQciw==
X-Received: by 2002:a9d:620d:0:b0:6cd:8c3:5b40 with SMTP id g13-20020a9d620d000000b006cd08c35b40mr4649798otj.36.1700722705824;
        Wed, 22 Nov 2023 22:58:25 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id w37-20020a634765000000b005bd2b3a03eesm615437pgk.6.2023.11.22.22.58.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Nov 2023 22:58:25 -0800 (PST)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, songmuchun@bytedance.com,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH V1 11/11] riscv: Introduce 64K page size
Date:   Thu, 23 Nov 2023 14:57:08 +0800
Message-Id: <20231123065708.91345-12-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231123065708.91345-1-luxu.kernel@bytedance.com>
References: <20231123065708.91345-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces new config to control whether enabling the 64K
base page feature on RISC-V.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/Kconfig       |  1 +
 arch/riscv/Kconfig | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index f4b210ab0612..66f64450d409 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1087,6 +1087,7 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
 
 config PAGE_SIZE_LESS_THAN_64KB
 	def_bool y
+	depends on !RISCV_64K_PAGES
 	depends on !ARM64_64K_PAGES
 	depends on !PAGE_SIZE_64KB
 	depends on !PARISC_PAGE_SIZE_64KB
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 105cbb3ca797..d561f9f7f9b4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -227,6 +227,7 @@ config RISCV_HW_PAGE_SHIFT
 
 config RISCV_PAGE_SHIFT
 	int
+	default 16 if RISCV_64K_PAGES
 	default 12
 
 config KASAN_SHADOW_OFFSET
@@ -692,6 +693,25 @@ config RISCV_BOOT_SPINWAIT
 
 	  If unsure what to do here, say N.
 
+choice
+	prompt "Page size"
+	default RISCV_4K_PAGES
+	help
+	  Page size (translation granule) configuration.
+
+config RISCV_4K_PAGES
+	bool "4KB"
+	help
+	  This feature enables 4KB pages support.
+
+config RISCV_64K_PAGES
+	bool "64KB"
+	depends on ARCH_HAS_STRICT_KERNEL_RWX && 64BIT
+	help
+	  This feature enables 64KB pages support (4KB by default)
+
+endchoice
+
 config ARCH_SUPPORTS_KEXEC
 	def_bool MMU
 
-- 
2.20.1

