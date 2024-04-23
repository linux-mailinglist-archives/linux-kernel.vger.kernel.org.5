Return-Path: <linux-kernel+bounces-155010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F048AE44B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD4BB25351
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87A85639;
	Tue, 23 Apr 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPq94+6b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B284FCB;
	Tue, 23 Apr 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872404; cv=none; b=CvN9bCnPHM7UBFMwfa0+1MnhMzLDD+MHJjqJTjWGo5lyBQ+ToyBvxg9JrqBZPtMeQ2/XOVhfqj2z2E17SCXLE9f1wFWqSZ8H9V/zWRipFI10JHcr04C5VOR5hf7XFQ8n+b2gwKLuy0ii7is6xTe1zBikyDQn30hkKXi6inbOQSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872404; c=relaxed/simple;
	bh=Gr8K871TzLaNpZVkCi2hmx9Lyr3gDUp5Ll+ni/+Pssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctW4bDHnlEypYEXjgH7QxZskdpVucL03nb9l7aG1jxpmPwkUDNyKcWN77nNjdaSEwsldkMbi3k55UnuAJkJWVDxZOZzzhutioU6gaVz5l+/mKP30oUGw0bQPbkXXs85O3DBVg2HGOdLLN/TvcaQAHFdzpvyTMp8AHG8na1Y22fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPq94+6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D1CC4AF07;
	Tue, 23 Apr 2024 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872403;
	bh=Gr8K871TzLaNpZVkCi2hmx9Lyr3gDUp5Ll+ni/+Pssg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPq94+6bEBwKVI/clbJKJljAa87YME5K+oPIDW56AvLf1Mbi6JmK6O/KMfagBoUYa
	 TWVzWw4s9DXpQYiAfpqLakWFzg/Ll8bpJO/2xpezsl16uKag30QmINVelrpfeFlW14
	 suw4KmZy8hBzZFIcllIdV4EYEly7HE2WK/CJYr2kWPTEokHsSkw1znXn7jeSqzvap0
	 2LL12fBlKSf8rQ6iOjMnz5Gcowtm0O6qC4xpcVKFIq6qg08R4BsP7UuS16Wm4mR6BS
	 wB4R7sHVgjSJexfN3jTTZM8edtC2Kmpc50d8lLTZaZMxgWBE3adqj5yBkV3tn9jeBl
	 P6/48hmczeavA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 02/18] fs/9p: translate O_TRUNC into OTRUNC
Date: Tue, 23 Apr 2024 07:00:58 -0400
Message-ID: <20240423110118.1652940-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
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
index e337fec9b18e1..ffb76ec3cd9b3 100644
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


