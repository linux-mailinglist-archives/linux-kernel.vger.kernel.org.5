Return-Path: <linux-kernel+bounces-33454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB28369DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819681F24F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4527412CDAD;
	Mon, 22 Jan 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q00Xc0Jy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4212CD98;
	Mon, 22 Jan 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936351; cv=none; b=JxOl9CEop29wpByLZhTVXfNNRN94L+fZkKI1HOA+iyv/oU9riIGT14X0YQ1D0FSfY+HFKBRSBGOKl+XWOPCgiKxDVpV2BqTWv48MMTNTs5xqwA8T5Ikw1/N1b4Ah3kI8YNOXiTSTzKGpA8RsRF6bvJs92t2WToHtiwo+2zeD4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936351; c=relaxed/simple;
	bh=IM0mBk72pQQiITIsPzOisHFy07r4WeQvg4rA/rcSlsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZNLwzgfGB4RYmA+aIKIV3briHdIMP6k6u2ourKoTZbQy/2gCEsByN+EXj/HFVXbkt3hi/hUxDzkDyp8rTq/q8F6MGHNVlpKEHlZtBw4lHe8raWlY1PPDQvxRvRN17F7JyOQQRkqye68hfnlDxqULql/0y4r/DQv2WDqyYC3NFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q00Xc0Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F265C433C7;
	Mon, 22 Jan 2024 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936351;
	bh=IM0mBk72pQQiITIsPzOisHFy07r4WeQvg4rA/rcSlsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q00Xc0JytyD5dxmQSURnpfXK1+Jr5xcT+BH+wc1u7mXsbZlLu3dG6gyrLsZt3olTI
	 cG3R1os75i+YRmWiSu4KVbsW0lOPr8xsz/83CauqLvoF2/WCI5gxFu3GTVE2fHlyNn
	 ZQSvPrN4T96o1Lw5iL0GmpSEieN+nnWV+467in6EBJAqenCuH8K4OJO2N3Ml/BmzJj
	 /emEm3ILOIhFl0ViSxaCDdRqmtDt6BPPlzNXhXkZexdxAjMGi9gQtSoMaaGuvcjFEb
	 +FbqZFJfKyihSSFMQgBbzNNkjzFcLG9cMKlH1vFweFzUQuQ6N4QjoFqC5QHktY0LzP
	 isuyyeh+xAh4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 53/53] ksmbd: send lease break notification on FILE_RENAME_INFORMATION
Date: Mon, 22 Jan 2024 10:08:54 -0500
Message-ID: <20240122150949.994249-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index ebb7d100c851..252f5b96862b 100644
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
index 8d4e2c666c34..f5468cfb523d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5567,6 +5567,7 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
+	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
 	kfree(new_name);
-- 
2.43.0


