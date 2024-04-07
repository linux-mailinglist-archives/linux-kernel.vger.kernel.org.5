Return-Path: <linux-kernel+bounces-134443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D4489B18D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413A71F213C1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC447E78B;
	Sun,  7 Apr 2024 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx4Sfm0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C07E58F;
	Sun,  7 Apr 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495563; cv=none; b=FZgfxpU43qW7N6t6A98rM9doD6YcvPPQfdbgmX/mglDWlTbEnQ06qlB6lT9g3OLIzqaz9vEEG19KN8/jlGfbnlRbyt49wINsio7HcwH96jYP6xqYaZYXV00QtQJuBloL7768NEwsYo+qw691MtG1LC/oNI76hIMSC4V3hbhBVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495563; c=relaxed/simple;
	bh=8UFHsvHgzCsXgZDjS9bHr7Ics7xVVOT44/zZgR3dvCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtgVsmMZiGivhGtpXYA6L9lKs/1UCMulDl+crjI1MYlvanvgPp9Q8LmJ2QgWqYY5HaY0zE+kkdG6kvDAshGOK+zVITrsWawTQ6RXp8E3yodyNgLUT9AQsxUlDuULXQsd7LuFswa54A18DrpPSHK9+eSkUlpquvOc/NJuzJpkn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx4Sfm0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911A1C43394;
	Sun,  7 Apr 2024 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495563;
	bh=8UFHsvHgzCsXgZDjS9bHr7Ics7xVVOT44/zZgR3dvCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hx4Sfm0r88cEAwrJZ+E1Lz2c3Llzm7U3mZgGLXzD62zrID2/dKg8gxPW2Y/paEP9F
	 u5aC2OeWf2VGXs/IipDdVSjLvTpaRJi6wyz1mBJ7NUkQ6VA3sNOKkTMDE1FI77HFGC
	 amhS3ShlUMQcT6oqXmyo7879YEs+R8+qjv4HWuU49b2FYcH06y+Vj4rGP2/vDJd+sf
	 oCY2N1OQaLcS//ueVybE9zJClEvmQnlOkewiwshgYtcbGBLC1qw5fiFLdulPdt2iv/
	 rOMcTbHGDmivSI5tMrs0TZtGHwX18F3kEBPr/4HWkVsN4GCSWGoN47G+rE/D+IZf7w
	 kiLTCgafWR8/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Price <anprice@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 08/22] gfs2: Fix invalid metadata access in punch_hole
Date: Sun,  7 Apr 2024 09:12:07 -0400
Message-ID: <20240407131231.1051652-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
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
index ef7017fb69512..2b578615607e4 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1715,7 +1715,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	struct buffer_head *dibh, *bh;
 	struct gfs2_holder rd_gh;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
-	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
+	unsigned int bsize = 1 << bsize_shift;
+	u64 lblock = (offset + bsize - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
 	unsigned int start_aligned, end_aligned;
@@ -1726,7 +1727,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
-	if (offset >= maxsize) {
+	if (offset + bsize - 1 >= maxsize) {
 		/*
 		 * The starting point lies beyond the allocated metadata;
 		 * there are no blocks to deallocate.
-- 
2.43.0


