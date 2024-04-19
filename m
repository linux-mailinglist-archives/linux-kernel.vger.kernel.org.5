Return-Path: <linux-kernel+bounces-151050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D28AA85F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB0A1F21FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FF410A2E;
	Fri, 19 Apr 2024 06:22:12 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3724C8E0;
	Fri, 19 Apr 2024 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713507731; cv=none; b=I2KTOvfO9+yVVqxqGSfNaHtulEWb8HBmV2toCfV2/ZDH/5puLnkUZ+e+QcQIjwA4jg4ld7v6eVNw9EEV3zfqpEfQWo1wgra6o//d5fGY6cbg4wwh98awF6xWDYlDDHxPXwzxpP1LVwa0Qp9mjXF6nqkYVFqVU0fkkJ4f8f31Vgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713507731; c=relaxed/simple;
	bh=OgtNH68QHSOCj2Q1N4piVftBi0yqKXVj2TEitr652PM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQueyN0L16s+cHzvgUHhy6onI0lQl7vqCcXn4UPFX8uuNeQqKxoBoRaOMRi9OpVVHHh/a9sMJs695rQ/ANYM4LDBxJx58crr4bWFed61RBS/GlvTk1Xbm4VIHjwqfLWML9tCWVVxPZUisuO9cRJQpOse0wvsGxBiJfvRRy0Cj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VLPcJ3b4nz1N87g;
	Fri, 19 Apr 2024 14:19:12 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 42AF4180073;
	Fri, 19 Apr 2024 14:22:07 +0800 (CST)
Received: from huawei.com (10.175.101.107) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 14:22:06 +0800
From: Ye Bin <yebin10@huawei.com>
To: <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
	<chandan.babu@oracle.com>, <dchinner@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH RFC 2/2] xfs: avoid potenial alloc inode failed
Date: Fri, 19 Apr 2024 14:18:48 +0800
Message-ID: <20240419061848.1032366-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419061848.1032366-1-yebin10@huawei.com>
References: <20240419061848.1032366-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)

As 'pag->pagf_longest' may be temporarily set to 0. When the AGF buffer
lock is not held, using 'pag->pagf_longest' to determine whether the space
is available will cause misjudgment.
When the fragmentation is not serious and the reserved space exists, using
'pag->pagf_longest' to determine whether the space is available cannot filter
out the space that really cannot be allocated.
So remove judgement about 'pag->pagf_longest' in xfs_dialloc_good_ag().

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/xfs/libxfs/xfs_ialloc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index e5ac3e5430c4..bb0ce2248386 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -1689,7 +1689,6 @@ xfs_dialloc_good_ag(
 {
 	struct xfs_mount	*mp = tp->t_mountp;
 	xfs_extlen_t		ineed;
-	xfs_extlen_t		longest = 0;
 	int			needspace;
 	int			error;
 
@@ -1717,12 +1716,7 @@ xfs_dialloc_good_ag(
 
 	/*
 	 * Check that there is enough free space for the file plus a chunk of
-	 * inodes if we need to allocate some. If this is the first pass across
-	 * the AGs, take into account the potential space needed for alignment
-	 * of inode chunks when checking the longest contiguous free space in
-	 * the AG - this prevents us from getting ENOSPC because we have free
-	 * space larger than ialloc_blks but alignment constraints prevent us
-	 * from using it.
+	 * inodes if we need to allocate some.
 	 *
 	 * If we can't find an AG with space for full alignment slack to be
 	 * taken into account, we must be near ENOSPC in all AGs.  Hence we
@@ -1742,12 +1736,9 @@ xfs_dialloc_good_ag(
 	ineed = M_IGEO(mp)->ialloc_min_blks;
 	if (flags && ineed > 1)
 		ineed += M_IGEO(mp)->cluster_align;
-	longest = pag->pagf_longest;
-	if (!longest)
-		longest = pag->pagf_flcount > 0;
 	needspace = S_ISDIR(mode) || S_ISREG(mode) || S_ISLNK(mode);
 
-	if (pag->pagf_freeblks < needspace + ineed || longest < ineed)
+	if (pag->pagf_freeblks < needspace + ineed)
 		return false;
 	return true;
 }
-- 
2.34.1


