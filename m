Return-Path: <linux-kernel+bounces-62573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8D85231C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABC61C233D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0995863A1;
	Tue, 13 Feb 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrJqLwNJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEA46AB;
	Tue, 13 Feb 2024 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783524; cv=none; b=empVd+9ycx+SOGOFaqefbqlPj6nzpWN6p0NEMgPw97F78SX3KzSIY+lCbR1m7NO+iH6SZcBDEH2OqNCWQnl3WYj47Rmo3gu1Rafx3BjrQJkfgVOO2sbY2duV86aL/70U7/FliXBLSW1I8eWiGEgkfxJANFpxUTk5MOj1WUWqt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783524; c=relaxed/simple;
	bh=4N5cSpt3eWeRSBedEY1Trk2ZLl+cOm9dl4wsLJKcRP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2wk5x5E1R2Nm5d9fVrTFONirW3pCMfFItELki21n6doBUinos7RRIF88CbW4McD3272P+nzi8ydwUSGUkRPoJiKXVy8lIJIY2fD3ClJhV+FBcwywHFiMWUxi728o098qSnOd0d0qgo6HD7BYRNQeBFXDnQkPm/fpQ1nXthIBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrJqLwNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16467C433C7;
	Tue, 13 Feb 2024 00:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783523;
	bh=4N5cSpt3eWeRSBedEY1Trk2ZLl+cOm9dl4wsLJKcRP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrJqLwNJE40oif4kOmMKUWtoC3hRc4HtqaIdjphtzulEGA/fUL8OsvSbt4BW7L5pH
	 h394yduOOTkQR8uJNOi1mr2OqTemtnsYvrS1yMeBnGDaNWEfczFAHV3nttPnyJwrdC
	 KIUcb4r0fAh17yS1aMI47kSmEBE/CY63znvPmP/lUDEaQC/GsdI1whc9v2ZrONtxT3
	 Okpmju192wI0bUT6n/OeI0z30p3jAQVsHE3gSUmWmUlDDcgziEXVPvtBCqhoEy+tKK
	 r0Z540yPRTW5hRQjx201pEMRHdu9svfD6eqKATsY1GtNZFzCvz+LOdm8IppicArbdw
	 i270OtE2uVGxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 04/58] fs/ntfs3: Correct hard links updating when dealing with DOS names
Date: Mon, 12 Feb 2024 19:17:10 -0500
Message-ID: <20240213001837.668862-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 1918c10e137eae266b8eb0ab1cc14421dcb0e3e2 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 53629b1f65e9..7b6423584eae 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -535,8 +535,20 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		return false;
 
 	if (ni && is_attr_indexed(attr)) {
-		le16_add_cpu(&ni->mi.mrec->hard_links, -1);
-		ni->mi.dirty = true;
+		u16 links = le16_to_cpu(ni->mi.mrec->hard_links);
+		struct ATTR_FILE_NAME *fname =
+			attr->type != ATTR_NAME ?
+				NULL :
+				resident_data_ex(attr,
+						 SIZEOF_ATTRIBUTE_FILENAME);
+		if (fname && fname->type == FILE_NAME_DOS) {
+			/* Do not decrease links count deleting DOS name. */
+		} else if (!links) {
+			/* minor error. Not critical. */
+		} else {
+			ni->mi.mrec->hard_links = cpu_to_le16(links - 1);
+			ni->mi.dirty = true;
+		}
 	}
 
 	used -= asize;
-- 
2.43.0


