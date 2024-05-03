Return-Path: <linux-kernel+bounces-167732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09EC8BAE38
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89EC1C22635
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC981553AB;
	Fri,  3 May 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKmtYXce"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA8155317;
	Fri,  3 May 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744518; cv=none; b=p6FONY6+NsxcQxn4S/UEUbjqbhT/HQJ+9tXtzwsSCx9qeVMbqDByCx6EFhr8cXguYzI+1q44kFuZ7NwDM5EZgxlR8DJAxCAtIWHfyBpyCOOIacDj4zNnVH4n1mWeTHkQZkXIan5jbhGbnbaonNp9wJ9OqpoUobaJuJnVtiDJ/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744518; c=relaxed/simple;
	bh=sv3bHJPSIAzAatSQs/bKdLt9FMtfOseslXyoRcccdI4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4Lh+D4YYnd7RsVZzxBNipN/dZ1hNwrNBeAt1L8f2cOYoK4Ba2WCBYX/N3l6khPHHgvrXUzNwr3Bx4WPFKGqzq9ftLLzQNoom/dOqenSChDxxkdPYUcsKIGfAmi4LYo9BGNCAbyZyGVpv10OyPs+pyYqP6pZH0VrDHisP3JlJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKmtYXce; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso67150245e9.2;
        Fri, 03 May 2024 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714744515; x=1715349315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORf4L+Kc1pyBC8fE9YC0FQfG86LMRHTWb3C7SJM7A84=;
        b=QKmtYXcePf2kHemzC3alUjw4Dcd1/lDo8VxZ+h9Sqe3x0pqvzxBAZDtRdXui8YiAfK
         jRHD/UM3pkq0kzeSP6DVNdwKSzCpFva+CIdZgrAIpJqXMdew9ejH871FXOzlrPlSNKp8
         qVgWRXLJ+4gvGwqBSllenR0Ai6e9xDuu0a+NSP7gL5ACCkL7hjpADVTLkErwjdmL/b5f
         Qa20oNvFIpeGq1if8PIAEO0rjRs2Zz6nJ6HCs6UrHtH87RrMTd6gTXAuXCDxIAXmAyql
         mCXMaFrNiBgv+3ua0ErPQYoa6AbGeMS8c+8oKjSqNVYdKVKsxoptPeQ+2WDmPaxrE9Bt
         p/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744515; x=1715349315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORf4L+Kc1pyBC8fE9YC0FQfG86LMRHTWb3C7SJM7A84=;
        b=b/TU/yG2pk10lEQedB+p+WbaoPICXMmdyTuF12K4AZtO8g9g9IYgACnRgTo9ym8+oO
         oIx/VnGpnhMp4+41D4iCNF5/QY1QL9BpO4NtH66mBa7BmzdKs8LVNl0MrVrQoa/DUuyY
         bA8odean9ebTn91O23vZULSijAylcYSwn7yI2YrucEIlEgW0C3iDuI0gRw1HoYnkMreM
         +M7Q3f34qDKqWdPghJDwQE6tAAH5QjkkYIgi94VVTHAeDk6QhWMsL4zV+P/SwBS1cZkL
         cmvUZXucInlypMaPJYxSbE/FvaHYZC+FG7HveF4p3gcalhdSxeBSMbXfzo/h/IVqjEkO
         Lhow==
X-Forwarded-Encrypted: i=1; AJvYcCUfPzpS9T+Ffm3WKg4gYfaGSotAIhkXWDORMMtchsCDpAuPgmqp2GoLXQZdL1ih7ojYdWLD5LbSuu6Fj+Bvb2AXUATavhk3qaOvaumQ9oRxvZWjB+rVW3ToP3NXIXUvTsHrH3mQ7mjdo5w4NGrYWG2VgkQrTdopyrSEqO383xc3Qg/e99o=
X-Gm-Message-State: AOJu0YyaO8rDY113i71GAnZXXhAsThKVl3tcVxVxIdCFKJzDrW6svTCo
	t2M2vxNPI3HcUFfsWA9DA0NB+r0b3RZU5X8BW+8Uyq/4QlHypKJk
X-Google-Smtp-Source: AGHT+IFkP1WaMT+0uGQZLaq5utzRvX1j8q6mLmJ2/l/tUpebX6xSKa77EdO0TBHbtqDy7Hi8FlWeYA==
X-Received: by 2002:a05:600c:5494:b0:41a:b6bd:4de5 with SMTP id iv20-20020a05600c549400b0041ab6bd4de5mr2214660wmb.39.1714744515067;
        Fri, 03 May 2024 06:55:15 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id k8-20020a05600c1c8800b00418a6d62ad0sm9537339wms.34.2024.05.03.06.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:55:14 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gonz=C3=A1lez=20Cabanelas?= <dgcbueu@gmail.com>
Subject: [PATCH 6/6] bmips: dma: drop redundant boot_cpu_type in arch_dma_sync
Date: Fri,  3 May 2024 15:54:06 +0200
Message-ID: <20240503135455.966-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503135455.966-1-ansuelsmth@gmail.com>
References: <20240503135455.966-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop redundant boot_cpu_type in arch_sync_dma_for_cpu_all. These needs
to be parsed only once and we can make use of bmips_rac_flush_disable to
disable RAC flush on unsupported CPU.

Set this value in bmips_cpu_setup for unsupported CPU to skip this
redundant check every time DMA needs to be synced.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/mips/bmips/dma.c         | 5 -----
 arch/mips/bmips/setup.c       | 1 -
 arch/mips/include/asm/bmips.h | 1 +
 arch/mips/kernel/smp-bmips.c  | 7 +++++++
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 799cc3e12fc3..e9af34f82dcd 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -11,11 +11,6 @@ void arch_sync_dma_for_cpu_all(void)
 {
 	u32 cfg;
 
-	if (boot_cpu_type() != CPU_BMIPS3300 &&
-	    boot_cpu_type() != CPU_BMIPS4350 &&
-	    boot_cpu_type() != CPU_BMIPS4380)
-		return;
-
 	if (unlikely(bmips_rac_flush_disable))
 		return;
 
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index bef84677248e..d27043b10405 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -40,7 +40,6 @@
  * with "mips-cbr-reg" in the "cpus" node.
  */
 void __iomem *bmips_cbr_addr;
-extern bool bmips_rac_flush_disable;
 
 static const unsigned long kbase = VMLINUX_LOAD_ADDRESS & 0xfff00000;
 
diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 3a1cdfddb987..4a48c8f1077e 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -82,6 +82,7 @@ extern char bmips_smp_int_vec[];
 extern char bmips_smp_int_vec_end[];
 
 extern void __iomem *bmips_cbr_addr;
+extern bool bmips_rac_flush_disable;
 extern int bmips_smp_enabled;
 extern int bmips_cpu_offset;
 extern cpumask_t bmips_booted_mask;
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 7bde6bbaa41f..63534af367c7 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -681,6 +681,13 @@ void bmips_cpu_setup(void)
 		"	or	$8, $9\n"
 		"	.word	0x4088b008\n"	/* mtc0 $8, $22, 8 */
 		: : : "$8", "$9");
+
+		/* Disable RAC flush as not supported */
+		bmips_rac_flush_disable = true;
 		break;
+
+	default:
+		/* Disable RAC flush as not supported */
+		bmips_rac_flush_disable = true;
 	}
 }
-- 
2.43.0


