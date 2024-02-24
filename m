Return-Path: <linux-kernel+bounces-79653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D32886253B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372171C20E62
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF3245026;
	Sat, 24 Feb 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z+wCMTJW"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADD481C6
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782464; cv=none; b=meiB6SSgjn9KX3K2VBlcCFnRSpoQUr1ZIfXG8wRPwT/x98KTPOF6R4Ox7ks75tAp1LWz92cqlgg1Gpr8TpfVKJ/gb149yY09T79LONLlFRNXN7URWHdmmdzE/KZJytdizqr0CW0AWc47buLAXkCfYbZ0R2EKsEBYeXc8b2s9EK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782464; c=relaxed/simple;
	bh=VOqdFD002G9aGfr02w/5hYUtS7LomyuWVefHYXsh7SA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AP8GF1ag1WNv2BcUkeujyBVb7dpBx/wzcD0kg1Yzm+F3ts0sFn3iUnOC5wxE411Qs06A4t1SME31RAo+piXmb+5HLGVEBJDn+2/Y+NCd+F4JQjqMEQlrJ1ItThAOYMYuKHoHr1F4AjydS0fWSbQykjRglFYXbD82i0U25ZRXwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z+wCMTJW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XhzA1t4BRqDcpPiJ25Uf8+6t2OXS7FCxF+VYL2dOXRc=;
	b=Z+wCMTJWMVFyRVAkgVB6cN7ATU078/NuFpUaldfXkNi0f+x2vMcnZOaE1lhNzmUiJOxI3j
	d09bO8LKs7M1tecqmYiH2CSNQ/wSMtOqLRW/z1f5NHRjoYghBMyc6uWFEeXes657pUQ9dR
	eu3Z2lsc1Ti4+YH2Gt+o9WNm05wMth8=
From: chengming.zhou@linux.dev
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com
Cc: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] dax: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:47:28 +0000
Message-Id: <20240224134728.829289-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 drivers/dax/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 54e528779877..cff0a15b7236 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -547,7 +547,7 @@ static int dax_fs_init(void)
 
 	dax_cache = kmem_cache_create("dax_cache", sizeof(struct dax_device), 0,
 			(SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-			 SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+			 SLAB_ACCOUNT),
 			init_once);
 	if (!dax_cache)
 		return -ENOMEM;
-- 
2.40.1


