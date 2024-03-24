Return-Path: <linux-kernel+bounces-116120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0A8896BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F50D2882A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0413ABE8F;
	Mon, 25 Mar 2024 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVvXBWys"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D417967F;
	Sun, 24 Mar 2024 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323645; cv=none; b=MjVvE0LmlC2s/ELXjOJhWXletWlqJszKbOrM1rvtVSxaagshspANU9+osKo1VNRcS4WxRg2xzSPuKzfeLMdFhZCKZD+UuCtSm95Xr5oiWauRdAoCQ0UoQmGJGa59XRSQvvJXrZ6wmZLWJsX8fWBa0LLPTlvHkBSWX5+bCtCtaEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323645; c=relaxed/simple;
	bh=/+JbcQspYtn1cfE7npVm5z6VSjqlZ5+MhDIb1KgxOJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTTkv0vLVUvNA4e7riS7lbuv2kRdff9lEvhRRQcW8pllVHAV2RAhxmrz3mVxADi0jzAqxzFLhvVdStaXIUkEud6n9BKKGj05cHkmJ8unCKxpiorVcwZXy8PMwGD7dDlPLOLHnvKP3vcKO1CRLoq9iKA3yU2FxTKkqLzp4Lu1ecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVvXBWys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D17C43399;
	Sun, 24 Mar 2024 23:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323645;
	bh=/+JbcQspYtn1cfE7npVm5z6VSjqlZ5+MhDIb1KgxOJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVvXBWysHVCmnjORrhPtsPlGZ5e4DgWatojRcitez5bo9f9XKIuNfmgHOmFevTIK3
	 bzfrfGeEOFdPx0XrRquGRiPuFu04BKb+CHqS5u2bmXaiuDZ23GlfzG+LTGv08jzzxM
	 OcwQxcoeoHeSfEtRVo6CR1pq5vqaHk4qH2QhoTX3jnsQF3S1KAyIZ/SgArvg6h5bjW
	 xBQQ2RJ+dMOIILg9XZz+FL6Ca4Ws/Hsf/5JA5oNOySKQWxbsHIyjuVGTE5/8cT2IlK
	 6m9wavPD//Vi95oXQ1NvDYTYhRg/fwOJYuYFiYKttorOdhcyG1ZC0VSJAWNwHKvFTJ
	 FICoFq97AXC6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 016/238] net/iucv: fix the allocation size of iucv_path_table array
Date: Sun, 24 Mar 2024 19:36:44 -0400
Message-ID: <20240324234027.1354210-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 6f84978a77265..ed0dbdbba4d94 100644
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
@@ -542,7 +542,7 @@ static int iucv_enable(void)
 
 	get_online_cpus();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
-- 
2.43.0


