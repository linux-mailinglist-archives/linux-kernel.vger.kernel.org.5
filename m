Return-Path: <linux-kernel+bounces-155028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1E18AE487
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF371C22A67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8DE13AD2D;
	Tue, 23 Apr 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ9k+tSa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C213A3FD;
	Tue, 23 Apr 2024 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872436; cv=none; b=OhgckPmM47q713vJPKUdk92S3N5jOP10VE4phaeBr90kE9OuYT1C9fddO7boVeIaoLoeOmaONnZZGd8iRcUzSGuy9J5UwEcwgKorlRqfw1u7hwpfOYz1T4wIvjp9k1AYRoNfwp3os9gNfRz+wuaXt4vJ27APfjXGQQKJsUD9KqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872436; c=relaxed/simple;
	bh=EO0f9jWsh/qqGbONeLeQCAk5Df9v3wGuANGEEpiFeTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP2pisJVPzfeSFPONBxUVqFtczwOUHietRp1VdQUidMIrZYFvmV9Z07nCRaNE7dIYIlwb1+YI6OIl9B0MtBxBRA7sI2/8iEZuAaU4mzFSz6Yul8hr4k57kX8VC8DpTW32U5pLKV7fPJrkjEUD4ZoQJ+0YK9vaLUwSoFfI0YtMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ9k+tSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E48EC3277B;
	Tue, 23 Apr 2024 11:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872436;
	bh=EO0f9jWsh/qqGbONeLeQCAk5Df9v3wGuANGEEpiFeTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJ9k+tSaKJ1OYZgZPLlZgi0vvJhvOYNa34R24G5XMW+t6hlA3HPgydNVL7yITxvEb
	 5qkKjpz6dKasKbRxO1HlHHZiF9cBTMbHf5khYWyjSm1mZLTQQyxaUDoNivEMI1eW1d
	 zfit47KWsiqY/tzYs/C2SqUb8uCdDdP5p+OOrIJvEHNdKzvvr0H7jwF3jvplxu+9gc
	 L2u3OPwnUvZlDJlxN1rQ7b7dMlSPArvxDjiQMfB4+rQf5r93s4mkwQeR6GiDjHfDrG
	 gVpVo4N1RjcV99tjVBzF/Qqer+ncs+Rd8QrnywimRcZUwKYB/nXyT9QRgZRc5ade0k
	 stRYdSSyLTMmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 02/16] fs/9p: translate O_TRUNC into OTRUNC
Date: Tue, 23 Apr 2024 07:01:35 -0400
Message-ID: <20240423110151.1658546-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
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

[ Upstream commit 87de39e70503e04ddb58965520b15eb9efa7eef3 ]

This one hits both 9P2000 and .u as it appears v9fs has never translated
the O_TRUNC flag.

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 3bdf6df4b553e..853c63b836815 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -178,6 +178,9 @@ int v9fs_uflags2omode(int uflags, int extended)
 		break;
 	}
 
+	if (uflags & O_TRUNC)
+		ret |= P9_OTRUNC;
+
 	if (extended) {
 		if (uflags & O_EXCL)
 			ret |= P9_OEXCL;
-- 
2.43.0


