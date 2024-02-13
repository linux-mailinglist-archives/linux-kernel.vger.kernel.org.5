Return-Path: <linux-kernel+bounces-62621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF948523BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CC5281609
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B5E59B7F;
	Tue, 13 Feb 2024 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wkr8Xrvw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD758ADC;
	Tue, 13 Feb 2024 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783597; cv=none; b=Gy0qAJOK6iPhLYGbbF7Du1FqO4Iot/+CI+FDGWz5cgEEphoDBnfp/gbhvjyQ6vF58KV3+nULzLP6p2OBA6F8Z1ivchjYoOilTROueDIYnLUBoricMKTflvW1OyHBCJ44Rv/ZwRAMeUd99MrUPB0Zo5WuhDBCuJBxNQdj2TFcH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783597; c=relaxed/simple;
	bh=rhhdBvei3SMJbaSMhvmMrPQ275EeitdI+uUvrspB+WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwXzzqxrACf021D6wCg3Be7OMT8Puo2U2gc+t1H4Y5MpBXWL0bijoLPYd02NF/a+R39oy/7NCGfogkTHX/1gMWdYK2ABeuKHWQue4oE7t3wTmrojBs2Gh2I3iHNXsKAZW/mNOs9Uc9h8Gt/s4vvDnVix/ZXJM1bNFemzKZS69lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wkr8Xrvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3B6C433F1;
	Tue, 13 Feb 2024 00:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783597;
	bh=rhhdBvei3SMJbaSMhvmMrPQ275EeitdI+uUvrspB+WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wkr8XrvwYZQxHxqvwOdSrValoT8ZyVpUfpU6PEqqWL9Q+kRS7XPYEdRA/BlPLoMsf
	 m0yKKRo8dGxUOgYQ/+1zdGzuaHApX2rDXO3FHid+X4SvH3vg7x1GeL2SkBavyWqGyd
	 8XaXOJfrqJBre6AbzzL1jH0Ii6ncGM4RfrLTxiElqD8H1iT/D+sDej0fhGXpIg5Mw4
	 4SeJE8J++/bHhrW8h1Acgo6w4CLAJQakwgWG1w739E5oKlkUYbE2DNT1lObqLuiFwL
	 piXvBgK9OAWkn9S2P/O48k5R25N+OhOfamZzFv2z/lEW2uX+T+rtKz+zoYsq8z+STQ
	 ExmugrKpTGPrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 48/58] ceph: always check dir caps asynchronously
Date: Mon, 12 Feb 2024 19:17:54 -0500
Message-ID: <20240213001837.668862-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 07045648c07c5632e0dfd5ce084d3cd0cec0258a ]

The MDS will issue the 'Fr' caps for async dirop, while there is
buggy in kclient and it could miss releasing the async dirop caps,
which is 'Fsxr'. And then the MDS will complain with:

"[WRN] client.xxx isn't responding to mclientcaps(revoke) ..."

So when releasing the dirop async requests or when they fail we
should always make sure that being revoked caps could be released.

Link: https://tracker.ceph.com/issues/50223
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c       | 6 ------
 fs/ceph/mds_client.c | 9 ++++-----
 fs/ceph/mds_client.h | 2 +-
 fs/ceph/super.h      | 2 --
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 9c02f328c966..f7bb03df9b02 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3215,7 +3215,6 @@ static int ceph_try_drop_cap_snap(struct ceph_inode_info *ci,
 
 enum put_cap_refs_mode {
 	PUT_CAP_REFS_SYNC = 0,
-	PUT_CAP_REFS_NO_CHECK,
 	PUT_CAP_REFS_ASYNC,
 };
 
@@ -3331,11 +3330,6 @@ void ceph_put_cap_refs_async(struct ceph_inode_info *ci, int had)
 	__ceph_put_cap_refs(ci, had, PUT_CAP_REFS_ASYNC);
 }
 
-void ceph_put_cap_refs_no_check_caps(struct ceph_inode_info *ci, int had)
-{
-	__ceph_put_cap_refs(ci, had, PUT_CAP_REFS_NO_CHECK);
-}
-
 /*
  * Release @nr WRBUFFER refs on dirty pages for the given @snapc snap
  * context.  Adjust per-snap dirty page accounting as appropriate.
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 558c3af44449..2eb66dd7d01b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1089,7 +1089,7 @@ void ceph_mdsc_release_request(struct kref *kref)
 	struct ceph_mds_request *req = container_of(kref,
 						    struct ceph_mds_request,
 						    r_kref);
-	ceph_mdsc_release_dir_caps_no_check(req);
+	ceph_mdsc_release_dir_caps_async(req);
 	destroy_reply_info(&req->r_reply_info);
 	if (req->r_request)
 		ceph_msg_put(req->r_request);
@@ -4247,7 +4247,7 @@ void ceph_mdsc_release_dir_caps(struct ceph_mds_request *req)
 	}
 }
 
-void ceph_mdsc_release_dir_caps_no_check(struct ceph_mds_request *req)
+void ceph_mdsc_release_dir_caps_async(struct ceph_mds_request *req)
 {
 	struct ceph_client *cl = req->r_mdsc->fsc->client;
 	int dcaps;
@@ -4255,8 +4255,7 @@ void ceph_mdsc_release_dir_caps_no_check(struct ceph_mds_request *req)
 	dcaps = xchg(&req->r_dir_caps, 0);
 	if (dcaps) {
 		doutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
-		ceph_put_cap_refs_no_check_caps(ceph_inode(req->r_parent),
-						dcaps);
+		ceph_put_cap_refs_async(ceph_inode(req->r_parent), dcaps);
 	}
 }
 
@@ -4292,7 +4291,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 		if (req->r_session->s_mds != session->s_mds)
 			continue;
 
-		ceph_mdsc_release_dir_caps_no_check(req);
+		ceph_mdsc_release_dir_caps_async(req);
 
 		__send_request(session, req, true);
 	}
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 2e6ddaa13d72..40560af38827 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -552,7 +552,7 @@ extern int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 				struct inode *dir,
 				struct ceph_mds_request *req);
 extern void ceph_mdsc_release_dir_caps(struct ceph_mds_request *req);
-extern void ceph_mdsc_release_dir_caps_no_check(struct ceph_mds_request *req);
+extern void ceph_mdsc_release_dir_caps_async(struct ceph_mds_request *req);
 static inline void ceph_mdsc_get_request(struct ceph_mds_request *req)
 {
 	kref_get(&req->r_kref);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index fe0f64a0acb2..15d00bdd9206 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1254,8 +1254,6 @@ extern void ceph_take_cap_refs(struct ceph_inode_info *ci, int caps,
 extern void ceph_get_cap_refs(struct ceph_inode_info *ci, int caps);
 extern void ceph_put_cap_refs(struct ceph_inode_info *ci, int had);
 extern void ceph_put_cap_refs_async(struct ceph_inode_info *ci, int had);
-extern void ceph_put_cap_refs_no_check_caps(struct ceph_inode_info *ci,
-					    int had);
 extern void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 				       struct ceph_snap_context *snapc);
 extern void __ceph_remove_capsnap(struct inode *inode,
-- 
2.43.0


