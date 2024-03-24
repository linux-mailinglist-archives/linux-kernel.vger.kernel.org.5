Return-Path: <linux-kernel+bounces-114901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F2889214
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868C01F2D131
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654B62D1878;
	Mon, 25 Mar 2024 00:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i09gg5Qr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20517831E;
	Sun, 24 Mar 2024 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323567; cv=none; b=bt21z1Ak0Gk8m2lt8TzT64/ofh0kLj3XkF3IOvxlGGYBVyi6G7yK15V86W2RRc+ZIZp6iW5yXFbIiJlK0aNIAV0V4R8VfPumjuAtKylRkfTA3HPw/+X/Cx8Nx12ze2svZlcSbKh4Jg5O0S6WVrAEgVjtwQ02U175lHe9Ug6Z4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323567; c=relaxed/simple;
	bh=lYH8x8NXl+D9jSgcCFP/jUoI1eKm4X/OKybsLqIHfWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDYCvxAzKVs8bEdRj4a5/EqjGESdvFg70K4QMgiad7dlxN0wgyHyixadZcXu7hvOn/WJapFEL8gfhjTiucP3IMigmjdc2b9bH2pLzaygLBo5Bm2tTTCVb0bgOcr5Y+HRTHvc6T2OZj1uLip2Cyx26GdPfmaWPw39WRrBFo/dVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i09gg5Qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48F5C433A6;
	Sun, 24 Mar 2024 23:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323566;
	bh=lYH8x8NXl+D9jSgcCFP/jUoI1eKm4X/OKybsLqIHfWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i09gg5QrfjbIe6h109YUp0NnPoW/5qvrY6ePxDebJCPVh+PX9q9ViNJVixt3GLZS4
	 GPSh0VvIULab4ciRwHgLhJ7qa/snv+tUPnWO/jVOydbpjARtbZPAHxokP/CvwrGa6P
	 ovlX7WMahSPMqKdeDsDeKpJVmRTSc2+pA1/lDbW1A1HhplnlpqISz7DhbJGwq3bcB/
	 9XWypTOzK1dKbAl/hT+Jlzx8Zx+o1Wab+NVz1oJvEZoQ8RktKCaagCDN0cu+9a/LbC
	 /QSNvAxsqPhwfuD7rZbOeIqqwb30v3Fq03j1dMUCOZL5ehDx8hpNMdXMAnl5TK0QyJ
	 q/o1q7lLUtYFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Jeffrey E Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 273/317] afs: Revert "afs: Hide silly-rename files from userspace"
Date: Sun, 24 Mar 2024 19:34:13 -0400
Message-ID: <20240324233458.1352854-274-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 0aec3847d044273733285dcff90afda89ad461d2 ]

This reverts commit 57e9d49c54528c49b8bffe6d99d782ea051ea534.

This undoes the hiding of .__afsXXXX silly-rename files.  The problem with
hiding them is that rm can't then manually delete them.

This also reverts commit 5f7a07646655fb4108da527565dcdc80124b14c4 ("afs: Fix
endless loop in directory parsing") as that's a bugfix for the above.

Fixes: 57e9d49c5452 ("afs: Hide silly-rename files from userspace")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/008102.html
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/3085695.1710328121@warthog.procyon.org.uk
Reviewed-by: Jeffrey E Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dir.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index c4e22e9f7a666..cec18f9f8bd7a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -492,16 +492,6 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 			continue;
 		}
 
-		/* Don't expose silly rename entries to userspace. */
-		if (nlen > 6 &&
-		    dire->u.name[0] == '.' &&
-		    ctx->actor != afs_lookup_filldir &&
-		    ctx->actor != afs_lookup_one_filldir &&
-		    memcmp(dire->u.name, ".__afs", 6) == 0) {
-			ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
-			continue;
-		}
-
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
 			      ntohl(dire->u.vnode),
-- 
2.43.0


