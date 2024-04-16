Return-Path: <linux-kernel+bounces-146414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346568A64F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664D01C21E79
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC013BBD5;
	Tue, 16 Apr 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/N0NDiq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F77FBC6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252077; cv=none; b=T/9iWYPDfK4CocWpWpJSWrGtpZIhYpN+ZAnBganwh7k1k6DVNSvqXLjJxtDAe9gLVLDCYi2cUkZs7NTzYGx9/m+MdHA5YvOBPf77cJwuhp/40pAtndNryg/8nYfSGYwSllInwt7RJfCm+5CQEMzZ+q05/Ou6hqNKv/LmFo0jD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252077; c=relaxed/simple;
	bh=djpKyoxPD0DIOaQ6IMcLFl5d0YTE8pMEG0ARTsy1XVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5KWXnHZrSVWDnQOR+9m0RfvZpU0JOOhf4OdqPtZrSNtoIHkUPntcQXkVB1HeMXSxsXoJlj06zsZ/N9f0JexjTH9wj4vdtwJtCZx1yOa11Vgrf8diiK3kDzmPJVeVlWiNR0PVolJwPMoo4L7iofV2lpJIgNXiCOxcVO7n1r7N7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/N0NDiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD080C2BD10;
	Tue, 16 Apr 2024 07:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713252077;
	bh=djpKyoxPD0DIOaQ6IMcLFl5d0YTE8pMEG0ARTsy1XVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/N0NDiqd9ZL7Q8iDqkpEjnMorp+1p7z58Z6PIaYlzoOqQ3QYbXnon6GN8Pt+9Cjn
	 qlEjksywYkAYutBWKmOX2isenwRUFUSr3TwLf2sC54uu9zDntM06FxjFD/Wmeg0m9w
	 +qbhvuZ92E5/zRm9WGKAxzq4fwEfNx2QqhHanMDN7BBrGo6CYBcyZbTH3gOQsozS7U
	 BEnRbc8zSF4zI19StzSPBicX5OvH3GA073yU2SaWltNXw6ucfoMjaHDQFqD0bcB+zo
	 ZQNHn3xEVrxs8uJPwznNs2oulYma54XN/ZVvE1aZ99u0HssYQpcUi7+xbU/LxP/1Ye
	 tSuKANTYjZ2eg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: remove unnecessary block size check in init_f2fs_fs()
Date: Tue, 16 Apr 2024 15:21:08 +0800
Message-Id: <20240416072108.5819-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416072108.5819-1-chao@kernel.org>
References: <20240416072108.5819-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit d7e9a9037de2 ("f2fs: Support Block Size == Page Size"),
F2FS_BLKSIZE equals to PAGE_SIZE, remove unnecessary check condition.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6d1e4fc629e2..32aa6d6fa871 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4933,12 +4933,6 @@ static int __init init_f2fs_fs(void)
 {
 	int err;
 
-	if (PAGE_SIZE != F2FS_BLKSIZE) {
-		printk("F2FS not supported on PAGE_SIZE(%lu) != BLOCK_SIZE(%lu)\n",
-				PAGE_SIZE, F2FS_BLKSIZE);
-		return -EINVAL;
-	}
-
 	err = init_inodecache();
 	if (err)
 		goto fail;
-- 
2.40.1


