Return-Path: <linux-kernel+bounces-62689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8238852468
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E2D1F246B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85E7779F5;
	Tue, 13 Feb 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRbzN7rV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E477643;
	Tue, 13 Feb 2024 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783764; cv=none; b=n1oQ9jGrAdihkA001O8Rx8Yju/aAHzfAWKMfFuCN5CdRWjG3bH/1cDDwv0IfbOwHHzEd0EnmiWDtgGHf5JlR49KtEiEwcpYYbHlyPqeLUqbsNN7w0Tys7fYL5iWf54ftOswIkjNW9oHY5PsvVvUU7tP0eY8zc8whQCbrsEQ6yzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783764; c=relaxed/simple;
	bh=O6g1VVx5QMh4Rrd0SWjyJShEcGSxkSd2Ea0RIaJqiqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOT524HYwNgYaavNWgA3jiZZWYSgTh4o0/o75e4u0p96SSKCkyZwR7F1bH8fxckwvAf5vrhVORvcA3werc68J9eCIm2yrcpaBoDbmVjJCSZ/n3pR83Bsx+fd8iGtlmGi431NoSQ1dYguFh+pBKLxpyQMUXta8AXkdK4VOMEJ99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRbzN7rV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB845C433C7;
	Tue, 13 Feb 2024 00:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783763;
	bh=O6g1VVx5QMh4Rrd0SWjyJShEcGSxkSd2Ea0RIaJqiqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRbzN7rVDC3iWP1lG1QE1QNGpvl64213CHkSICFb7c7320ZAt2t30q4GSKy0RpXPP
	 IA3LfRMgiOmq2c1Tl+cB1XLeuuDV1hXqPMQXwheZTKXfGoey6ak8LE3W51ymjQ1uKn
	 0MR5GFW7pMRB8alJeJoHV5pS0U/pwoSlAERMRwm+q4gWmhlP7Ls0qYTcr3bQDI8Pb7
	 zRC0r3g9BtWiEKKOyr5xhc8Xu+NDeUtlvXRP8Kjk+/DzHdjRIxtBE2GyaoxTOnGl36
	 adZYokjrZ9VJHozw9bslcVo8GK5lFeyIpDHe1a5/q5C+C7xYegXQp97my3kzXWA14z
	 bFcqlHB8Nq4VQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 06/28] fs/ntfs3: Add NULL ptr dereference checking at the end of attr_allocate_frame()
Date: Mon, 12 Feb 2024 19:22:04 -0500
Message-ID: <20240213002235.671934-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index 2215179c925b..2618bf5a3789 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1658,8 +1658,10 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
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
@@ -1740,13 +1742,15 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
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


