Return-Path: <linux-kernel+bounces-109285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4E881722
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409172825B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693186CDCD;
	Wed, 20 Mar 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtivLhoG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6456BFAF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957927; cv=none; b=F2qRReyl26CyxfIBlZX8SKPVkc6Rhf6XpOLuRPl3P0Br+AC4re3HANvnj4uXGOsAL7XfAPaIK8vzDjP05FXyIFCcVLkthwkBigdE85WCPhzJvFPFmg9NwDB4qkTLsEJ5YqgpK5GVKEgM1dB/rn3UItJ1W2xI48B3jiZR0wtZToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957927; c=relaxed/simple;
	bh=1s4aUZIPBocoXACMhS7GE2BVp4kgHGLC2CJJXZtE8DM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aNfLQ017St+jTwNyhzia/kt7+hvI1mwRqhAlwlDoM5bLnFvnGPHhJjQyL8pDA4Pl+G+I2lHiPwOtlJa/GJ3Y6nNzyLmR+R+6glXx8KaFR6RKjy0wubXyuS9SdhJoQkBcjgzP7bv61sghztpMpqkmTyXUFgnKcFqejWx8w3OFC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtivLhoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0244C43390;
	Wed, 20 Mar 2024 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710957927;
	bh=1s4aUZIPBocoXACMhS7GE2BVp4kgHGLC2CJJXZtE8DM=;
	h=From:To:Cc:Subject:Date:From;
	b=jtivLhoGv+fG4nwY/BGLtXmTeb9SuJn8VWFtcs4Zw0sMkiavpZ0Hu5pmm4FwoNmr/
	 Y0HhOyof45+8lJzfum7+lR6kO82upFjCcw9/407KxWWM3Q4yRgrjb7aD7xaDbcnq4S
	 xCKCgemMM8auj2ALZPpieppwRD6POdJL9AL2FAd9GcX3OMIPCiLG6Ko57m1ER8XPKO
	 4KeatyKtrNyqztfFL6iIoHHXczh2OlqLXF7RMonZ7yj2hFPXHP3WN85z/edlybZf8y
	 04GJdKsOn9vkjXBkMAGH60eIdWFPX0EI20RgSuXorqWOwpk1ccjVihU5is3f6xgEhV
	 MzwuV4GchGPMA==
From: Arnd Bergmann <arnd@kernel.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin Brandenburg <martin@omnibond.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] orangefs: fix out-of-bounds fsid access
Date: Wed, 20 Mar 2024 19:05:16 +0100
Message-Id: <20240320180522.173616-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

orangefs_statfs() copies two consecutive fields of the superblock into
the statfs structure, which triggers a warning from the string fortification
helpers:

In file included from fs/orangefs/super.c:8:
include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);

Change the memcpy() to an individual assignment of the two fields, which helps
both the compiler and human readers understand better what it does.

Link: https://lore.kernel.org/all/20230622101701.3399585-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent this last year but never got a reply
---
 fs/orangefs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index fd20ed1de4e9..c714380ab38b 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -201,7 +201,10 @@ static int orangefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		     (long)new_op->downcall.resp.statfs.files_avail);
 
 	buf->f_type = sb->s_magic;
-	memcpy(&buf->f_fsid, &ORANGEFS_SB(sb)->fs_id, sizeof(buf->f_fsid));
+	buf->f_fsid = (__kernel_fsid_t) {{
+		ORANGEFS_SB(sb)->fs_id,
+		ORANGEFS_SB(sb)->id,
+	}};
 	buf->f_bsize = new_op->downcall.resp.statfs.block_size;
 	buf->f_namelen = ORANGEFS_NAME_MAX;
 
-- 
2.39.2


