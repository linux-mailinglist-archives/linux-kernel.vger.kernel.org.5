Return-Path: <linux-kernel+bounces-33309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A378836839
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373381C2387F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67A5FDD3;
	Mon, 22 Jan 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrPBoaLd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83315FDBE;
	Mon, 22 Jan 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935744; cv=none; b=GYxAvkMKgIK4dsZJeEwlpjWWOvrFU+UTr3n9dp0YkIbmks/2U1tYLsZh+f2W8Avx2MW1HOBFKUDVmtg0sg/xatnbuIag06diyTqHXyTwNOPYRxp2XSTrSg+4v5e3q1eJW/vxKfnR1UcEakVmXNI3JYGfA/wYjVTbsfnRu3ew9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935744; c=relaxed/simple;
	bh=1v7yhRkCsHnbDmrDhYU7jxmxAs6MM8X4JDMXcOlc/Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diCzbLWr6rYV41lp2WHqrFQWdFFZLMgnzniOcdMljPxDYpk2LsqqLemC0tikmkUPNT3x8Uoy5Gwt/IXlYd83xc+zPy8K0sVY6NF7EuCONfFZUTbMpoc/yytHKHtddYEjg2nu4VI7NV46oKsoR+wBpemkSI+ZJLL5tx50Ylj1xzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrPBoaLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEE9C43609;
	Mon, 22 Jan 2024 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935744;
	bh=1v7yhRkCsHnbDmrDhYU7jxmxAs6MM8X4JDMXcOlc/Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrPBoaLdKpc/ydnrl4Nd/dQgAaWaKE6KytsSOY6i/NIvyR8xKKMeNmbvGiuz+ldWi
	 oZ1wrJYprWofvIlM9FTIcAMg/fgZZqIh3zcJVgSmmhy2vGTopbSMAn3TDfGZSlVO2Z
	 bk9T9rhXu45kBmj9OhqquuRK+MB7WdwZNeOJZGzrReh8iWhHwH1cZNYm9wIsDfXhtV
	 PmsMzIGUxhFTNVHaS8nmT9vcJoi4L7NMyAdxDY+ThzN20o5fZClVL2WQO8Xp9NZf46
	 vecV1mBxxfAig2AzGEpvNmq1zXRkQyVsyn07IV+eTOVUUuuuwiznVVixsvG1i4oVFW
	 IkjLhSfBIufiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 87/88] ksmbd: fix potential circular locking issue in smb2_set_ea()
Date: Mon, 22 Jan 2024 09:52:00 -0500
Message-ID: <20240122145608.990137-87-sashal@kernel.org>
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
index 652ab429bf2e..a2f729675183 100644
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


