Return-Path: <linux-kernel+bounces-62636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD48523E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC632814DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1835F574;
	Tue, 13 Feb 2024 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO2cffHm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DE5F54B;
	Tue, 13 Feb 2024 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783659; cv=none; b=jV/mM0tIiGoSHGc+KeEOeGnyWnP2Qe8NxwW1NDHA4QhDOX7vPV1KavCUc18Zt1xAKU9jeDBGYf5UTN+gV34zkPY7tQot3SnYev0x9XwLfytHaWoHCiQ8eOEoR5MKIB9dDO7UsJAW06KqwuiewwuEgtKGBDcPuMw9YGN9Aq9oXPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783659; c=relaxed/simple;
	bh=4N5cSpt3eWeRSBedEY1Trk2ZLl+cOm9dl4wsLJKcRP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjTX9hFD1MqdEZP2MdnrguebeTmhGjlwgrlwObn6ncYNW/qRbfpatkwuew0PpEoVGOF4BTjAsyguXeHxtB/FbggNOF0gvqCLsOK7NK/dcNidStp0qShSgx4ybiOlETEhnoDcFrkOn5+/XrRGfU1FF41HV4gdnjeeFH0ZyAgmteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO2cffHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3B9C433C7;
	Tue, 13 Feb 2024 00:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783657;
	bh=4N5cSpt3eWeRSBedEY1Trk2ZLl+cOm9dl4wsLJKcRP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aO2cffHm3BmfcbqSvJIdEINFP8kwXWZ1dYkkWfsVk7YY6fpuM5RXlkWOhyj/770I6
	 Uh9/ZJqNH+QC2P+drr2hipCV/w+YBf7p/gbQk1yRkeCzxWR+pLEUyf0kqq326Hr3YX
	 86aszRE/CQsUZ5M+HqBn1A+4ceZx5A0n+ra1n44wz3Rib5vaXbXS2a3fME9oz+eE7y
	 Xso06E/NlxRjW9cwXjie8sPcZy7N1v6soNwrcKIQRPJdLfQd8eh0RjQX/UW6n0pOTg
	 M+kt+VOL1Jk4vL1M25jJL3+d+8KknnrkLzGVc5vh6Jqdiu3FMdaDVuHh/rDwWiLSme
	 AdD1+4XrufXrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 04/51] fs/ntfs3: Correct hard links updating when dealing with DOS names
Date: Mon, 12 Feb 2024 19:19:41 -0500
Message-ID: <20240213002052.670571-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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


