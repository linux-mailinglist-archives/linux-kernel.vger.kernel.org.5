Return-Path: <linux-kernel+bounces-62584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2EE85234C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0106B25A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C742208A;
	Tue, 13 Feb 2024 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU/scv9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE136210E9;
	Tue, 13 Feb 2024 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783536; cv=none; b=ImUU7172AfUDJIE0o4zQQIYju+ckIKVJxYPgCzXo3ykXJzf4G/wghL9fejEBuF/7yor5yl7yTymiOMDZ+QAK4WxPyGMwTJ7NPPv10Kif9NkL3VVQj5AUc8w4tom/croBj/VHPffpOgs0ZZvkIDbPfHgCWvHRfLkfcjvA6njobxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783536; c=relaxed/simple;
	bh=XJ/yE4/VzELE2NuVOHXY7KLGljvdrWPIc06nOowYOE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeUXxMXvEt1v9WcCITTU2kMtf+ritLDwsvHoNhWbsmVajQfBghK+8ykqeuedoLGgUb46/akK8lckzk6JTMUIQf4s7tBbytidFq+EViI8SSUSALosm4ou0xr9SWFMI3+w6HFBe33963J3aj8+BeUG5KaLl5+1tXjBql2YbV1LTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU/scv9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A0CC433F1;
	Tue, 13 Feb 2024 00:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783536;
	bh=XJ/yE4/VzELE2NuVOHXY7KLGljvdrWPIc06nOowYOE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LU/scv9FwM7MxVnTi4LALganllK24pLhU1Yyg+gFxK6yGbiye4V0X9tKMZEaE5Kl0
	 NbQEKUbsnAP6AiO3/TeWyLqWF9dur43Fxnh8uvVSIItsa8IujQo9S5nSg8rVGK36Vy
	 Z5puGWoca1bRNZFgLIV8RxI4LsHlmn7NxIeEFVYebxQJwc37iaCwOyC9zrQ7+VYT/j
	 aicqpgmfQnZEKPnabPt3BDpSK0ri5w/o5dVV807Bi9cvZ5xo1GGKzf5tbwdEO28l5U
	 ZTis2j5fNge8Z/nB1fawxyLMd86dIHkLQu0HnCp/IHR9o73+KJfUAsm56IHAQ0Ag4M
	 Vd9elc9TcrM3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 15/58] fs/ntfs3: Add NULL ptr dereference checking at the end of attr_allocate_frame()
Date: Mon, 12 Feb 2024 19:17:21 -0500
Message-ID: <20240213001837.668862-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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


