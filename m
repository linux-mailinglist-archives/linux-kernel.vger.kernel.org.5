Return-Path: <linux-kernel+bounces-33398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09C83693A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9A728B828
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365AA7C0B5;
	Mon, 22 Jan 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNDuuhjT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7567C0A1;
	Mon, 22 Jan 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936134; cv=none; b=lcHeLW+TNgbCVhm+54Rv1u9js0/CuxfjGbLwUhAbuz7PB8XqNP3uTNxf8b1WhKokYQ/JGn6bpowN+JFfzv7q/WgGZfQXdKcMguE1OgflnbFiVeEfA0/BxUes0LBLkRpb27q2g0RLEWl0QCSCGEKa3g3d3WcCRu4KqaR7G/e+voM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936134; c=relaxed/simple;
	bh=+7yMAS4xP5XSO3RKSbVhBlgHnIRgyQSydZSIP0R+ByI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNP/KaLHBxC2B9rKyvHZOALAqs2/4DSw1BkTIHDZt+V/W6vPMj8SKZi7KwdmQQwT4UI3tMTXlxPwozoq1j2PG3VnL8hP4R2Sbc3ryE4x80qRYXzCz0JzVmoCzLaPQQqsmpYa/jLsFb1qrwxSOIsgRdryeQDBVhvsV56BU/SS/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNDuuhjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B10BC43394;
	Mon, 22 Jan 2024 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936133;
	bh=+7yMAS4xP5XSO3RKSbVhBlgHnIRgyQSydZSIP0R+ByI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNDuuhjT0uQuLRCMJ0zdpQWXah6xNqBj2NcD8Ob8sA/V4UgPE1H42hT/nLauR2uRY
	 SAL6N7tK/iXYpk1FDwoYA/WGHCp/OMi8P+3f7R5YlHg1HVGKp6rueTvWWe0IdSJDut
	 zKOP024xiNRjY3kPs6WYQ8pkf/896cUzWhpgU379CzVF878wcQI4zW948JIOgnmIOq
	 5MATaWdo3xUev+KPNnLwqg8ANzFKG9Y0QrY5Jup9yH/wEZSh1i90YtjYlHW+DE1AlB
	 0hvWSCzhwpKyfr9vu2Ihr8VsbYe97orbGLRVhsT45+PVbKWCY8ks5y2aVTTqMksFut
	 G4fqPnggYG0XA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 73/73] ksmbd: send lease break notification on FILE_RENAME_INFORMATION
Date: Mon, 22 Jan 2024 10:02:27 -0500
Message-ID: <20240122150432.992458-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index ede6d8ec04d8..51f3597101c9 100644
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


