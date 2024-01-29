Return-Path: <linux-kernel+bounces-43338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA4D841253
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D42BB24A17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390C215CD66;
	Mon, 29 Jan 2024 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQw8KJ2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7997C15CD51;
	Mon, 29 Jan 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553352; cv=none; b=X5EKb7usITvyKGUKgp+RwxnMAMgUEJjbN5Ym3TeCXukBWt9UtpNNLD5MEGjfbwyhw/6jSYioMcCxp1EqQ5wcO93A7eC2p8RQmUAMi36pKpCatCFSz4DJ/L3yVV7OyZGemg8669y2z4SlwfOk1uEJT4EYrjFPFy0H4UUPewASpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553352; c=relaxed/simple;
	bh=mKe94oXHijUCD41Gsl/vdEsMQ4NY3znazbTmZLqIyLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8P40B8ng0xI8SAgNOdUx1cnLo5h7xRxot2UAzTOM7YlezJ7z2i75BmrYpBDKVDHR8Lf0Dgao3uOrwg1Yrt2Nh/t8/8GokiIc7upiyD6tex2Y+TF2E73rjzaiSzWPJ8VdKzVUliTGIQLHuZWX0TBiyVoPH0tu89QuF4CS1ga4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQw8KJ2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FB8C433C7;
	Mon, 29 Jan 2024 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553352;
	bh=mKe94oXHijUCD41Gsl/vdEsMQ4NY3znazbTmZLqIyLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQw8KJ2LdYli5zpKybfkSar9EaTpXru+ZVr4INrNhNoTjJ0U9qXq5pDXIYnYiTsnZ
	 Oap98Oh5tVNl6uaWeK/as7gBn5JZioD/Pw0oeMIto8Dp9Pa+9v1GN155gBrKPUZCA5
	 WCxggITOAQ3y51BmlJ9YNQ6A33L4xCecCAXz4P5WzxhaIhK68kXxCHaHQhQECKlwbi
	 C8/ko++jqIc4myGvmL/lxOptarxpJ29+h2I4tDSz5WRQUI1WJlM0xMGYTaYLimEiFo
	 qiqmsr04A45b0Kob+bL0+Iin1psATAmk4YnXz/+LfTO0OuSSJ9I9a2Jj6m5bzienlP
	 X7NqYyOIzhn7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 07/10] cifs: open_cached_dir should not rely on primary channel
Date: Mon, 29 Jan 2024 13:35:15 -0500
Message-ID: <20240129183530.464274-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183530.464274-1-sashal@kernel.org>
References: <20240129183530.464274-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
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


