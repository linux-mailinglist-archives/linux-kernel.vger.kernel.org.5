Return-Path: <linux-kernel+bounces-87510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D324386D550
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80145B27DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9475D169E08;
	Thu, 29 Feb 2024 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHcJRa89"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF116A375;
	Thu, 29 Feb 2024 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239299; cv=none; b=YgyybDJgUkDiHK+vaDZsjcIUVjLX2kLJcb+0jA4QL+/7dk2xM3NZty3FA74AJac+hPmovlFKRBzaYUGkqAQUN0nsWTZEy8xQ7Id4EeDD7csdaLJesJfHOsjoosWaOpTcoupIDT9EH4w9RH2t4W+pXwms+IcpsqoF0f0XaMo4uzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239299; c=relaxed/simple;
	bh=/+JbcQspYtn1cfE7npVm5z6VSjqlZ5+MhDIb1KgxOJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFAHKFR6GXwlY6OirN93zr7LH/yda10GVWTCfC/0Cvov6wao4oNJuAOBDmS1ZnKO/Klkh3Jb0oKr4jQ48heCycC/yVWHSmbiv6btn+EqPjnXmJ+6RLyX9K0Pb1tXdxerKRhuZjhKRyfO1KOzDlJ621FjAvOI0ttdR+2hoZRLcgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHcJRa89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2927DC43330;
	Thu, 29 Feb 2024 20:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239299;
	bh=/+JbcQspYtn1cfE7npVm5z6VSjqlZ5+MhDIb1KgxOJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHcJRa89sa/JNhV1RtNgILyhebxnCYZUr9pXoU7umhFKgL/5R9EiTSVqtWeB0yKhn
	 a0E61/XrwpNupKhURnh55WzQXnUjKKblkXcfMklXB3W5vTNtdrupTU6zlbr+vSRPyv
	 cqyot7ym71EC3gdGj5u9K+MOrOUtJhL/ZbipGwabAZYLTb9Y4lX0BH7pJtFFWGPko/
	 bMolewgUAVQGSBRFpUPLuHnj4QMhrCJgUHS/0SDW+JrVpU/UCrnbl8HGC1aoJd4qpW
	 tuRcW1Irv/VpnQ5F0T89M62GrxduGl6mKr2zk4ks8ow/usAnKThdwwD2nYlBlqhJw5
	 5CufV9aRNAkZA==
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
Subject: [PATCH AUTOSEL 5.10 5/8] net/iucv: fix the allocation size of iucv_path_table array
Date: Thu, 29 Feb 2024 15:41:22 -0500
Message-ID: <20240229204127.2861980-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204127.2861980-1-sashal@kernel.org>
References: <20240229204127.2861980-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
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


