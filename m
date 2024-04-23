Return-Path: <linux-kernel+bounces-154974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E578AE3CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B391C22A58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511227E118;
	Tue, 23 Apr 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="KbzSdeRd"
Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37777E10B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871523; cv=none; b=r/+JzP79OXEcTZuc+1IMO3X+uOFPq/cZi292KoulEPBqriZJZHS6E0Yy4WQQRRUfs8Adjrkw0L8FPrLZsPLYmlPlw0apZ6E9hWMkSIVki6uplV9ZRDyJzztRfjTi9ErSB7Zu8qilhKWFmXbf6RbdbzSjIppSGitW7vRmBw4faKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871523; c=relaxed/simple;
	bh=vG4w4lm74pJtjt2dxWDDT7funVus0pgdkP3n6FI0+/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVXCgqRLY24slHbcJJkkbEe0RcE5WP5Be0bKNy/tq+al3uIGAIWLCEo0WBY5Emk+ppAJ+HLUC/PGp1zAZSpOa94Bv1nyMUUJ9N6JFoyg6gDNKUabLHafdfuh9WwVs1uWTwRBe6YwxWi3NLDyQzx1OfCtelgZUzDuIys74b0rxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=KbzSdeRd; arc=none smtp.client-ip=140.205.0.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713871513; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CiQKB25MktD/QLDdLcPUH0+dexeuRZvHnI8X4wiFwkI=;
	b=KbzSdeRdhEqfTocRcD3qjnwWJWV0DEuvXT/AkDlAGaISR79UMbLn8BNrY9YTq1IeQsOsagA+pnqtq/lzvup3Dx0RaqVe/w64xFwBOpxhVt3UP+blgL+cd6NbzRxUE/4r3VEl1lsCG3Pj4d7dihytjL9R8NMXCrsHW5uPGNUvi7g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYhm_1713871512;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYhm_1713871512)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:12 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/7] um: Fix the -Wmissing-prototypes warning for __switch_mm
Date: Tue, 23 Apr 2024 19:24:52 +0800
Message-Id: <20240423112457.2409319-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __switch_mm function is defined in the user code, and is called
by the kernel code. It should be declared in a shared header.

Fixes: 4dc706c2f292 ("um: take um_mmu.h to asm/mmu.h, clean asm/mmu_context.h a bit")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/mmu.h           | 2 --
 arch/um/include/shared/skas/mm_id.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index a7555e43ed14..f2923c767bb9 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -14,8 +14,6 @@ typedef struct mm_context {
 	struct uml_arch_mm_context arch;
 } mm_context_t;
 
-extern void __switch_mm(struct mm_id * mm_idp);
-
 /* Avoid tangled inclusion with asm/ldt.h */
 extern long init_new_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
 extern void free_ldt(struct mm_context *mm);
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index e82e203f5f41..bdfab67174ff 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -15,4 +15,6 @@ struct mm_id {
 	int kill;
 };
 
+extern void __switch_mm(struct mm_id *mm_idp);
+
 #endif
-- 
2.34.1


