Return-Path: <linux-kernel+bounces-155056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6BB8AE4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADC0288904
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB877143893;
	Tue, 23 Apr 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhZDUmY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74FB143883;
	Tue, 23 Apr 2024 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872478; cv=none; b=Iz2JOi4XHcaAtB7t18AsTRYvzix5hEkB1XSj7Q4vYK18HTeQLKeI1TXLWMoJTTOG+JqolfmJJ38NBMmM6F4/Xos4m6Q2D2bh9ccOAlh5L60JzlFXRPq3wamgpo/Bb1NyKhO0M/3HzD/n8osQFvUuPMV6uC0mRsfy6D8ocE2DFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872478; c=relaxed/simple;
	bh=g4dZJJoeF61zBO7Dry8uQjsDxb4e43Q0JLDwHGtaS+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+gKUDJ2yOxeCFaSCe9Ne+ZA4JXQFiTjycW2V51fwEbgnHPfH4Dn7ztca8QlytNolnQCcpPfW72MIg9bJJ8x1SMBbZhobqr15jLB4nDg8w2RrA/4VW4iiDO6e2cwpLJ2r5bIJnTMz0S5b5mrzArtOzy64OymYApwdNjYxlTABPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhZDUmY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CABC116B1;
	Tue, 23 Apr 2024 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872477;
	bh=g4dZJJoeF61zBO7Dry8uQjsDxb4e43Q0JLDwHGtaS+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhZDUmY5Rs43cRulKPG0LxF+tW7ERzulyZiBMY8F8t9L2/Hy3NeGJh568jq96vmx1
	 XANNMlBQdJkIXBrqT7k/GG438vvbgqj3HuUsXWakxS+H1mKI7QTNSB58wyuy6FRhAS
	 2FR1zAuvi50ExKvLQ3z5EC+CqsbEqK84PQJIgkd4hlwFqzC+M2aMVo4/1p9TtaYEiC
	 oXaWzhR1BzuhVd+5awzsr/P+FkCz84TMQ9ja7PsxT7MXNa8kfTAaCuAI0cSE1Utp8S
	 2fxnYp6cbmV1kBu3SLz+FhFnv/XCM/asXSXAcXHLebxGTEcxFy/YGb5pzclQcf2YCm
	 7W4CubrACi2qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 2/9] fs/9p: translate O_TRUNC into OTRUNC
Date: Tue, 23 Apr 2024 07:02:24 -0400
Message-ID: <20240423110233.1659071-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110233.1659071-1-sashal@kernel.org>
References: <20240423110233.1659071-1-sashal@kernel.org>
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
index 75907f77f9e38..ef103ef392ee3 100644
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


