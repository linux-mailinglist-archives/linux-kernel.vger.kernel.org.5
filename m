Return-Path: <linux-kernel+bounces-134490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E9F89B21E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2854DB21B9D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB3139563;
	Sun,  7 Apr 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAF8rycj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C224207A;
	Sun,  7 Apr 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495656; cv=none; b=Ku9sBWfzsS2ESeay3Uw8bjyWviO8445raiHmXkOUi//DWtbuI2wtxdrhpMltGQQXlmAv2IYIts3k21lDhaCM0nj3wCFCfdqBJYJ51dsJc4d3/zluoYNqf1TiYatKJZi9HKjXxHCCpRaTERCjGy/hogMJbhwel5sK4nEDuetsmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495656; c=relaxed/simple;
	bh=roeq4iNmTDqWIVN7ynwqH8Gp1SGs3WNdFIk/ykNTzPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7+CPXwPZ0ToHbnPhUbDZbKIKqFwMdzIhU0WIBYMxudS9fGwgBq1Hyjv1JWpUV1iacgJpINaxVToomR9K6RpEp7Bkwj4NTodv7FfaH+osVvAxomk9q3zfqejwjPYMc2IQq0LscMDSzuphZ5VzTL0/DDkr5PcpZIZWYzp1SfBvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAF8rycj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED20C43394;
	Sun,  7 Apr 2024 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495656;
	bh=roeq4iNmTDqWIVN7ynwqH8Gp1SGs3WNdFIk/ykNTzPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAF8rycj4Zw9U3mkh8WfdRvyDftQm9XXyRLOsEBhuEBuIwTLgXVK6cl3K4gQpJZ1p
	 Cn6fjYUdAXq9imxP9raDaIqjd55lhjcTrKnvVKzl9neCEih55fCNmQNaJQeqW+7BMm
	 UqYyuR8G114TQ62WyhNBxoDOYEjNXf9f5OOci7QJ/QBWvnPQoWyO1Uh9c1IQ2ZOBj8
	 dYtaIKP5bS4x1hTNTnwjG33e8gpagqCXK0VBLYPkLS937QuZkoTNukmkCedNKUt+5e
	 K/EKPuCOYeXNRWdSUrIVqJVgg02ET9GPBvdqXMR6+RM0+no/LD1KDrcpKR2rIjuHdl
	 T1/VQFMZ930mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Price <anprice@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 2/6] gfs2: Fix invalid metadata access in punch_hole
Date: Sun,  7 Apr 2024 09:14:08 -0400
Message-ID: <20240407131414.1053600-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131414.1053600-1-sashal@kernel.org>
References: <20240407131414.1053600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 63e925aa12a75..1dc0f0bca3ab3 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1760,7 +1760,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	struct buffer_head *dibh, *bh;
 	struct gfs2_holder rd_gh;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
-	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
+	unsigned int bsize = 1 << bsize_shift;
+	u64 lblock = (offset + bsize - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
 	unsigned int start_aligned, end_aligned;
@@ -1771,7 +1772,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
-	if (offset >= maxsize) {
+	if (offset + bsize - 1 >= maxsize) {
 		/*
 		 * The starting point lies beyond the allocated meta-data;
 		 * there are no blocks do deallocate.
-- 
2.43.0


