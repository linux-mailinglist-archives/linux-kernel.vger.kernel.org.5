Return-Path: <linux-kernel+bounces-82470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62882868507
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE378B234C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F84C8B;
	Tue, 27 Feb 2024 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dYYQggaD"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E61848
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994197; cv=none; b=oRO+7HpRVqvru9yP/Z1QVII4K+LihTxiWRHbejFnKDhd9D8fTFqL6WkX2UDcKh/fl9FQGUGYLmegzKQ/V8PInhyQD6lrhNQx7Q0YhZGtDcTtO1l81nf4FoafIi7wNRvoDeIvwMEllqtuBTdB1xOExLJGRvpEw1/71/00VKKSHHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994197; c=relaxed/simple;
	bh=yfuDmq0tSBnwHEFGusBHNjVaLXcr5VaOBNNiZ8nN2dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbYAqo+y16yZbxgahVGRfwsJRrZXnvoVaGMSVvtCIR71rCen6ZG/AA1zyIwsE9vfBIcPy703aGMW9pQltHUAhZx1hMJt6+UBpEtXOnghXhJqTQL10BxpVHsVUqr5SnKvscGqLS3OBYKIg0+R2tW9IWjnVufyTeK/i5EjyMjF60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dYYQggaD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso3349206b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708994195; x=1709598995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj3OP08z+QmSADpUch3bINy+udg5hxpgq6aJUETENlU=;
        b=dYYQggaDAjShGq2ob4iTzg7eF9N3d0jPQjnbmEYE3n1u0cUBGFyI3ZzvgZ8NILompq
         Bl+gbJRdDzODSmWmfMsgO186VklypNMwMdI2ECG37u5HeCsdW5SijC6MSJwkyy/tpEqR
         x/RcwZcLLaIMPrhFviFTnzRaPIvOf/40/d2kCbiCC1zSElNYPemWZ766bdigc3z7uBuW
         7r4ZHi17i4fJSVINtY4Mo70MfCaiFRMtCYt2wghEUFmirMM0PyUY4TSVUZ5CKBsSYC8P
         ZoK+s4MLTxbgRUYCZaLFWFRLsmuYmimD60mKyR1lqc/VBQTnFcTJbeo4lb0oR4l0saLx
         qBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708994195; x=1709598995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj3OP08z+QmSADpUch3bINy+udg5hxpgq6aJUETENlU=;
        b=GmibWoerqSlV/Tm7J7/MSNMO+cnaen3HGb0NxqscHdoCXH5AXCVE/lD78QZiaN0Ocy
         CVKdh8HX6bzyZhVBWzUtBKvffUJgqEgNAtwTMmwt47Q6ZhDZ1kwVIwafrVJjquwOq6jC
         MbKQiK7im0K44+3rFUS1HAr0w5NYmWznT7e2FOQM3weOk5mMsuBvV4FXSnI2gbZ1ax6M
         OS+oh5rhw97cJBAxeyOX5hoZp3luWbEYu4KXhjomUeV0/fkztU4iKj1v+qj5hy+xJP1j
         RkGwtLOgxHtZSxnsZ88xSf17+YgX/cerzDpY9Af/wFJwqVBnY2WqUQ73fJV6wdzB7W53
         dSYQ==
X-Gm-Message-State: AOJu0Yx6SDemmQ6MerU2pM87L4JaKxxjtQQh1GH8hUaFuMFEVSHfaWU5
	pDQg7RNk9XatMv4dD+A5Tn7b/oj3N2DyjYkJfGd+f45fPuRRWM1BSE0HJ5lHUx4=
X-Google-Smtp-Source: AGHT+IFgPx9lY7vngIVEaxgfVmEppG2EU25f61Y7UcVq+5kUQ65nzj4A2GDggdH2jKZXiIDb84Cgkg==
X-Received: by 2002:a05:6a21:910c:b0:1a1:fb:7586 with SMTP id tn12-20020a056a21910c00b001a100fb7586mr944213pzb.57.1708994195402;
        Mon, 26 Feb 2024 16:36:35 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020a631919000000b005dc85821c80sm4504117pgl.12.2024.02.26.16.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:36:35 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 2/4] riscv: Fix loading 64-bit NOMMU kernels past the start of RAM
Date: Mon, 26 Feb 2024 16:34:47 -0800
Message-ID: <20240227003630.3634533-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227003630.3634533-1-samuel.holland@sifive.com>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear
mapping") added logic to allow using RAM below the kernel load address.
However, this does not work for NOMMU, where PAGE_OFFSET is fixed to the
kernel load address. Since that range of memory corresponds to PFNs
below ARCH_PFN_OFFSET, mm initialization runs off the beginning of
mem_map and corrupts adjacent kernel memory. Fix this by restoring the
previous behavior for NOMMU kernels.

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/page.h | 2 +-
 arch/riscv/mm/init.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 57e887bfa34c..94b3d6930fc3 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -89,7 +89,7 @@ typedef struct page *pgtable_t;
 #define PTE_FMT "%08lx"
 #endif
 
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
 /*
  * We override this value as its generic definition uses __pa too early in
  * the boot process (before kernel_map.va_pa_offset is set).
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fa34cf55037b..0c00efc75643 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -232,7 +232,7 @@ static void __init setup_bootmem(void)
 	 * In 64-bit, any use of __va/__pa before this point is wrong as we
 	 * did not know the start of DRAM before.
 	 */
-	if (IS_ENABLED(CONFIG_64BIT))
+	if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU))
 		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
 
 	/*
-- 
2.43.0


