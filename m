Return-Path: <linux-kernel+bounces-124071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260A8911CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F891F22A04
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7AD376E2;
	Fri, 29 Mar 2024 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OqpMA345"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607637160
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711681291; cv=none; b=SLKl/w9zhMpHQYdrD2LubjaJUnTBLm5jIsCSKyAho5YuI3SR2nMvuTGcXzmrikWJmyy1FYkWYdoGMV/GVg96EZL9E0AygSGA6FV1ifNqR9sGzQON/XYY0sg47Jy88bVNRcWhkp20Q0DbIkEgQWG3PJX1a+a5s18QSVbuIDumELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711681291; c=relaxed/simple;
	bh=H8gUOHQf9TsAaH1yq1L8GUK6KvmmDdkD6x4q/6VURsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=brR8e6nxsyMnpEO5BOZuEV2QjLaYVrba7JDlgF/rK+npDEUhV27cALdIIRSKVaHMhPT619Vgis+SAoBMmVz+S7mQmUp83dFujclG/WzI/Zb9s4JLPafu4Xzt3KVlU2E43c0/+9SZTYMenOZqe/jJ67o0reiqx8Dxcek8TjejXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OqpMA345; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711681286; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vrxKUk1S17HIEtbtDU9RXj6Ll9EGFBccFdXnmENZ8tg=;
	b=OqpMA345hsnou4xCnAPP5JsPGIVlInaxNh/bjWywqB0joDsRV19jSJUGcyHAP6nYwd19cQvxjnlQ0XaBOLKjdgdFwGhj86Cltvvnn4vhxDrfVKGxMJRkh46ybGL4lM8qSiwHkNKfzNBaX6TUuFBpPS3GCoMO2uw3CXzPIu7OUkk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W3V8Nrx_1711681279;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W3V8Nrx_1711681279)
          by smtp.aliyun-inc.com;
          Fri, 29 Mar 2024 11:01:25 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mempool: Modify mismatched function name
Date: Fri, 29 Mar 2024 11:01:18 +0800
Message-Id: <20240329030118.68492-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

mm/mempool.c:245: warning: expecting prototype for mempool_init(). Prototype was for mempool_init_noprof() instead.
mm/mempool.c:271: warning: expecting prototype for mempool_create_node(). Prototype was for mempool_create_node_noprof() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8666
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/mempool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 602e6eba68d3..4fa7c78fc409 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -227,7 +227,7 @@ int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 EXPORT_SYMBOL(mempool_init_node);
 
 /**
- * mempool_init - initialize a memory pool
+ * mempool_init_noprof - initialize a memory pool
  * @pool:      pointer to the memory pool that should be initialized
  * @min_nr:    the minimum number of elements guaranteed to be
  *             allocated for this pool.
@@ -250,7 +250,7 @@ int mempool_init_noprof(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 EXPORT_SYMBOL(mempool_init_noprof);
 
 /**
- * mempool_create_node - create a memory pool
+ * mempool_create_node_noprof - create a memory pool
  * @min_nr:    the minimum number of elements guaranteed to be
  *             allocated for this pool.
  * @alloc_fn:  user-defined element-allocation function.
-- 
2.20.1.7.g153144c


