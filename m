Return-Path: <linux-kernel+bounces-155082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBC48AE517
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D8C2839EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD6D14A4F3;
	Tue, 23 Apr 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfrJshIV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4714A4DE;
	Tue, 23 Apr 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872523; cv=none; b=ClrB4sfLcEZlXJ++Cc9uZBi2TmCbD+dl77T1fVMoYzNHINYKmCWI/I2z4xCoWko1N/SEKzETChAeCXDmwZjz4nmJJ6dqbLurh8dW2zStDYqGzbzOeN588YVA39TRUjHTaprSr9X1YIvacHdZ74o863X9PKvm9d8fkpv3nRzcgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872523; c=relaxed/simple;
	bh=8qv5nn3QTCh8dHUbzLVT7MhZOXQov3Pz+CHyf9UKg/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWQRYefNzODcNOjY3Q53J4L4Yd1eQSSQe6AZmy0yKAo+8VgMKiH42qoX3aiv0rEgK1oExnho+bWr3yMT/esLWSguTO2EhXgVWnZGPhgtgcSsC1rjWjzvJCAYIdsw7gGxjlW3S1YEOhxGV8ZtqWfvN/osQfgsR7R1aXB0cNGI11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfrJshIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B17C2BD11;
	Tue, 23 Apr 2024 11:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872523;
	bh=8qv5nn3QTCh8dHUbzLVT7MhZOXQov3Pz+CHyf9UKg/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfrJshIVhBDa0ncKrjDyXJjwlRf7AMMY4MGj3MtbwbhpU0u+y2cxWq6TMlV8baC66
	 TNvN61EzwwIEawj6gx7Ij68sx5/hpKITjslUDALe9FoCPitYAGoYsnIUrL90IZq9ki
	 5afR6KcwxCv8XSr6JuS9L5rtBLg9wxOrkNb25KEhphxStjX5zOcaLhPOfBW89dt+iS
	 28VAbk53iAK4eaOuKmMrbogliOVsO0zaKKIEznrdlBOo0tH+zq244CC/jhzN+ssTS0
	 GA9+eDtZ8E0gXgTxFOAFrsvKlDyGlz+fFBzADE7ZKN6AFzIYXO+6hQtXIy1ykY/0yq
	 vxF2NudxxGHgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 2/7] fs/9p: translate O_TRUNC into OTRUNC
Date: Tue, 23 Apr 2024 07:03:12 -0400
Message-ID: <20240423110318.1659628-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110318.1659628-1-sashal@kernel.org>
References: <20240423110318.1659628-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
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
index d1a0f36dcdd43..ea32af83729d9 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -192,6 +192,9 @@ int v9fs_uflags2omode(int uflags, int extended)
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


