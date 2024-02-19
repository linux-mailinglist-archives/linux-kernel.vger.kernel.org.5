Return-Path: <linux-kernel+bounces-71901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FE285AC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812581F224AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173275BAE3;
	Mon, 19 Feb 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml2xbaVH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5B5B5DE;
	Mon, 19 Feb 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371890; cv=none; b=ShGrz1f6pQv5NvbOuZsls70kl/po+PGwqbDY03aJn3bpXe5kKMuiHbkgDKhkKpYXJiZRGKfTTsdR5n4wZ3PGZSKS8FGdGTmZXad97v7VA32zgg5Yxo2zvYQxVK97V5gDl3j4R4L7WdjLplZosGUIo18HTCBR81a5zGULYJ8LnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371890; c=relaxed/simple;
	bh=tG3S12R9lWJQ+3nlob/l1OneJpRLcwIKt8aIF6Enn4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pS3tZD9Gt7h3oPFKhI5Hz+RD/9AXMdzVTYNBsXDafOeLDlOJxPO2zhOz2PAHLIe6xTvoGWLsuY0KEdY32pkO7z4w0p/MIy2NQ471luQELczPeaIFn8PLjhKGxAGYvHVoRbqyWuj5BLjvpdalnnJvqCUJ+XFYYAvwdOQokNptdh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml2xbaVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78DEC43390;
	Mon, 19 Feb 2024 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371890;
	bh=tG3S12R9lWJQ+3nlob/l1OneJpRLcwIKt8aIF6Enn4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ml2xbaVHRr850LD2Xo3UE5RqNzk6jup3abKGVZsJufjCxh4FJL1I8ZLvAZQoyItue
	 HsySrTPrtzqdevNi77IFL3ZvmPJis7apE/tV6U6QtXX2SNDv5FT/sKqi2/hKWVjzoe
	 gdoaRsNbvsNuyUEd4Lq3oJ5reSR7mh+S046aZHsPibxoaN4WpBJaxV5l/AHDuPka7n
	 HQ2YIwBqI3s/axquI4sbDmMIpgQRcTMt9Ac6Ol1oXPTRv/6lWDDkUuFj/3whWZSJmf
	 hHiEKQnRplZQhMflDZlQr8UmQs0rNWwf6LwEEx3x0UJg11hlIUZCbjrkPrqcf9wZES
	 /bSAM8OTHrttw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] mm/damon/reclaim: implement memory PSI-driven quota self-tuning
Date: Mon, 19 Feb 2024 11:44:30 -0800
Message-Id: <20240219194431.159606-20-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219194431.159606-1-sj@kernel.org>
References: <20240219194431.159606-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the PSI-driven quota self-tuning from DAMON_RECLAIM by
introducing yet another parameter, 'quota_mem_pressure_us'.  Users can
set the desired amount of memory pressure stall time per each quota
reset interval using the parameter.  Then DAMON_RECLAIM monitor the
memory pressure stall time, specifically system-wide memory 'some' PSI
value that increased during the given time interval, and self-tune the
quota using the DAMOS core logic.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 9df6b8819998..9bd341d62b4c 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -62,6 +62,21 @@ static struct damos_quota damon_reclaim_quota = {
 };
 DEFINE_DAMON_MODULES_DAMOS_QUOTAS(damon_reclaim_quota);
 
+/*
+ * Desired level of memory pressure-stall time in microseconds.
+ *
+ * While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
+ * increases and decreases the effective level of the quota aiming this level of
+ * memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
+ * per quota reset interval (``quota_reset_interval_ms``) is collected and
+ * compared to this value to see if the aim is satisfied.  Value zero means
+ * disabling this auto-tuning feature.
+ *
+ * Disabled by default.
+ */
+static unsigned long quota_mem_pressure_us __read_mostly;
+module_param(quota_mem_pressure_us, ulong, 0600);
+
 /*
  * User-specifiable feedback for auto-tuning of the effective quota.
  *
@@ -198,6 +213,16 @@ static int damon_reclaim_apply_parameters(void)
 					&old_scheme->quota);
 	}
 
+	if (quota_mem_pressure_us) {
+		goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
+				quota_mem_pressure_us);
+		if (!goal) {
+			damon_destroy_scheme(scheme);
+			return -ENOMEM;
+		}
+		damos_add_quota_goal(&scheme->quota, goal);
+	}
+
 	if (quota_autotune_feedback) {
 		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
 		if (!goal) {
-- 
2.39.2


