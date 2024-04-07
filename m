Return-Path: <linux-kernel+bounces-134462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8F89B1C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1176B282064
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79012DDA9;
	Sun,  7 Apr 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3vC4lsA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2112DD84;
	Sun,  7 Apr 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495603; cv=none; b=jZdBw7DbRT/BjnmuMigeP+FVUvI3+I92ChhsEzo2P5xMg6IgD+Wna3FgC5yJf7Vl3dflYia45u4eUFW/jmLARvEotgjeeaCrHp4sFt7ex0I3eKXQuwNUEq/3vY3PhMh/Pl46npHM+QOcwYAbW65pin6jOEXGrZkPgUg4PRGSO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495603; c=relaxed/simple;
	bh=ExiDq7Dr9hNGSblPCeuSJ3kySLnJtO2FQk3DC3vnvC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myMEQEGiDeQu2D7/n818bSbqdth3SWKjsCtfeOSp0cvjLkOqk+gVJRJAjCb9vLcnayLAG7sYbeMStruApVINExBb+YcA9c2Jwlwa7OpLN/5S83PKSF870uiTOeCoxLRPihWkV6TISvvPnUrJkH4bx2WGz5UeZ08RqdxKmlSuaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3vC4lsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE557C43390;
	Sun,  7 Apr 2024 13:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495603;
	bh=ExiDq7Dr9hNGSblPCeuSJ3kySLnJtO2FQk3DC3vnvC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3vC4lsAVB2uOD6hVnXNobY26G9GJA24lU/E2CcdWfEw+Fmq0PNOR953sWf1Olr8W
	 3VfrJQL0cbM1RHo3Pmo1+Twf6kQcNuvG6N2A7VO65EEO5ZJq+oIjJ4dG8Dkaux5TwL
	 MAlXuRm1YGztWkNN43KMndxsYUR0q+1iPlOwbJECWkPH+Ao7AG7Abvqs0fLpC/1q1a
	 6SXVXc/CC2DVV1zpK3ClszHnToF1wPj/cqEevConw6hbmLS2FRyoXA+R3aVcfWIMmE
	 b4f3WkxurIBuIEdjwM3w8ZTbba5CzAnavHPNpMVJivr5cdhUNWangAQPmwIDdzwcOp
	 l7ncM5Ub4RAtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Price <anprice@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 05/13] gfs2: Fix invalid metadata access in punch_hole
Date: Sun,  7 Apr 2024 09:13:04 -0400
Message-ID: <20240407131316.1052393-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131316.1052393-1-sashal@kernel.org>
References: <20240407131316.1052393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Andrew Price <anprice@redhat.com>

[ Upstream commit c95346ac918c5badf51b9a7ac58a26d3bd5bb224 ]

In punch_hole(), when the offset lies in the final block for a given
height, there is no hole to punch, but the maximum size check fails to
detect that.  Consequently, punch_hole() will try to punch a hole beyond
the end of the metadata and fail.  Fix the maximum size check.

Signed-off-by: Andrew Price <anprice@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/bmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index e7537fd305dd2..9ad11e5bf14c3 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1702,7 +1702,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	struct buffer_head *dibh, *bh;
 	struct gfs2_holder rd_gh;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
-	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
+	unsigned int bsize = 1 << bsize_shift;
+	u64 lblock = (offset + bsize - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
 	unsigned int start_aligned, end_aligned;
@@ -1713,7 +1714,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
-	if (offset >= maxsize) {
+	if (offset + bsize - 1 >= maxsize) {
 		/*
 		 * The starting point lies beyond the allocated meta-data;
 		 * there are no blocks do deallocate.
-- 
2.43.0


