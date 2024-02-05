Return-Path: <linux-kernel+bounces-52044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8D9849344
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787F1281FC9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67C9B670;
	Mon,  5 Feb 2024 05:19:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10AB645
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110380; cv=none; b=RppBT8gYHZhKuxZ4owZliFYzrpQOCAXtHVYnKd1Gs5v3NigrAX3ZL9p8P1GxrRTABfF+oIwakJBEsrIowd/LdYnjC5NUeM64QOpUk0pNmtg45lr/9pkSHQt64lN0ivx4FyzN4DbAeEHSGMam7CmVEbi8MNxN931/SD2XH1VIKIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110380; c=relaxed/simple;
	bh=LNvoRVHOHOXT7MvScBmB66UiOPGnGVcsj/8+dvqjwGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+9kfFrSHSuhxEg93B+Uq9MJ1OkBsy+fgt4wBGlnar8tlXHa1Y7VSSrLVZ4ruxK0TPfv45PdZ1vQPvSXghi49ULO6fgnkDnJZ38StnzijSUJjvCgBIb8lsBX3mmvR1nlhnKIvmeuxO5zoDKzZ9bAPpoatl3co6RVRn6lRAj3CNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A60D1FB;
	Sun,  4 Feb 2024 21:20:19 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A94D3F5A1;
	Sun,  4 Feb 2024 21:19:34 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/cma: Make MAX_CMA_AREAS = CONFIG_CMA_AREAS
Date: Mon,  5 Feb 2024 10:49:29 +0530
Message-Id: <20240205051929.298559-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no real difference between the global area, and other additionally
configured CMA areas via CONFIG_CMA_AREAS that always defaults without user
input. This makes MAX_CMA_AREAS same as CONFIG_CMA_AREAS, also incrementing
its default values, thus maintaining current default for MAX_CMA_AREAS both
for UMA and NUMA systems.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/cma.h | 6 +-----
 mm/Kconfig          | 6 +++---
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 63873b93deaa..9db877506ea8 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -6,12 +6,8 @@
 #include <linux/types.h>
 #include <linux/numa.h>
 
-/*
- * There is always at least global CMA area and a few optional
- * areas configured in kernel .config.
- */
 #ifdef CONFIG_CMA_AREAS
-#define MAX_CMA_AREAS	(1 + CONFIG_CMA_AREAS)
+#define MAX_CMA_AREAS	CONFIG_CMA_AREAS
 #endif
 
 #define CMA_MAX_NAME 64
diff --git a/mm/Kconfig b/mm/Kconfig
index 35fa9940e61f..88ba99d84ac3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -917,14 +917,14 @@ config CMA_SYSFS
 config CMA_AREAS
 	int "Maximum count of the CMA areas"
 	depends on CMA
-	default 19 if NUMA
-	default 7
+	default 20 if NUMA
+	default 8
 	help
 	  CMA allows to create CMA areas for particular purpose, mainly,
 	  used as device private area. This parameter sets the maximum
 	  number of CMA area in the system.
 
-	  If unsure, leave the default value "7" in UMA and "19" in NUMA.
+	  If unsure, leave the default value "8" in UMA and "20" in NUMA.
 
 config MEM_SOFT_DIRTY
 	bool "Track memory changes"
-- 
2.25.1


