Return-Path: <linux-kernel+bounces-62644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A4C8523F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA650B213D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2D60272;
	Tue, 13 Feb 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aboQWC2h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE56025F;
	Tue, 13 Feb 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783668; cv=none; b=pD4a9u2CopA2itS/ufdXwfXxRUEzQeXtt4hTDP4AbKbBhL4W4MzyR1N4tsVh1nXbJu+tbYqa6aZcKxDmH6U+OC/hs4nm0IjQuX64EBDVwIYcQQ9OlR+jMEe+uetzxW45Hfb28o2Qy64gVt0Cxx8x9EAl07UgRF68pMgm+6qQqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783668; c=relaxed/simple;
	bh=XJ/yE4/VzELE2NuVOHXY7KLGljvdrWPIc06nOowYOE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oI7Fv3Mge86I2T4phThTBEJ8/wy5CEalzmctodzjCyyOMOC0rwSf9udCLLNsQVr5fkDifhz4rLkjPxYvR2r4ZyzcKrO+qgFUjpBorwPaMccf1VM9956du+iO5SPPHXukmYBD8f3l6n/WZfGQ/N7Yxil9cIU5FGLUI1O05ZWh1rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aboQWC2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519CAC43399;
	Tue, 13 Feb 2024 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783668;
	bh=XJ/yE4/VzELE2NuVOHXY7KLGljvdrWPIc06nOowYOE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aboQWC2hhxDzArMfT8BnvB9/j5iKQez4nLYTCu6rhzOloWgRw9XqLM+2rzogNqLhK
	 wTahGSb5oHwIT0tss+cK97CVKdK5ES2ZfLUjrB0/1k40ZhEEOZKrG5K9n0JJnslD+p
	 lkRfMC49Cg5LLOm9k0lKFLxlQuqQKMs7OHE97haGED1jsDF6mYx+Zu3JCeGF552YQZ
	 n7y11TqHIr39m34KHVtCjt0s+4/fzwjb9iicNvsf9Jc6w+pz6fyEwkhF7TiskmEWu8
	 dVjX06o4nhuThG/+wbz4w5u76sKu5f9heLUVQjMDL9ix1MWZ6bZdyGHCaIcuYy3Dvc
	 UC266IzOo/lLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 13/51] fs/ntfs3: Add NULL ptr dereference checking at the end of attr_allocate_frame()
Date: Mon, 12 Feb 2024 19:19:50 -0500
Message-ID: <20240213002052.670571-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit aaab47f204aaf47838241d57bf8662c8840de60a ]

It is preferable to exit through the out: label because
internal debugging functions are located there.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 4b78b669a3bd..646e2dad1b75 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1743,8 +1743,10 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			le_b = NULL;
 			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
 					      0, NULL, &mi_b);
-			if (!attr_b)
-				return -ENOENT;
+			if (!attr_b) {
+				err = -ENOENT;
+				goto out;
+			}
 
 			attr = attr_b;
 			le = le_b;
@@ -1825,13 +1827,15 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 ok:
 	run_truncate_around(run, vcn);
 out:
-	if (new_valid > data_size)
-		new_valid = data_size;
+	if (attr_b) {
+		if (new_valid > data_size)
+			new_valid = data_size;
 
-	valid_size = le64_to_cpu(attr_b->nres.valid_size);
-	if (new_valid != valid_size) {
-		attr_b->nres.valid_size = cpu_to_le64(valid_size);
-		mi_b->dirty = true;
+		valid_size = le64_to_cpu(attr_b->nres.valid_size);
+		if (new_valid != valid_size) {
+			attr_b->nres.valid_size = cpu_to_le64(valid_size);
+			mi_b->dirty = true;
+		}
 	}
 
 	return err;
-- 
2.43.0


