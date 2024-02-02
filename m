Return-Path: <linux-kernel+bounces-50359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9258477FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB25291EA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633383A09;
	Fri,  2 Feb 2024 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFwcvtjX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56B839E4;
	Fri,  2 Feb 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899188; cv=none; b=flAue43g3izjCHFLW9yPnvtpoQmvKZszM521supQ1mSzOggA/ggZ5gXRHYLUpZerc1NQv9oMDeJO5nawXChcUpLhXS5ESR86FB2YPYgON9J4HuXfPrdUIUv2ShSa7rpAS7+Qu/c5xevF9o3u1adCJvRREu4shn+8PJ2ZCXCe/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899188; c=relaxed/simple;
	bh=h8jXtTbDF3QcVqF2+aNfPyeCWx7zVJBEkorWh4cJrmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw7fP5i+z7cO6L4OzYOwTgdRW+LowDR9vDAW0cFfzelXIopfe7ySZeaxbumDvwbCs8luG2zFdHaQV6J9x3tnvJ7WzzsaN8GWKSbSEH6Uq0S03DITQn+cjfRn9EV3QgpAtiZWrRURGnfpdiD7TNS/wIkF6WmhFP5lfEgSk6Lkh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFwcvtjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFB7C43394;
	Fri,  2 Feb 2024 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899188;
	bh=h8jXtTbDF3QcVqF2+aNfPyeCWx7zVJBEkorWh4cJrmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFwcvtjXm/M1QuRuIO1iQqGrTQJ/KkmQn5f327MENghcZTzi0UtRfWJK727GUmYfF
	 rXb34G1oXR10AxLFMCAgx62JufFlIWsvNnSfhXTc/vCw4LhpXdu1Lwi5eKxJkVXS5g
	 q0d4HKsAB+Q0rl5ppc9iRPFjmITwjub4UOQl1vS7bSI75HpIYXSrkgZmsbuExNC/cs
	 5JRlWLlAUKWMJhJ1uL3bpyPzkm65/6zb18M64W+hSodHbRNM7As2MfxuLcx4FkNlVr
	 mOcLSKwAkaCdpmXbGc1/gsfS2B1XI9BxLqrFszqzIOxHcqTqvPXCAZPVLY4jnJ1nLK
	 kGEJBsd5sW5Hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.7 14/23] cifs: helper function to check replayable error codes
Date: Fri,  2 Feb 2024 13:39:10 -0500
Message-ID: <20240202183926.540467-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
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
index 5e32c79f03a7..aa9b898de4c5 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1806,6 +1806,13 @@ static inline bool is_retryable_error(int error)
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


