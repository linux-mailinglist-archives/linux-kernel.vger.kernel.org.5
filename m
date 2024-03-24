Return-Path: <linux-kernel+bounces-115758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49091889779
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA41C30D06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEBF22645F;
	Mon, 25 Mar 2024 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se9bkRgj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED901448F8;
	Sun, 24 Mar 2024 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321963; cv=none; b=o/EYQ118ojj4mY0Y45lKVgYyblJFFPenJcur67h0hz6psCA8o/txak4Bd32WSBIUoN7k/e/gnpBC1QY0T5fndX5trgp5tH17t0DNNCM4NU2KhC6Vbe8/uNK/uaraeQC7H1OXNWfjnS+TSclpc7QcgqxYOlQRmamSW4RO75TV6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321963; c=relaxed/simple;
	bh=74kBJTUxv1Q4HgbcKWpYMeYUi0KuiFLvBp1n22KuFJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMzbZ9bjA9AnS4gxmLNGDjq+EDQwjtfuQUXDILG/mAkKrb7CEhe0ntF4YsmX/jDy9ZAeMgigdJFy94jVOy5bYmvg168fbcAE5cdoqI9Bjb4CgFd02RzNpaMYtGsyd+J8WqtJny8JYMgEJrzsb5efI3CA0mrkbs0mFCru54kirb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se9bkRgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2BFC43399;
	Sun, 24 Mar 2024 23:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321963;
	bh=74kBJTUxv1Q4HgbcKWpYMeYUi0KuiFLvBp1n22KuFJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Se9bkRgjcslhztjaovvPXPhxO1Eb0A0vc9lwEXtRHhfl6pggZFHdHnmT8IJum4nOs
	 +obc9jlHyUtNeQx+/oAq1UQr+7vPvg2BOScer1WlCzqaOoSCxGiMSsX92XYHV1Md/H
	 UYfEKeZ3p57VaKBH3ML9kroa0P7v+yJE2A6VJWIkXY3UVaik7tGEsHfWZMc1lCm13g
	 EK8zX8/JUH5F2XzT3nOO8q0hQgkjwudZpfnT75hHk6yhdPD0sAmK0/apT6gDogMfPc
	 +d0e5d5xfiIeLvM1SkgYDW1RPeI3GzUjw/g5v1QW2ixzFqNBJQAEXtk9Pqgc9xoovd
	 5DzabkJ/MjtUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 035/451] net/iucv: fix the allocation size of iucv_path_table array
Date: Sun, 24 Mar 2024 19:05:11 -0400
Message-ID: <20240324231207.1351418-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index fc3fddeb6f36d..f66b5f74cd83a 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -156,7 +156,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
 static LIST_HEAD(iucv_handler_list);
 
 /*
- * iucv_path_table: an array of iucv_path structures.
+ * iucv_path_table: array of pointers to iucv_path structures.
  */
 static struct iucv_path **iucv_path_table;
 static unsigned long iucv_max_pathid;
@@ -544,7 +544,7 @@ static int iucv_enable(void)
 
 	cpus_read_lock();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
-- 
2.43.0


