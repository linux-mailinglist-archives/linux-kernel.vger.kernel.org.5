Return-Path: <linux-kernel+bounces-155027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1698AE485
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E251C228E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EB13A3FA;
	Tue, 23 Apr 2024 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAc1a6xf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BA137743;
	Tue, 23 Apr 2024 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872435; cv=none; b=a8KZ24Qye97kuBhUt4zQcSvf7myMUoIdtqDboYGqe5jKA5UChYXYYXFLZ66cTLEtyJpeMg/IKSf2KtQTaQUmkZZ4GVDTveW799fgtaQCuVnXbQgImEVjRAtTV/+9Q/7orzzuvdZeObMrEgjcVwfBIyNDtSzrIdJmbksmQ3HriRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872435; c=relaxed/simple;
	bh=qRVQSE/RK9K6R1EUJcZUf3XOwJJdJoMBMEgAaDBSqx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tylsgsM4O93xPz7ZsxHGCxCgq7fGD7Wo5Do1+5hpTc82o0e1I+i7XdCDlP/vBwgCu1zGn9jYPX6v9tK4UYAP+xPuuW8sRLBMZ+F0ZcJ61apjBH7gJSb/6XgsbvraMBd21t6tPgkA4qrMWpFau2X9ePAshIsQ1uJgcxsT4P1MgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAc1a6xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6E8C116B1;
	Tue, 23 Apr 2024 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872435;
	bh=qRVQSE/RK9K6R1EUJcZUf3XOwJJdJoMBMEgAaDBSqx8=;
	h=From:To:Cc:Subject:Date:From;
	b=UAc1a6xf2le3VSKXm433AuLIH3mxX6+XK9mznSiXuyHTTBDFLPBBDakI90VeU2/7q
	 8J1VZaGFdxBbVsYHqglWXT38gbdy4pdOiUfzwVyr6vuDdBcyHGEh97DUC/OnpVy4c9
	 kYRXw/yh7D0clHEnuRMx6f7BrI9OuZdiGsgHOmGwt38UwZ5b8gvZPspS03LZ29Nadb
	 jWy+6e6MuocnawQZgd6KQMy3u7Sm8+9MHHZKU5DgsEm0gGJKXsXTROR8LpF9dzigad
	 oaEqvb4CpH16uigRYOl1iMF0cT7JPUsVwTG+uTgHhQ0/k2WVhplRjQ2y5xHh8hEKuU
	 iFBCPFwDhOPqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 01/16] fs/9p: only translate RWX permissions for plain 9P2000
Date: Tue, 23 Apr 2024 07:01:34 -0400
Message-ID: <20240423110151.1658546-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index ea695c4a7a3fb..3bdf6df4b553e 100644
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


