Return-Path: <linux-kernel+bounces-62719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A828524C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F5C1F22644
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB186620;
	Tue, 13 Feb 2024 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHQfWoKu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B148664B;
	Tue, 13 Feb 2024 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783821; cv=none; b=VlS+z189PpLmJLLpcyo2QmTBTEnrjuz6h1Gyl9wC4eWYnmfgREGnYASl4kRQYXL9nwZOVrkvTXYWp77zwknXIOcRonN+CrSj8hO2IKhs6akrczHn4OMopbvdem1L/KvsV10mYx6DlB5kktFn1ul9r37YRAQXCzXaFNmeb4/aVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783821; c=relaxed/simple;
	bh=CIRJBfId1RTlgmGCy2RcJc711guDos+mkPR47Y3W2JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euqRjs39b76ZdykICltfb6+HcoYLA+I5ReZkapYiwy1A9ZAOf5nrcxQrffSVxdUk4bsJXlgfuLOAsux0dfvFHIEZ4cFVQt/wXDiu13FlJ+81EPEzbaunv36OhlxVosJX5EkHoRcaJwkmQzNb8EAHqEoppEhqeVV0WgIyMcqU2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHQfWoKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7502C43394;
	Tue, 13 Feb 2024 00:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783820;
	bh=CIRJBfId1RTlgmGCy2RcJc711guDos+mkPR47Y3W2JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHQfWoKueN3FOFEwUZwlFgszY9Vx7nLbALGmk+dVepteTqxx9dX59sDMgC/TVbizA
	 0BRR47UddY08ykaJ0Lh6CZdaMBWBf2ujZuipc5ljV8G2KJAikMy1u1sFHCNj+nFbZx
	 DiIUbU918d+hvE8FeGNnv8OBaTqpynr0Ft80QrVY5b7B+Erz2+8U/4NixjGv7yBJs6
	 VYcphLRisMFBT+/xnw50DHzLwpf+97/gNUbfmOEbRLJq8jrUuTQxVlv5iGz89TqWY0
	 qkfVmdXOZbbFruMUY9v+TpUGVKtiV+O/p30kiSfb0DzhXER7tfx3krnOyHr0mmD+sn
	 sQP/+R8y7Sr8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 07/22] fs/ntfs3: Disable ATTR_LIST_ENTRY size check
Date: Mon, 12 Feb 2024 19:23:09 -0500
Message-ID: <20240213002331.672583-7-sashal@kernel.org>
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

[ Upstream commit 4cdfb6e7bc9c80142d33bf1d4653a73fa678ba56 ]

The use of sizeof(struct ATTR_LIST_ENTRY) has been replaced with le_size(0)
due to alignment peculiarities on different platforms.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312071005.g6YrbaIe-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrlist.c | 8 ++++----
 fs/ntfs3/ntfs.h     | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 0c6a68e71e7d..723e49ec83ce 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -127,12 +127,13 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 {
 	size_t off;
 	u16 sz;
+	const unsigned le_min_size = le_size(0);
 
 	if (!le) {
 		le = ni->attr_list.le;
 	} else {
 		sz = le16_to_cpu(le->size);
-		if (sz < sizeof(struct ATTR_LIST_ENTRY)) {
+		if (sz < le_min_size) {
 			/* Impossible 'cause we should not return such le. */
 			return NULL;
 		}
@@ -141,7 +142,7 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 
 	/* Check boundary. */
 	off = PtrOffset(ni->attr_list.le, le);
-	if (off + sizeof(struct ATTR_LIST_ENTRY) > ni->attr_list.size) {
+	if (off + le_min_size > ni->attr_list.size) {
 		/* The regular end of list. */
 		return NULL;
 	}
@@ -149,8 +150,7 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 	sz = le16_to_cpu(le->size);
 
 	/* Check le for errors. */
-	if (sz < sizeof(struct ATTR_LIST_ENTRY) ||
-	    off + sz > ni->attr_list.size ||
+	if (sz < le_min_size || off + sz > ni->attr_list.size ||
 	    sz < le->name_off + le->name_len * sizeof(short)) {
 		return NULL;
 	}
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 8b580515b1d6..ba26a465b309 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -521,8 +521,6 @@ struct ATTR_LIST_ENTRY {
 
 }; // sizeof(0x20)
 
-static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
-
 static inline u32 le_size(u8 name_len)
 {
 	return ALIGN(offsetof(struct ATTR_LIST_ENTRY, name) +
-- 
2.43.0


