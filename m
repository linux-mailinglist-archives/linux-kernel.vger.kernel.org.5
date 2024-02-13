Return-Path: <linux-kernel+bounces-62715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF88524B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D081F233AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB0385649;
	Tue, 13 Feb 2024 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buLSDcGh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703385293;
	Tue, 13 Feb 2024 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783816; cv=none; b=swR13aCbpcYqQBErdgYWeeocaE3Wck/+P5Rx5mBHagc4FGpYlQ69uyLzI8RFQVfkemFJI4lKZcUVFJOTih5OqNJuL6+0K4hfz0vWWTHpMDcJ/o95CAXJJQ6Zk8e7h5UAJPJLeBBYjWYN0MFAt/dfSOfQOkb8A+d/WOAgWIWfSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783816; c=relaxed/simple;
	bh=8att6em83XP4x8L9kbT3vO42aBRBm7fuV0mWnVIZeZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKL8ZtyVQTtYo/IlZDa1hlbyaiQNz0aNdKP7rA6y13t/7SAbx1eMR2xAU7zEUE0v+ylTTpvqPS3KOWRnStDPpz1cTL8ZHywnmEoC/SO/AXAycoqOQ0eBbEVw5fl2mwl7CDce7WMmOECKNhtr6ZlqFFUMqD5tjRzGVNO9H9rR/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buLSDcGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62093C433C7;
	Tue, 13 Feb 2024 00:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783816;
	bh=8att6em83XP4x8L9kbT3vO42aBRBm7fuV0mWnVIZeZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buLSDcGhW4IEJCDPzF5BHhALXf8FEXfuKufohZq8DW4ZI6cdjmI2e0b1rd6AVZUdm
	 n4a8WK3EyVDE7cu5boh1doWGtxkxpoxa529YlKf1AjzGQ2UakmSJ2kuEu4dlbCf46g
	 /L5/ZTMp4P5vgmhYiYpH1Hq2oNX1Q/dAUPn5VFmDyBYNxhecqBsR85+mX1DP0c98A1
	 +6BfaDQRZbVd2B/OaCqXDDRz8XRhLIrTAR+6CZPtzw2B7ofuH9PWt/4H7GuzbAz/3T
	 hXu4DRUkTmiFomtj1Kz0+i2pUcmcDjb5knsfqSfC7Gs6K9e0VjzeVC2kDah+fqZbhC
	 H9qbZJuYoXMBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 03/22] fs/ntfs3: Correct hard links updating when dealing with DOS names
Date: Mon, 12 Feb 2024 19:23:05 -0500
Message-ID: <20240213002331.672583-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002331.672583-1-sashal@kernel.org>
References: <20240213002331.672583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 1918c10e137eae266b8eb0ab1cc14421dcb0e3e2 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 938fc286963f..ac43e4a6d57d 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -509,8 +509,20 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
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


