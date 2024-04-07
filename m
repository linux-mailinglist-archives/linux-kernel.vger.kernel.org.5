Return-Path: <linux-kernel+bounces-134483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DD189B208
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE9C1F215FE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901721369BA;
	Sun,  7 Apr 2024 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hesZoPbf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21ED13699F;
	Sun,  7 Apr 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495642; cv=none; b=U1sd8gDCtWlnFsL8jghEvK9uld3PPcFJeTVrDyLv6YndlETu27jtYrrQ0ZIxY7F4HasxtGXwTME/XVhj6AR0+J991LNK/GaFSIUDDqyobuXvmrxfzrqi7gKRMPw3tQ5HZIeWuyb3RTCcejcJAoneUB5tvZbss/ZwI+JGqotERn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495642; c=relaxed/simple;
	bh=Co2oBeV4FKWb8mRad4axHq42/5EAf1Y8/UAR1uy3KDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ea5OZ2RXXPKY90vGWI5MNynIlmIzNdAi+WZg1tPyUaOc1JVHwzDE06nJOqLg/ZbtNHVOflvFzuEbjjCHMEy+KS9x8cY7Y/nkYAv6PFdmOv4Rj0W69NdQBH0J3AIcItzxFnE/qh/9b+oSVueWwul6kVOtDFOgKiTIw9Ncb2pFyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hesZoPbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBE9C43394;
	Sun,  7 Apr 2024 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495642;
	bh=Co2oBeV4FKWb8mRad4axHq42/5EAf1Y8/UAR1uy3KDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hesZoPbfpYypn0G3eq6vT4XS4pILQBsxCBLZlb0qSls7cIVJj5ldKJ9L8HS9kcKaN
	 XRFsJz15i+3gjyk5VWjNyb3ta5cdWC1oZ0SuOzvoak6G7kyhcRwzBB1ex0cOWNymv/
	 ivYo+HD3m797tR2dbZE2s0vq6bB99C2Z2uljS2AvDGUNA2Y5oX8ZFBzSdCG4m558Ms
	 d8BEE865THSFdtMx6iDDic/1Q5DLN9s0sPGoDZ8fyBLFa1sD6xylWBttJNItfkY9ku
	 +0lod6v4YrmrPzq7lyiCnIsetanMC03c9ZmnROk2dsEfb9ngi+dePW8a15TJctViff
	 KtFdiUubkT5eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Price <anprice@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 2/7] gfs2: Fix invalid metadata access in punch_hole
Date: Sun,  7 Apr 2024 09:13:53 -0400
Message-ID: <20240407131400.1053377-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131400.1053377-1-sashal@kernel.org>
References: <20240407131400.1053377-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index eaee95d2ad143..3d60ad9982c87 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1758,7 +1758,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	struct buffer_head *dibh, *bh;
 	struct gfs2_holder rd_gh;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
-	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
+	unsigned int bsize = 1 << bsize_shift;
+	u64 lblock = (offset + bsize - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
 	unsigned int start_aligned, end_aligned;
@@ -1769,7 +1770,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
-	if (offset >= maxsize) {
+	if (offset + bsize - 1 >= maxsize) {
 		/*
 		 * The starting point lies beyond the allocated meta-data;
 		 * there are no blocks do deallocate.
-- 
2.43.0


