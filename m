Return-Path: <linux-kernel+bounces-57134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8254E84D45C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D2F1F25C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F615147D;
	Wed,  7 Feb 2024 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqXTtZtz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99A151469;
	Wed,  7 Feb 2024 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341067; cv=none; b=eJgkZwkfVsxOO4U2cItG1qDKQ2Oo/zbj4Gl/LpS29tO6L3Um1Q4tSF/AsvpMMNOi9eCEapSNKs3Q8EBxUiPyidKQovJzrUaO5iquneekwhSyj/PWEtXYL9lYs2vsNsHw63O7HXI6zhXboxoaSgZQiEhYxsAfkJrRk7o2Ud+yPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341067; c=relaxed/simple;
	bh=j2pD5hUy6ikBMlbVLzADzaYatT7YY7pGsXPuO6keV1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnrKMhaeECuL4lKO0Ja8j3hzHcOwz08n6/bxGC0z6tHNjn9EnPj9WQD33Asoo050meEbL8cb6l25oG3ZW2YZygZtxQ18tHw/5sJv4BppK1//WivSY3sWT1G6PQwv52OOOQtOW/+1rXIQW+3D6Vic2Nj+6WUiWTYEeywizi2BfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqXTtZtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215C8C43390;
	Wed,  7 Feb 2024 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341067;
	bh=j2pD5hUy6ikBMlbVLzADzaYatT7YY7pGsXPuO6keV1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqXTtZtzU1jqkiCQgCsv5flelwmhrUhKsnPyOBgxT3hYKuAmpdC3uZmYjhk+RvERT
	 +bmcXjMJnAtsvSLFyn/Zv819EMJiB02xC5UvYyyRgG2g9IxT237d/nQhswIMBivRdj
	 qZfdftESbdZDJIhu3s4UWtNSv82Qgsa81dkNYrs3GS8XXOULZXXdxt++aPNgb3CU/s
	 N0WfbVoWiWhJP2C+KlEgwGnRqX1o0esKRvU4C71UK87X4ktRDNLod4JFfz5D69DoKn
	 ljMz3Ms/StDOqxjYxn5mkot/qo+xCZCKPKoOuMHefykfWsvNDM9bHQm+0ovWrz27f8
	 2iwI0u7C2LJQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 24/38] cifs: make sure that channel scaling is done only once
Date: Wed,  7 Feb 2024 16:23:10 -0500
Message-ID: <20240207212337.2351-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit ee36a3b345c433a846effcdcfba437c2298eeda5 ]

Following a successful cifs_tree_connect, we have the code
to scale up/down the number of channels in the session.
However, it is not protected by a lock today.

As a result, this code can be executed by several processes
that select the same channel. The core functions handle this
well, as they pick chan_lock. However, we've seen cases where
smb2_reconnect throws some warnings.

To fix that, this change introduces a flags bitmap inside the
cifs_ses structure. A new flag type is used to ensure that
only one process enters this section at any time.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  3 +++
 fs/smb/client/smb2pdu.c  | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 5e32c79f03a7..75ca732a1679 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1004,6 +1004,8 @@ struct cifs_chan {
 	__u8 signkey[SMB3_SIGN_KEY_SIZE];
 };
 
+#define CIFS_SES_FLAG_SCALE_CHANNELS (0x1)
+
 /*
  * Session structure.  One of these for each uid session with a particular host
  */
@@ -1036,6 +1038,7 @@ struct cifs_ses {
 	enum securityEnum sectype; /* what security flavor was specified? */
 	bool sign;		/* is signing required? */
 	bool domainAuto:1;
+	unsigned int flags;
 	__u16 session_flags;
 	__u8 smb3signingkey[SMB3_SIGN_KEY_SIZE];
 	__u8 smb3encryptionkey[SMB3_ENC_DEC_KEY_SIZE];
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index f5006aa97f5b..ab8765113392 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -399,6 +399,15 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		goto out;
 	}
 
+	spin_lock(&ses->ses_lock);
+	if (ses->flags & CIFS_SES_FLAG_SCALE_CHANNELS) {
+		spin_unlock(&ses->ses_lock);
+		mutex_unlock(&ses->session_mutex);
+		goto skip_add_channels;
+	}
+	ses->flags |= CIFS_SES_FLAG_SCALE_CHANNELS;
+	spin_unlock(&ses->ses_lock);
+
 	if (!rc &&
 	    (server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
 		mutex_unlock(&ses->session_mutex);
@@ -428,15 +437,22 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		if (ses->chan_max > ses->chan_count &&
 		    ses->iface_count &&
 		    !SERVER_IS_CHAN(server)) {
-			if (ses->chan_count == 1)
+			if (ses->chan_count == 1) {
 				cifs_server_dbg(VFS, "supports multichannel now\n");
+				queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
+						 (SMB_INTERFACE_POLL_INTERVAL * HZ));
+			}
 
 			cifs_try_adding_channels(ses);
 		}
 	} else {
 		mutex_unlock(&ses->session_mutex);
 	}
+
 skip_add_channels:
+	spin_lock(&ses->ses_lock);
+	ses->flags &= ~CIFS_SES_FLAG_SCALE_CHANNELS;
+	spin_unlock(&ses->ses_lock);
 
 	if (smb2_command != SMB2_INTERNAL_CMD)
 		mod_delayed_work(cifsiod_wq, &server->reconnect, 0);
-- 
2.43.0


