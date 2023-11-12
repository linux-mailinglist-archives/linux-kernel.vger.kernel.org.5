Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9727E90D4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjKLN2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjKLN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:28:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDD1478D;
        Sun, 12 Nov 2023 05:27:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5453BC433C9;
        Sun, 12 Nov 2023 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795664;
        bh=9vhBc7Fs6Y9lkJ1xg2BsEPs3oqHHcJRgomUXvGemPjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/iKHbV/wtENL7i+rst2HGAw+T7Ys+l/CpVGbeKVUh5u2eohjLyM7UqH4lP4r1Q5r
         wvcbuKaXYNBW+pLlHOODgb/A+woKxewp+StwaccXoGy3RSJrcdIokrG8iFCLqcyYKJ
         7YWptAaYoXDo+TmpqPdxt3pgkAVAcO3VsBPzvM7Sv0ilHk8sJx9F7U8qlD+HufaE57
         M8JBytB48+nvhkM6PhHIiQqrPNqA2yvNg+coyw19bsfk7olREnjdFQtaBTTFRpkIrI
         4uTTl1evuMyBZ6DIOkZAxiOgt3AV6U/32X6QNrLgwM4ygO5BaUH+8zH3OvbNy3cWeV
         uNGQIKxjFi6VA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, swhiteho@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 6.6 05/11] gfs2: fix an oops in gfs2_permission
Date:   Sun, 12 Nov 2023 08:27:28 -0500
Message-ID: <20231112132736.175494-5-sashal@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 0abd1557e21c617bd13fc18f7725fc6363c05913 ]

In RCU mode, we might race with gfs2_evict_inode(), which zeroes
->i_gl.  Freeing of the object it points to is RCU-delayed, so
if we manage to fetch the pointer before it's been replaced with
NULL, we are fine.  Check if we'd fetched NULL and treat that
as "bail out and tell the caller to get out of RCU mode".

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/inode.c | 11 +++++++++--
 fs/gfs2/super.c |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 0eac045079047..eb4bbe1728c06 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1868,14 +1868,21 @@ int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
 {
 	struct gfs2_inode *ip;
 	struct gfs2_holder i_gh;
+	struct gfs2_glock *gl;
 	int error;
 
 	gfs2_holder_mark_uninitialized(&i_gh);
 	ip = GFS2_I(inode);
-	if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
+	gl = rcu_dereference(ip->i_gl);
+	if (unlikely(!gl)) {
+		/* inode is getting torn down, must be RCU mode */
+		WARN_ON_ONCE(!(mask & MAY_NOT_BLOCK));
+		return -ECHILD;
+        }
+	if (gfs2_glock_is_locked_by_me(gl) == NULL) {
 		if (mask & MAY_NOT_BLOCK)
 			return -ECHILD;
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
 		if (error)
 			return error;
 	}
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 02d93da21b2b0..0dd5641990b90 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1550,7 +1550,7 @@ static void gfs2_evict_inode(struct inode *inode)
 		wait_on_bit_io(&ip->i_flags, GIF_GLOP_PENDING, TASK_UNINTERRUPTIBLE);
 		gfs2_glock_add_to_lru(ip->i_gl);
 		gfs2_glock_put_eventually(ip->i_gl);
-		ip->i_gl = NULL;
+		rcu_assign_pointer(ip->i_gl, NULL);
 	}
 }
 
-- 
2.42.0

