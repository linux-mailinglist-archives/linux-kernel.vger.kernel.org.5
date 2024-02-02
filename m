Return-Path: <linux-kernel+bounces-50381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08718847842
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC051C25B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D268131B33;
	Fri,  2 Feb 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tW8Pgvr9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E61332AA;
	Fri,  2 Feb 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899237; cv=none; b=aRYR6h3fqXbcNnDA9TdO527Ihew7VDz6jMz8sgmKxIGnyy2vnI8jqGb6aWDQ+9ncK8iJ+iFkb4sApWfaL3gegR0fuh6qulG3D/ChPUDEEFYgVqDT7RPWsrSq/cBv1HqQRWhef/YzH2bQ/BjRStxv3+vN3SJPUeOWFotkIRgNvus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899237; c=relaxed/simple;
	bh=X10j6hIkapjDwin0+mzTVm9pOVNX2fDuyoPHpwhjl5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nibgJ+bCDfhtVrMtKMRJxy9vOZ2LoIpLiDhGgcB27eaWerrf+CbF8/RnjUcmD5hVp8cOV7e8yRvfAROaZbpKQWgiVkJvk0ON4c8mF1qn1EFG5LE6pvwfeHBIBO2Y7+gw2a1EGpvUdkk49EBJIlRbX0f7tj/Rhk5BRYcgks20QKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tW8Pgvr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6518C43390;
	Fri,  2 Feb 2024 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899236;
	bh=X10j6hIkapjDwin0+mzTVm9pOVNX2fDuyoPHpwhjl5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tW8Pgvr9cU9otJ9k0NFhJEvK2Db6FjLVm8uOORYr3yYFnoF42zCDDs4d5yIhQ0pm/
	 wTGxRd1BaFSwFzyYBhDlrdTl2Ov75F+RYCDcNlNzjap9NcXJ9LewdqdWg8cuuQbzJr
	 YEeAxHkVPgGHCpBg0BjlQIBbuqtN3S7xmfF2Kgk61uqCeydH94oFz79Rpdvrv831HS
	 HigbJVl/LsE0u+seIliwklFKr9Z2f685NMhFR5k44vO4lfVBN/z5tCJVer8Di1vOWX
	 1rLSEZ4zhrm0kwYd/0sgh/ZmyDrA9NYyZ/t2HKWd8HZF3AntOHGpSb4MUHLqAetdyy
	 HxSVMCiM91rIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 13/21] cifs: helper function to check replayable error codes
Date: Fri,  2 Feb 2024 13:40:00 -0500
Message-ID: <20240202184015.540966-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 64cc377b7628b81ffdbdb1c6bacfba895dcac3f8 ]

The code to check for replay is not just -EAGAIN. In some
cases, the send request or receive response may result in
network errors, which we're now mapping to -ECONNABORTED.

This change introduces a helper function which checks
if the error returned in one of the above two errors.
And all checks for replays will now use this helper.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cached_dir.c | 1 +
 fs/smb/client/cifsglob.h   | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index d64a306a414b..ef96d5f7809e 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -367,6 +367,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		atomic_inc(&tcon->num_remote_opens);
 	}
 	kfree(utf16_path);
+
 	return rc;
 }
 
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index ec1e5e20a36b..000ed4a01624 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1804,6 +1804,13 @@ static inline bool is_retryable_error(int error)
 	return false;
 }
 
+static inline bool is_replayable_error(int error)
+{
+	if (error == -EAGAIN || error == -ECONNABORTED)
+		return true;
+	return false;
+}
+
 
 /* cifs_get_writable_file() flags */
 #define FIND_WR_ANY         0
-- 
2.43.0


