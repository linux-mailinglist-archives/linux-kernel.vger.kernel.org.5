Return-Path: <linux-kernel+bounces-62630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F8A8523D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE45B25ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E729E5DF37;
	Tue, 13 Feb 2024 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRzWyq5K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF45DF17;
	Tue, 13 Feb 2024 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783626; cv=none; b=qwdm8VtYZHYFlHu5zLH0wGilv9gspWRU+AF/QRiI1bCFKEcDhFpjbp743c/v9P3dW8LKYrrYLj8aFJKfHU+BwluPEbPOB5AIrXEnYMg5ppiXH76dIcCaixdMlHwvLyOGokjAb8bXfUwuOdJPiTy2fUYaS2LfGzq0zpHNRjZAMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783626; c=relaxed/simple;
	bh=qYrp+SSdH6hurMDxVQoI22UibkgqT7B+YKX1ZL1VjKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhb9YICOKU9F21EVsVoGpDZWtGjLEJxeCO5ccdykPV8RbxuPtdPP2R3NwkKdlM+qauqqmUJcd9C1b9BWtG8GIPGHg8MxluP+9TstqJQgPoczV0TJQ4vYln/N2JyjpYCm5Jo1KQznTVNOoslX7bqaXckq6MddKzP+62Pr+IvjNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRzWyq5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9524C433A6;
	Tue, 13 Feb 2024 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783625;
	bh=qYrp+SSdH6hurMDxVQoI22UibkgqT7B+YKX1ZL1VjKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRzWyq5KqZGSa7EDv7MSnh0bVqez40QA8+PCNcQN5EibBV6RYn1MGOKUnZw0vtbQs
	 j1aAhkIflWtD0DNMg0OCfn7XjYPXZ6LdiP2e/DXwFWpEBBOz7baqg1mvBKugQIQIal
	 EphJ/753lU47jONYXpsO1hskAU3fNxYBLuuKM6HFw4E2fB7DZbeMhBNE+1x8OG/IaB
	 oI1+cE6ylNMnQN1ZFV1KFrJ2crOaWSfQa+RZIG7QgMTo1QWzHJQSWMOt5Ij4AY4Pv8
	 OY5FBVfagrqzNAOaSSezo1A/q6RDWXj5a55nYMe2AqMJaOsX79fIdPpnBN0UeLfc+p
	 Em96n5ngTs5eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.7 57/58] cifs: handle cases where multiple sessions share connection
Date: Mon, 12 Feb 2024 19:18:03 -0500
Message-ID: <20240213001837.668862-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit a39c757bf0596b17482a507f31c3ef0af0d1d2b4 ]

Based on our implementation of multichannel, it is entirely
possible that a server struct may not be found in any channel
of an SMB session.

In such cases, we should be prepared to move on and search for
the server struct in the next session.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 6 ++++++
 fs/smb/client/sess.c    | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 87f0cb95a2a7..ff16edcffb36 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -233,6 +233,12 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 	list_for_each_entry_safe(ses, nses, &pserver->smb_ses_list, smb_ses_list) {
 		/* check if iface is still active */
 		spin_lock(&ses->chan_lock);
+		if (cifs_ses_get_chan_index(ses, server) ==
+		    CIFS_INVAL_CHAN_INDEX) {
+			spin_unlock(&ses->chan_lock);
+			continue;
+		}
+
 		if (!cifs_chan_is_iface_active(ses, server)) {
 			spin_unlock(&ses->chan_lock);
 			cifs_chan_update_iface(ses, server);
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index a16e175731eb..44506552ad96 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -84,7 +84,6 @@ cifs_ses_get_chan_index(struct cifs_ses *ses,
 	if (server)
 		cifs_dbg(VFS, "unable to get chan index for server: 0x%llx",
 			 server->conn_id);
-	WARN_ON(1);
 	return CIFS_INVAL_CHAN_INDEX;
 }
 
-- 
2.43.0


