Return-Path: <linux-kernel+bounces-86968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD186CDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EC81F2405C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8916086C;
	Thu, 29 Feb 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1JUMKjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1915F308;
	Thu, 29 Feb 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221769; cv=none; b=jM843040C4cZboKQnHpH5tdv4i4bhsqSmDpmGEZ/Cw8VaFG1MOA70wtgazxma3GPhot+PL3+4zktKG9nHEcmwA1Dbqw7V9OSpsn0FViv0zlkNYNrx4ycpmsb5kYoVlduJ0KLLABsu1SoLBWn6XOM5X59uK7xYkFuKW/cf3OWPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221769; c=relaxed/simple;
	bh=894SECjX07TeJHgEDN4GpeYDrHauzDYi/LFjH0WQrXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9FdGofX9vCxXrHlGVpGjx0Yg63QsNzIkdchGG/CLyAPJsdXJvKD5GWt6NyyxGkq8Vvp6pOlRfWnqkkHz2z1n7E7DOBkHQnqJ8O/6Aj3oLRIsFZX/KgvDEig+I7R1zYXIuE1n0HTTkw8Re93rbWIPY3BoIwGRYUOEpmRMOtoIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1JUMKjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64F9C433A6;
	Thu, 29 Feb 2024 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221768;
	bh=894SECjX07TeJHgEDN4GpeYDrHauzDYi/LFjH0WQrXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1JUMKjILmIExy8I6Zi0vmVS8LhIsFeyoGWbpLuQSMPVimfjZSi0MeQcaPCZy5w1U
	 frm+o/TWdI+46DBT47nIB5AXAWU3Wgm1JsUbxWz2ioSAr1dgVYFFuUHLZo8jHmf2re
	 F3NrJgzogFLb9ELFXIOC0WcrS2KyA2HB9Vt9KF6w4NCqITovXZgBB6wDzxSdKCxlnT
	 2koSV5us7TVI2wMvsvFTNwoDLRFLXF5vABYyzEFS8+jAH5iY1pOvuk9hklW/raBbYk
	 Kdh1ymR7Jq0llEAbrLy7HKD8xtMzuCcGKPJ5ljll6ydhk0FgF0vyPQpHD1Lp6bZjs5
	 aZcL1dU/w2KnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 20/26] ceph: always queue a writeback when revoking the Fb caps
Date: Thu, 29 Feb 2024 10:48:39 -0500
Message-ID: <20240229154851.2849367-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index 9c02f328c966c..ad4d5387aa1c8 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2155,6 +2155,30 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
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
@@ -2182,30 +2206,6 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
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


