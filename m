Return-Path: <linux-kernel+bounces-134496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661EF89B231
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658391C21161
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7213AA20;
	Sun,  7 Apr 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGkNsXr6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F113A884;
	Sun,  7 Apr 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495669; cv=none; b=FrmYjYidrC1KlgUAB+u74l8CDWWsmB24nm8PaVfG0AzHGvuWXGtyEmlTzQnZci82ZkgzjN4k82Gg/mkTfRwszkUFyqnzfF2vSzUyHq2SLm+IQ/KGvp5uV2s4lU9Jxt59nyUG57P0kJxPT6OmbE1T3LntX6Oz035agpKo0QkC9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495669; c=relaxed/simple;
	bh=4xpsCVfMYEwznucleJen4/R5GMLDzY7m9VjBJYptFOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/AVVzVjJWZ8LXElJjWwlFoDKpu20puUDDhIcO7bEupOmznRWLLLfj54ANK+77qMY42cSIgyghF59sJtX+3eA+gCUqoCtMNAJk+D8GUiAHB8kO25B7kjUElHe5DRtchx/uZMTdqYmBFl/L47l8LyuPVWNqQ2StHAfVUYe1vrydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGkNsXr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FB3C433C7;
	Sun,  7 Apr 2024 13:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495669;
	bh=4xpsCVfMYEwznucleJen4/R5GMLDzY7m9VjBJYptFOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGkNsXr6d10TZG7Wl23ZCr2jAQ2Ftf+u2R/H2B+PiwaxcwVKLATzLKcl4go0GXDm4
	 oKPpPffDpgI6CpP9CXcJwrS72oz1d7RjKZVVvMh4h2tn0ddlXsca5L7GtCST46HbZW
	 d3eTDiWv3f2SzU5nBBC+J3sBs9xetnc6K0mvGf6iRbY3rSstzr4b6yLLI6mqGoDaNN
	 Y5K4B6cDpNKadNkLfgWsb78wRxWaEkO0wiPXgeekvPVDLHJ1aCXePvAnTLtVx2nGM+
	 MRl9EIXO/WPVR9Fi90wfEp/HuOVmC7iOTFRswAzkqM2lUvZXIHzZhLhKEoHhMAAZS1
	 I6GRbuXUY/DGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Price <anprice@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 2/5] gfs2: Fix invalid metadata access in punch_hole
Date: Sun,  7 Apr 2024 09:14:22 -0400
Message-ID: <20240407131426.1053736-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131426.1053736-1-sashal@kernel.org>
References: <20240407131426.1053736-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index 729f36fdced1f..b365828328df0 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1751,7 +1751,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	struct buffer_head *dibh, *bh;
 	struct gfs2_holder rd_gh;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
-	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
+	unsigned int bsize = 1 << bsize_shift;
+	u64 lblock = (offset + bsize - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
 	unsigned int start_aligned, end_aligned;
@@ -1762,7 +1763,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
-	if (offset >= maxsize) {
+	if (offset + bsize - 1 >= maxsize) {
 		/*
 		 * The starting point lies beyond the allocated meta-data;
 		 * there are no blocks do deallocate.
-- 
2.43.0


