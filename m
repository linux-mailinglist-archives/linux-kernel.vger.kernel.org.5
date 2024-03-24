Return-Path: <linux-kernel+bounces-116232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E347E889DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCDA1C35490
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA7D2922AB;
	Mon, 25 Mar 2024 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAUKJ+Tj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0D17EB7D;
	Sun, 24 Mar 2024 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324010; cv=none; b=m4ymnkEyoMgJpbRMHbNS1+/IITIqf6MwTa8j90WYTWK3yVjhIncLBwWWCFdrreISrj+NVRfyMWk0+LacsqKL2qVp7G+Kps9IN4CJUlgO2im6S2f7JpyfWpRSZUmp5JdjiAz+5Fjopm9E4TSE+yqhV8j+RObnzCjV3Q7h4Ew8Pq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324010; c=relaxed/simple;
	bh=C0gSXFhMFIQyyEvs+6TeLlPz+LAlhzCRatW1d/j8fyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T57Jsj4OMGQPVJhkG0NDjn6SfZrTdaN76VA2t7xiAjMD14h/WWS1uKdI8oPA9ar0uuktyb0PFnwA/+4D3BncrsRmdL1MpWTg7WuFdzQVWdQsBJB8WbufoS5afyHzAN40wC9BXpdM6K2KT0X/XMKmSbP4XB8FynL0A+PG8BjVXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAUKJ+Tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1984CC433A6;
	Sun, 24 Mar 2024 23:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324008;
	bh=C0gSXFhMFIQyyEvs+6TeLlPz+LAlhzCRatW1d/j8fyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAUKJ+TjTkxqCRYbHEY6+3Zyh4u/uncy9oCrRE1wnnt0Xx8mnROwWC+RtDehcoONB
	 6Q0eiooBFKLaMRNPazeGFvuxJvfGyqIoBrktVs7NXoURgKkWMTYejcAIC4QJZJEB3H
	 ot0jWag1vdS3CnqTuR57Hg09534DkARxIbqsQHczDy9MapG/hS7CSqWEIfN6azWM3K
	 SnimZxjybQs9yhxlnmp/dh0AT92n4H7pjDuHeF2rf7B7m9opBAbst22Efz1pt5FcYs
	 pzPqi7jpmzCanGLL8yVvx10OjA7oKv93cqNiCu8szrSBkMMCG3jSgIryY24YNhDE8k
	 4L0H6WWGCwaSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 009/183] net/iucv: fix the allocation size of iucv_path_table array
Date: Sun, 24 Mar 2024 19:43:42 -0400
Message-ID: <20240324234638.1355609-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit b4ea9b6a18ebf7f9f3a7a60f82e925186978cfcf ]

iucv_path_table is a dynamically allocated array of pointers to
struct iucv_path items. Yet, its size is calculated as if it was
an array of struct iucv_path items.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/iucv/iucv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 392f8ddf97191..8b5b8cc93ff8b 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -179,7 +179,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
 static LIST_HEAD(iucv_handler_list);
 
 /*
- * iucv_path_table: an array of iucv_path structures.
+ * iucv_path_table: array of pointers to iucv_path structures.
  */
 static struct iucv_path **iucv_path_table;
 static unsigned long iucv_max_pathid;
@@ -590,7 +590,7 @@ static int iucv_enable(void)
 
 	get_online_cpus();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
-- 
2.43.0


