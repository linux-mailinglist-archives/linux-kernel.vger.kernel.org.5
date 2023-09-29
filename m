Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0454C7B2B13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjI2FOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2FOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:14:37 -0400
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567EE195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1695964460; bh=5TrBxRkf8axAboRq5eJan1h4q+4K8csemq/WK/VP9ZA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=do/G6q9r/tlorBmTdac9FvUvIjtHyBXdJqg2ExEi6A3UgQ2kL1IuO8CIXkKPo4iVv
         0Ih7El6ezPjRTCOtJ5bZol3iNCoIpDlBsXxUhxqGuqjI79z3y1UB08uD8TRI0/fOOW
         UCai0Mi8pDHABqMbn1jj8VaW/OBcdNEVXteTkniQ=
Received: by b221-5.in.mailobj.net [192.168.90.25] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Fri, 29 Sep 2023 07:14:20 +0200 (CEST)
X-EA-Auth: tVqjOmq4lkR80hgPN1Q6rvpztdtUdTqm+kt5z3NoCdz7P1X7GYld++tOOVSzXEg4yFVPF8nuORj/+y7BiDt+O1Bd4GglWdfR
Date:   Fri, 29 Sep 2023 10:44:16 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <error27@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] gfs2: No need to be "extern" at the time of definition
Message-ID: <ZRZdKAmDjrpCQLwE@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to for the extern keyword at the time of function definition.
Remove it to silence the following Smatch warnings:
fs/gfs2/super.c:1579:13: warning: function 'free_local_statfs_inodes' with external linkage has definition
fs/gfs2/super.c:1594:21: warning: function 'find_local_statfs_inode' with external linkage has definition

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 fs/gfs2/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 02d93da21b2b..fad36ed89853 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1576,7 +1576,7 @@ static void gfs2_free_inode(struct inode *inode)
 	kmem_cache_free(gfs2_inode_cachep, GFS2_I(inode));
 }

-extern void free_local_statfs_inodes(struct gfs2_sbd *sdp)
+void free_local_statfs_inodes(struct gfs2_sbd *sdp)
 {
 	struct local_statfs_inode *lsi, *safe;

@@ -1591,8 +1591,7 @@ extern void free_local_statfs_inodes(struct gfs2_sbd *sdp)
 	}
 }

-extern struct inode *find_local_statfs_inode(struct gfs2_sbd *sdp,
-					     unsigned int index)
+struct inode *find_local_statfs_inode(struct gfs2_sbd *sdp, unsigned int index)
 {
 	struct local_statfs_inode *lsi;

--
2.39.2



