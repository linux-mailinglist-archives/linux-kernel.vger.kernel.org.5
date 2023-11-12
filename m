Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51697E925A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjKLTqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjKLTqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:46:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C9B1BFF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:46:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2906DC433C7;
        Sun, 12 Nov 2023 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699818375;
        bh=3hLtCq4IeSzVAzt9xwdt8SFMTkOmxWIve71ZhjNphZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilsJm/vrsBo6Yu1ARBJXfw+m015LoFYGrGhL/3VpYDAsxMUdX9vYwdMYJDtgee/3r
         2BobP/nc2JGuXBqoYQqTNwcHNW5Ul9h5jQBXL8J9jNE/kU9f+YyP4IB3ucA1GKwMF/
         aVX7CwYjHhsScSiQ6bEPXWZXfsqDaxSSXIIamlhSeqRsvgt7urc/TcfeDoBssuSlIs
         5nsUjlIN3IEX+FEQIB4x0276ygds0KDvX8pHGguetiHuUDPLdMrlnI0JiCa8UY/bm7
         Hd5jdrzrPWfkBHm2Us92VOCJDsEJu9z7ez2YSTrZ29EZEOa9USrpWHji/+z1pjDsqj
         yaPQldDJREiJg==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/8] mm/damon/sysfs-schemes: implement a command for scheme quota goals only commit
Date:   Sun, 12 Nov 2023 19:46:03 +0000
Message-Id: <20231112194607.61399-5-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112194607.61399-1-sj@kernel.org>
References: <20231112194607.61399-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To update DAMOS quota goals, users need to enter 'commit' command to the
'state' file of the kdamond, which reads and commits not only the goals
but entire inputs.  It is inefficient.  Implement yet another 'state'
file input command for reading and committing only the scheme quota
goals, namely 'commit_schemes_quota_goals'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  3 +++
 mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
 mm/damon/sysfs.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 5ff081226e28..4c37a166eb81 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -56,3 +56,6 @@ int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
 int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
+
+void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 10d8678e48ea..273fb7862fce 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1888,6 +1888,22 @@ static void damos_sysfs_set_quota_score(
 	}
 }
 
+void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int i = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damon_sysfs_scheme *sysfs_scheme;
+
+		sysfs_scheme = sysfs_schemes->schemes_arr[i];
+		damos_sysfs_set_quota_score(sysfs_scheme->quotas->goals,
+				&scheme->quota);
+		i++;
+	}
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 2d31390edfc0..f6952cec9f19 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -994,6 +994,11 @@ enum damon_sysfs_cmd {
 	DAMON_SYSFS_CMD_OFF,
 	/* @DAMON_SYSFS_CMD_COMMIT: Update kdamond inputs. */
 	DAMON_SYSFS_CMD_COMMIT,
+	/*
+	 * @DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS: Commit the quota goals
+	 * to DAMON.
+	 */
+	DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS: Update scheme stats sysfs
 	 * files.
@@ -1025,6 +1030,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"on",
 	"off",
 	"commit",
+	"commit_schemes_quota_goals",
 	"update_schemes_stats",
 	"update_schemes_tried_bytes",
 	"update_schemes_tried_regions",
@@ -1351,6 +1357,24 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 			kdamond->contexts->contexts_arr[0]);
 }
 
+static int damon_sysfs_commit_schemes_quota_goals(
+		struct damon_sysfs_kdamond *sysfs_kdamond)
+{
+	struct damon_ctx *ctx;
+	struct damon_sysfs_context *sysfs_ctx;
+
+	if (!damon_sysfs_kdamond_running(sysfs_kdamond))
+		return -EINVAL;
+	/* TODO: Support multiple contexts per kdamond */
+	if (sysfs_kdamond->contexts->nr != 1)
+		return -EINVAL;
+
+	ctx = sysfs_kdamond->damon_ctx;
+	sysfs_ctx = sysfs_kdamond->contexts->contexts_arr[0];
+	damos_sysfs_set_quota_scores(sysfs_ctx->schemes, ctx);
+	return 0;
+}
+
 /*
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
  * @c:		The DAMON context of the callback.
@@ -1379,6 +1403,9 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active)
 	case DAMON_SYSFS_CMD_COMMIT:
 		err = damon_sysfs_commit_input(kdamond);
 		break;
+	case DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS:
+		err = damon_sysfs_commit_schemes_quota_goals(kdamond);
+		break;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES:
 		total_bytes_only = true;
 		fallthrough;
-- 
2.34.1

