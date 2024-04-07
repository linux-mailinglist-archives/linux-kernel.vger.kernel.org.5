Return-Path: <linux-kernel+bounces-134648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0125989B417
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA00B21109
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669D245955;
	Sun,  7 Apr 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="VBBI6PeT"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3F42073
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712525564; cv=none; b=sOlHunantG5C7MPVFguUShYrIhOcE7Jqj+FEieV2Iz44xzmDTRyK9Eutza0mW09kVQxUUTfzOtv2yfJjLsFET/hTosOCukd2opJXGAAcdd3OxpaKsZQit9tnrLhVDrR8xa3UbetRmV9zbnrYqgQf4POZSFkcIfHHF6woAXxnjys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712525564; c=relaxed/simple;
	bh=Vd+Jcz3NEwAHWZiNnJr9mmiPAQD0apkBNs/WpUnjVc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmPMjawXMnQNkUz9nRouUXHr4+agfeXL9DENy3apRTmZ+SDkzxwNboSDdaLcsiY8KdBNMoncoVtjysXXx1/S9z/xgoeHtWqm7Eta6xGzVmRUjY3Ou08lcB0uioHqrFnNPo7NlHdRsknMzvBQ/L7PZ7rxeDveFoyu7UrrRi28Hzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=VBBI6PeT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d87660d5dbso14092331fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1712525561; x=1713130361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EsNSIHIYC4W6bV2ld6cL2XgDhSvlKY5N8B8yWmcW/U=;
        b=VBBI6PeTpInV3oIYd0O6DDvmAACk/XBUWRbe4xb878q+5AupiMNn2jWL+6TOmn2N7P
         9PcGHaow8qrK+MFuzO4pj1NF1Y5IBqi6HDMI1kZWjOvPeqygC9IuyQa6IxpFq2/NS6Na
         H5M/Mbh5pCteQJedWPqBIc6YVeFiS4keuUb4vCtzB9aK8GDJcy4EYnyRjjgg/FcUE8rn
         /eqIpD0mJbHDyXhfgxPSDHJTMgE+FSY7tvATo39omxdcqBd2K7B9gdlrM4m90Jz/N9FM
         1Xo1Ub4hDg08OT9P5TJw/gcAoAGVsZEaj6ihLauNQuE+rxD8rXikarvbiaSHkLfpVeX6
         w1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712525561; x=1713130361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EsNSIHIYC4W6bV2ld6cL2XgDhSvlKY5N8B8yWmcW/U=;
        b=RI9SZmJeY5E8SMRMzDHiIwq43/r4URLzLP9GKxdmk8fGWXhm2tIebzYi3sb0GloGS2
         OEqPmeEMbmRq7mC1D2T+s1GPp/eXvTfeN0Zvpx+R9f9alDkaQ80dPU49r9Ze+nZILoOY
         +eJkAr7igw3V3DtAMvusjQM/7+T/l9XvQ29TvEFORCYI9j80I3MUhLCQLx1nkFbZYH7h
         ia8Dr5cgHiImQ9/1W8C2TY4lkRINPcSchS/XMw2FClSQ5Hy85khtVgjuYLG9Kttnk/NT
         5PFjtGmoXxBS+VWg5rhG1Ux1e9ihjU9k7lqeilylG8dnq3K7CqGWdCq4D5UwLNx7gN+Y
         utkg==
X-Forwarded-Encrypted: i=1; AJvYcCW5FS84FlS3wre2Eht8seU//IzT2fEP1lhydPZNpDhwTxsuDYvobk4STszye+3nSft8+jowY693WqK9Z0/Ftgs2+vgiZDXUGyqpWRIZ
X-Gm-Message-State: AOJu0YzijyLD8DlX+U4kM+Zm1yT8WW/jflhVbVUMabm8wG1P6SRTQsS+
	IyLlWRegJOAo27l6pm+HY/W8dAZe8Us2bLswPEqoJe6sn5aj8O/NVjUuWy4f7JgH+jEGwRqaI4M
	9i0Y=
X-Google-Smtp-Source: AGHT+IGi22D+aAqEe+3xMw9LUgzcozlZLoUYTQmYP6THAXpqnmjX0IEtXPFfJdDttmWTP1xPE/azBw==
X-Received: by 2002:a2e:b00c:0:b0:2d4:9201:d505 with SMTP id y12-20020a2eb00c000000b002d49201d505mr4908747ljk.51.1712525560966;
        Sun, 07 Apr 2024 14:32:40 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id i2-20020a50fc02000000b0056e22be831dsm3267562edr.42.2024.04.07.14.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 14:32:40 -0700 (PDT)
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
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] riscv: thead: Rename T-Head PBMT to MAE
Date: Sun,  7 Apr 2024 23:32:35 +0200
Message-ID: <20240407213236.2121592-2-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240407213236.2121592-1-christoph.muellner@vrull.eu>
References: <20240407213236.2121592-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

T-Head's vendor extension to set page attributes has the name
MAE (memory attribute extension).
Let's rename it, so it is clear what this referes to.

Link: https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadmae.adoc
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 arch/riscv/Kconfig.errata            |  8 ++++----
 arch/riscv/errata/thead/errata.c     | 10 +++++-----
 arch/riscv/include/asm/errata_list.h | 20 ++++++++++----------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 910ba8837add..2acc7d876e1f 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -82,14 +82,14 @@ config ERRATA_THEAD
 
 	  Otherwise, please say "N" here to avoid unnecessary overhead.
 
-config ERRATA_THEAD_PBMT
-	bool "Apply T-Head memory type errata"
+config ERRATA_THEAD_MAE
+	bool "Apply T-Head's memory attribute extension (XTheadMae) errata"
 	depends on ERRATA_THEAD && 64BIT && MMU
 	select RISCV_ALTERNATIVE_EARLY
 	default y
 	help
-	  This will apply the memory type errata to handle the non-standard
-	  memory type bits in page-table-entries on T-Head SoCs.
+	  This will apply the memory attribute extension errata to handle the
+	  non-standard PTE utilization on T-Head SoCs (XTheadMae).
 
 	  If you don't know what to do here, say "Y".
 
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index b1c410bbc1ae..6e7ee1f16bee 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -19,10 +19,10 @@
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
-static bool errata_probe_pbmt(unsigned int stage,
-			      unsigned long arch_id, unsigned long impid)
+static bool errata_probe_mae(unsigned int stage,
+			     unsigned long arch_id, unsigned long impid)
 {
-	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
+	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_MAE))
 		return false;
 
 	if (arch_id != 0 || impid != 0)
@@ -140,8 +140,8 @@ static u32 thead_errata_probe(unsigned int stage,
 {
 	u32 cpu_req_errata = 0;
 
-	if (errata_probe_pbmt(stage, archid, impid))
-		cpu_req_errata |= BIT(ERRATA_THEAD_PBMT);
+	if (errata_probe_mae(stage, archid, impid))
+		cpu_req_errata |= BIT(ERRATA_THEAD_MAE);
 
 	errata_probe_cmo(stage, archid, impid);
 
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 1f2dbfb8a8bf..efd851e1b483 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -23,7 +23,7 @@
 #endif
 
 #ifdef CONFIG_ERRATA_THEAD
-#define	ERRATA_THEAD_PBMT 0
+#define	ERRATA_THEAD_MAE 0
 #define	ERRATA_THEAD_PMU 1
 #define	ERRATA_THEAD_NUMBER 2
 #endif
@@ -53,20 +53,20 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
  * in the default case.
  */
 #define ALT_SVPBMT_SHIFT 61
-#define ALT_THEAD_PBMT_SHIFT 59
+#define ALT_THEAD_MAE_SHIFT 59
 #define ALT_SVPBMT(_val, prot)						\
 asm(ALTERNATIVE_2("li %0, 0\t\nnop",					\
 		  "li %0, %1\t\nslli %0,%0,%3", 0,			\
 			RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
 		  "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,	\
-			ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)	\
+			ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)	\
 		: "=r"(_val)						\
 		: "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),		\
-		  "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
+		  "I"(prot##_THEAD >> ALT_THEAD_MAE_SHIFT),		\
 		  "I"(ALT_SVPBMT_SHIFT),				\
-		  "I"(ALT_THEAD_PBMT_SHIFT))
+		  "I"(ALT_THEAD_MAE_SHIFT))
 
-#ifdef CONFIG_ERRATA_THEAD_PBMT
+#ifdef CONFIG_ERRATA_THEAD_MAE
 /*
  * IO/NOCACHE memory types are handled together with svpbmt,
  * so on T-Head chips, check if no other memory type is set,
@@ -83,11 +83,11 @@ asm volatile(ALTERNATIVE(						\
 	"slli    t3, t3, %3\n\t"					\
 	"or      %0, %0, t3\n\t"					\
 	"2:",  THEAD_VENDOR_ID,						\
-		ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)		\
+		ERRATA_THEAD_MAE, CONFIG_ERRATA_THEAD_MAE)		\
 	: "+r"(_val)							\
-	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
-	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT),			\
-	  "I"(ALT_THEAD_PBMT_SHIFT)					\
+	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_MAE_SHIFT),		\
+	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_MAE_SHIFT),			\
+	  "I"(ALT_THEAD_MAE_SHIFT)					\
 	: "t3")
 #else
 #define ALT_THEAD_PMA(_val)
-- 
2.44.0


