Return-Path: <linux-kernel+bounces-49865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F2A8470A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A102871AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A3717C67;
	Fri,  2 Feb 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgCPUre4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5B46A1;
	Fri,  2 Feb 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878267; cv=none; b=vBMwd+4J7ud77E9uPmGp2uGB/btHRNCpHwb5qVUisd3gW2QKU6m48l4ro3gakI29MKOyXsBogy18TV+qg9Op7vpF4Y2VmyXVLdU3KmldNXaUBlonIl4FFkg9VqzeKSRYf3f5ZRpLlDU6qp6apnB86ELOGmxIFtI/wBxFHZBm8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878267; c=relaxed/simple;
	bh=bohs+MfRQtoEvlbrdoNXCxU86/PjKr+jUrCw8c/Vbak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f71cPalTzj17nAwPHOCFsPxfOF4NEHb3Qa4fzG/zofhnWm9+oVWHi1UkamZNa8bTigA2GXZRiz4NAe7Utv6aaxDe0VrUDZZt3FtdQtQGTIRLSvmnNhpwnVqqDKmMljVYa0uqaeDRFRxYiBKEV0whHgDboXpcT7GyLzxnzaByt5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgCPUre4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5DCC43390;
	Fri,  2 Feb 2024 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706878266;
	bh=bohs+MfRQtoEvlbrdoNXCxU86/PjKr+jUrCw8c/Vbak=;
	h=From:To:Cc:Subject:Date:From;
	b=jgCPUre4x8M4zBJWCaJb4zOgOhqI0TLLjGDrWbZBmG+RHHh5dkzO7D8EpwaWU0jcv
	 sQ3qIa/mLGTPGceZucN8231CoKtoPMgnggFHnxgYAQWYNJ3xEC9hSlHgy669XbaotB
	 a66B3kI9Sdes77idWssZiYHA1+Q2WnXBkp6Yfy2opQaCyh4sQMd/lL7GCpc5i98V7j
	 Y5/hFCDrdA0U5th+9eDblPZv9eJsSFibGRhG2EGD8lO4FBIZl9lSiyrpt2Y0deBIXI
	 g0mso1YO0bfAK1GLd7F3IIRA/BNetGiSrXCpWFqLj948v3vPfpYHCBUrmxASYzaOHn
	 KnHZqrng12pNw==
From: Arnd Bergmann <arnd@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Edward Lo <loyuantsung@gmail.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs3: avoid an unused variable warning
Date: Fri,  2 Feb 2024 13:50:56 +0100
Message-Id: <20240202125101.986302-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A newly introduced variable is only referenced in an #ifdef:

fs/ntfs3/frecord.c: In function 'ni_read_frame':
fs/ntfs3/frecord.c:2460:16: error: unused variable 'i_size' [-Werror=unused-variable]

Move it into the same conditional block.

Fixes: 4fd6c08a16d7 ("fs/ntfs3: Use i_size_read and i_size_write")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3b42938a9d3b..7f27382e0ce2 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2457,7 +2457,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct runs_tree *run = &ni->file.run;
 	u64 valid_size = ni->i_valid;
-	loff_t i_size = i_size_read(&ni->vfs_inode);
 	u64 vbo_disk;
 	size_t unc_size;
 	u32 frame_size, i, npages_disk, ondisk_size;
@@ -2509,6 +2508,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		err = -EOPNOTSUPP;
 		goto out1;
 #else
+		loff_t i_size = i_size_read(&ni->vfs_inode);
 		u32 frame_bits = ni_ext_compress_bits(ni);
 		u64 frame64 = frame_vbo >> frame_bits;
 		u64 frames, vbo_data;
-- 
2.39.2


