Return-Path: <linux-kernel+bounces-87672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4145986D7A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2904283EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B89275814;
	Thu, 29 Feb 2024 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gmTxm6T0"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56096D52F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248936; cv=none; b=oYPlq4hwaJliz6rXS/nVyOpKDMrq1shS77rVv47Z1BJPwMTQkOb15p5RPhEkNr+ECPOILJCiOCVHBtIc2c48EqvyLcGodAlg/DvjibBhOGdP285KVdUfxH9/ZE5I05wbu3lGUB1tekjF/BwAnAxlmeP2RogHFnG24ez1S/j2Y0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248936; c=relaxed/simple;
	bh=KWtoavmsQ9Zyjmm584UX//N/CxD8kDI7cE1TWuh589Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB+GrbU7Z/ANJ2XHjcS/wplP/vefrBl8g+umekIhXshnhAYEobHraveMFs7YDFM05u5Wxl/ww6DoWdXXpnjqS0fSHC1bYddI/ucLxlDojeyJK2Hr9k/v1JYxwdAxtqODd9dyQXQWrlq9rO2frxcM39JdYnsARqz/OGBLEpB77nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gmTxm6T0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e5896846f2so1080168b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248934; x=1709853734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O37VWqG4iCvkiZDgqVtP8oElF9rd1vMtEBQWx77Nmx0=;
        b=gmTxm6T0avUpX9VJ7qCwLt1Rfkqoxx8cFMtmIMvsDRBBrKpf0SbuHte/6vrcxvgbE9
         W6okPqhJfltLijsznF+BcrEfSMXPXPDFSulZeKD5MD2VaUefw4qWCuyjvQqD4/atesfq
         98lhyxshteYBc2moJwwnBYpXZngNGPecE1AyivgB/XFeAlb/+XssbU4kBeajC2GxKNlS
         nOXf1GDd7b/1bdWQHJfuKcw5+dUYE4Y88G1Mz6VlNW+LOhh+jrHY4BdUCQnFMZGYBjHK
         uTlhnTvKOSnD+Trg8ZRa+FkTyhvGMTknAmhPoCriPfL3H0LH0HjUqCK0u3E5jEdhC5iG
         TS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248934; x=1709853734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O37VWqG4iCvkiZDgqVtP8oElF9rd1vMtEBQWx77Nmx0=;
        b=BRkEcEDuFubf6GxAqSckhMV7WrI2peULZr6yMPRyiWeS9BEjwDnug9G0MXfl5hT/2T
         uwnRRKvrPEHvEMgCJ1QMh3VcsHFvMcLD+DBaORtWr5wlfCvUonh1/csLIkoj1YPmKIT/
         Scqm0UNPWv/greuiayFbwhlS8f7cfXEkw0zy99aG483iHiUqbzLiXgwpIMajN2vyn/sa
         qfGS/cwa0EpClcCfhwVlrcfwSfi5ayhruOk6yBnIfgulxoF8AT1dPghAcMuG53/emH8L
         5BkRqM2Dc+PPeVKE73WFmI2fTQuUgQuhOL04GXcLahZ/MMq6RkXVfIFkHGbGtzvr77fk
         g94Q==
X-Gm-Message-State: AOJu0YyQFxl32DCFu67chu4ojaIrBvIe/08J7dcEA8O5aNMSWaa81Xz+
	NhDwl4TZFIC0UrvNT0HB46oltwoz/ZuJCjGohLOYpjW4ytU0fj3xDNqhSRyhCuo=
X-Google-Smtp-Source: AGHT+IEXcsW9CGPGmNlysP87xM+KqyMeGQDT/2i2zpW2/RfnrP1VyWuH3lyJldn2H0bz6i0E+Cfqiw==
X-Received: by 2002:a05:6a00:2d1c:b0:6e3:fa52:2f26 with SMTP id fa28-20020a056a002d1c00b006e3fa522f26mr168419pfb.8.1709248934208;
        Thu, 29 Feb 2024 15:22:14 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:13 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 01/13] riscv: Flush the instruction cache during SMP bringup
Date: Thu, 29 Feb 2024 15:21:42 -0800
Message-ID: <20240229232211.161961-2-samuel.holland@sifive.com>
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

Instruction cache flush IPIs are sent only to CPUs in cpu_online_mask,
so they will not target a CPU until it calls set_cpu_online() earlier in
smp_callin(). As a result, if instruction memory is modified between the
CPU coming out of reset and that point, then its instruction cache may
contain stale data. Therefore, the instruction cache must be flushed
after the set_cpu_online() synchronization point.

Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executable")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v4)

Changes in v4:
 - New patch for v4

 arch/riscv/kernel/smpboot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index cfbe4b840d42..e1b612f37dd9 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -26,7 +26,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
 
-#include <asm/cpufeature.h>
+#include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
@@ -238,9 +238,10 @@ asmlinkage __visible void smp_callin(void)
 	riscv_user_isa_enable();
 
 	/*
-	 * Remote TLB flushes are ignored while the CPU is offline, so emit
-	 * a local TLB flush right now just in case.
+	 * Remote cache and TLB flushes are ignored while the CPU is offline,
+	 * so flush them both right now just in case.
 	 */
+	local_flush_icache_all();
 	local_flush_tlb_all();
 	complete(&cpu_running);
 	/*
-- 
2.43.1


