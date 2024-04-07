Return-Path: <linux-kernel+bounces-134474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3289B1ED
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521C51F2142D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCD2131198;
	Sun,  7 Apr 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f30phbYj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A1131181;
	Sun,  7 Apr 2024 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495627; cv=none; b=cbkWtllJ3bD6MpSJEjNfZQ96C1OriioqluNgpInV8JB6f1EgYTUjcvPh6YHVE6jqYmIQAT1Srka2IZRIx/Xxh+QO2VqXW0kY5gjfokygkDZPcwVXqBB09ej2MBx7yY+G3HM4Y3H2olgegJtpPgELwYDQx3Q5MAR88xo4D3r+aBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495627; c=relaxed/simple;
	bh=x8Z9ZmyjqSs/YVDXBuClYp/eiiFqnfPjPyNZCrlIjGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNdG82vU12o+pfhM0Pj0q6tPyVBjZZrKj9veCSjURH06mmjL9n4hQNMp7zfgqEJoVJ3l1hVSCQd6YoT4CKHJgputjXvMWQtCuzi1kAV8rVUcPZZ58zHDeKcPHlkneaojxuJEnf3adifgIrLJZ79OUMSDIJ/kJ2scf/BTL1Q3qGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f30phbYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA93C43394;
	Sun,  7 Apr 2024 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495627;
	bh=x8Z9ZmyjqSs/YVDXBuClYp/eiiFqnfPjPyNZCrlIjGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f30phbYjOPnybuQ5Zjo0o+c/u9yE7g3u8l2KX9d2GfTc+Xt4ikZkgTsfKS7fkyVdG
	 fje+FyWt5vBMpFS+GIL5/t5JcFhwg2fmyqVkRffl+zQrF9rBMdWmzSFFRuD4NlphX9
	 zRQE2C0ddM9ee1/1fJKC/+zVG1Mh625gdbDrVjsJ3jyfusuxO3TjWjcpDIJdLUQOt3
	 w3t2nwcLOVCt64trTk89f1lbj9WuFB9tkIMeeaSg6qk1uIB63Hs+BwTmfmKlLCkZFY
	 ujp+vXZkh6IGWCP3AaBXGv29b0CkWpD/esEoeQwmKrNAMS2k1MOoeeaT+XgXpTnTtw
	 KvWyqdIM9SCIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Price <anprice@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 04/10] gfs2: Fix invalid metadata access in punch_hole
Date: Sun,  7 Apr 2024 09:13:34 -0400
Message-ID: <20240407131341.1052960-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131341.1052960-1-sashal@kernel.org>
References: <20240407131341.1052960-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 0ec1eaf338338..d2011c3c33fc2 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1704,7 +1704,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	struct buffer_head *dibh, *bh;
 	struct gfs2_holder rd_gh;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
-	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
+	unsigned int bsize = 1 << bsize_shift;
+	u64 lblock = (offset + bsize - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
 	unsigned int start_aligned, end_aligned;
@@ -1715,7 +1716,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
-	if (offset >= maxsize) {
+	if (offset + bsize - 1 >= maxsize) {
 		/*
 		 * The starting point lies beyond the allocated meta-data;
 		 * there are no blocks do deallocate.
-- 
2.43.0


