Return-Path: <linux-kernel+bounces-120311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C4388D594
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5591F26871
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C725634;
	Wed, 27 Mar 2024 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cMSxOfqG"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73EB1C68F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515056; cv=none; b=or4mIshcemuFySr/OwMEaR7BcZuPwFvJ6w2StSzvHY4qO8kRgYpbnD7Oy2j7gj/om9cQ7maSl2xuqpoadEeGFv29wlYf9OpZFrAiQRktQvGLsLNjZtzydWPq13ZvSaIJXZ2ut5IsjR2mCYlXxRMYff677WyTu0jFJx54Bx/5FzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515056; c=relaxed/simple;
	bh=Iif7UTJ12URNnNmgEZh/g3vOOkBXUamO89prNktl0Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LU9WZCHXevtNuMOA3/l51sB8m265C2OF1r9/JfEZdtrwUuqTRd9JiQ3m/WOq53rP6iaf1vHMdG44N9gyVHFRoEeSj4MwTjgV8lvKARyaatqQOHTEastSUakSlzGEDkXOH0YuZcAxAphTmcxXL4hlCKn8Cq1lubsOADtuRrz/yro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cMSxOfqG; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e6e37d33c5so992083a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515054; x=1712119854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DMxbhiunBS0lKLURYVBJG3nyObzwUO8ZrXza9ckh2c=;
        b=cMSxOfqGKSsa7JMEOtNfyE0WC1EZgJeCD74yAJ3guvzcHJejioBByzrzpjIwR6n1Y2
         SkFsT6xh+y9jXXHtWdZSn7xE68jAH7Ou4tybR0KYqnJTiag64Zo1HCORkzOr9dO8f8ZL
         /QKtDOY1XgdHTieiblQAZqN5G8Xfpbx4vjtTzIw4D04YOzOuJZ6AenRcYK76YF4L6zWw
         gprcbQG/nufiP0qh6ahE+EW0w2kuOMKBX8BKVnXw2sDoczvlWv+uMf3bkfOcAIjEfAT6
         7fP/qGcJuVjFhQAIA6M29bGHpIXNoJIrxUaGe/QggZwH2hC5NxP0MvBsXZqtgFPyT23C
         IPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515054; x=1712119854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DMxbhiunBS0lKLURYVBJG3nyObzwUO8ZrXza9ckh2c=;
        b=YB1hvlkDL5fZJ4AeVrfF5GJ6qL2Fd16OQhhwSbeWbBI9UYvbjiXLHg2t3jKIb9rQkU
         KP4QYcrTagTV8qD72B+PaGhcHU5Iln7a0dLnMUwvoW0VGmcQG+SmEkSKy9K7j1InCW5W
         moKjMhmBZR+H/Yqmaz2yH8B54hD3gFOs+YkB9j1eO7cysZYrdou+JmQaFnI1X+b83oLY
         r+mPrSJ9nVTWGAaYpr26EwlKvsQDIzpAR6enouJlZTrkfUeVPxts9RxSac1gzScAjS2/
         7fSaLCaK20R6MuySg3rkTzRLQhKoQkMbooP/UfWZvNXdwat8uauhwxgdCeR+DAOsFUkm
         Je6Q==
X-Gm-Message-State: AOJu0YxPc2OXunFssFZWVfLILlQhlk+HlR2UFGwpx0jznKZz7AX0Xede
	+d+rYjjNg43afU/zvefo4CPg4BqU8LvJ8ZpZyCHncceCp4ecZGDt92xIH1lqU9Y=
X-Google-Smtp-Source: AGHT+IEKVJUxYPHGmGQ7jZ/KC0+y46rPbmkW2DQ4LqVeHQ3jmUBdRhZe5PVjdoDThc5iPwQM0jPRUg==
X-Received: by 2002:a9d:61d8:0:b0:6e6:9af5:752b with SMTP id h24-20020a9d61d8000000b006e69af5752bmr1730488otk.0.1711515053696;
        Tue, 26 Mar 2024 21:50:53 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:52 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 08/13] riscv: Avoid TLB flush loops when affected by SiFive CIP-1200
Date: Tue, 26 Mar 2024 21:49:49 -0700
Message-ID: <20240327045035.368512-9-samuel.holland@sifive.com>
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

Implementations affected by SiFive errata CIP-1200 have a bug which
forces the kernel to always use the global variant of the sfence.vma
instruction. When affected by this errata, do not attempt to flush a
range of addresses; each iteration of the loop would actually flush the
whole TLB instead. Instead, minimize the overall number of sfence.vma
instructions.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v6:
 - Clarify the commit message for patch 8 based on ML discussion

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
index ad7bdcfcc219..18af7b5053af 100644
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


