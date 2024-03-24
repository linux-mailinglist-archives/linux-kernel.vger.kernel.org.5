Return-Path: <linux-kernel+bounces-116007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0241889562
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EDE297E36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE13179953;
	Mon, 25 Mar 2024 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR8vMK08"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3E2733C2;
	Sun, 24 Mar 2024 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323318; cv=none; b=BELR5ODsVDnZiWG0UmDvXCoMyMYaUm3wLMZMiNHLnqhFXmERx9NtetaSVmcj7dPdNuFLzdtNnAYdRV1wFVfi1o+UCWLn1pFw+HvHAPsCskwoncUZID1Jscu0cNE8twW3prmV29MIBT3lUBxb7DoDIunQ9yjT1ODLXHshdu2OD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323318; c=relaxed/simple;
	bh=+L8wkVGdqLlELuYmKWeEuKakPfIif0WoiIE0dd9miA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epwfl1eT1qwSGF8xfejYCTU+A3N93lFz8i22kTSk4c8ohU9UHNtA5d9ST270rz0A36tQDzwBvMV4xuk7ZHQhz6/UACeIK/DpqgNKxlgGeNhL2bzjdIoc6eeDoaP9NK7xeVzqdbmb4BIVGx8ArCMc0Ptg6IKHPA1Te39KafUXE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR8vMK08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92400C433F1;
	Sun, 24 Mar 2024 23:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323317;
	bh=+L8wkVGdqLlELuYmKWeEuKakPfIif0WoiIE0dd9miA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bR8vMK08NPVGNXchIRoUgrNDdGbl30bvh16ODIfdboM3ZlJeQZeb4d7RgX6bXCzgW
	 lS4gux5Fj8/mUcWyDGeNbCURE9JwH2Lfbn18wokDJFCsx9fVHVY45gm1LMUso/8GTI
	 2EnLN+KPnUo7oYmAzbntOtR1AE1IQnlmpZ66GyYbE/XojD1RkFELuvl202oPkHrAjF
	 Do7em8huShpIYvoaeFGtBy92S8kSH0lg0E2ZAbgmnca7C/+wJpq+tgpeBiBtWWfLrp
	 CWcEWUlFufDd70x8QP30YaPyEQHVXgIzI4Y7BOnCYGlUJsSicpef5gsaVwizEBDdSr
	 l4kH3kmeh+kOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 017/317] net/iucv: fix the allocation size of iucv_path_table array
Date: Sun, 24 Mar 2024 19:29:57 -0400
Message-ID: <20240324233458.1352854-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


