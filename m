Return-Path: <linux-kernel+bounces-87501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2A686D535
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08691281C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B51509BC;
	Thu, 29 Feb 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OndRqQVv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A1165911;
	Thu, 29 Feb 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239279; cv=none; b=V/dN54QJPwsIn83Lpb/QMKobjDfNivnwtiqSmI3mPhyxMsIMGhPtect1xPrl4lIyIzQa3/JHmP+Hg+cZs5j2i9W/K7z4Ya4dXCwVE5AWx4dAgVcGE0cwo0Q95wq4x4rVJ0zDq3i2cXj1QHuX1ontoVbcRkENxyWRsZdP1oSE4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239279; c=relaxed/simple;
	bh=+L8wkVGdqLlELuYmKWeEuKakPfIif0WoiIE0dd9miA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbmKrrYRJzQstp3UTX/6cXKhiyN/BOkuxoB/rYIMtNhkWT9LTF5wHMPg34KXLZjCYHtsCQqYf54DQqwvvmNGKaTt4i6g7VdvDXKYQhNtq4OrYfKV0J0HKOJu8FN14fGTC7xuVpirjhM3+CoS+/Kj9aRr0GKKEdb0quV6KnIsp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OndRqQVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE65EC43399;
	Thu, 29 Feb 2024 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239279;
	bh=+L8wkVGdqLlELuYmKWeEuKakPfIif0WoiIE0dd9miA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OndRqQVvlze3x1yuDANXwUWxTwq6IFtU6SXWL/ECRq1h9VVGuzQLwWWszlAjBoYRA
	 qLS9BNjVfaoTMB4rF3Xu8uILPeOd3v9m95RAUs/+ZJo5LKm2aqhfR1BfTYgJDsFlXR
	 YISNRR0C8R5JCGQ9FnbEH6NA70TyhLSsl+5JVwob1Q7C7jBXHcUdveDq3bFwkfhY1d
	 gix2PYvAnMrhI8K8HlNpSD38JhT5snQ0CQjF9nH84VEu6nTXUPdvLKo3q1dTO5faPS
	 vFAcVz6fQSVBDBzuHwEaHt38dosY2FqG/DJIMSQvRhjPcFplHGYSu9i8+tX79zxczF
	 69105rmcztyzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	twinkler@linux.ibm.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/9] net/iucv: fix the allocation size of iucv_path_table array
Date: Thu, 29 Feb 2024 15:41:02 -0500
Message-ID: <20240229204107.2861780-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204107.2861780-1-sashal@kernel.org>
References: <20240229204107.2861780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
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
index 8efc369934fc7..68edefed79f16 100644
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


