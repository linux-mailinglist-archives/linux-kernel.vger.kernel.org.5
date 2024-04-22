Return-Path: <linux-kernel+bounces-154289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FEF8ADA57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B041C21664
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D0157A47;
	Mon, 22 Apr 2024 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/PUeZ7a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2CB171089;
	Mon, 22 Apr 2024 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830231; cv=none; b=HzmsHJokMLk/ezMrL8ciKz+02MlfIVcvQV4Zh5QNhnSpeYmsLSWT2Z6Cpy/jf47wgCgUgusY5KYOeOk6zGGU3Cq5nn949hSOKBeqEHZCQWwuBh9y1i2iWg5ItO9CqKCwBGQNyogzFO1I2kWHrm4xpHln4XmgSHdnx9SieHME8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830231; c=relaxed/simple;
	bh=IgM1Yko1zMQPfnrJm3RQl9Npy4toNAHcrZ6Qk1FQZ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzq9k/D4u+RTihZjIKqMPR3hooMu7J8UfhVTBuRQW+hzlF4z/bbEdni+WHAQzndjBKvRfeyYIfY52M0no1iiuKRN2vYj4uF8YwQ3ZN9W0RKc02JJ1ZgYVdqiUhhfXzL+PWWuJ5uIKAUMIzshMC/0PXhVQRuYCblSH+lXrnqgyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/PUeZ7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951BBC2BD11;
	Mon, 22 Apr 2024 23:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830231;
	bh=IgM1Yko1zMQPfnrJm3RQl9Npy4toNAHcrZ6Qk1FQZ6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/PUeZ7at4kMhUclUlCmJeKbaqh9CEpHOnTilangu+UDkoDuqyc+ByCEO+oPgqpWS
	 xCdWbdQiB7jhcIDQZCi8Zgh4/tJx+bSs9T7gy4LCVpNlEVj80vl3b6b0JSG8eTx+I3
	 uEmUYOxZvYNbroNGz4Id7DNJ5m2SN+eRmVmI0LGTQyKffYLWrkaFJEPSNP09vCwau5
	 9a9o6ajrTHvTQlIs5KnSUVUqvsPTDI85zahpjtVFNrBxs7eERsW3kFZfeXJ7uosYxk
	 k8bp5JNChobWcR1E5g+JR4N7/1jgQ1SN8M21QAOeP2aRX4mjwoFUmoap2ic7z4E2SC
	 qNf3OF9eXYZ7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Steve French <stfrench@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 28/29] smb3: fix broken reconnect when password changing on the server by allowing password rotation
Date: Mon, 22 Apr 2024 19:17:09 -0400
Message-ID: <20240422231730.1601976-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 35f834265e0dc78b003aa0d1af65cafb89666b76 ]

There are various use cases that are becoming more common in which password
changes are scheduled on a server(s) periodically but the clients connected
to this server need to stay connected (even in the face of brief network
reconnects) due to mounts which can not be easily unmounted and mounted at
will, and servers that do password rotation do not always have the ability
to tell the clients exactly when to the new password will be effective,
so add support for an alt password ("password2=") on mount (and also
remount) so that we can anticipate the upcoming change to the server
without risking breaking existing mounts.

An alternative would have been to use the kernel keyring for this but the
processes doing the reconnect do not have access to the keyring but do
have access to the ses structure.

Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h   |  1 +
 fs/smb/client/connect.c    |  8 ++++++++
 fs/smb/client/fs_context.c | 21 +++++++++++++++++++++
 fs/smb/client/fs_context.h |  2 ++
 fs/smb/client/misc.c       |  1 +
 fs/smb/client/smb2pdu.c    | 11 +++++++++++
 6 files changed, 44 insertions(+)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a878b1e5aa313..1f6954b7311e3 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1049,6 +1049,7 @@ struct cifs_ses {
 				   and after mount option parsing we fill it */
 	char *domainName;
 	char *password;
+	char *password2; /* When key rotation used, new password may be set before it expires */
 	char workstation_name[CIFS_MAX_WORKSTATION_LEN];
 	struct session_key auth_key;
 	struct ntlmssp_auth *ntlmssp; /* ciphertext, flags, server challenge */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 97776dd12b6b8..7091885d5036d 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2195,6 +2195,7 @@ cifs_set_cifscreds(struct smb3_fs_context *ctx, struct cifs_ses *ses)
 	}
 
 	++delim;
+	/* BB consider adding support for password2 (Key Rotation) for multiuser in future */
 	ctx->password = kstrndup(delim, len, GFP_KERNEL);
 	if (!ctx->password) {
 		cifs_dbg(FYI, "Unable to allocate %zd bytes for password\n",
@@ -2218,6 +2219,7 @@ cifs_set_cifscreds(struct smb3_fs_context *ctx, struct cifs_ses *ses)
 			kfree(ctx->username);
 			ctx->username = NULL;
 			kfree_sensitive(ctx->password);
+			/* no need to free ctx->password2 since not allocated in this path */
 			ctx->password = NULL;
 			goto out_key_put;
 		}
@@ -2329,6 +2331,12 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 		if (!ses->password)
 			goto get_ses_fail;
 	}
+	/* ctx->password freed at unmount */
+	if (ctx->password2) {
+		ses->password2 = kstrdup(ctx->password2, GFP_KERNEL);
+		if (!ses->password2)
+			goto get_ses_fail;
+	}
 	if (ctx->domainname) {
 		ses->domainName = kstrdup(ctx->domainname, GFP_KERNEL);
 		if (!ses->domainName)
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 58567ae617b9f..9d485e7b85541 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -161,6 +161,7 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
 	fsparam_string("username", Opt_user),
 	fsparam_string("pass", Opt_pass),
 	fsparam_string("password", Opt_pass),
+	fsparam_string("password2", Opt_pass2),
 	fsparam_string("ip", Opt_ip),
 	fsparam_string("addr", Opt_ip),
 	fsparam_string("domain", Opt_domain),
@@ -314,6 +315,7 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
 	new_ctx->nodename = NULL;
 	new_ctx->username = NULL;
 	new_ctx->password = NULL;
+	new_ctx->password2 = NULL;
 	new_ctx->server_hostname = NULL;
 	new_ctx->domainname = NULL;
 	new_ctx->UNC = NULL;
@@ -326,6 +328,7 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
 	DUP_CTX_STR(prepath);
 	DUP_CTX_STR(username);
 	DUP_CTX_STR(password);
+	DUP_CTX_STR(password2);
 	DUP_CTX_STR(server_hostname);
 	DUP_CTX_STR(UNC);
 	DUP_CTX_STR(source);
@@ -874,6 +877,8 @@ static int smb3_reconfigure(struct fs_context *fc)
 	else  {
 		kfree_sensitive(ses->password);
 		ses->password = kstrdup(ctx->password, GFP_KERNEL);
+		kfree_sensitive(ses->password2);
+		ses->password2 = kstrdup(ctx->password2, GFP_KERNEL);
 	}
 	STEAL_STRING(cifs_sb, ctx, domainname);
 	STEAL_STRING(cifs_sb, ctx, nodename);
@@ -1271,6 +1276,18 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			goto cifs_parse_mount_err;
 		}
 		break;
+	case Opt_pass2:
+		kfree_sensitive(ctx->password2);
+		ctx->password2 = NULL;
+		if (strlen(param->string) == 0)
+			break;
+
+		ctx->password2 = kstrdup(param->string, GFP_KERNEL);
+		if (ctx->password2 == NULL) {
+			cifs_errorf(fc, "OOM when copying password2 string\n");
+			goto cifs_parse_mount_err;
+		}
+		break;
 	case Opt_ip:
 		if (strlen(param->string) == 0) {
 			ctx->got_ip = false;
@@ -1570,6 +1587,8 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
  cifs_parse_mount_err:
 	kfree_sensitive(ctx->password);
 	ctx->password = NULL;
+	kfree_sensitive(ctx->password2);
+	ctx->password2 = NULL;
 	return -EINVAL;
 }
 
@@ -1672,6 +1691,8 @@ smb3_cleanup_fs_context_contents(struct smb3_fs_context *ctx)
 	ctx->username = NULL;
 	kfree_sensitive(ctx->password);
 	ctx->password = NULL;
+	kfree_sensitive(ctx->password2);
+	ctx->password2 = NULL;
 	kfree(ctx->server_hostname);
 	ctx->server_hostname = NULL;
 	kfree(ctx->UNC);
diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index 8cfc25b609b6b..e807bea49d41f 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -137,6 +137,7 @@ enum cifs_param {
 	Opt_source,
 	Opt_user,
 	Opt_pass,
+	Opt_pass2,
 	Opt_ip,
 	Opt_domain,
 	Opt_srcaddr,
@@ -168,6 +169,7 @@ struct smb3_fs_context {
 
 	char *username;
 	char *password;
+	char *password2;
 	char *domainname;
 	char *source;
 	char *server_hostname;
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index ef573e3f8e52a..9f2a13083500e 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -101,6 +101,7 @@ sesInfoFree(struct cifs_ses *buf_to_free)
 	kfree(buf_to_free->serverDomain);
 	kfree(buf_to_free->serverNOS);
 	kfree_sensitive(buf_to_free->password);
+	kfree_sensitive(buf_to_free->password2);
 	kfree(buf_to_free->user_name);
 	kfree(buf_to_free->domainName);
 	kfree_sensitive(buf_to_free->auth_key.response);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 94bd4c6d2d682..70530108b9bb9 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -367,6 +367,17 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		}
 
 		rc = cifs_setup_session(0, ses, server, nls_codepage);
+		if ((rc == -EACCES) || (rc == -EKEYEXPIRED) || (rc == -EKEYREVOKED)) {
+			/*
+			 * Try alternate password for next reconnect (key rotation
+			 * could be enabled on the server e.g.) if an alternate
+			 * password is available and the current password is expired,
+			 * but do not swap on non pwd related errors like host down
+			 */
+			if (ses->password2)
+				swap(ses->password2, ses->password);
+		}
+
 		if ((rc == -EACCES) && !tcon->retry) {
 			mutex_unlock(&ses->session_mutex);
 			rc = -EHOSTDOWN;
-- 
2.43.0


