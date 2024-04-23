Return-Path: <linux-kernel+bounces-155045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCAA8AE4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3EB1C22D73
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07DA13E8AF;
	Tue, 23 Apr 2024 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ8VzOXa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E278405C;
	Tue, 23 Apr 2024 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872461; cv=none; b=GDbKuTm9FwSHQ9wj6Ca6TzlrElu9QByS42RFmzP1Si7KjuYzZ+2qOetiIH77nql0jz762IMHT/TpKJUd1joy2kOWykq2E6X5OEo69WsAe9kClxzzkXo0B8O3wIznBAPfUgd82Tx5HX8dWffHs9WPNHX0P+3LT9mqieWGNaiJ2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872461; c=relaxed/simple;
	bh=u6atV+OLMHNTLY8+wu0KG9l3vCscL5GRgW7Lt3EVGEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kx210lpvyT4LTidTjEMLhxtEN5y/y4oBmIuI5vHMguElJmkwuFT5SYW1HkmrKFtKXroyfyKsXLv9H9sNkqHvFsN7YE34mJUTVbdoLeIrMNpm+qtZirR12hBErjrXAHqp9vNPyPeIkk+zntZ7CgZZNVTy3E8Wif9zOT6kj5pgXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ8VzOXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C8AC4AF0A;
	Tue, 23 Apr 2024 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872460;
	bh=u6atV+OLMHNTLY8+wu0KG9l3vCscL5GRgW7Lt3EVGEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=HQ8VzOXakdhZW4HirWFX19yxcL4cdfbn4R3D9vRYXzVKBXmk9w+Xn+kGQ7Ke/Lz2z
	 DzoGbP/m5005VkDZxiFtSIIYnIPRRcUgwyBmcNK7MmDgP1+MvgufGGSZHDwmJ518ch
	 Hiusiu/eKxBCmIilYKdZS/4UiFROqI455fv248uJjgdNZx9EjtOnDzfeJrmx8iYysn
	 uwMZhRDu/PNggMurHIEIB3KakJSzxnlB7F3/fxiUrwwdIRi2jUw0yaAeYEN5aq0Ff4
	 J1o0DwBq/HdgbeDz+IzZZ1H+vDhmiqVD41bIf9NKYCEa9zslXLOOZQ5Rk9ua+wwul9
	 ljnYcOD5GoRYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 1/9] fs/9p: only translate RWX permissions for plain 9P2000
Date: Tue, 23 Apr 2024 07:02:07 -0400
Message-ID: <20240423110217.1658879-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index 5e2657c1dbbe6..a0c5a372dcf62 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -85,7 +85,7 @@ static int p9mode2perm(struct v9fs_session_info *v9ses,
 	int res;
 	int mode = stat->mode;
 
-	res = mode & S_IALLUGO;
+	res = mode & 0777; /* S_IRWXUGO */
 	if (v9fs_proto_dotu(v9ses)) {
 		if ((mode & P9_DMSETUID) == P9_DMSETUID)
 			res |= S_ISUID;
-- 
2.43.0


