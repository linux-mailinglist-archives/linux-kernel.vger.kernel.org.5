Return-Path: <linux-kernel+bounces-79649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D90862535
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C471C20E4F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A51A4205C;
	Sat, 24 Feb 2024 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZGQPpAiY"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFE3FB28
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782425; cv=none; b=dADimRmT1O/+eqo6ea2+jOuzAlKNKMJKsI2ydQasg7kF8zVMSZGKRKP+qSBcIRsiY1+vnjS68FpZAOkzDX8TcvP4uDh1HiKg3iFEZsOt4dcz+AVoTVWsCPxV967/nDuCAK99UH3VKZTSiUXwy/2M7OwYAM/To3Tl/tMDhHK5nQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782425; c=relaxed/simple;
	bh=fQiIyGANEpTEfNpY32a9B9N+QodgRGRhVvL+EP121b0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uRSungVgTbnlplZIWWNVGGKao3tgg9daQd43m6d+BivKwKaOzFD1SJ1cRTmEgZAEoQJzBmjF2RMVUd1qVX6sVNR4gaH7CdJu1LH80Z+9DYh0PwnQ4Z5DWghjTdF0XAZc/1B6efTf0yIKV1PEBhpzYHbxDtZUDfuMxk3ywTblPWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZGQPpAiY; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vAqWclroKkGVD5OBWda/UPx1L56Bmxv2Hafday/lWEo=;
	b=ZGQPpAiY+bZvdOZuYOvQFC+2tIaIpyMMPNReEkudNglDZiwtb9fZbau8Xk+Xw+FM/2plcG
	GxntFxhyu25nLfASCwsh3FYpQx9vV0s7b7CsRpNLv8JvxIDd67rZpXn8+zCU1bwmMAUJE8
	ECpV+i3HUd4zdNXwLXaFf8GXQLsOHSo=
From: chengming.zhou@linux.dev
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] befs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:46:55 +0000
Message-Id: <20240224134655.829132-1-chengming.zhou@linux.dev>
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
 fs/befs/linuxvfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 2b4dda047450..b873452e96ad 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -435,8 +435,7 @@ befs_init_inodecache(void)
 {
 	befs_inode_cachep = kmem_cache_create_usercopy("befs_inode_cache",
 				sizeof(struct befs_inode_info), 0,
-				(SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
-					SLAB_ACCOUNT),
+				SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
 				offsetof(struct befs_inode_info,
 					i_data.symlink),
 				sizeof_field(struct befs_inode_info,
-- 
2.40.1


