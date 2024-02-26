Return-Path: <linux-kernel+bounces-80378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792CF86678A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3509228182E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE16AEAC7;
	Mon, 26 Feb 2024 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kba7Cjwy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB2D53C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708911142; cv=none; b=qTUEGNAfOT8Wz+nSeSZK4hUzWPH24ynltqww4ba4OJJBrLHYSb1uT/aHfsRIL21SJPd+ygDYwjcq3+Y6V75QnaiGW0RwjgaXttPtdyLX+vc+Nky9NJG2AqfCZO84xddyQc0JxEcVXV7kFVLlFLpdibdBwjJmyGEkz50OX7+FE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708911142; c=relaxed/simple;
	bh=A4yz3LRTSvapt9o8FbzBxwIf+iiKoUhwLj0hcQkJ+Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AcOUjMEK+H2z8cLKASBv+XUzRdgany/QCVPUsb17BD5IPB0S5zcWlVgasK2SL2s6G0jnFmfpcHlbll8bfc6S9/8vDXzW5FKwu+UbvLHtVOhNxrA/63hsIVguGKXqADzmPg5uW1RH7EZn5D+fG6DnFdS8AQBmJHWRXnTAaqvI0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kba7Cjwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87233C433F1;
	Mon, 26 Feb 2024 01:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708911141;
	bh=A4yz3LRTSvapt9o8FbzBxwIf+iiKoUhwLj0hcQkJ+Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kba7CjwyvYHZYqaueT48znUox1iICesihe//v1MzldqInj0Axh8uIvIfBjn+h6T/6
	 TCqvnsiB0U6qFKtp0I7a2S7tBvyRGZoGO0kXG2dw1ERyFzI3+bOctLMqV2Ri/LbDIV
	 XtFDkbFXIpHuv+baKXjHLX/KsG+0uyTmNtt4/2h/FlAAzfaNPqL/HQU7ZgQ5ffPzDv
	 XEp7AniLEMBQsfyArGdqI8+sQy0D7i1NVN9HcLjwmJwIXH2BkdIrModkOfqGQ0b18E
	 9Zpb4EtqwTcKyakW2QPyKkX9BLFTdkYizPcvgCpU4q8VlRi9K6ZpEmX+X4VYYzcmhA
	 odIiTNwigmV1g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/4] f2fs: relocate f2fs_precache_extents() in f2fs_swap_activate()
Date: Mon, 26 Feb 2024 09:32:06 +0800
Message-Id: <20240226013208.2389246-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240226013208.2389246-1-chao@kernel.org>
References: <20240226013208.2389246-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch exchangs position of f2fs_precache_extents() and
filemap_fdatawrite(), so that f2fs_precache_extents() can load
extent info after physical addresses of all data are fixed.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0c728e82d936..bd8674bf1d84 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4045,12 +4045,12 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (!f2fs_disable_compressed_file(inode))
 		return -EINVAL;
 
-	f2fs_precache_extents(inode);
-
 	ret = filemap_fdatawrite(inode->i_mapping);
 	if (ret < 0)
 		return ret;
 
+	f2fs_precache_extents(inode);
+
 	ret = check_swap_activate(sis, file, span);
 	if (ret < 0)
 		return ret;
-- 
2.40.1


