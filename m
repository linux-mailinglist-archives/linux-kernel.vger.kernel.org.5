Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0CA75E8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGXBpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjGXBnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD6659C9;
        Sun, 23 Jul 2023 18:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B048661005;
        Mon, 24 Jul 2023 01:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3810DC433CD;
        Mon, 24 Jul 2023 01:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162421;
        bh=+RocHvnNFJlIRiCk08j1lWI2RgriEuuhPAOcAf/E5Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRX4HYoMHHJVejSdjCETw635S+e6TxbNGcVt2iVl9igFFU3w0MyU6JYk6FJvM7cij
         hrEMENXTBLrQ2cQzlZXsoLrioftwUmXQ1d/UItlc94ZL8K42qo3uwG1PaZ5Mk+juKO
         h4iGXlHFfaZx9RXAXNHbbL6KpmIq5CkAhR+k+DfzzTiEwgxv+qfcaMUoNVPUxG6voH
         qtqkP0VaIQ13n7fyiAEsmGFUDXDUR5QutbA3hUHy2JfCZljmHC9G3XTjOqPjnLHhKR
         claTUm5P9V3PRHfnljk4Z2fokcMoL75L57NeHNv/VXg5AoUGybwqoj/W4RMBx6HmSq
         HdRpf4L0Lp78w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tuo Li <islituo@gmail.com>, BassCheck <bass@buaa.edu.cn>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, swhiteho@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.15 10/24] gfs2: Fix possible data races in gfs2_show_options()
Date:   Sun, 23 Jul 2023 21:33:11 -0400
Message-Id: <20230724013325.2332084-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013325.2332084-1-sashal@kernel.org>
References: <20230724013325.2332084-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tuo Li <islituo@gmail.com>

[ Upstream commit 6fa0a72cbbe45db4ed967a51f9e6f4e3afe61d20 ]

Some fields such as gt_logd_secs of the struct gfs2_tune are accessed
without holding the lock gt_spin in gfs2_show_options():

  val = sdp->sd_tune.gt_logd_secs;
  if (val != 30)
    seq_printf(s, ",commit=%d", val);

And thus can cause data races when gfs2_show_options() and other functions
such as gfs2_reconfigure() are concurrently executed:

  spin_lock(&gt->gt_spin);
  gt->gt_logd_secs = newargs->ar_commit;

To fix these possible data races, the lock sdp->sd_tune.gt_spin is
acquired before accessing the fields of gfs2_tune and released after these
accesses.

Further changes by Andreas:

- Don't hold the spin lock over the seq_printf operations.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index ca6ee1cbccd50..51b44da4a0d64 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -980,7 +980,14 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 {
 	struct gfs2_sbd *sdp = root->d_sb->s_fs_info;
 	struct gfs2_args *args = &sdp->sd_args;
-	int val;
+	unsigned int logd_secs, statfs_slow, statfs_quantum, quota_quantum;
+
+	spin_lock(&sdp->sd_tune.gt_spin);
+	logd_secs = sdp->sd_tune.gt_logd_secs;
+	quota_quantum = sdp->sd_tune.gt_quota_quantum;
+	statfs_quantum = sdp->sd_tune.gt_statfs_quantum;
+	statfs_slow = sdp->sd_tune.gt_statfs_slow;
+	spin_unlock(&sdp->sd_tune.gt_spin);
 
 	if (is_ancestor(root, sdp->sd_master_dir))
 		seq_puts(s, ",meta");
@@ -1035,17 +1042,14 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 	}
 	if (args->ar_discard)
 		seq_puts(s, ",discard");
-	val = sdp->sd_tune.gt_logd_secs;
-	if (val != 30)
-		seq_printf(s, ",commit=%d", val);
-	val = sdp->sd_tune.gt_statfs_quantum;
-	if (val != 30)
-		seq_printf(s, ",statfs_quantum=%d", val);
-	else if (sdp->sd_tune.gt_statfs_slow)
+	if (logd_secs != 30)
+		seq_printf(s, ",commit=%d", logd_secs);
+	if (statfs_quantum != 30)
+		seq_printf(s, ",statfs_quantum=%d", statfs_quantum);
+	else if (statfs_slow)
 		seq_puts(s, ",statfs_quantum=0");
-	val = sdp->sd_tune.gt_quota_quantum;
-	if (val != 60)
-		seq_printf(s, ",quota_quantum=%d", val);
+	if (quota_quantum != 60)
+		seq_printf(s, ",quota_quantum=%d", quota_quantum);
 	if (args->ar_statfs_percent)
 		seq_printf(s, ",statfs_percent=%d", args->ar_statfs_percent);
 	if (args->ar_errors != GFS2_ERRORS_DEFAULT) {
-- 
2.39.2

