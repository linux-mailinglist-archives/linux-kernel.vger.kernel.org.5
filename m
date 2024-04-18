Return-Path: <linux-kernel+bounces-149478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78828A919E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E091F21D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EA852F7D;
	Thu, 18 Apr 2024 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y2pDslNs"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B35244
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411851; cv=none; b=RHkk758oY1WjvKLQzYhzcZnjNSY7jhtgigWLE0tdnNhGPk52J5x2X1lExWI/YIDjq6Ji1i+IcOgjM/qO/rMC5vc687VMO1Zefg1/rIY4usUQ2i2iTzfF1eh27nxXt5QlzvcNNf8MGpiFdWxi4iAWaz1YjZcWbuCoD9mRYkMDVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411851; c=relaxed/simple;
	bh=f1DDzJv3xHeLtz/8Uh38H6uqD2mqnmTd8LGL7fsQk2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A47OFxTtxAY4kf2vEuO+xQwZ0xBH03SGvb/55o6goDeJI3/sy36wY0XfIA0uof91bcOOWP0C08OBn8gAMQQmDKmIc8wEScmf+rihYxMfrQ8NlqgLRXEHIRFtu859s8cVtu39ukS6yWpD5BNT+XBIiMugmcj2o1EwrzMM6JlILw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y2pDslNs; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b519e438so285237a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713411849; x=1714016649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aKuxY2Fk4OLcsa0CSr6w7+nYt28fnnuhVioZfggdrc=;
        b=Y2pDslNs5o41NGzmdJJe6es0UHYGtMsHBXO3sHQGXG8g9WcEp+5HSi0l69Bar+p1q+
         lP+bMKdv6Jl17qPwyG7D7pMcFYIKTgJYUjqmGjoSbPS08i/MmXwcXGL7Ytfo287kX+md
         JvuRg8LdUZQfaldR+h9tGT16aqxuhrpA71ZP/oWayGANBxokw60UmgNux2s0JB6FXnuk
         qScbX6hEOOpT25+0aTjxeQ8OPh0ao+RWpkSkGnvKmG3aQbsmLCPqQEXqyBpvQDfghCUr
         v23phpV+DazBqW/HYVq9taJGapXxvaHh7JZToQkw8MIBZ7h/mgyrioL2wbM+D5CYxgqX
         Ae7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713411849; x=1714016649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aKuxY2Fk4OLcsa0CSr6w7+nYt28fnnuhVioZfggdrc=;
        b=NsXWu6GuUyclGM3t9XCkEUeABUDV+/1F/hxPT/j/QE+qiIFkJQrGtyjZP2wDd6UJR5
         ajBOjfr9tXmuDpx8l8v77LLTbCUAcB5zJyjb+ct7NnCWas7fFCEhSMHiZ3bsCSnXFN+N
         mgMyiqGq5DdAugBYSuT136JpLuViP11kW1i77CL0Nr1s8Rmd9espog6SMlqO+xC7kI/V
         u6W/HyQrTvjAjFX/soTXwtJYwdsuF6kZbzxhPH1Xx+qfIDx5NfEToaKYY7OJHd6M1s16
         0DLnTxti2HPdsobxJGxVTq/foBaluGphPVPNy7PEqYZl6CvZ8eu/B2njgkZ4Z6iFjxbQ
         aWHA==
X-Forwarded-Encrypted: i=1; AJvYcCVTT8b5/U7XZ0qYXrEY021ohixZ9YpMGur1FnIwVQv3Bwovu6Mkt0foblHGtgV0Am1PBAhzMxnZlymsSViDSlfDBk3nd+iQU1t0H33i
X-Gm-Message-State: AOJu0Yz5Q+BNL2nle2Eq44zwR7gyv/Xa+ZoOYMDsEPy4MKMOSSXkXyQJ
	BbToTIVrCc8f8sCE0t9dheof/KRa5Hsqmy7HyIjp8gxVz2CXX7oWToUA2LlK+9Pcv7cEujsuFUB
	YKwY=
X-Google-Smtp-Source: AGHT+IENnC+gIH2bbDka18v3JCTvqRUUTm8xhPk1GrdsMZSjMFsPl6ypgKPGxdD/ZPfFfCVnnmOTAQ==
X-Received: by 2002:a05:6a21:184:b0:1a9:8834:ee7d with SMTP id le4-20020a056a21018400b001a98834ee7dmr1973589pzb.4.1713411848825;
        Wed, 17 Apr 2024 20:44:08 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170902fa4400b001e88a4ebeb2sm109880plb.152.2024.04.17.20.44.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 20:44:08 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jhugo@codeaurora.org,
	jeremy.linton@arm.com,
	john.garry@huawei.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v4 1/3] riscv: cacheinfo: remove the useless input parameter (node) of ci_leaf_init()
Date: Thu, 18 Apr 2024 11:43:28 +0800
Message-Id: <20240418034330.84721-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ci_leaf_init() is a declared static function. The implementation of the
function body and the caller do not use the parameter (struct device_node
*node) input parameter, so remove it.

Fixes: 6a24915145c9 ("Revert "riscv: Set more data to cacheinfo"")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/riscv/kernel/cacheinfo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 09e9b88110d1..30a6878287ad 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -64,7 +64,6 @@ uintptr_t get_cache_geometry(u32 level, enum cache_type type)
 }
 
 static void ci_leaf_init(struct cacheinfo *this_leaf,
-			 struct device_node *node,
 			 enum cache_type type, unsigned int level)
 {
 	this_leaf->level = level;
@@ -80,11 +79,11 @@ int populate_cache_leaves(unsigned int cpu)
 	int levels = 1, level = 1;
 
 	if (of_property_read_bool(np, "cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 	if (of_property_read_bool(np, "i-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
 	if (of_property_read_bool(np, "d-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 
 	prev = np;
 	while ((np = of_find_next_cache_node(np))) {
@@ -97,11 +96,11 @@ int populate_cache_leaves(unsigned int cpu)
 		if (level <= levels)
 			break;
 		if (of_property_read_bool(np, "cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 		if (of_property_read_bool(np, "i-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
 		if (of_property_read_bool(np, "d-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 		levels = level;
 	}
 	of_node_put(np);
-- 
2.20.1


