Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2D7F4944
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbjKVOr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjKVOr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:47:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAD4A1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:47:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C9EC433C8;
        Wed, 22 Nov 2023 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700664443;
        bh=2iDkyy2pYuw/tH7EYuXZS9rOXSZNR28XOlJHo6ZUDdc=;
        h=From:To:Cc:Subject:Date:From;
        b=QyTy7j7meGO9qKAr0c6GbSYsAbArXo04NjyVeodowq4Wn5GvYhRETi0lq5vrNTZqI
         XdYsY8wpQ4VSf271TevH3ZLCcu5jefHtGNfEIgpS3OJbCHTbSdUxojiWNmSYbU/r4A
         u970WvgT43UpiGEPX4Ux5LPdIqO2MKFHnHreNFW82QlSm9q5iwOu7p+/M5HB0/WDa3
         g+8S977gf0m/YP9yCfBqR91ASWZa8Wavlh2xRJsDv/BjwZ8aemRLN+LL8X8WgKTDA4
         8jbpgY1fWVZyJI+eksAFXIC0ax39/8zD2fOOB3NGakhfko0SXFODUtMjvWozAURLaG
         zJcUDCWoTUWgw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: sysfs: support discard_io_aware
Date:   Wed, 22 Nov 2023 22:47:15 +0800
Message-Id: <20231122144715.518256-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gives a way to enable/disable IO aware feature for background
discard, so that we can tune background discard more precisely
based on undiscard condition. e.g. force to disable IO aware if
there are large number of discard extents, and discard IO may
always be interrupted by frequent common IO.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/f2fs.h                          | 7 +++++++
 fs/f2fs/segment.c                       | 6 +++++-
 fs/f2fs/sysfs.c                         | 9 +++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 36c3cb547901..4f1d4e636d67 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -740,3 +740,9 @@ Description:	When compress cache is on, it controls cached page
 		If cached page percent exceed threshold, then deny caching compress page.
 		The value should be in range of (0, 100], by default it was initialized
 		as 20(%).
+
+What:		/sys/fs/f2fs/<disk>/discard_io_aware
+Date:		November 2023
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	It controls to enable/disable IO aware feature for background discard.
+		By default, the value is 1 which indicates IO aware is on.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9043cedfa12b..86a145be4e53 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -374,6 +374,12 @@ enum {
 	MAX_DPOLICY,
 };
 
+enum {
+	DPOLICY_IO_AWARE_DISABLE,	/* force to not be aware of IO */
+	DPOLICY_IO_AWARE_ENABLE,	/* force to be aware of IO */
+	DPOLICY_IO_AWARE_MAX,
+};
+
 struct discard_policy {
 	int type;			/* type of discard */
 	unsigned int min_interval;	/* used for candidates exist */
@@ -406,6 +412,7 @@ struct discard_cmd_control {
 	unsigned int discard_urgent_util;	/* utilization which issue discard proactively */
 	unsigned int discard_granularity;	/* discard granularity */
 	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
+	unsigned int discard_io_aware;		/* io_aware policy */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
 	unsigned int next_pos;			/* next discard position */
 	atomic_t issued_discard;		/* # of issued discard */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f4ffd64b44b2..08e2f44a1264 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1172,7 +1172,10 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 		dpolicy->min_interval = dcc->min_discard_issue_time;
 		dpolicy->mid_interval = dcc->mid_discard_issue_time;
 		dpolicy->max_interval = dcc->max_discard_issue_time;
-		dpolicy->io_aware = true;
+		if (dcc->discard_io_aware == DPOLICY_IO_AWARE_ENABLE)
+			dpolicy->io_aware = true;
+		else if (dcc->discard_io_aware == DPOLICY_IO_AWARE_DISABLE)
+			dpolicy->io_aware = false;
 		dpolicy->sync = false;
 		dpolicy->ordered = true;
 		if (utilization(sbi) > dcc->discard_urgent_util) {
@@ -2275,6 +2278,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->discard_io_aware_gran = MAX_PLIST_NUM;
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
+	dcc->discard_io_aware = DPOLICY_IO_AWARE_ENABLE;
 	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
 		dcc->discard_granularity = sbi->blocks_per_seg;
 	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 417fae96890f..7099ffa57299 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -516,6 +516,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "discard_io_aware")) {
+		if (t >= DPOLICY_IO_AWARE_MAX)
+			return -EINVAL;
+		*ui = t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "migration_granularity")) {
 		if (t == 0 || t > sbi->segs_per_sec)
 			return -EINVAL;
@@ -926,6 +933,7 @@ DCC_INFO_GENERAL_RW_ATTR(discard_io_aware_gran);
 DCC_INFO_GENERAL_RW_ATTR(discard_urgent_util);
 DCC_INFO_GENERAL_RW_ATTR(discard_granularity);
 DCC_INFO_GENERAL_RW_ATTR(max_ordered_discard);
+DCC_INFO_GENERAL_RW_ATTR(discard_io_aware);
 
 /* NM_INFO ATTR */
 NM_INFO_RW_ATTR(max_roll_forward_node_blocks, max_rf_node_blocks);
@@ -1074,6 +1082,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(discard_urgent_util),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(max_ordered_discard),
+	ATTR_LIST(discard_io_aware),
 	ATTR_LIST(pending_discard),
 	ATTR_LIST(gc_mode),
 	ATTR_LIST(ipu_policy),
-- 
2.40.1

