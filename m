Return-Path: <linux-kernel+bounces-57107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07684D416
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4752C289FDF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654413DB9A;
	Wed,  7 Feb 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBUZHXac"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A613D512;
	Wed,  7 Feb 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340998; cv=none; b=tzOWY/HfFYKMFo71EUrQx81L8e+IodEjwc+4om8213T61AF1QyAuqHWG2Ryk8kqSGmaTvEJ4lJI4at1jzvi7TU6M0lSPWQVpDyj2IE1jiVhPXQ66xrQnL9Ijt0VRBL5gTkoVEuYS1AUIxd6OThv+n5gft2yGoq6M7RhJgwCuTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340998; c=relaxed/simple;
	bh=iV8TDHDm87heF1yhhXW1+AK8m7ySSOw9hdNKZx8k57M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvZLl0ftxyt5U863JZySfzUChU49TZ2RhL82Zh1ES75vtzDoYZuYAzxjGT6yBQ31wdM8eEw0XNZhrTs5woCqATf+xLJ19AJbbsqDMoWD0c0gtKhUPiqHKqMz5atlTUSw0dfToJu098JDJcCzuWFqSBAjKFrEsumDh+U3YmM0NXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBUZHXac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44813C43390;
	Wed,  7 Feb 2024 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340998;
	bh=iV8TDHDm87heF1yhhXW1+AK8m7ySSOw9hdNKZx8k57M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBUZHXacq/LTMCSbpQMSMqPLKBVjtXonFZoCVOudnReY4SdDIvt4HsgnGY9lKZIbG
	 QXFR1K98WIQ1avWCKxJstVp4oZbmG/11epDMvG1i9ooqRmc3vXwWxs13fly4yRby7z
	 nWZlY/suwbIkhjSX/xqsUAOMxsNcXnUlxQbqrUOWUJJHOnPuicj+dCdhGy6Ao03Fni
	 FcSf1pJ/2k8yQkMk0yr+na9Iftx5tk2pTDPKRrJ5BQdNd4UTmL+gGiJCKdOr5okLZ/
	 0BLgSXdU5vxst9+24FOjeJYJLu3g9Bs5KweRR2n8WZr1f/Y+xM+qHoHOFH1gIuUV/w
	 0gNUgmgIGcUPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.7 41/44] cifs: do not search for channel if server is terminating
Date: Wed,  7 Feb 2024 16:21:08 -0500
Message-ID: <20240207212142.1399-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
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
index 2d3b332a79a1..b503a4833ae0 100644
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


