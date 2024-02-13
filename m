Return-Path: <linux-kernel+bounces-62629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723928523D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA72CB25C75
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FC05D91D;
	Tue, 13 Feb 2024 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oxc6jgLf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9785D909;
	Tue, 13 Feb 2024 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783624; cv=none; b=jsFDt35gXu8G7lWzZTqpQyyjkcPFjWp4qgsaaox7Y2ggW74JJlUBsoA4kBdJc9yQgcWMgswwGwx/vRRnNJWsB/m3xosfPyYjhjGJw7th1OGSoeXcPD+rpcA8SDENihMq9UL1EwPL88ku/9nqOFGU1FWMnp03W2CScoBr/XYi5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783624; c=relaxed/simple;
	bh=oPMFjA9VlPUGHrEFuSDSdhxzO7uU0L5pnGwiQ0oZPEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKeyO+jt7Z9yDrTDzSUGsvV34n7ToizT8e0elWrR/THr2SsdmGkkbaYva2aMMgu942sS9UwfS64am4F3SpWrLqYB3yTH0MiurzdaIbfrn70hxk1Sfv0ZVIEj1WIaUvJHAVqv2Ryca09cRGg5/T+N2XCcTH4M1VMMJcJs6YHnWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oxc6jgLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F2BC433F1;
	Tue, 13 Feb 2024 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783624;
	bh=oPMFjA9VlPUGHrEFuSDSdhxzO7uU0L5pnGwiQ0oZPEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oxc6jgLfjCFLemOC5vUSOxh/5ltrTvYKXx4Mh/aGKa1y8TERdSMvoC1CsyRhCTLkX
	 0RZP2FeBBU1/bEkGlDNzPfk3sRKx94X+DaooluqAkcC9cvdOH1A6TRy3LIQ9lwLY3o
	 pw37o/NJvE9uuaPwse0Ex9a3ZA/EiiB95XSuwjG+qY0uFiUHE7MJJZWv2zjRej6gZn
	 BsVENGzlccPSsUxsExBZc6fwm7PtxCjuALvEMTMzpvAVnc6aRVqouNj4jf40eHv2ad
	 Ga18pCwczBmZHb+6YO1d8xlfSS0jwgLuXEJ8bmKS9jTOAEX6cG0m8mCDrmxKusi+4b
	 JSflW9YSuxpLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.7 56/58] cifs: change tcon status when need_reconnect is set on it
Date: Mon, 12 Feb 2024 19:18:02 -0500
Message-ID: <20240213001837.668862-56-sashal@kernel.org>
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

[ Upstream commit c6e02eefd6ace3da3369c764f15429f5647056af ]

When a tcon is marked for need_reconnect, the intention
is to have it reconnected.

This change adjusts tcon->status in cifs_tree_connect
when need_reconnect is set. Also, this change has a minor
correction in resetting need_reconnect on success. It makes
sure that it is done with tc_lock held.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 5 +++++
 fs/smb/client/dfs.c     | 7 ++++++-
 fs/smb/client/file.c    | 3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index dc9b95ca71e6..87f0cb95a2a7 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4215,6 +4215,11 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
+
+	/* if tcon is marked for needing reconnect, update state */
+	if (tcon->need_reconnect)
+		tcon->status = TID_NEED_TCON;
+
 	if (tcon->status == TID_GOOD) {
 		spin_unlock(&tcon->tc_lock);
 		return 0;
diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index a8a1d386da65..449c59830039 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -565,6 +565,11 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
+
+	/* if tcon is marked for needing reconnect, update state */
+	if (tcon->need_reconnect)
+		tcon->status = TID_NEED_TCON;
+
 	if (tcon->status == TID_GOOD) {
 		spin_unlock(&tcon->tc_lock);
 		return 0;
@@ -625,8 +630,8 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 		spin_lock(&tcon->tc_lock);
 		if (tcon->status == TID_IN_TCON)
 			tcon->status = TID_GOOD;
-		spin_unlock(&tcon->tc_lock);
 		tcon->need_reconnect = false;
+		spin_unlock(&tcon->tc_lock);
 	}
 
 	return rc;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 32a8525415d9..4cbb5487bd8d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -175,6 +175,9 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
+	if (tcon->need_reconnect)
+		tcon->status = TID_NEED_RECON;
+
 	if (tcon->status != TID_NEED_RECON) {
 		spin_unlock(&tcon->tc_lock);
 		return;
-- 
2.43.0


