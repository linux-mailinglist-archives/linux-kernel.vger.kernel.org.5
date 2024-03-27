Return-Path: <linux-kernel+bounces-120304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022188D58C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8FD29FAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9F5227;
	Wed, 27 Mar 2024 04:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z5t5F8WX"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702A3DABF8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515041; cv=none; b=ObFu/xYAB2e3bL/meua773NWMYVzEwrccnxWj9++2gQNnEVZ07ETUgQu7XO/TYiBKLSGqrqXT3yJBZEgAkfuQAXmNbDpyix28qEPsaC719vUhRO8WdMeMbaaIGFcX5w25dsF+5e5ObcRl649+LJx8LY62VbNebtLq4W/3R97QRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515041; c=relaxed/simple;
	bh=9pe7R/eOPtpKV/p0oqNPsZLIbMKVAFsvdDFGxpx/rcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kII1mVzD6n+3gH6xAwOt0MlIx0LUE/EAHWSVma4Xvk8MPQZqPAzd5Lrx1X3whMBWlSWh7Do2vKYKotEzp3jtRaXTMzXpMsPgNe6MNpp4tznf5lggQiI3ApVZRC+oFjpmzJeBZMJuh3Z7h0qYJvl8+qrySNZji8IlEONe3lxVuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Z5t5F8WX; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso4480264a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515039; x=1712119839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shQKeKcQeNJUU/JQ5KWmpXdfmdrhkhe16Q2MMRo9oOg=;
        b=Z5t5F8WX+DWGeHMb2BK0DpVQhHlDuvFvHMB6cN8v5REGRr7Kji79Ns2Ohley9bdxIG
         0f9xU7t9pY8bZlVWszzPBe4qJ5me1WSbrXnliwhrlcjnbHZrChEiKQRf3tOy1wUT6/B7
         cJsQdcVFgZJBCUnf2V94UhoUsL7pLZCspTA+vdQmmBz0qMVG1KdLhXKDS94GZBzjxPG4
         IzkpEymuMhkGls9GcVgtwlXFEs8LYn/mvmLdvlEYqHRhJxfy/adiApW/pZCi7rga9LgD
         x+4u4FTv+BfwKpDxVxQl5GUP8irCwI986ZYvUS+vGtTihQvlR7CxqGl4jU32wgqAD4pX
         f24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515039; x=1712119839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shQKeKcQeNJUU/JQ5KWmpXdfmdrhkhe16Q2MMRo9oOg=;
        b=WQUe6/Dj8HOvNfKpQuhe4TXbRAZgi6ZSKuxVfG+np4rQ38kb9nPhHPyoK5om459OLl
         mhYEKuL9raTUBTJ3Vhkji+kcCsiGj23CEglyCNgmG3BtIGjWLndjPtGPPDhe7BNogrUk
         +P1hfyQNoyff89pRJicnqfG/EGDtSFLwlX5/MAXAerzLRX1fMxfZAVkMzHpxRahXnBLd
         1KJFLFyGRqGmufBPLdEl4NgkXxOsESUrcrX4eNKlw6zMBosT7JxL7mgUr5e3F9A7+ve8
         3pbIFgrWW/wCoQQ67P9Iur9Vrub5kiwEK/i1rRZXaJffI2uvVdOUzVXL6NhBuyddc0eM
         PtnA==
X-Gm-Message-State: AOJu0Ywhy2B0J9hpvASzl4/caukb3Zmzx+j90D06jsZzZMLw1bXRfmH1
	MnMh/rPPaGKbCLhV63tRd+vcwXTTBUX+YYomV4DBRuEikIHN0QtkaKALc2n+Q+M=
X-Google-Smtp-Source: AGHT+IHpHyQ5wkbbDg1/9QOIdZT7U8XEUGKwcMibXVBUL9WTi2GIa5kveh+VvtS/wwBFRvp4M1UHpQ==
X-Received: by 2002:a05:6a21:164e:b0:1a3:4979:f25e with SMTP id no14-20020a056a21164e00b001a34979f25emr128528pzb.59.1711515039607;
        Tue, 26 Mar 2024 21:50:39 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:38 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 01/13] riscv: Flush the instruction cache during SMP bringup
Date: Tue, 26 Mar 2024 21:49:42 -0700
Message-ID: <20240327045035.368512-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327045035.368512-1-samuel.holland@sifive.com>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
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
index d41090fc3203..4b3c50da48ba 100644
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
@@ -234,9 +234,10 @@ asmlinkage __visible void smp_callin(void)
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


