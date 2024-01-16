Return-Path: <linux-kernel+bounces-26791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0F682E63D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944341C227E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759C5FF0D;
	Tue, 16 Jan 2024 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqPetzLa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B25FEFA;
	Tue, 16 Jan 2024 00:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EF9C433C7;
	Tue, 16 Jan 2024 00:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364882;
	bh=3jJHOPQa0mr2Qfc7Y8nOM2W7SPLwLOUsNKrjKQsLx18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqPetzLaCsXgxzwLLuJdRdzPTYZjqxwijq0bmXisph5bcaxyXP0Rg2ZFYaXzgLkeo
	 SXt/hnvM6os27JcA3mtmkwPPa629dGuwDJgC6p9LmZoqJNFYwEH98lCRS7R6zVti6T
	 0sMHQ5yNRguTxQ8HnQ7CGGU0Z34iNAx0xpnOGyvEL0+sW1Noi9s2+FfOgISXJRlWLq
	 rnD4jEjxkGvPCgHV8wEbVLonkUTXevBGXqxVh5fcKchdrq6a1b5tLBAN3Bp8OgqM12
	 PcEH5rcsGjhR4OGF05j5ehaUN0a6M3AQKE+fmXaLJfU4KOu6SWjpThy508YT03mSbH
	 7SBOUXU67hsRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 11/12] gfs2: Refcounting fix in gfs2_thaw_super
Date: Mon, 15 Jan 2024 19:27:17 -0500
Message-ID: <20240116002731.216549-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002731.216549-1-sashal@kernel.org>
References: <20240116002731.216549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 4e58543e7da4859c4ba61d15493e3522b6ad71fd ]

It turns out that the .freeze_super and .thaw_super operations require
the filesystem to manage the superblock refcount itself.  We are using
the freeze_super() and thaw_super() helpers to mostly take care of that
for us, but this means that the superblock may no longer be around by
when thaw_super() returns, and gfs2_thaw_super() will then access freed
memory.  Take an extra superblock reference in gfs2_thaw_super() to fix
that.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 15e757f76380..e6aa7e279785 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -770,6 +770,7 @@ static int gfs2_freeze(struct super_block *sb)
 		goto out;
 	}
 
+	atomic_inc(&sb->s_active);
 	for (;;) {
 		error = gfs2_lock_fs_check_clean(sdp, &sdp->sd_freeze_gh);
 		if (!error)
@@ -786,6 +787,7 @@ static int gfs2_freeze(struct super_block *sb)
 	set_bit(SDF_FS_FROZEN, &sdp->sd_flags);
 out:
 	mutex_unlock(&sdp->sd_freeze_mutex);
+	deactivate_super(sb);
 	return error;
 }
 
-- 
2.43.0


