Return-Path: <linux-kernel+bounces-33310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A748883683C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1371C23FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AD55FEF9;
	Mon, 22 Jan 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD6QXqRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EC95FEE4;
	Mon, 22 Jan 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935746; cv=none; b=AdON/dukGg6xOux8oqXmijmnXPKv56U4FBdp6j7v3kxE9uQlqAT7jXE1ZGjEtbfqyw+Ht1pqWLaL4OSHjtoassKkq3R69AJkTwtMPYTnnYLsv0Yt/dLINDRrtrdgej1mpuUzHy9K916CSKuXffejK6KWwtC3tx5tBaFQxmX17L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935746; c=relaxed/simple;
	bh=6MUIiwQtfzOMU4krgJ1pAmawqGlakVp+3hazCD2oV6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPvaxcFdwYJb0sFTmfnlnrFhSDqbHu5VQwkWBl6b1hdbwuo2dKjIBTMORRtcXm/mEKY4sHgelbCIGcxKJqSPi27Hut7KwnvAYN/gFrkmF0XWkHJFqZcGcvYfWDhkn0YHMiEm6I2cx2pVldgist+YFpdCXCuuNVK8Yz0aaMd9oHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD6QXqRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135A7C43141;
	Mon, 22 Jan 2024 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935746;
	bh=6MUIiwQtfzOMU4krgJ1pAmawqGlakVp+3hazCD2oV6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iD6QXqRDhLgF+cyY1MZIl683Cxu4o3MjxglaT3xtbcYn2iko/qalBsi0qWDNKQD6a
	 F4d6FP1fHrKLYenedX2B6ZKzANpCGSFItej89D5Jen06BHPt2BeYKGrPTAyLo6iqTB
	 Oo+BuMffRjUd2bcN3ub6SUu5dgyfrcEBdHS656ukIVcx6mK2vfCODpH1p0wdeLLwKS
	 ky2HNh72MdxMNYBeyGnKr65ldEoDkH70AwE9JRwlUUqgrxHCNgmUu1L57yr+AsWKlG
	 QEEUDMq5+2zgkDm8YqJnH6DupCqCgHTaod0P5zGxuIZ/YUPdEx+bPzCZXKFR4GXw8v
	 rFWfrjMDMBoSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 88/88] ksmbd: send lease break notification on FILE_RENAME_INFORMATION
Date: Mon, 22 Jan 2024 09:52:01 -0500
Message-ID: <20240122145608.990137-88-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 3fc74c65b367476874da5fe6f633398674b78e5a ]

Send lease break notification on FILE_RENAME_INFORMATION request.
This patch fix smb2.lease.v2_epoch2 test failure.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/oplock.c  | 9 +++++++--
 fs/smb/server/smb2pdu.c | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 9a19d8b06c8c..6bf2b675add9 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -546,6 +546,7 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 			     atomic_read(&ci->sop_count)) == 1) {
 				if (lease->state != SMB2_LEASE_NONE_LE &&
 				    lease->state == (lctx->req_state & lease->state)) {
+					lease->epoch++;
 					lease->state |= lctx->req_state;
 					if (lctx->req_state &
 						SMB2_LEASE_WRITE_CACHING_LE)
@@ -556,13 +557,17 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 				    atomic_read(&ci->sop_count)) > 1) {
 				if (lctx->req_state ==
 				    (SMB2_LEASE_READ_CACHING_LE |
-				     SMB2_LEASE_HANDLE_CACHING_LE))
+				     SMB2_LEASE_HANDLE_CACHING_LE)) {
+					lease->epoch++;
 					lease->state = lctx->req_state;
+				}
 			}
 
 			if (lctx->req_state && lease->state ==
-			    SMB2_LEASE_NONE_LE)
+			    SMB2_LEASE_NONE_LE) {
+				lease->epoch++;
 				lease_none_upgrade(opinfo, lctx->req_state);
+			}
 		}
 		read_lock(&ci->m_lock);
 	}
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a2f729675183..5a31d47875da 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5569,6 +5569,7 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
+	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
 	kfree(new_name);
-- 
2.43.0


