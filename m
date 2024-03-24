Return-Path: <linux-kernel+bounces-115281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7888954B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09FDB21498
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216215E7ED;
	Mon, 25 Mar 2024 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUhC2F1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689CD7F7C1;
	Sun, 24 Mar 2024 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320475; cv=none; b=EUpTh+JUT86OlN6vYhW7BX5XG/9zJbJ+Xux3LcxeGf2S2ptd3eYQU9zy2j1mWeZ4trTOf5cNva+4ZVNCdR7R0EQKDYxKClxEhjYyitfkBXomuR6uc/1HXoB6U/0MFvzRJ1fOnbYtyZiOi1FHFbVBCssynTAb3MdopyV8QJrmiO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320475; c=relaxed/simple;
	bh=I+EymkwU1C2leoNdI8aU2Kcpdiz2ujgLAG0SkJyGVXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQDEhhV6kFA5gCO7nQzJi8LooqzIWW0xLJuBTzzQ1k/dY6EzFvyQaFceUnuAJEGJPJ2/9LksGHWpnDVmdIVb5kAuZo9JiE2SFJt6fVr5/ZcndLF6scVFK89o8pIK0lehAvGRgjXrITOwqm6dpmHJOou+yPIRcVGpdieOpZH1J2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUhC2F1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93487C43390;
	Sun, 24 Mar 2024 22:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320475;
	bh=I+EymkwU1C2leoNdI8aU2Kcpdiz2ujgLAG0SkJyGVXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUhC2F1hSNXsNyDCjrTeM/aFogIzRir8MyknXzrFSBh2uvIy0BvphDdRaHNKDOiXf
	 b/PVIy93N6rs+U2fU27NCl5FM/Aoe0ZJLdrrDYTL2LNDSYXwBceqErMEja9Gv8tDGv
	 HGK/vQon6t+bnNr+YJrK6wsPPtncd9Wqlym+oDEAJKZfxlFhNh8d1Qc35gXIbYRiPZ
	 Uk9qGWUoObV3u1omJrsm1fYE4tNuw292Q2SIsDVzWFlKeb1kFHISoHW/gqQER+yOA9
	 3xkzFB/NXu3EN4C/HlQVxL1BCeXKeRCy8Fhg07PWVnl6OgSH55kX6t/64+af6VwKLJ
	 XVpdGMHy3Lvmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 034/713] net/iucv: fix the allocation size of iucv_path_table array
Date: Sun, 24 Mar 2024 18:36:00 -0400
Message-ID: <20240324224720.1345309-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 0ed6e34d6edd1..ce33adb65afb0 100644
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


