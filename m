Return-Path: <linux-kernel+bounces-155064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E058AE4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED023B263B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E90112B17B;
	Tue, 23 Apr 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbDiYjv5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1CF12A14D;
	Tue, 23 Apr 2024 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872493; cv=none; b=WjE3LnF39G2Hx4M/UXxwcmOUrCQX5V3Mp/yKEhc5oQgwjnWNu3pkeYIv6IMa0WNRrA1XmPVwBpGQK+55mXMIyqJD9oJpt7R/u55+zU/C/zjTm2mYMr2HIW9STmDmbAGvW97hFit/gWVCPn8kYwfIuaU/XPGLhYTWeRJ5dFgL+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872493; c=relaxed/simple;
	bh=Khs07139aQyjFwNWRiE6gp6SX0SSu8LGSaVSC7BkSr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blOUEBfr3wtN++Xr6NOYBHGF2QwH05Oqdppfm7GGrLoinGGjKsbeuS0QsR9jZSRtm4CUvuYaV5jh2Fm499KLhOOPp/66eA/gQggFeSY//ZKxQGfu7sTCQlVwBf+2Bi9btme5UsSHujzwc5pKB6vzJOQogdHjzux/ncsyIlMBPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbDiYjv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83732C116B1;
	Tue, 23 Apr 2024 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872492;
	bh=Khs07139aQyjFwNWRiE6gp6SX0SSu8LGSaVSC7BkSr0=;
	h=From:To:Cc:Subject:Date:From;
	b=CbDiYjv587ns7luKcOuizWRNUnw3FbqGPlA+iZBiwkM0RxdCD6aH1Srwi6kKVWFNe
	 D6KS3eNuoAnHUNEyv/22FA3nPiPmP5e32+x6UwsvWvShNakUYgYPcsDFEKTU9SPeo6
	 YR3bJaHdrFDftc9+lp7Ay6FLlZx3/MvxdxMSVpo4kvmHrhWsaVk9STa6JNYmIYBJT1
	 xZIzevSUsl3y0x9Uu0nQ1E6KWu8XQkG5F+QBsDmYwsv3oQLfFreoqHanNKn9Bray/0
	 zpT2WBu5WuvP2DJHgbu6KEIzjMpfS20F5RcyzbnuBo1vEEL8N9UAipj0Uz9P292muR
	 15to7l4Xkv3cA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 1/9] fs/9p: only translate RWX permissions for plain 9P2000
Date: Tue, 23 Apr 2024 07:02:39 -0400
Message-ID: <20240423110249.1659263-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
Content-Transfer-Encoding: 8bit

From: Joakim Sindholt <opensource@zhasha.com>

[ Upstream commit cd25e15e57e68a6b18dc9323047fe9c68b99290b ]

Garbage in plain 9P2000's perm bits is allowed through, which causes it
to be able to set (among others) the suid bit. This was presumably not
the intent since the unix extended bits are handled explicitly and
conditionally on .u.

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 0791480bf922b..88ca5015f987e 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -86,7 +86,7 @@ static int p9mode2perm(struct v9fs_session_info *v9ses,
 	int res;
 	int mode = stat->mode;
 
-	res = mode & S_IALLUGO;
+	res = mode & 0777; /* S_IRWXUGO */
 	if (v9fs_proto_dotu(v9ses)) {
 		if ((mode & P9_DMSETUID) == P9_DMSETUID)
 			res |= S_ISUID;
-- 
2.43.0


