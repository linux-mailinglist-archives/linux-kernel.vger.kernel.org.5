Return-Path: <linux-kernel+bounces-33453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E213836A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1BCB23885
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3212C54C;
	Mon, 22 Jan 2024 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/9efLQ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321112C53E;
	Mon, 22 Jan 2024 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936350; cv=none; b=ht5hOcm3xrIkM/Jaipr5eQU+iuKorvusaIZ4K33ckOBbfye9Uv9mfyKBfsCdGEpyRA5LyjsbakpwVeRgJlOReTgRgL02bdXYSt+46o61kOnJYpo37MhHdE126+Bsjgthvr9gRHS74yXjaIPqkikFnCTlovt9oTuY+pVmh6CrhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936350; c=relaxed/simple;
	bh=9iHR+jbKnYfBMII71Q/+qNk9mQC5iZ4kg34y7IHNyo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImTHF0nqkyEyTcJRyeErpiTz9+oAZLyjnnqhbJt4afHF3taTyFMCZJ2kSLtyHZR6UXlc6a8sd+8ihvo0sgJm2+hx5myvK3dYdYqB9ByGnoH8MDANQiD9FeRsDmv6U6Shey79gXTak0TNK7Egvt8v2d9JX1/7rBZEXI37odKcZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/9efLQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BC4C433C7;
	Mon, 22 Jan 2024 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936350;
	bh=9iHR+jbKnYfBMII71Q/+qNk9mQC5iZ4kg34y7IHNyo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/9efLQ99rmlh8quWBt3DPucpWtw7HAiLsDKRqRZn+sahlQSSf6cvuqWkeTY8nfrG
	 hiwp2oUuZwTuow0oqQbxsYWo+EHqsFUpckkKdNGsaEm4KSygaAIrbzCkN8wwmkf0z3
	 r7QzVJ1QIQLJ8M0wLjciuZ0K/ofqVBSS0Q3uM1QzKHkixWgn32H0JuSkmTQvhAil1o
	 aRFMNtdIpQASHseybe6uQyjM6hEizDsNGYXEIanHCNWcr53UvP0UYZC+2V+u1BN0/N
	 oOVWfyeAL6Q3oHnZketvavkaqF1cYATJ+bX6+/XYHlYPqZVaYcpE4TAtg100oyahVf
	 KO66qDojrm+fA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 52/53] ksmbd: fix potential circular locking issue in smb2_set_ea()
Date: Mon, 22 Jan 2024 10:08:53 -0500
Message-ID: <20240122150949.994249-52-sashal@kernel.org>
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
index 6e5ed0ac578a..8d4e2c666c34 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2309,11 +2309,12 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
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
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *attr_name = NULL, *value;
@@ -3001,7 +3002,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = smb2_set_ea(&ea_buf->ea,
 					 le32_to_cpu(ea_buf->ccontext.DataLength),
-					 &path);
+					 &path, false);
 			if (rc == -EOPNOTSUPP)
 				rc = 0;
 			else if (rc)
@@ -5990,7 +5991,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
-				   buf_len, &fp->filp->f_path);
+				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
 	{
-- 
2.43.0


