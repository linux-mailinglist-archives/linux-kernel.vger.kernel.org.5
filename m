Return-Path: <linux-kernel+bounces-33397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63D8836935
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861BB1F22848
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392D7C088;
	Mon, 22 Jan 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyTJtGi3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17307A733;
	Mon, 22 Jan 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936132; cv=none; b=hmgaeETYW9ovFHuyjfDL9HWVG3VRnOyaL5v+ugvmPP5TxEVYF3e0UI58BXHY43dtGnpiJlUBXfweqJf/vAURqQDsNIithaIGiEJyWZA2sot9leYjGY5aVA+iHqPjFhjNCg4tVyYqQChTtp7Fy/S2iUsy2ObfHQE4MrLxC2W2I9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936132; c=relaxed/simple;
	bh=/WVS7P2VidOgLCDa6zdQqaMg0FQih02rDJAAcbhYVIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBQeTsDv+dJou2UnBitXRNSYscXRqNcbf13hTTotxPdoH9EnwZ5IAn8xgjgT1weuyZgDEJNrOmBPPtGkutVLz1PYqiz8UzTyJLNNc9FNncBd9lAulr94mdDwY7O97A+jj6C7mjBOLQ0z8jF+eZB+kVng1ps6OK84jeEJcAoE0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyTJtGi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6138C43394;
	Mon, 22 Jan 2024 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936132;
	bh=/WVS7P2VidOgLCDa6zdQqaMg0FQih02rDJAAcbhYVIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyTJtGi3tm5RRFbylGEYCBKy3D6/u/aSnBJ3VjLM/kXk+Et7MmjMDvQcaFbKOS2Te
	 w+y8lUHAq/Yzm1SgsEXdUazNTxIBFKcyAl1Y4iINtTXhRUuau+wndifEhLy/NEwMc9
	 waEHoaDZQnFs1Guh4zVmK5hcj7R66OT8yiE4g4SQ9RDKe1fL5KDUPccvVtjMW+G6Xu
	 /aYkwLHyNbvI1NNynUGSp13BQwVtnJA20JtwRGaWm88INMdq9vv6lRyjeGkYBHTEPU
	 93t97E06KFVa8Ux9wr4RechueEoeF4bA5z9RwD4M+vvOm6Iyb4qNo8/A4pZXFNusZz
	 GOtPwKo3HTKyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 72/73] ksmbd: fix potential circular locking issue in smb2_set_ea()
Date: Mon, 22 Jan 2024 10:02:26 -0500
Message-ID: <20240122150432.992458-72-sashal@kernel.org>
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

[ Upstream commit 6fc0a265e1b932e5e97a038f99e29400a93baad0 ]

smb2_set_ea() can be called in parent inode lock range.
So add get_write argument to smb2_set_ea() not to call nested
mnt_want_write().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index fbd708bb4a5b..ede6d8ec04d8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2311,11 +2311,12 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
  * @eabuf:	set info command buffer
  * @buf_len:	set info command buffer length
  * @path:	dentry path for get ea
+ * @get_write:	get write access to a mount
  *
  * Return:	0 on success, otherwise error
  */
 static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
-		       const struct path *path)
+		       const struct path *path, bool get_write)
 {
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	char *attr_name = NULL, *value;
@@ -3003,7 +3004,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = smb2_set_ea(&ea_buf->ea,
 					 le32_to_cpu(ea_buf->ccontext.DataLength),
-					 &path);
+					 &path, false);
 			if (rc == -EOPNOTSUPP)
 				rc = 0;
 			else if (rc)
@@ -5992,7 +5993,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
-				   buf_len, &fp->filp->f_path);
+				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
 	{
-- 
2.43.0


