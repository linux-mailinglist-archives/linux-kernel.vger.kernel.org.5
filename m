Return-Path: <linux-kernel+bounces-43328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F727841233
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1201F27D94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A90315AAAA;
	Mon, 29 Jan 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6U3RUPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C315A4B3;
	Mon, 29 Jan 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553314; cv=none; b=DmlBTnLrxtV7j4V81vcJXgMmKgfcsaO9Qk/WPvpojYB8xVsQcp7ctgw6DYHW6Paf1j7VoZXHIAl9Z44FrR967JecB2OQ+PSK7lODee3BEdJ+3JtRZx+ate1WbjMyD5FevZYdxgbN8R7mCYKZ4Gvm5sx5/FC6A9SjZIXkzjtUYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553314; c=relaxed/simple;
	bh=mKe94oXHijUCD41Gsl/vdEsMQ4NY3znazbTmZLqIyLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoYeOzrUS3nwE911yGkDQuPbhraMzRpo3W+zzf5UDKvCsyybYrq8KIFpIWANXqdDqpKlOhCUHDi6hZOB+rUZJbzHTB2IUkSYIJef3pJecCtManghDFXYWhCI0vDZ2FwrCgbn3WavLHMNfW9kirRq5HT7BkcJi9hlY7EGl6B8LrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6U3RUPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C964CC433F1;
	Mon, 29 Jan 2024 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553313;
	bh=mKe94oXHijUCD41Gsl/vdEsMQ4NY3znazbTmZLqIyLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6U3RUPs/bgdoFS0sq7LsNtvfB1wRjCUgUB7fvWPsmWS+p6Zlio47/KJfGdAAJHO9
	 iP8PdNZNnKfDIZJtDys5wt6P2oisLCDj+BBjB3sRE4sFJ1E6V9NuUz7G6hmZBimR4/
	 1jBw+D2k4CfdWuodXoDzC50VxrCh1SCTpp0gmrsp9V6q+q8omOMq4Mo4uMbPDP0Bvx
	 9ig8hZ1BaHikhpv3v8BP2bbNGBq84TnZ0unRcZ20BxJ7l5jZRiqAZkriGGM++Lbneq
	 8cBZ6RTlqTboLoshaeM7wtk8nVnEzcwqwvqDfOak9GBf5BYIHbsLfZ6vl1hSqwBkGT
	 TXEnC2nHoN6Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.7 09/12] cifs: open_cached_dir should not rely on primary channel
Date: Mon, 29 Jan 2024 13:34:18 -0500
Message-ID: <20240129183440.463998-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183440.463998-1-sashal@kernel.org>
References: <20240129183440.463998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 936eba9cfb5cfbf6a2c762cd163605f2b784e03e ]

open_cached_dir today selects ses->server a.k.a primary channel
to send requests. When multichannel is used, the primary
channel maybe down. So it does not make sense to rely only
on that channel.

This fix makes this function pick a channel with the standard
helper function cifs_pick_channel.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cached_dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index d64a306a414b..971892620504 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -151,7 +151,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		return -EOPNOTSUPP;
 
 	ses = tcon->ses;
-	server = ses->server;
+	server = cifs_pick_channel(ses);
 	cfids = tcon->cfids;
 
 	if (!server->ops->new_lease_key)
-- 
2.43.0


