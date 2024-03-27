Return-Path: <linux-kernel+bounces-120669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D988DB46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3691F2A175
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019163EA7B;
	Wed, 27 Mar 2024 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="F49AGDMe"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769781C32
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535498; cv=none; b=PB8gUrLAvblfDRGSTbh8ubAHPh+Ob1jnZDRHglzZQ85nMw04KXMw6KjXeiefqcjZlAyNsAKO0XhEQF/eex4TjdBOzLHQOm6dEPYwjO9ouzefnsoswBE+1jBSLBgeW/p+1r8R5A9Lf7Rl5ByII18LQVj1y/RvzGMr8a0OwzA81F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535498; c=relaxed/simple;
	bh=yD9gMfFxCFOf87qA7aDCq+KNVtkVotiVL/nqF6nQSEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5AGGPVaF5MYR4jUVuX8BnwyYEHN1g6JF0eMjidB3eU/Rpz6kuiLpvvJIzvMz9dYR33gwNA1MZDfoknuwEk0COnm95ciqwjVjeuKLBUUMtfoDA2AH70u2P8HwsWjr/lKqDfDmtuUjHVilg0SsMWkCtVNIwBATA2uQQ53OyzZAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=F49AGDMe; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so8378635a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1711535495; x=1712140295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFFjWbcETbPCVovmbM8tpReuGu8aZixvMHFh/xJCQ5U=;
        b=F49AGDMeCuDw9QobfUsUKtaecu7Vw1B6RvkpUu6JVVDDJF6tftX2AxERmGMsGYy0kZ
         dL4LujeHb+8MQpJ3BcYjkDFhWR1kCCFERGF7Ob5RRyQL2Ejr8F9EEldqH8kTBHcFTn4i
         0Fdy1mU6Gu+nczdqvq53K/mxRDaG/Sxtb0wze3fXqE8NkdPer74KPWUFj6VF+wVAfXpl
         zjfuDF75FXQEbBdtKKAmayjuENWec2Y/3sV+3kyxcJkiiUz2exgQx52SFZrpgmrC6veO
         3GA5cglnnAX0jAJ65JgSAkvLII2ITAD1melKlqbEqkX2ls4e1eZZiiOIK1vTJ4deMX39
         39RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711535495; x=1712140295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFFjWbcETbPCVovmbM8tpReuGu8aZixvMHFh/xJCQ5U=;
        b=drOFJSOsJCfKwrmaYrDgwTy6y/zWfjvC4TnP+iyNEAQj9I2XerzGHJsyl4SLYCqmhV
         Bqk8uOP6wUD05CxcjagYLpI0R3ydp53hoNpNiVDk0NdXMSxQroPU4/yypc4+YJPRG52k
         CDZDvnZ6I29lGot9SEexsyfNhZlsRWe9xsWH6S3q215YnELfCa01REJHHSZEY0GH8XqP
         ZMwFUPxjhz8ojOp/NA6KMJBu9PLCalbF+dY2bZ7Obq3kZuso9ZjCzjy8Vm7orhGEFO2s
         wiZsUYLyDPiCq/ABJHJ+QKZYWzOrpcfbc6g8aHKlU7xjagGV9Fz2YHLRi7WKqqYMu8KR
         0zNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWDdgOztHIUCG0rRNXrdDIbMxklOaRIn3zRn3BJwZg5I6HN0p7YM7jwLDHb9GI+zsWAYddeTIiqaQxULMNAZqUd1X2B2f0mmXSFZCo
X-Gm-Message-State: AOJu0YwhjVNOZnTjbZavw10Y3Jic3xU3jXDlLIBBShkLQidfGrVBiCgF
	9CMNfSvZEY7kwEkNnt5EM7qcqDxT8Y43MxpmRg6PtYuQ0MADmWtdWl8tq1ktcp4=
X-Google-Smtp-Source: AGHT+IFpb/VYghvSGRAZv/KSjYVbhAxxbRz3wD8nc7CPHRDPIyI0sKYTxchYPDN6RU4YBfPXV3vdmA==
X-Received: by 2002:a17:906:d7ae:b0:a44:4c9e:8809 with SMTP id pk14-20020a170906d7ae00b00a444c9e8809mr2772060ejb.32.1711535494767;
        Wed, 27 Mar 2024 03:31:34 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906270f00b00a46b8cd9b51sm5294078ejc.185.2024.03.27.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 03:31:34 -0700 (PDT)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Cooper Qu <cooper.qu@linux.alibaba.com>,
	Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
	Huang Tao <eric.huang@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 1/2] riscv: thead: Rename T-Head PBMT to MAEE
Date: Wed, 27 Mar 2024 11:31:29 +0100
Message-ID: <20240327103130.3651950-2-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
References: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

T-Head's vendor extension to set page attributes has the name
MAEE (MMU address attribute extension).
Let's rename it, so it is clear what this referes to.

See also:
  https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadmaee.adoc

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 arch/riscv/Kconfig.errata            |  8 ++++----
 arch/riscv/errata/thead/errata.c     |  8 ++++----
 arch/riscv/include/asm/errata_list.h | 20 ++++++++++----------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 910ba8837add..2c24bef7e112 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -82,14 +82,14 @@ config ERRATA_THEAD
 
 	  Otherwise, please say "N" here to avoid unnecessary overhead.
 
-config ERRATA_THEAD_PBMT
-	bool "Apply T-Head memory type errata"
+config ERRATA_THEAD_MAEE
+	bool "Apply T-Head's MMU address attribute (MAEE)"
 	depends on ERRATA_THEAD && 64BIT && MMU
 	select RISCV_ALTERNATIVE_EARLY
 	default y
 	help
-	  This will apply the memory type errata to handle the non-standard
-	  memory type bits in page-table-entries on T-Head SoCs.
+	  This will apply the memory type errata to handle T-Head's MMU address
+	  attribute extension (MAEE).
 
 	  If you don't know what to do here, say "Y".
 
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index b1c410bbc1ae..8c8a8a4b0421 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -19,10 +19,10 @@
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
-static bool errata_probe_pbmt(unsigned int stage,
+static bool errata_probe_maee(unsigned int stage,
 			      unsigned long arch_id, unsigned long impid)
 {
-	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
+	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_MAEE))
 		return false;
 
 	if (arch_id != 0 || impid != 0)
@@ -140,8 +140,8 @@ static u32 thead_errata_probe(unsigned int stage,
 {
 	u32 cpu_req_errata = 0;
 
-	if (errata_probe_pbmt(stage, archid, impid))
-		cpu_req_errata |= BIT(ERRATA_THEAD_PBMT);
+	if (errata_probe_maee(stage, archid, impid))
+		cpu_req_errata |= BIT(ERRATA_THEAD_MAEE);
 
 	errata_probe_cmo(stage, archid, impid);
 
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index ea33288f8a25..7c377e137b41 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -23,7 +23,7 @@
 #endif
 
 #ifdef CONFIG_ERRATA_THEAD
-#define	ERRATA_THEAD_PBMT 0
+#define	ERRATA_THEAD_MAEE 0
 #define	ERRATA_THEAD_PMU 1
 #define	ERRATA_THEAD_NUMBER 2
 #endif
@@ -53,20 +53,20 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
  * in the default case.
  */
 #define ALT_SVPBMT_SHIFT 61
-#define ALT_THEAD_PBMT_SHIFT 59
+#define ALT_THEAD_MAEE_SHIFT 59
 #define ALT_SVPBMT(_val, prot)						\
 asm(ALTERNATIVE_2("li %0, 0\t\nnop",					\
 		  "li %0, %1\t\nslli %0,%0,%3", 0,			\
 			RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
 		  "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,	\
-			ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)	\
+			ERRATA_THEAD_MAEE, CONFIG_ERRATA_THEAD_MAEE)	\
 		: "=r"(_val)						\
 		: "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),		\
-		  "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
+		  "I"(prot##_THEAD >> ALT_THEAD_MAEE_SHIFT),		\
 		  "I"(ALT_SVPBMT_SHIFT),				\
-		  "I"(ALT_THEAD_PBMT_SHIFT))
+		  "I"(ALT_THEAD_MAEE_SHIFT))
 
-#ifdef CONFIG_ERRATA_THEAD_PBMT
+#ifdef CONFIG_ERRATA_THEAD_MAEE
 /*
  * IO/NOCACHE memory types are handled together with svpbmt,
  * so on T-Head chips, check if no other memory type is set,
@@ -83,11 +83,11 @@ asm volatile(ALTERNATIVE(						\
 	"slli    t3, t3, %3\n\t"					\
 	"or      %0, %0, t3\n\t"					\
 	"2:",  THEAD_VENDOR_ID,						\
-		ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)		\
+		ERRATA_THEAD_MAEE, CONFIG_ERRATA_THEAD_MAEE)		\
 	: "+r"(_val)							\
-	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
-	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT),			\
-	  "I"(ALT_THEAD_PBMT_SHIFT)					\
+	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_MAEE_SHIFT),		\
+	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_MAEE_SHIFT),			\
+	  "I"(ALT_THEAD_MAEE_SHIFT)					\
 	: "t3")
 #else
 #define ALT_THEAD_PMA(_val)
-- 
2.44.0


