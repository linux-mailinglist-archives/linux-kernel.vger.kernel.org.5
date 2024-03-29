Return-Path: <linux-kernel+bounces-124466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557689186D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861CB1F21F54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AD38565D;
	Fri, 29 Mar 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="SYSEuWV1"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E84F9E9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714463; cv=none; b=eO3QpAZyp5eRBhvy4wTaDbYjltLGr/O0TVL4/gPsMP4EUIgu4owIxXGi9AVd013GtffHzk3SY3DjsHn/xmcDLl+iGfvOm44IFs+KxsZNB/wiChJyKFASSS6edaNNAMiTFtvS+rsOR5PfyvS/vMf7Q5YJY5x7Hi7Cma9M1Bj0Y5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714463; c=relaxed/simple;
	bh=yD9gMfFxCFOf87qA7aDCq+KNVtkVotiVL/nqF6nQSEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIE5ynRLrTi68LGv6snOWCYDMq+JxyA50RcLLLBnzpqiC1r7fE2T8CQ5KrjqERIlw3ooZrWEp+PrRGUKJtOd5QePIdQY/X7omL16QuAwMetPGsUXnohGuI7dHD2xF/kWrwaSdXZZ6895vG2TTsopm2nY2NfqHRyffaConxn7XI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=SYSEuWV1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4751063318so244699166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1711714459; x=1712319259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFFjWbcETbPCVovmbM8tpReuGu8aZixvMHFh/xJCQ5U=;
        b=SYSEuWV12cSwr1SLwVPP9Og+GpllGE1oubyHvms9cSr5p/DBte4kwAJv4/+/AxtaLR
         1qvNQ4Zlg4U/5anu3Coh7sXRDu3LuKNQ2ahp2sb1M8OV/zptPrgKkrEPlvD+sRfCWwnx
         UdIBWNWcSvGZ7aPqxWg8zZiyN91z+WVWXDYTDp45Jg8RW4rZyIoZH/R6R8zkdJyTCVdT
         hGC8ZZrwTcmlHUFKbuFmzB0DGo56gaEwGVn5zsQwtYa+mcTVym9tW9B5cLVqvYDHUkTz
         TFM6OqZ81SQT9rmED8ikeMZcb2XdmGSYAjiIasD0bn93ZPwdoomtaJuSITLPL+1mkIWi
         MK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711714459; x=1712319259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFFjWbcETbPCVovmbM8tpReuGu8aZixvMHFh/xJCQ5U=;
        b=KDLPks6P+WdwUDVV6HnNlAV7ij9ZLaSNd53H/V21ER00TLGFGW/dmq0rJkDWexGZGE
         t96XWM8R4wZEGtLTlDAbfbqAK2YDirm4OsAVINMHGP0yYaxVY6q+0/au4feXmf72Co6Y
         bZsNObeeAVYHZ1gO0hRnfXQseNCnKT9MAj7eX9K87KkK14ut4y6J2gU88gqGjjO/9iyS
         v77bYMena137I/1WaSp4r4t4xsJi1AiO3MJ/Tw1KlVEDxnBkE70rwg2yCS1M+EJhjS4o
         p/wppISHAy8o1B1KybB7fSmW9PGQ7rz9B6vISszX33gvOetVP9JJ7C+4b1o/ggIfK3VY
         aAAg==
X-Forwarded-Encrypted: i=1; AJvYcCXta7p2TBFyBrTbFdWzz3XeINH/thz4NicUFhJAh8pwK2H53ywIT41BCU8dlk7OHDhCvoyieNbebTHfr0N6DfKKrODplTLcFNr3Ofio
X-Gm-Message-State: AOJu0YzlxWMeCQSEQYkQO1QJ+TrZPUn54/vJE57kK4LuKFOz14cKLSYY
	+7m7orW6zzZK8ZNdk3GcPvJD4rWkxGtpjBLH3zbDwx4O+biVxgdtA2uQ1/gaZBU=
X-Google-Smtp-Source: AGHT+IGLABwyH28ATsB0x8W3Kqgj27YWFl1l10nx/AfsG23r+Q9xo/kACBZfAHUxCCRT+b66nkS/bQ==
X-Received: by 2002:a17:906:33d9:b0:a4e:220d:ff21 with SMTP id w25-20020a17090633d900b00a4e220dff21mr1346615eja.59.1711714459528;
        Fri, 29 Mar 2024 05:14:19 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b00a46dd1f7dc1sm1869942ejo.92.2024.03.29.05.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 05:14:19 -0700 (PDT)
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
	Conor Dooley <conor@kernel.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH v2 1/2] riscv: thead: Rename T-Head PBMT to MAEE
Date: Fri, 29 Mar 2024 13:14:13 +0100
Message-ID: <20240329121414.688391-2-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329121414.688391-1-christoph.muellner@vrull.eu>
References: <20240329121414.688391-1-christoph.muellner@vrull.eu>
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


