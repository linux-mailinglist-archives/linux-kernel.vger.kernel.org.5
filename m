Return-Path: <linux-kernel+bounces-71884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2979085AC31
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF0D1C2174D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33EF535DF;
	Mon, 19 Feb 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmCv8hem"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C853387;
	Mon, 19 Feb 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371881; cv=none; b=HMoFCH7zIeQ4yGssXZhKzGR/fx7MxfbD8qQuPsdZN9pPr9AxIRj3ejqTypPhtFHDYjsFde2wxnru2Wv+QmvkEoCNhTi/1eHUn/t4TJ5nUPNd0jXk0NVxPJ9H0VsGYTBdXIaObgxbzK0Wny1Z9qKEEZQTqmhAnsrdy5FMG+q5KBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371881; c=relaxed/simple;
	bh=rzYXRY+0g/n7Kn4lIsgWKL7FZXy8S0J6qwcWKx/b2nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZD/ZosR/v+vzS35IeOV0NvOYRYkDTsaqv3ztLckLgjnu82j7KGJqLn43O0JsBVk5u7zAXbudsTN+mLOMjy5ZQWyL6jFEDLgrOrb8PdnbOII6ZfY2r8+QGeUW0cC15uP5F2yckzZ3V7nrCYIbN3S9s8ZrhHtydr5b7Pthf7G2x2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmCv8hem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41180C433B2;
	Mon, 19 Feb 2024 19:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371880;
	bh=rzYXRY+0g/n7Kn4lIsgWKL7FZXy8S0J6qwcWKx/b2nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmCv8hemCSNgYrpk0Ff5mzvIxAHJ3jIHrdLuTVvCYP2smFXiNdJFrxas2R7s6aMTD
	 VXDPpBUJN1p9KGnKN2lVRQ/qZxTQqQbnmdTl45LhAcXXZnWRkT/PWxRl/Rn7EXbTlx
	 tQg8ZSSuCxUKk8kMw17YYl0Tey2AkJGW2D6FtYmyx2TkXUvbs87nrMyKTfgLAUTq3m
	 HJcMUTNmM7XsPbJ5dVn9ZbBde4zoPcfekCrT886UNpCuAjstpOzlo8qqbu1WS0bXmF
	 Ho0ojO1mPVMNxv90T0GcCt6rjzs1y3XRdPEdSztpAHgGZ0bLTYY3rbpscgrkFAR+zj
	 D+AhW7SDqDk2A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] mm/damon/sysfs: implement a kdamond command for updating schemes' effective quotas
Date: Mon, 19 Feb 2024 11:44:14 -0800
Message-Id: <20240219194431.159606-4-sj@kernel.org>
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

Implement yet another kdamond 'state' file input command, namely
'update_schemes_effective_quotas'.  If it is written, the
'effective_bytes' files of the kdamond will be updated to provide the
current effective size quota of each scheme in bytes.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  4 ++++
 mm/damon/sysfs-schemes.c | 20 ++++++++++++++++++++
 mm/damon/sysfs.c         | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index ec0703e1e90b..5a1ac15fb2f8 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -61,3 +61,7 @@ int damon_sysfs_schemes_clear_regions(
 
 void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
+
+void damos_sysfs_update_effective_quotas(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index dd46b2db5455..9d90e7b757b7 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1930,6 +1930,26 @@ void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 	}
 }
 
+void damos_sysfs_update_effective_quotas(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int schemes_idx = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damon_sysfs_quotas *sysfs_quotas;
+
+		/* user could have removed the scheme sysfs dir */
+		if (schemes_idx >= sysfs_schemes->nr)
+			break;
+
+		sysfs_quotas =
+			sysfs_schemes->schemes_arr[schemes_idx++]->quotas;
+		sysfs_quotas->effective_sz = scheme->quota.esz;
+	}
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 678de97fcc88..cc2d88a901f4 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1019,6 +1019,11 @@ enum damon_sysfs_cmd {
 	 * regions
 	 */
 	DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS,
+	/*
+	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS: Update the
+	 * effective size quota of the scheme in bytes.
+	 */
+	DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS,
 	/*
 	 * @NR_DAMON_SYSFS_CMDS: Total number of DAMON sysfs commands.
 	 */
@@ -1035,6 +1040,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"update_schemes_tried_bytes",
 	"update_schemes_tried_regions",
 	"clear_schemes_tried_regions",
+	"update_schemes_effective_quotas",
 };
 
 /*
@@ -1375,6 +1381,29 @@ static int damon_sysfs_commit_schemes_quota_goals(
 	return 0;
 }
 
+/*
+ * damon_sysfs_upd_schemes_effective_quotas() - Update schemes effective quotas
+ * sysfs files.
+ * @kdamond:	The kobject wrapper that associated to the kdamond thread.
+ *
+ * This function reads the schemes' effective quotas of specific kdamond and
+ * update the related values for sysfs files.  This function should be called
+ * from DAMON callbacks while holding ``damon_syfs_lock``, to safely access the
+ * DAMON contexts-internal data and DAMON sysfs variables.
+ */
+static int damon_sysfs_upd_schemes_effective_quotas(
+		struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+
+	if (!ctx)
+		return -EINVAL;
+	damos_sysfs_update_effective_quotas(
+			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+	return 0;
+}
+
+
 /*
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
  * @c:		The DAMON context of the callback.
@@ -1437,6 +1466,9 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
 		err = damon_sysfs_clear_schemes_regions(kdamond);
 		break;
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
+		err = damon_sysfs_upd_schemes_effective_quotas(kdamond);
+		break;
 	default:
 		break;
 	}
-- 
2.39.2


