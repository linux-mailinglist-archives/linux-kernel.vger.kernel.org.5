Return-Path: <linux-kernel+bounces-155046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94198AE4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175691C22E89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4563013F458;
	Tue, 23 Apr 2024 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0OEvcM7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7A13E8BC;
	Tue, 23 Apr 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872462; cv=none; b=cFYEw+HnRx/03lxTydMf3nNtMJuGWj5WsddyZe1Q9w2QuQbSBv1vtaQoZlsIiJVBPYd0+J6sg36HbgZ4mdMf6OzuUppiwEGpjsh5Cd30rY0ojA3KId+WsAMEO7EWUwcvoeoJFzV2sOr9W31+S4LU02yEEicqnvLbUkxJ2pucnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872462; c=relaxed/simple;
	bh=N5CvA0kzhNVnwmYknNTI+zmx8qwLZ++XKkjhBDdFhoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWC5qq9ICkJmpvv9rmULVj1bSu5vLflMM5OEda8EGMxbYaxxu2bwbzBjEpDRlBPA7Fix4d5jPZmrAdMgzL1DKfz1LO1lOidOTAecPMEEUI8snA3d3eC7gjUatzg40fazRhBJnW6ZposA+eELY+PuqiFx4yaJ9Wazgkx5bt51+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0OEvcM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAA6C3277B;
	Tue, 23 Apr 2024 11:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872462;
	bh=N5CvA0kzhNVnwmYknNTI+zmx8qwLZ++XKkjhBDdFhoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0OEvcM79bMUupCgSa1hEiNiNE6pHHqa3kCbh17vbzcK8CDHNDj+xitMgSEwQLZGo
	 GqUkkz1KY3e9McTLrSMmG2nUX2C9nBtO66vzx9VVLrsyQisVGOHFhdX8sj4AMtvDMR
	 RDaS/pGtx92nwvNGuUDTG/QzU75L/llz5bTjR+JipfXtIsisf9jjH8HIb7ezJRYk7C
	 57BkN2mYe8cz1mOw/ZcTnuDdsFZO8K3Q2noUmgfFGRe/tKkkaP1aHUYtC1BlgtdMsg
	 SD+QvNHCGbIVWTFlW54CJiWysst+iB0ien4DPaywNPATxy9zYgk3+b17C4ybBGh86c
	 9vC4SKpsPYHcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 2/9] fs/9p: translate O_TRUNC into OTRUNC
Date: Tue, 23 Apr 2024 07:02:08 -0400
Message-ID: <20240423110217.1658879-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110217.1658879-1-sashal@kernel.org>
References: <20240423110217.1658879-1-sashal@kernel.org>
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
index a0c5a372dcf62..8f287009545c9 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -181,6 +181,9 @@ int v9fs_uflags2omode(int uflags, int extended)
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


