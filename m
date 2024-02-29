Return-Path: <linux-kernel+bounces-87680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D14A86D7AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6561C2174A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F678144052;
	Thu, 29 Feb 2024 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Mk6byHHF"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883C14373B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248943; cv=none; b=AMmtoKVpn2ZrS94o/+gH6D2FXUeSyVMGapQ6Tb2SIcHdY4Q/JPwolEmZrDvUf545bahtru8ZGcO2lBW4FOAay/VYwcLlpSjUDb66u0fhUtWENRshSwGoPRwc3wAwVOE5mMXql0IUpIxB6twWSbsR9gnjbXLp6RweY/4Vt71TAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248943; c=relaxed/simple;
	bh=jkqIBDvnCBgBGk4k5FZq/mUWCLaMf0fOgLBnB4HUugQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRnNmwiKAtb6EWjj3ws0iEtL3okN0omImDgmcJ87Oh+MqbGbTEMEyyws/2bLuRHlSAI83+1wG/1+k+0xlAzvYFR9zFjakefpidBkXfUrR+18xRvF6de3Jl9SGwiHJMcodSI317Xqkjz3Obb3Rwx6VYpcso4GVCOUH8ClCJg+lMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Mk6byHHF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e5675f2ca2so977775b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248942; x=1709853742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHMbuRyYmPRZ8L34XsarFB0wBhmLHt6PApeEi+FQBPY=;
        b=Mk6byHHFJBfEZXYBz3yaFeDsYmhz51BLgR3FLsX2wkqi9auwAdRoNcOz4xF2PHrJqv
         xpWBYapxHBuxwdwbv5akbzUDAUGoJfkzhIj3XsbYQwZXuWaSgOVG09gQ8a6LItOl2xzK
         dYfdaLp9AqFTyOH2mKXHQG0vxaVPG53NTPp/nE1jIF6/R07qNph5W1vRYqGaGGX8XB8c
         DbQl6t7ayGZnf58pIQ2dPCgG20zvHSOGAyBClPTMgwpkBHSjpyrGRSsMsPvgORGsTbaM
         yORJYsEf6I9qaWMPUYERuZuUerMIkity5L+Qr5CDL12kVBfYTiAAw/8gFtt76NuCOimc
         VDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248942; x=1709853742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHMbuRyYmPRZ8L34XsarFB0wBhmLHt6PApeEi+FQBPY=;
        b=RNtprg5gYgEGTMm+1odHO43NhOs8q+JpancBHY1l9h4cnqskjPfwtQm2/SFH+nNXVh
         DSVXN1dQBqJjTMu5jCy6K+KtZ2JfzNU2nC0wW2BTf//85P2XRP3U0FRuwoiq/QxNh3I3
         IQbjljyO0AB0Mbw6mV0/wZ39wgFVAsrhWx964sODVDJS/2YjCDdMUcdHfom8jW9GxGbh
         lJ/gkC9TJG96XhjiJbR9SGpgMYHELBLyxLbyMpohliG6Kn1SVJs90X7rPGOEJ9NDhdGP
         IUJ/RYOpa6RwU+aYycHFbBHu95K9KCdbKgeCNv/W2SlpaBmBme0tXi1EQx92XzNWcM1A
         cfaA==
X-Gm-Message-State: AOJu0YxDAlUp3bvIQWrpRLJMxoO43jvf4JCb+mq/IkHKoEmGxk4c0eBe
	yoak3kmr4/pZJMQBZMH752XJTewC4GssEjyh2w842YNL/pu2bKlowj7myy37NGI=
X-Google-Smtp-Source: AGHT+IE0KT3RuIOZoiwK4WAulPfaiFPRjhF12PREr/S+YlSI1LgFKc32EbVKWDUbhqJfm1349m8bOA==
X-Received: by 2002:a05:6a00:1955:b0:6e4:eb29:357 with SMTP id s21-20020a056a00195500b006e4eb290357mr165166pfk.12.1709248941678;
        Thu, 29 Feb 2024 15:22:21 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:21 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 08/13] riscv: Avoid TLB flush loops when affected by SiFive CIP-1200
Date: Thu, 29 Feb 2024 15:21:49 -0800
Message-ID: <20240229232211.161961-9-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240229232211.161961-1-samuel.holland@sifive.com>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since implementations affected by SiFive errata CIP-1200 always use the
global variant of the sfence.vma instruction, they only need to execute
the instruction once. The range-based loop only hurts performance.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v4)

Changes in v4:
 - Only set tlb_flush_all_threshold when CONFIG_MMU=y.

Changes in v3:
 - New patch for v3

 arch/riscv/errata/sifive/errata.c | 5 +++++
 arch/riscv/include/asm/tlbflush.h | 2 ++
 arch/riscv/mm/tlbflush.c          | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 3d9a32d791f7..716cfedad3a2 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -42,6 +42,11 @@ static bool errata_cip_1200_check_func(unsigned long  arch_id, unsigned long imp
 		return false;
 	if ((impid & 0xffffff) > 0x200630 || impid == 0x1200626)
 		return false;
+
+#ifdef CONFIG_MMU
+	tlb_flush_all_threshold = 0;
+#endif
+
 	return true;
 }
 
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 463b615d7728..8e329721375b 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -66,6 +66,8 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 			       unsigned long uaddr);
 void arch_flush_tlb_batched_pending(struct mm_struct *mm);
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+
+extern unsigned long tlb_flush_all_threshold;
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
 #endif /* CONFIG_MMU */
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 365e0a0e4725..22870f213188 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -11,7 +11,7 @@
  * Flush entire TLB if number of entries to be flushed is greater
  * than the threshold below.
  */
-static unsigned long tlb_flush_all_threshold __read_mostly = 64;
+unsigned long tlb_flush_all_threshold __read_mostly = 64;
 
 static void local_flush_tlb_range_threshold_asid(unsigned long start,
 						 unsigned long size,
-- 
2.43.1


