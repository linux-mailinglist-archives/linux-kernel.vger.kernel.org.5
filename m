Return-Path: <linux-kernel+bounces-115594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8AE8896D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9200B2D168
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF477251198;
	Mon, 25 Mar 2024 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj2iaNlD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044CE1FB711;
	Sun, 24 Mar 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321307; cv=none; b=IJRwDdDQSzEmdQW6QpwiAkvsId5eMyhv5rQLdZFeXFjMdRldCamq3rLtaDR19SkMvIgZ5B/Nup6sNSQZskwozVL21yCFysnroGflxznI/sc69/eU001NF5AmQQXpg+h8Vecw5ykk6U1Zqq8cRg+/5PKn5xdZf3ZbOdBaueiZ/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321307; c=relaxed/simple;
	bh=74kBJTUxv1Q4HgbcKWpYMeYUi0KuiFLvBp1n22KuFJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoYZHeA7L31hdygopoiihcV1b2oZ4X5MyhPv4tz/QLEm+mWdIhY8TNqvdnakz63ag+fSbgjuEvUv2TAPoYIpIO0EjAFqahyOPQV4SfdZBDswHTczsKsOQB5xkduXWTd0OAVAJGkFMr2hA8Yi/7DwZX9UZ6uqEzFInDPiwNAloQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj2iaNlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D429AC433C7;
	Sun, 24 Mar 2024 23:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321306;
	bh=74kBJTUxv1Q4HgbcKWpYMeYUi0KuiFLvBp1n22KuFJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sj2iaNlDZFeJT3jT66ppwvepPePxrw4F/qxUz0yboGgGElS3AKaDWv1fXNwcK06Gf
	 p3nAFM6YN1+4Ds1xBI9DO3ONI259WfY0QJEvp/zbQwA82G1/RtCa/ZRPvVA/SWQwkg
	 jqUu0ACYx2Rftl2uP8fYQP06htHoXzFKr+5Dc5KcPP4bXY4iJe6kcy7kSug04183I3
	 GcO27dNdcZfDAdlB5GHGNrk1d5VNCP3DldjF6pYYKqGsjPZXUCIHm23FaqBlaJP4rj
	 2V6OSQdx+dYk0OMh+yAvAyet0GlRGVPycBBTKzVHdeaiSkeAvWHv0AsHNtMHTVUGCp
	 vguDFYmbANm7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 029/638] net/iucv: fix the allocation size of iucv_path_table array
Date: Sun, 24 Mar 2024 18:51:06 -0400
Message-ID: <20240324230116.1348576-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


