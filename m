Return-Path: <linux-kernel+bounces-26803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0706B82E65A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8335F1F232DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B949E64ABE;
	Tue, 16 Jan 2024 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC3ynQRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBEC64AA0;
	Tue, 16 Jan 2024 00:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0F0C433B2;
	Tue, 16 Jan 2024 00:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364922;
	bh=m5rPlNU7OgLcvCTGM6mSvAH1UFCN9n3MJ5KAXvKT+tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AC3ynQRyzjEcZ/L4xFspxWKsjoY4sQXogDrK83c7rHa5saNwaCEMyYWPUITvSTw5m
	 6hDleL9AcZpwaEYnk1KJTOHevvZooe9wvR8ftOGuwfUBjuPlQ3rOQ/APP5xMsd3ibl
	 qWBbiXaHqdG1nD0X2uWvQQuBmB8iqsQ+Y6Zi5ghgcxHSKB9BlmklfbVDTLX3Ie4ORc
	 7PJPcxJkr0G2lsHmTRuVcUTkCE9NKR0F15WsM6KSjMaUPAaljZTCqXomeyP7ZYnYmt
	 s0+2NChEJI7CtK2gYDxpyBCzThcli/wtXgpyz2sHbStK62nfquKIImZbWgwLaBqE6P
	 4wBhC874L2dTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 11/12] gfs2: Refcounting fix in gfs2_thaw_super
Date: Mon, 15 Jan 2024 19:28:04 -0500
Message-ID: <20240116002817.216837-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002817.216837-1-sashal@kernel.org>
References: <20240116002817.216837-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 29157f7d9663..2993598d18a4 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1013,6 +1013,7 @@ static int gfs2_freeze(struct super_block *sb)
 		goto out;
 	}
 
+	atomic_inc(&sb->s_active);
 	for (;;) {
 		error = gfs2_lock_fs_check_clean(sdp, &sdp->sd_freeze_gh);
 		if (!error)
@@ -1034,6 +1035,7 @@ static int gfs2_freeze(struct super_block *sb)
 	error = 0;
 out:
 	mutex_unlock(&sdp->sd_freeze_mutex);
+	deactivate_super(sb);
 	return error;
 }
 
-- 
2.43.0


