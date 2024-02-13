Return-Path: <linux-kernel+bounces-62682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A3852459
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C91E1F245FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372AC6A33A;
	Tue, 13 Feb 2024 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5HvAlAu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EB219F9;
	Tue, 13 Feb 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783744; cv=none; b=OckLaQn/oLP1wAdv1jrCc1i+5INu1Waiu8529MvITXXfKEfDuGfQMLjF7CjGNPQthhU0EWX4ajQbuHnej1XIL2xWI1Pehtbl1Yq7sq4k/eWZ8yyV8LRSmb5puSJ0CYXYHG3mu/awd2QG54xvei8xm4d1PI46S3cNmCo4OgQDGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783744; c=relaxed/simple;
	bh=bdGr8hof4XTUBHuaumGWXIMIxr/Pj98CJJdAYT4Sjmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBM9tNkutsuYZswO0EmU6laGHoQy+wKcrHgutsbjlYp1/Vhjz82JuZ2h0AQretW9UfiPOwpDl6ZPPhDlTddzDNiHyVIgJCTgEVMLDDzgaMzRST7/3zRQm26FQJmBwg+kFSIDcToabpmAz+Sjv6RiOe+PJWipcSIhLepsSGNFppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5HvAlAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478B2C433C7;
	Tue, 13 Feb 2024 00:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783744;
	bh=bdGr8hof4XTUBHuaumGWXIMIxr/Pj98CJJdAYT4Sjmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5HvAlAu/qEKiKroJz623TmobdvJgPNz8/GRgBIAZcp/+BoZY20PrKwPC6Yq766vw
	 qQ1WyHmb5HE01xhuBAlI40BMzNuKr3TmvvGzjbk0PtIhU8wV0K8vPa5Z+OHhZ9fDU0
	 kE6lJ9b201alRRGtIVFMPe9iJnZz/DDEE+mqttNB9K843UkSvNSgWSKaX8XBBSMI5L
	 /+IWU59m1sqnrnlCzNVjXk4fs7N7yk35POJyQ1kkmVRGfNU6O2iC27Kv62dTvt6G+w
	 ijy61b0na401rqQopN+CjSUxa+fSsT9lrbgeaG1xWHQ7tej1OOE8e4JkrmmZAOzgQi
	 BQ1gkegWHVYsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 50/51] cifs: handle cases where multiple sessions share connection
Date: Mon, 12 Feb 2024 19:20:27 -0500
Message-ID: <20240213002052.670571-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
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
index d53e725f6be5..5551f73e2207 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -229,6 +229,12 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
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
index 62596299a396..0067712f0537 100644
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


