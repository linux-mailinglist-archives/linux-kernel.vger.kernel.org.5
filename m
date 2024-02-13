Return-Path: <linux-kernel+bounces-62686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF79852462
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59808283970
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584074E19;
	Tue, 13 Feb 2024 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxEp/MX4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEB71B38;
	Tue, 13 Feb 2024 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783760; cv=none; b=Wo6BySIFeqmBjZ17X0s/BvdCyBFTouf9SXq3PWjT2PqECLiNRr1/81xoYf1+oTZ0bY/CnKMd8ddGDYiotJaew3BcuE7WXpE3XGBKkNk5Hlh6XWJ44+iBeUiQyvSeJUCk5EyWHnPCfXjwk4lCh1jwfdGlcX6NVuoK8oyHio43UFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783760; c=relaxed/simple;
	bh=8ihEVflOv1jQ6OzK869Yv1uPRUtmxtAHHdIRmcDNL+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5W3D5S2MUzTcLzgf25ZT49RRw6Sk3M8MIqBMlEkACunb9rw0I5qIDtglWTYAzJ9V/hFwNcODdTUi7wy8Btda4gu8kjl+DdQEm7PEBfLXJHKN+LnjupJ8I8cSSYVjaVoolPwd6RKaJ9jgR4E1RB9qCuNSIU7Ivq9PoYUm+cWVKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxEp/MX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BA0C433A6;
	Tue, 13 Feb 2024 00:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783760;
	bh=8ihEVflOv1jQ6OzK869Yv1uPRUtmxtAHHdIRmcDNL+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxEp/MX4NWoAfI1DXTW+AyHrFV4+IydiHXah8yaR2TA7VQze1oHfuMpIJF6mwSqUJ
	 UmemWQWSlvb/xVwh/ZNw3q2S2ma9Fa66hBJdTFkomopxAY/gLoj9oVJpjzwSbnkBsT
	 vtSE9iPimIqnsetSm2KvM8GMxCgr/bPgauqmDeUbiHzFJOcD2gmWF29xpfAJCdnO4W
	 zupXEv8bTcjIgan2TgI4qa3gmahQSPXv3qJSfBwAzf+cRa2ma1ek58ljAmF7s2Ps8T
	 AU8u46QMO+34TSDEOLUvKPsOQcH1S4YxzDBK/9gksVTnHTiPW6GlqAiD7T84G8WowD
	 8fMTzuTje5UMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 03/28] fs/ntfs3: Correct hard links updating when dealing with DOS names
Date: Mon, 12 Feb 2024 19:22:01 -0500
Message-ID: <20240213002235.671934-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 1918c10e137eae266b8eb0ab1cc14421dcb0e3e2 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index ba336c7280b8..ab03c373cec6 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -491,8 +491,20 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
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


