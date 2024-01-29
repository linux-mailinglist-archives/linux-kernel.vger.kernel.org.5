Return-Path: <linux-kernel+bounces-43344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A03841267
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322441F2AAFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309CD15EA80;
	Mon, 29 Jan 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuRMvnYc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69C15EA91;
	Mon, 29 Jan 2024 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553365; cv=none; b=duMdTUg0U0IkpP/p9xRLMz0EVJF/UWphPO28Ynxl6sMI6BUjv7UWMVicEycEi/eMer8bJE1UI34rOCkCkxKi906LOd0XlvRMlJx+/p41yO4xnb8OrCqedmdbHbl/1qWWESxQ6o58LAq5kAyuDRr8t0Sliibipu/Qh3BX6gily8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553365; c=relaxed/simple;
	bh=sF+XC8yxInb6tcbUAiZlJhPfbUfQ9pMY6cfsB1HznAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLx6EdwUQ3q4pLmUAVpavjAlQ0DOkigUPmFJtv9a5hfRJE/mzsRAy0UYUvnppqqyeZnSeyFPkDyfN6XX1ktt78XZywGFYeIcS7rcJl1iEVk1Mv4wGbkfYiewpllM/HfDeBcxC0BOq6HHy16nfImeGRnwOT7OQEobuW/2Rvu2rCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuRMvnYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFB0C433C7;
	Mon, 29 Jan 2024 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553364;
	bh=sF+XC8yxInb6tcbUAiZlJhPfbUfQ9pMY6cfsB1HznAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuRMvnYcsNzEWo74oioGM4oYZLwYbB1vOESmZmQ47M2SKhKHLQr/WWMcOM7gx7sgO
	 8R5ifscADBNLFpoYYkJJWWGCCWtsP4+kqYxm/VHpO11SCHA4Bed2x9oT3SrhCsVze8
	 KBUiHjkXb1ViD05sPJBrH2NriqMlVY0Kir8V/Yq4x0wOIPPH1O9ohEvdEu1cCQsupD
	 nwgSv6DOVCs9YfOGOsqRjG0XIV0O3sWUmaOvUfbzbr89jdGEUwYQzMaV61XUQHIwGL
	 4Kt43i3DvwbtlSBtWPOB+8gFaZYMQXpW0huf7N/e8mXU37V629bps1E8JDcG5oTuge
	 wsv0b2C4nGZpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 3/5] cifs: open_cached_dir should not rely on primary channel
Date: Mon, 29 Jan 2024 13:35:55 -0500
Message-ID: <20240129183559.464502-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183559.464502-1-sashal@kernel.org>
References: <20240129183559.464502-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index 5a132c1e6f6c..64091929da71 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -149,7 +149,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		return -EOPNOTSUPP;
 
 	ses = tcon->ses;
-	server = ses->server;
+	server = cifs_pick_channel(ses);
 	cfids = tcon->cfids;
 
 	if (!server->ops->new_lease_key)
-- 
2.43.0


