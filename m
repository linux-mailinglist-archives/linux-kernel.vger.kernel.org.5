Return-Path: <linux-kernel+bounces-113625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388BD8885C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E060B288B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C5813FD90;
	Sun, 24 Mar 2024 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jenbOAuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA41CF8DE;
	Sun, 24 Mar 2024 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320459; cv=none; b=MFKFOIxO/2hAkFBNpZMxuoi4fQuk+YFR1ABRZUWojXefFCN0VyfdOHcvOuPP/NxFb/CYZL1jIGG3eJ1jAVt/oPfLuFTfpqzElZFwlheay8Rl3wZ9DSFNUpLRfoFWvPYtsMgjUtZU3Zt2rAhnGQDPMJTPab+2zcGDKlSIoOZZ1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320459; c=relaxed/simple;
	bh=qE+vEiN0vFqYCbenxmXpv9h1SM4UJIhPix7Hu85NBsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q03AucZbbZWuYxl+2p6uzN9x8y8e2sKYHW+0vLXIG+L2Xii7m3D44RwAhgMEg8fiNaqxCK/FMQ5TFKWlE9NoGkux3XrmVTGSjXXmTrN2ZHOag5q/VozgFg4yVe1bs8SFLPEsd4VfeMgkeZ+lGy57ffMre2wYe9I9Qnyt5pBA9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jenbOAuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FDFC433C7;
	Sun, 24 Mar 2024 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320459;
	bh=qE+vEiN0vFqYCbenxmXpv9h1SM4UJIhPix7Hu85NBsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jenbOAuyf6cUjlmTdyF+UDvjMW63f2hJcLSol+ol8Fm8dg/PDkFXmsPNFjcZXZJmv
	 QfN7Nkspx9YVuCLDyUmO8MX39UQP0iaOKT9SB2unF5M6aqXGA7jGzpFMA1q5kBku3Q
	 HcQmwb/yS5/P/16D3GycwA2o20MSX/rDzV8GKabCNtl2rVMy38PK4ONZKDzKSMCDuB
	 osKiN1t6PBq8LFt9NofrJF3JUs1csiE8I8F8zhRbNgWW1y9GcMo00mIpnzqpo3K6Th
	 wUwt4Gz1mFl3+sxGd0VvevChLnHOkqkr48quqDrw/hCiaqPqj/br57LT5KkHUSvRWo
	 vjJmqqMekMMLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 018/713] ceph: always queue a writeback when revoking the Fb caps
Date: Sun, 24 Mar 2024 18:35:44 -0400
Message-ID: <20240324224720.1345309-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 902d6d013f75b68f31d208c6f3ff9cdca82648a7 ]

In case there is 'Fw' dirty caps and 'CHECK_CAPS_FLUSH' is set we
will always ignore queue a writeback. Queue a writeback is very
important because it will block kclient flushing the snapcaps to
MDS and which will block MDS waiting for revoking the 'Fb' caps.

Link: https://tracker.ceph.com/issues/50223
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index ad1f46c66fbff..bce3a840f15c2 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2156,6 +2156,30 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 		      ceph_cap_string(cap->implemented),
 		      ceph_cap_string(revoking));
 
+		/* completed revocation? going down and there are no caps? */
+		if (revoking) {
+			if ((revoking & cap_used) == 0) {
+				doutc(cl, "completed revocation of %s\n",
+				      ceph_cap_string(cap->implemented & ~cap->issued));
+				goto ack;
+			}
+
+			/*
+			 * If the "i_wrbuffer_ref" was increased by mmap or generic
+			 * cache write just before the ceph_check_caps() is called,
+			 * the Fb capability revoking will fail this time. Then we
+			 * must wait for the BDI's delayed work to flush the dirty
+			 * pages and to release the "i_wrbuffer_ref", which will cost
+			 * at most 5 seconds. That means the MDS needs to wait at
+			 * most 5 seconds to finished the Fb capability's revocation.
+			 *
+			 * Let's queue a writeback for it.
+			 */
+			if (S_ISREG(inode->i_mode) && ci->i_wrbuffer_ref &&
+			    (revoking & CEPH_CAP_FILE_BUFFER))
+				queue_writeback = true;
+		}
+
 		if (cap == ci->i_auth_cap &&
 		    (cap->issued & CEPH_CAP_FILE_WR)) {
 			/* request larger max_size from MDS? */
@@ -2183,30 +2207,6 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 			}
 		}
 
-		/* completed revocation? going down and there are no caps? */
-		if (revoking) {
-			if ((revoking & cap_used) == 0) {
-				doutc(cl, "completed revocation of %s\n",
-				      ceph_cap_string(cap->implemented & ~cap->issued));
-				goto ack;
-			}
-
-			/*
-			 * If the "i_wrbuffer_ref" was increased by mmap or generic
-			 * cache write just before the ceph_check_caps() is called,
-			 * the Fb capability revoking will fail this time. Then we
-			 * must wait for the BDI's delayed work to flush the dirty
-			 * pages and to release the "i_wrbuffer_ref", which will cost
-			 * at most 5 seconds. That means the MDS needs to wait at
-			 * most 5 seconds to finished the Fb capability's revocation.
-			 *
-			 * Let's queue a writeback for it.
-			 */
-			if (S_ISREG(inode->i_mode) && ci->i_wrbuffer_ref &&
-			    (revoking & CEPH_CAP_FILE_BUFFER))
-				queue_writeback = true;
-		}
-
 		/* want more caps from mds? */
 		if (want & ~cap->mds_wanted) {
 			if (want & ~(cap->mds_wanted | cap->issued))
-- 
2.43.0


