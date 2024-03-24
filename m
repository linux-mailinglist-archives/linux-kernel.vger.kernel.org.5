Return-Path: <linux-kernel+bounces-115163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68857888DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D55B341AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB88305DEB;
	Mon, 25 Mar 2024 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE90f+GV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105551836C9;
	Sun, 24 Mar 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324222; cv=none; b=uVSktg+/pePFvlgVIOqEXKj0j7pSCaQSTGCM96YR/4HIY5QnbF85TeJlhUpvZoWmUPTwRoHr9IK125x3+VxwRLQL+gEkonT5jzUzmStrg/4sSMwNhgiFVbHIbboQI/J5IO7uLoYnkKLzkBpKjp5b0/Pgf1Ys3zkIWu8/o8b/Yyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324222; c=relaxed/simple;
	bh=1jDYd53jim3o+DnL/gcsQfkGwzdeqRP4MNNLaXnXoPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0btKCZAvyxrqiUkIRRz3CYEq8/nHvvpFS9mzv4f65rwfIxDUi59bf8nGVvfBrLSqUxMpoH8KgjengahFff+YiAM2D/uL6KK6zsilX7iAqW/SbJ1JcTNwk7pNkfpeoPB3kpsKIBldPoJRyCbho1GfWx8bK0gAhMGY8OPDjW9guM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE90f+GV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EFAC433C7;
	Sun, 24 Mar 2024 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324220;
	bh=1jDYd53jim3o+DnL/gcsQfkGwzdeqRP4MNNLaXnXoPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eE90f+GVztFPnhnvyxNuiScDGmZ7CuSJztlUZSUnhlRLmYLlMnb+KAL8xMetCs8Uj
	 hoY5d1Pumcr+AAV9YN0JvKm6kyHgom0NK4oswFL3ykuKjpwa5nlkSe6IbNL+dwdgq+
	 2KmsJAUQ87VAoQwomFx1e5HuiEmJAR0anAIg7Dtj+e18YG604MsM8xu8ToGDCHU9R3
	 OlorhczTcT6h3HU4rNUlImuEhi6Cy2EoZyO+ghz0hoTZeJqO2e374CmSjjQ9XhIrRN
	 E6Ls2MjJ//hkxqIfNKJ/pv53n8Z59w/43WL3ZDdOmp/7CUst4q2U3UUOMDNTATcjjv
	 T41sE7iy5Aivw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 004/148] net/iucv: fix the allocation size of iucv_path_table array
Date: Sun, 24 Mar 2024 19:47:48 -0400
Message-ID: <20240324235012.1356413-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index aacaa5119b456..da4cee91fc63d 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -192,7 +192,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
 static LIST_HEAD(iucv_handler_list);
 
 /*
- * iucv_path_table: an array of iucv_path structures.
+ * iucv_path_table: array of pointers to iucv_path structures.
  */
 static struct iucv_path **iucv_path_table;
 static unsigned long iucv_max_pathid;
@@ -603,7 +603,7 @@ static int iucv_enable(void)
 
 	get_online_cpus();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
-- 
2.43.0


