Return-Path: <linux-kernel+bounces-155009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA768AE448
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07E3B2515A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38CC84039;
	Tue, 23 Apr 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLWFKZLV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A6E824B1;
	Tue, 23 Apr 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872402; cv=none; b=h+cXGDkJwgbhnDjti9hHfnsC09L1umIrctN0kq5F+ChwkLKz0v6Awcc8/y4NdopeKF9oM0PQ/LUmGPREwuxiDD5E0o/VRTiJLnjY+87nZp51UJq/HvR43TWrHl/pJT2+Bvk9Vcs0YUXVhbrbitCRf5MuRRZiGUftDWnTRVHdLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872402; c=relaxed/simple;
	bh=uxG/CkClSDymNnYyfIlf2Wp9gxXub3W6bIqP+YwWKvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jY9bcRSBLnXeVt2kMocsgI8kiqNdUm8Sp8+ktgEUWwu+fUhXFvsQJmJ/FoWQP43DrSUuv8esBQIwAP83Ozct0zWjljciSG0YCK0BTvHFbfSuwYkSYoNHIlYC3Ve++3BaRqoFFBHpnMteJrk3gDpzVV1olDz/l0QcEBKYEBJ6sG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLWFKZLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8557AC116B1;
	Tue, 23 Apr 2024 11:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872401;
	bh=uxG/CkClSDymNnYyfIlf2Wp9gxXub3W6bIqP+YwWKvE=;
	h=From:To:Cc:Subject:Date:From;
	b=lLWFKZLVRhTGthnayGFse3ryC6sBCPPRKAPeVAtE0J+LrWdhmSeSzj/Bj/aWn4271
	 e6rBSCP6iHgdx+C29TUh/OAgGP87pxNDXuyi2ao45Iv5qgYkkOghCsW8msIDGKDv0w
	 j+c3Xe7puLGMn0lvY370CLlOeLknf8c50Ftnkd4r7RTQ+Zmb4NfziDi7enElSxPups
	 gpHe6ybE74sw/d3dwcI5EpKlvqEV43JATLyH9Fm8yBdaz5UfL5j0uM8/xvUT9++koa
	 GwZn1DHXIRR5vPsZ4wV/1FlVJRG4jxhiy8i3sY9SVbYyQT4bSZg/mypLZi4YuSHs+o
	 IVb90y/x2HZqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 01/18] fs/9p: only translate RWX permissions for plain 9P2000
Date: Tue, 23 Apr 2024 07:00:57 -0400
Message-ID: <20240423110118.1652940-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
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
index 32572982f72e6..e337fec9b18e1 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -83,7 +83,7 @@ static int p9mode2perm(struct v9fs_session_info *v9ses,
 	int res;
 	int mode = stat->mode;
 
-	res = mode & S_IALLUGO;
+	res = mode & 0777; /* S_IRWXUGO */
 	if (v9fs_proto_dotu(v9ses)) {
 		if ((mode & P9_DMSETUID) == P9_DMSETUID)
 			res |= S_ISUID;
-- 
2.43.0


