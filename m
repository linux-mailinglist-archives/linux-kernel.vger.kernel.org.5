Return-Path: <linux-kernel+bounces-121602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5851D88EABD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6BA1F32860
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A871131BCA;
	Wed, 27 Mar 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SlnXUMS7"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3312D762
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555526; cv=none; b=lB0yq3CVPVXkuXFlCEiinO1TTCfKpSArFJIy6lKLGwI4H8jWjB7pCyUre2mw+gSJX9fWB+F52qHb+3jYh75UcOjAnnx69GvpzT2Vn6ikaU3F99y9KxYP7K0qR9cRZmrYKSkoEBpS3S48vk20eZelsh+Iva3bbScuLXVYEvI49yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555526; c=relaxed/simple;
	bh=c8cFzSPVDl3tMmEcmOn7avM7k4+aPkxahkvikC132Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0Ciqo2SPzU1u16qhVIqbKZT3jCrTBbKHYaJKnSRM6rrka03CShEyXaen3X0I3O0UAHgbdCJwTxatMw3oqcLObTJqhC/SmUeDlbIP8Po8SwoFn1SUQK76P16ngl9xjfXBc8Bx2p/5nXLsqYDIjJ6pQJ3NgYy5sGOc4Cq0uYZxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SlnXUMS7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0f3052145so19390245ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711555524; x=1712160324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuDNJ40vLIezNFuUe/xAQeUguFHfIodkK1lC+Qglvxs=;
        b=SlnXUMS7S82qLJrmBGLMzRMX/hG3CBkPZbPQmZ9t7pvpCSUWqLNfKfxWVA9DITdGnR
         bkCDxhmeqzvMzhHFHGfYedQPpA6YgVd8t+I9rp/DC35tRR7PzvDec2t4dp1c1xeTZzGI
         hOGUcBaEA/Fn/YtjHHl8HpI6MwYLRJEnyE45fhvbQ1+qFYTGt43tdqOfgkB/BfBnHw1n
         7tbEV74PJvWCzVfWUugmiqipIR61BA7IluSTQ7/m07yN1YJlFlySsuRpXseWsTvbzkJ4
         ewb1ZkD75Bn+s+XGvG3uvADAhUC+kUCSFOybI8kdOQacB2haw7OJtouY6OJwWLK+o6S/
         3E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555524; x=1712160324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuDNJ40vLIezNFuUe/xAQeUguFHfIodkK1lC+Qglvxs=;
        b=IwgcrT/EnQ8eQzEOmrwwllwc8XTPVnbLQ7FbDWKx/s8IGC1eAm4Y3CjjqMEljoilSZ
         W5960Y/6VMDr0xQIFXz71Iv4z8B0YOUxctb5dpuWO4mrmY5l7DonO16Ev9HX+3aweKbR
         4bFupJYzwElj1WJhjMc4BRGpnfMhEUSIZ0piMviITMSBm3H5rRAUoiWp+ctpANnAdR4G
         BS9EURyB4RJkYZA9J71tDI9r6Uf1IUJ4thfr240ie4c9o+CByZ6gK5HGttlkGUpknhVE
         nkqfpgtQ+nCaRBpAZdEK/E199laXiGakViUbtYXDYzS7BMUmZwChod7lN+R7ljVyt9rz
         Am8A==
X-Forwarded-Encrypted: i=1; AJvYcCUGnonJWLSz8yXld4rMv1LUvXgCFBopUnMh6fjEWFUwSb7OFTUiXCkaO7iyOUVcpH9Rnw4+qBMGRCBduodkvdp6cSg8VK0QrN5tIwqK
X-Gm-Message-State: AOJu0YyXxNsVSSf6J7oHQ+zsr5IHwljxjWGu/q96Q1yBsb/CuBEhpVuv
	tnHHPaPKAXm18IWkffOGtOGUWG/n7nvEZ0xXpbKHqPk9c9nFiyQkDDs9r1bnYsgk8V9GF/Z6TFn
	u
X-Google-Smtp-Source: AGHT+IFLpO6qOZi7q4RhE4GsZZhUwfq9Dw57tdLyUjstKo8gtTnO92RJN1LNXII9AjG38+eBbfsS1w==
X-Received: by 2002:a17:902:784c:b0:1dd:a33f:5913 with SMTP id e12-20020a170902784c00b001dda33f5913mr139558pln.30.1711555523234;
        Wed, 27 Mar 2024 09:05:23 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b001e14807f9cesm1718226plb.125.2024.03.27.09.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:05:22 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/7] riscv: jump_label: Batch icache maintenance
Date: Wed, 27 Mar 2024 09:04:40 -0700
Message-ID: <20240327160520.791322-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327160520.791322-1-samuel.holland@sifive.com>
References: <20240327160520.791322-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Switch to the batched version of the jump label update functions so
instruction cache maintenance is deferred until the end of the update.

Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/jump_label.h |  2 ++
 arch/riscv/kernel/jump_label.c      | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
index 4a35d787c019..6290b26f4a14 100644
--- a/arch/riscv/include/asm/jump_label.h
+++ b/arch/riscv/include/asm/jump_label.h
@@ -12,6 +12,8 @@
 #include <linux/types.h>
 #include <asm/asm.h>
 
+#define HAVE_JUMP_LABEL_BATCH
+
 #define JUMP_LABEL_NOP_SIZE 4
 
 static __always_inline bool arch_static_branch(struct static_key * const key,
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index e6694759dbd0..11ad789c60c6 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -9,13 +9,14 @@
 #include <linux/memory.h>
 #include <linux/mutex.h>
 #include <asm/bug.h>
+#include <asm/cacheflush.h>
 #include <asm/patch.h>
 
 #define RISCV_INSN_NOP 0x00000013U
 #define RISCV_INSN_JAL 0x0000006fU
 
-void arch_jump_label_transform(struct jump_entry *entry,
-			       enum jump_label_type type)
+bool arch_jump_label_transform_queue(struct jump_entry *entry,
+				     enum jump_label_type type)
 {
 	void *addr = (void *)jump_entry_code(entry);
 	u32 insn;
@@ -24,7 +25,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
 		long offset = jump_entry_target(entry) - jump_entry_code(entry);
 
 		if (WARN_ON(offset & 1 || offset < -524288 || offset >= 524288))
-			return;
+			return true;
 
 		insn = RISCV_INSN_JAL |
 			(((u32)offset & GENMASK(19, 12)) << (12 - 12)) |
@@ -36,6 +37,13 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	}
 
 	mutex_lock(&text_mutex);
-	patch_text_nosync(addr, &insn, sizeof(insn));
+	patch_insn_write(addr, &insn, sizeof(insn));
 	mutex_unlock(&text_mutex);
+
+	return true;
+}
+
+void arch_jump_label_transform_apply(void)
+{
+	flush_icache_all();
 }
-- 
2.43.1


