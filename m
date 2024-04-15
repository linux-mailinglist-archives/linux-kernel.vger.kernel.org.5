Return-Path: <linux-kernel+bounces-144875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D798A4C10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42517284B44
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764B4CE17;
	Mon, 15 Apr 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VyjYLYsj"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC14AEF4;
	Mon, 15 Apr 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175006; cv=none; b=a3sM+dz1mgAsqcjPid8FrhA/aNL5DB/eANpAA4KzKKYocSP2swlGCvcLrR4ByIpL7XxJ+lupRrkXz8vJZDPs9gxGuskZDm884EaX7wWWTv0/q5FgjiBwAt2U7oTTRFvE8rYpfHpmTyUkfVd4A4LDwGoCeesj1gPslfMClbTpovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175006; c=relaxed/simple;
	bh=p/eDb7xPCBZ8a/tAPqpUni2sUFc6xd5QsBAU3GFwCoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FmC5M87eVPRKtU4zKHQAPiPHFLkYtKZbefC68pIOTDQ6xbEo2bQ8N/C6S/4h/65AzExyO1k6LiyX3e9kIuP8+pCQ1jBhweN7RTSEfGQ7RQGgHSz1ZFgvO/dHvm+0rXCFxZM+OqsFuqoUv8HvPD2KMtVky397CkO9gbP7lfysSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VyjYLYsj; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713175001; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uKQrEiJDFuVgYKaCjACTRxFVEamjUwkGI79EoCthHgw=;
	b=VyjYLYsjwcIKWDpF1YRbCibJWkrmA0hupOiWHBlaFALKRLQymPxBUeqFGJe7KY7c1UnFQaVlfYYQc3y1zzBCAa762VPuDxR2gI9LxCdnp5l6qhNPfgvVTwo9LYPzAbMfHDU/WyNMyxHAqVRHxTQrs+/c9mSuQffH/Ce5w4FOZoU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4a9De2_1713174995;
Received: from localhost.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0W4a9De2_1713174995)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 17:56:40 +0800
From: cp0613@linux.alibaba.com
To: palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH] tools/perf: Fix compiling with libelf on rv32
Date: Mon, 15 Apr 2024 17:55:32 +0800
Message-Id: <20240415095532.4930-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

When cross-compiling perf with libelf, the following error occurred:

	In file included from tests/genelf.c:14:
	tests/../util/genelf.h:50:2: error: #error "unsupported architecture"
	50 | #error "unsupported architecture"
		|  ^~~~~
	tests/../util/genelf.h:59:5: warning: "GEN_ELF_CLASS" is not defined, evaluates to 0 [-Wundef]
	59 | #if GEN_ELF_CLASS == ELFCLASS64

Fix this by adding GEN-ELF-ARCH and GEN-ELF-CLASS definitions for rv32.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tools/perf/util/genelf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index 5f18d20ea903..4e2e4f40e134 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -43,6 +43,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #elif defined(__riscv) && __riscv_xlen == 64
 #define GEN_ELF_ARCH	EM_RISCV
 #define GEN_ELF_CLASS	ELFCLASS64
+#elif defined(__riscv) && __riscv_xlen == 32
+#define GEN_ELF_ARCH	EM_RISCV
+#define GEN_ELF_CLASS	ELFCLASS32
 #elif defined(__loongarch__)
 #define GEN_ELF_ARCH	EM_LOONGARCH
 #define GEN_ELF_CLASS	ELFCLASS64
-- 
2.25.1


