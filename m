Return-Path: <linux-kernel+bounces-57145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CD684D473
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F151C2285C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F9130AE7;
	Wed,  7 Feb 2024 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNcM2WqP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47A153BF8;
	Wed,  7 Feb 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341088; cv=none; b=gSYIirdGbviBKYEfMJzIu2wrkTfdHdgYqYL1GjRqqLCzs/d2gU3IJEBCLm44d1aL7nlMH9zMtd6eDbp0+ctcqpwwSxkW/wqhBjOUtFbqc8AqNZlmsjoWWQNeqE9EuFItZAUYt/7FGpJ3G3Cs4R+q4y+3mZHeQPiaAs9TRVOAYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341088; c=relaxed/simple;
	bh=DsFNP76lsmo2sZpGtNOJGnevy8kqTOxqFRXw17KcsUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWrxvKoGcIpuSQTkwUaXwRwfwPt5mUstZQuJmU03wsH9VyD6f6HsbZ3qEWvPiG+rWxEOkGtyynXKnbPGSFLk9tA4vBLDfBn2ey9W0OkI/cHhhTEL739BET3dzhw8XEZMhDShJLIwGk5Y6vsK0fGfjDX+3u8NXAuu3xOafFPr6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNcM2WqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AA1C43390;
	Wed,  7 Feb 2024 21:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341088;
	bh=DsFNP76lsmo2sZpGtNOJGnevy8kqTOxqFRXw17KcsUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNcM2WqP4f8F7KPH9qxUZgEb5ugr2UvfpsjEFGaE5V1ezYJyUIPiL9pzrDZ25psIR
	 5Uzmrnt98mU3VA+ViFySKZYHc/vniEmKHhMlYvHFHZ0mhZ4xAxHziHUWHuXfaEPHeQ
	 UZ0NHe3Z4S6GMS3EaPLSEvK6IMrRuuP2nEOgsu6NMrqCed30cZLFG2jadAvxSAXFMi
	 CbfWLzsihpnG4Wa+F0M2iCaS74iryDoeQGvAa0Y4g9ZjvCtFMee+9iYoEaTmthvZyk
	 BICCu436dUWiUV83KiKJPFOJgnrq5TgJrZk9X/eHOq7UwGgbYQ9/6vc8NJoAAo3ExI
	 k3qvr3hoEwnJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 35/38] cifs: do not search for channel if server is terminating
Date: Wed,  7 Feb 2024 16:23:21 -0500
Message-ID: <20240207212337.2351-35-sashal@kernel.org>
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

[ Upstream commit 88675b22d34e6e815ad4bde09c590ccb2d50c59d ]

In order to scale down the channels, the following sequence
of operations happen:
1. server struct is marked for terminate
2. the channel is deallocated in the ses->chans array
3. at a later point the cifsd thread actually terminates the server

Between 2 and 3, there can be calls to find the channel for
a server struct. When that happens, there can be an ugly warning
that's logged. But this is expected.

So this change does two things:
1. in cifs_ses_get_chan_index, if server->terminate is set, return
2. always make sure server->terminate is set with chan_lock held

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/sess.c    | 4 ++++
 fs/smb/client/smb2pdu.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 62596299a396..2b49a3646fbd 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -75,6 +75,10 @@ cifs_ses_get_chan_index(struct cifs_ses *ses,
 {
 	unsigned int i;
 
+	/* if the channel is waiting for termination */
+	if (server->terminate)
+		return CIFS_INVAL_CHAN_INDEX;
+
 	for (i = 0; i < ses->chan_count; i++) {
 		if (ses->chans[i].server == server)
 			return i;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index ab8765113392..bd2822ad9b22 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -178,6 +178,7 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
 		}
 
 		ses->chans[chan_index].server = NULL;
+		server->terminate = true;
 		spin_unlock(&ses->chan_lock);
 
 		/*
@@ -188,7 +189,6 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
 		 */
 		cifs_put_tcp_session(server, from_reconnect);
 
-		server->terminate = true;
 		cifs_signal_cifsd_for_reconnect(server, false);
 
 		/* mark primary server as needing reconnect */
-- 
2.43.0


