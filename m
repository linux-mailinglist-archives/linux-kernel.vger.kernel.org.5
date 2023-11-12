Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742737E90B3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjKLN3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjKLN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:28:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4B44BD;
        Sun, 12 Nov 2023 05:27:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB24EC433C9;
        Sun, 12 Nov 2023 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795672;
        bh=OQcedTAkLfa3WK98xTKXsrs1ITYYrTmtA2kDvbGrQ74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USs2p/LMyddVIkwdUZbjxZ9q6XZI0v7s5TPpHBRbkNuqi4HOSOxcz1TdbJky3QcM8
         nJTP3wWbn225yLg/CBDEIzn7RN5sfVat2TlS5mKdjLgUdD7Szsz2qTzbtf2mF7PSVO
         R1z9za0yKB7KaMdgE4YF8utVNVnrPy7A5BZR5HwVjjhLZOqUXjPMOiI0oLXV8R5zRt
         gfwTue2dV7phgcZo7TfWPy5u5tXf5fNHCznfBXHhLK1kv5n16lESxN8ygYjacTbUsY
         rA8fBcf5ZbVjdv/0u3NJpCPJawZH1pvcVhbaVMcpHjpLjApH272MlvxNmzuvrFTL/a
         77r1Qpc8kTZdQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juntong Deng <juntong.deng@outlook.com>,
        syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, swhiteho@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 6.6 11/11] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date:   Sun, 12 Nov 2023 08:27:34 -0500
Message-ID: <20231112132736.175494-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132736.175494-1-sashal@kernel.org>
References: <20231112132736.175494-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juntong Deng <juntong.deng@outlook.com>

[ Upstream commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37 ]

In gfs2_put_super(), whether withdrawn or not, the quota should
be cleaned up by gfs2_quota_cleanup().

Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
callback) has run for all gfs2_quota_data objects, resulting in
use-after-free.

Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
gfs2_make_fs_ro(), there is no need to call them again.

Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 0dd5641990b90..5f4ebe279aaae 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -602,13 +602,15 @@ static void gfs2_put_super(struct super_block *sb)
 	}
 	spin_unlock(&sdp->sd_jindex_spin);
 
-	if (!sb_rdonly(sb)) {
+	if (!sb_rdonly(sb))
 		gfs2_make_fs_ro(sdp);
-	}
-	if (gfs2_withdrawn(sdp)) {
-		gfs2_destroy_threads(sdp);
+	else {
+		if (gfs2_withdrawn(sdp))
+			gfs2_destroy_threads(sdp);
+
 		gfs2_quota_cleanup(sdp);
 	}
+
 	WARN_ON(gfs2_withdrawing(sdp));
 
 	/*  At this point, we're through modifying the disk  */
-- 
2.42.0

