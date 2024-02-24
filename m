Return-Path: <linux-kernel+bounces-79655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793E886253E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B8A2825FD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC204597F;
	Sat, 24 Feb 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fl/RWrgg"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC329438
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782489; cv=none; b=FxIG074jyApOMjAf2YyMBY8pSkGbLipBSdq/fc7uO83A49kSVGhNQ59oFXVLcVGDGDpMJqgqcd8B+gG7M9rR8ZONye+q5yGu6il2mBe1bmzUa4z6R4kYOG6XiozkCKXGv8Hbfj5dFyWlouCKftVHPpaKEQtnSzI2YCHjS4vzIGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782489; c=relaxed/simple;
	bh=Hf1EvUqSPPrwju7FZe9QROGFi2kgS1A0PvtxOKouvmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZW7h0TT2Bq52gE9izhsekiCBvJtzO2JVohNbc495SNkcwdadPwYZwS8ItzudWzV2B/ghnzthrYxBVvPQFDATzR7k/JbR5cDMDpMFLAYGPxPSI2SrMFVO6835DzXRmZ4siHcW4ZO6UAez7f9TII85+Ex57nXtopRg4dbwX11ucCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fl/RWrgg; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nhgk1xLGq4KX/ZM1rwfa07VQXn0oX30NwYq/BvwDp04=;
	b=fl/RWrggsb1lT23NO1RkWdvVun6tHSIULezh29Wj5sdbZDIbimQXihiTJ/TYDYuVSpgTUf
	xNrVYfDyUsd7UO0ltzy9rp3FfJEsstIkLMGalkZrHm/2aDPm0ANm3586REIj+DtM2NC8vA
	uNi52abAQJbIiC4SFfiaP+oHFRKV8AA=
From: chengming.zhou@linux.dev
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] erofs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:47:49 +0000
Message-Id: <20240224134749.829361-1-chengming.zhou@linux.dev>
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
 fs/erofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9b4b66dcdd4f..8b6bf9ae1a59 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -885,7 +885,7 @@ static int __init erofs_module_init(void)
 
 	erofs_inode_cachep = kmem_cache_create("erofs_inode",
 			sizeof(struct erofs_inode), 0,
-			SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT,
+			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
 			erofs_inode_init_once);
 	if (!erofs_inode_cachep)
 		return -ENOMEM;
-- 
2.40.1


