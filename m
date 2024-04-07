Return-Path: <linux-kernel+bounces-134418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F70F89B140
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06CE1F23056
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ACA5380F;
	Sun,  7 Apr 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqu4XBgY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DB537E5;
	Sun,  7 Apr 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495502; cv=none; b=eycf+kLEfOUD5rexKxdABIgon4KT7kcTGg8/FCn9998lH7BlkMeK+mjDRJE8ezoLj0GWC3nLEgj78m14I4rrASUjcUlg7qvffDUoYGa5Gbg6twS/f0oOHqyU6vtDDuwX5s+BRGCjBBEuIV2oHQNOzNAEwI9DkhtdvQcEmyH342M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495502; c=relaxed/simple;
	bh=G9Fh6PN/UQoZv3MxTEc3PJN9EC4x0hR+8c51ALX/324=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbJj6TPTIoMrvWjUv/WcLMGxcb3Fe8d1E1EHNhagBN3XCQoe8mjWykdye+izQcrOf4pdBEH42AHVfDXjvpWzm81e3fAzAF99DAziBVJl53mm7T0UznQWJM5GNrXMLW1G43FrvgH4QJrbONFM2RiUusPkGcaknUEKh2H2f8uVzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqu4XBgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93D9C433F1;
	Sun,  7 Apr 2024 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495502;
	bh=G9Fh6PN/UQoZv3MxTEc3PJN9EC4x0hR+8c51ALX/324=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqu4XBgY91bVEv3tVLlM/b79+/g6B4Vw+HYYk3ZsfIdcnZWpC8MYX6ddw8MZsgwst
	 AVxpPBXwnbeb1pSHuBmaTq1jSXlo9a1pp+h+tpnIlgVae9GwKRIKDadE7nNwCpgjlM
	 d3Je7zdQgpnfn2vlufz5IpQElmoPLT33Vxm3ye93wfkF7tx144sET7ECtMxWPkckP+
	 zN6TizKWLsrsr/1n4wl0g/icYeAYcFQX5DuqIxywacuyCtONru4qaoCDdNs6ZayULx
	 ZdsuwuFrI+eEm6AtGhsw3CEDkktW03qcg3zHUIbepOjURLp7brhX3FDRv662rcFuyY
	 yZjaz1da3/wxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Price <anprice@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 08/25] gfs2: Fix invalid metadata access in punch_hole
Date: Sun,  7 Apr 2024 09:10:56 -0400
Message-ID: <20240407131130.1050321-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
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
index d9ccfd27e4f11..643175498d1c3 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1718,7 +1718,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	struct buffer_head *dibh, *bh;
 	struct gfs2_holder rd_gh;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
-	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
+	unsigned int bsize = 1 << bsize_shift;
+	u64 lblock = (offset + bsize - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
 	unsigned int start_aligned, end_aligned;
@@ -1729,7 +1730,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	u64 prev_bnr = 0;
 	__be64 *start, *end;
 
-	if (offset >= maxsize) {
+	if (offset + bsize - 1 >= maxsize) {
 		/*
 		 * The starting point lies beyond the allocated metadata;
 		 * there are no blocks to deallocate.
-- 
2.43.0


