Return-Path: <linux-kernel+bounces-19754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 568778272D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D5928107D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BADD53810;
	Mon,  8 Jan 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8W5ldSG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6911537FF;
	Mon,  8 Jan 2024 15:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AD5C433CB;
	Mon,  8 Jan 2024 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727115;
	bh=JAXtta6eBaQuUW49iLcF5j0hoJdzALXBq37p3uzPtxo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G8W5ldSGTcXe1wI85QiNk/R4Nt5M91jkwxAgBe7JJWfQVHEnkgQGFTbv6dOrakM5w
	 gc9ZTQ75jGGpTENuwGqaq7ouk57FJdGulSMQHIBlQwpo1CSQmQDvlkyVT5WqMesilS
	 k3SuOPvJNU7DOgq8jXIxtfQYV/XYoZ1/d4dRLvLhReGCi3M+OKBfdC3wlgJF+quFi3
	 L/86jSQk+SAMPcRpB82COCFopTbp/0SrP6l2Dbn+FCUcdI6n9ReBoE7c3eDGnIGCQf
	 YpLNhI9nUhjrENtUo5gQo7W0CT+ug7ZUwKnY3F1InrYA8ZVYUzMp7gQXpiRn99cCOZ
	 pO66HJ+wrohgw==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 08 Jan 2024 15:18:24 +0000
Subject: [PATCH v2 8/8] fs/9p: fix dups even in uncached mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ericvh-fix-cache-dups-v2-8-a73f8822838c@kernel.org>
References: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
In-Reply-To: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=JAXtta6eBaQuUW49iLcF5j0hoJdzALXBq37p3uzPtxo=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnBJDMKN7uTDozbiBwYw6Uw+238ExMxgmeCOXH
 MVtGpdR1/6JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZwSQwAKCRCI/9X7Sl//
 mAAnEACF+V9GYs3urXSoT14H4gdEtiV8xD2pN2kphsn7+ltgzvWpkOPglthv7i2EcrX6IFLUaMY
 BqITnL8z0RjKO8FY5MFcoUiz+5ROo2gr63Me1HOYmJb4H+lH5Xj/XmBGTltdtZpblJhcpAD7xI6
 mQxAB85VQp7jzbCO7Vj5Aamf/SlIyD/CI6yYh0IRI7XBJG2b7AzjeUP2iKWXAHqnnX4KTiOptHn
 I/adoxCTrkL5wJixuFYBGRLNGWlHBrkntkGse65utIbuHOGKADPU+u0kxnw6FUGE/vjIMQt0vdF
 fk45nf4YHmvvyxYcuvgN11ua4e38hJs8dfKMRNOlBNEZ21Ck/87LtT/6mZNZzZWt5U+DLOsNPGH
 V7zB8BExdew9hrai/DkW6QBkPIBo8YLBBOShuLskj52H8XLT/D1YX0gAImgvDtMOcG7TvAQbthS
 OXTfa+040u8xfVK7TpGCwbsGw4uhNGe/oaLZr8HFbHGrNXziiUUBeLrVaHp2a13wcS1sBqZ8jI6
 Fzm3S29DkK8OLmZA8kSbqXAGEN/+7UbZnLpbIlMNvIzbjtZhKjLUAmFYtpaTTySBjZ01oRjTaiw
 ga1EE8R+v46LgJLD43Ri9p+yqld9tIgHY036w+1Xh4EsKk/XRiyg7QIvguTMfz1M0a7nanGP5O2
 rfsuDmgHuskwUiQ==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

In uncached mode we were still seeing duplicate getattr requests
because of aggressive dropping of inodes.  Inode "freshness" is
guarded by other mechanisms when caches are disabled so this
is unnecessary and increases overhead of almost every operation.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_super.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 6d9a98c57185..a898dbf97710 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -244,21 +244,6 @@ static int v9fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return res;
 }
 
-static int v9fs_drop_inode(struct inode *inode)
-{
-	struct v9fs_session_info *v9ses;
-
-	v9ses = v9fs_inode2v9ses(inode);
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
-		return generic_drop_inode(inode);
-	/*
-	 * in case of non cached mode always drop the
-	 * inode because we want the inode attribute
-	 * to always match that on the server.
-	 */
-	return 1;
-}
-
 static int v9fs_write_inode(struct inode *inode,
 			    struct writeback_control *wbc)
 {
@@ -303,7 +288,6 @@ static const struct super_operations v9fs_super_ops_dotl = {
 	.alloc_inode = v9fs_alloc_inode,
 	.free_inode = v9fs_free_inode,
 	.statfs = v9fs_statfs,
-	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,

-- 
2.41.0


