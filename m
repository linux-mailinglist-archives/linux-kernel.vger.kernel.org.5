Return-Path: <linux-kernel+bounces-105936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DCB87E69E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4371E281FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391A2E414;
	Mon, 18 Mar 2024 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPBhNVYN"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB02D627
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756175; cv=none; b=AMVPL6IL/S8ztrq3frkeQtnviRJiBtq1sJdKMbPH6ToyUJeWvNd45rDmc+EoRGT8isNgxHWRqjjOB9VFIkPJ/LLdl+yFJ2fnCKhKFY9aM785PlYZycw2IQUpjCg+77fFtlsaLovIDxNFAWiQSYFjFOxRhvv9Vsf5Eskec7ethjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756175; c=relaxed/simple;
	bh=23AJFBOQzolb/bX7PhDzjxxjGAgihS0rUtF2sxZKRPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ca7/PrCeDWfepW4QChvJihVyPc0ukOV6H6F9/FkL0ybhaeiQ0sHMsp/WAM7wBQAsBfk8QVg7VScjx7rNYPcEx1AY1K8tzuiGzqys+zppurCYWft8RjQwZT3slpaB8SR1Joa6O7xopacJE32CV1mNCDbSaafsC78PkJqvE9NTlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPBhNVYN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dddad37712so39303745ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710756173; x=1711360973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gV1l9rmzBCzJNW3ECkvyrqDRGHWu7/CWeWMayLYT9Qk=;
        b=UPBhNVYNbDfuGoWKqZgic7sn1XRBEpjI9evX6FAluPcLWR6J0Tij3fNpbsfjCqKPtb
         u8KkyVFNApTRxwLb3nVm3Hod48WRmBgBiKylGOx4/ilDLutKzr9+SLRDpa45qA3ikNPl
         9hOcYmPZ3OYefG/WHMlktmkOxglpOK4s3aWFm2vlckXJRpnsHHFJB0BghyZvNaemXsD2
         Cqt8HZRpCSxFpNJNHunYjACJzi6T6FlxYf6TiC4XYiPm5RCPv75ZvXE8X/pqVnq6EO7e
         xsRuy9eIEt6BdJFydUyZ9UA6dXnM9NRdSnQpOb3SfyxzxfuOgk01mmFpUO9DYWAoP+3m
         P70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756173; x=1711360973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gV1l9rmzBCzJNW3ECkvyrqDRGHWu7/CWeWMayLYT9Qk=;
        b=AvgDJSyaOwS2WIAjCnJaJhDvGT6+kNrozbRW6QLpFSK8bo/cUNN43ksaUice9eBotu
         77ebvxvMc6dccfaldwHx6O46pHPO8wD6xP+zPc8DuFK+1dT0+yTTKqkTLmvhUZBLsBGz
         R0au5fUXsXtu85LS3/RsOa8P42B/+UC/I1F6KXgYmjx8HL8gUYilkFIXjt2PWu2pPEs1
         XpUlvLtM0Vp7Ydo75EBFmcquI9aWRJZLufPLGDilCUd1OIhxKLzJpVePJ7l+mSqh1YvY
         d1aPlqvD/1ud7iOApqZsdfbNvGFbDU80p14w8AICKLQs9r7SLNMkgiH59Uc9qwN62j/J
         nIyw==
X-Forwarded-Encrypted: i=1; AJvYcCW0jJN/u3Zucy5N+baN7q9DxASEQ/UD9tjBFPfUgT2EAKdp0nHNQb5TqcvdMAz6EGTXs5LRg9DTPY7BcfQ03MJMiCBQof5FW77UtNja
X-Gm-Message-State: AOJu0YwGrVNA6WHn3CIPqTOJiBHY7jDcd0nZuGRbsyprZRcd2SX2InR7
	bs5TRVw7PWY4GFzGXYxJ3ojqJ97rWd8x9GrQlyMs0kXwvuAtfvSm
X-Google-Smtp-Source: AGHT+IEcvsWQUyJLQ8qV7FkXWB79q4QhcFWpWDYu78GsX363yZUh1ev5rOsRAXQM6lfbTC9LQZr5sA==
X-Received: by 2002:a17:90b:440b:b0:29c:7845:cba with SMTP id hx11-20020a17090b440b00b0029c78450cbamr10647032pjb.36.1710756172888;
        Mon, 18 Mar 2024 03:02:52 -0700 (PDT)
Received: from DESKTOP-4R0U3NR.siflower.com ([2a09:bac5:6249:183c::26a:36])
        by smtp.gmail.com with ESMTPSA id rr7-20020a17090b2b4700b0029bcf877eabsm7360608pjb.10.2024.03.18.03.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:02:52 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: [PATCH v2] perf: RISC-V: fix IRQ detection on T-Head C908
Date: Mon, 18 Mar 2024 18:02:40 +0800
Message-Id: <20240318100241.267857-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

T-Head C908 has the same IRQ num and CSR as previous C9xx cores, but
reports non-zero marchid and mimpid. Add the check for C908 ID.

Fixes: 65e9fb081877 ("drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores")
Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
v2: add C908 ID check

 arch/riscv/errata/thead/errata.c       | 5 +++--
 arch/riscv/include/asm/vendorid_list.h | 2 ++
 drivers/perf/riscv_pmu_sbi.c           | 6 ++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index b1c410bbc1ae..da3b34866d8f 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -125,8 +125,9 @@ static bool errata_probe_pmu(unsigned int stage,
 	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
 		return false;
 
-	/* target-c9xx cores report arch_id and impid as 0 */
-	if (arch_id != 0 || impid != 0)
+	/* Early c9xx cores report arch_id and impid as 0 */
+	if (!((arch_id == 0 && impid == 0) ||
+	      (arch_id == THEAD_C908_ARCH_ID && impid == THEAD_C908_IMP_ID)))
 		return false;
 
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 2f2bb0c84f9a..57b3de510d38 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -8,5 +8,7 @@
 #define ANDES_VENDOR_ID		0x31e
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
+#define  THEAD_C908_ARCH_ID	0x8000000009140d00
+#define  THEAD_C908_IMP_ID	0x8a000
 
 #endif
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index bbd6fe021b3a..34d8689982de 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -833,8 +833,10 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		riscv_pmu_use_irq = true;
 	} else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
 		   riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
-		   riscv_cached_marchid(0) == 0 &&
-		   riscv_cached_mimpid(0) == 0) {
+		   ((riscv_cached_marchid(0) == 0 &&
+		     riscv_cached_mimpid(0) == 0) ||
+		    (riscv_cached_marchid(0) == THEAD_C908_ARCH_ID &&
+		     riscv_cached_mimpid(0) == THEAD_C908_IMP_ID))) {
 		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
 	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
-- 
2.34.1


