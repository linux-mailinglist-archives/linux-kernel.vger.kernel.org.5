Return-Path: <linux-kernel+bounces-155055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3A8AE4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1858B288752
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D4D86AD4;
	Tue, 23 Apr 2024 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZwIGp5r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD314387C;
	Tue, 23 Apr 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872477; cv=none; b=FlGGY1B/0TnCKArxsrJVnt0EtSHfmMfp97/s2huvs8pcG79TySWoT5davfcAkYFbcu2lKhwTI3bXTK802+cqOAcPwONG3BbCBdCv/vBbl2Vk0G6Hlk2aZR/Aspf+Z5HcISy4y7l9b4gqxxFWqU3avh8UGlAZihwepYCu2yumoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872477; c=relaxed/simple;
	bh=xlBgd5tczq0neXBkEF2gi9Ygn6M7N9E/NS6EupaMaZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSSH/fUe6Xd+5CZOvAoIU4g9ZmOmDLPWGr8rh75t5suIM9fyQ48EaC3Ym5KHrQB8CfMcOUyXUM6IaLYUqP5qWRI1C+zLqwkZBBs9A08iEBLF9tk1b+RiCOs91FQKr+BecoC8fvl13Zl7syeI16GBbhoVmr0TpHtunGlLC0nlE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZwIGp5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA81C3277B;
	Tue, 23 Apr 2024 11:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872476;
	bh=xlBgd5tczq0neXBkEF2gi9Ygn6M7N9E/NS6EupaMaZg=;
	h=From:To:Cc:Subject:Date:From;
	b=YZwIGp5rKk18h1EPnbTS+CkFlplAB6Lfn4IQBshQ37LHaTC0zRCfsRmv7XaO1n9HF
	 AHtgAWk4tZZ6d5GrFWcmCuitbuUefphhitqv6k42Tg2AdWd5ntF5zD+377gWGqsf5C
	 8RHQi99TUfk3leUVWbTISMbVH96FfuFkFORYSDnC9jMk8NspnUOFYNyMuki8xzqYxR
	 GZyf5Gt4v4+v/6VKkReOczNL6WBrALWthTfHGZatguCtlwhxJLkotz1dYPA01NaI7F
	 SS3JYpYTLMLJcXp/gdod/RvlEo4j/GmXO4b8O7UTjx2cTA/bhDrrxy4ozxFRkje208
	 2E+cCfMPjikyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 1/9] fs/9p: only translate RWX permissions for plain 9P2000
Date: Tue, 23 Apr 2024 07:02:23 -0400
Message-ID: <20240423110233.1659071-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
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
index 0d9b7d453a877..75907f77f9e38 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -87,7 +87,7 @@ static int p9mode2perm(struct v9fs_session_info *v9ses,
 	int res;
 	int mode = stat->mode;
 
-	res = mode & S_IALLUGO;
+	res = mode & 0777; /* S_IRWXUGO */
 	if (v9fs_proto_dotu(v9ses)) {
 		if ((mode & P9_DMSETUID) == P9_DMSETUID)
 			res |= S_ISUID;
-- 
2.43.0


