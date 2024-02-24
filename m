Return-Path: <linux-kernel+bounces-79646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D2862530
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A361C20EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E431042078;
	Sat, 24 Feb 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JwPgOKvU"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69580E559
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782400; cv=none; b=Hx/uANSuNm7Ra7qLK+OFSS8BK2EhGS6tir2QxgnvqSUKZmSeu+pS1+GLHPqjeuB2qdmiaYtH9JO656+YTOLxvKuoMydV5JynchsoCidr7I4cCiZx1i/HeHQitGcVKX2GXiaLtSeGaxSSxD7L+YHGf/glK/uqf9aFMj/TEKOdYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782400; c=relaxed/simple;
	bh=vHVVXs52UZDUDt8d6C6jXJaAUgPqoSuNZEua3elrOig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bqmaI00BlqAGSOL34RPzluwMWL7vg0jPeZVbSh5tPnotvibiYDPQXbr3KV7z9IIfxE54cqLZVZ8qwvzs4V6h/YM4X4Of2c/DhaYljRYnRomNwN2ddxxn8TbvGMyKhxd5sk08qc+ZHqNlcXp8GA5aUKhKzUqMY1dnBXgP/MmU6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JwPgOKvU; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8N2J1+XCT+l1dZ8LlfhLcKCm1/gv2vTPXUnKvRWB5YY=;
	b=JwPgOKvUGKJAhHXRa/9jo1bpsVr36Jyvwy8h2k9XM0tB5NgAiYU9511lTjmX1LSAwoiUKC
	L01E8KlEW8tn5CwXlMGqlZWzKShTeqT6tx4mQsMNbnYtV/nn7UIG+IvXEPi1l1Tv7Qejaj
	PW+DNx87t8pGWIz5pt0hBSWn0tZVQ6Q=
From: chengming.zhou@linux.dev
To: zhouchengming@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] adfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:46:30 +0000
Message-Id: <20240224134630.829042-1-chengming.zhou@linux.dev>
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
 fs/adfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index e8bfc38239cd..9354b14bbfe3 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -249,7 +249,7 @@ static int __init init_inodecache(void)
 	adfs_inode_cachep = kmem_cache_create("adfs_inode_cache",
 					     sizeof(struct adfs_inode_info),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					     init_once);
 	if (adfs_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


