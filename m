Return-Path: <linux-kernel+bounces-62645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E24788523F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9513C1F21B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA2660249;
	Tue, 13 Feb 2024 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA/co9CM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A2604A3;
	Tue, 13 Feb 2024 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783669; cv=none; b=bfmZu1oedK2n4rcPX8i2NarpmPPDXfPpX3jribeozaNaF06I7C9MehP/djNSID7gwOEwB92UAgD6g0pyCmZzEhNhd3HiSisfrrzFtjAHQaM+43g8BIA4K2K7SYF5PHOeRQGrq4WFU5nFhLAHqO4ZCWHqhsGfTFsSVxxLTM2egZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783669; c=relaxed/simple;
	bh=ZfBDtGgJlXxul/Ylvz3m7NrPT+cYNKzLkb0X5m6e6DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhLAlWrkmEnq/G0EL7jGZeqISFow1ySzmx36efyfZeMSlfXh60wZ9N3IQSpW/aKMO64ycKmgMCddcxkNrf22Bse/debJtvIunl5M/rrwEM+EmEw7An0sCHcVxNVl64HhxREpDNKUQ/1ocg8MNTfvR+S7wwNl0e3pw8DK1SOdwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA/co9CM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEB8C433C7;
	Tue, 13 Feb 2024 00:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783669;
	bh=ZfBDtGgJlXxul/Ylvz3m7NrPT+cYNKzLkb0X5m6e6DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jA/co9CMILTBYh27izuqxjB8GuiF4ic2OKQqroLkZelW1sobDjxWb+z347+7KRYfs
	 TJ8KrypmZPhEC0hZGZ/i6O3I1sV5VbyeWKEmcrkoib3iTOb3b7I17ndfP87jAcakU/
	 VSkGDHhr08LDjDBsMrl3LsWUwYC2qUs7bThsbbMdq0TAbCOaQgWollmLooIZpseb7r
	 IgqS2C3jdTwuEgk7/SC1U+w6fObKfXlBMnRhy9hbxp89R5ePVwru7SHOUeToxKCAn8
	 5seDYWXwD3e0WDG/7e5Vsis+twUCCIDKiyh7nYVnb0XFEO5cD2Czc5Tv9ImGIrLUxl
	 DZgSbJp9QAKAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 14/51] fs/ntfs3: Disable ATTR_LIST_ENTRY size check
Date: Mon, 12 Feb 2024 19:19:51 -0500
Message-ID: <20240213002052.670571-14-sashal@kernel.org>
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
index 7c01735d1219..48e7da47c6b7 100644
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
index 13e96fc63dae..f61f5b3adb03 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -527,8 +527,6 @@ struct ATTR_LIST_ENTRY {
 
 }; // sizeof(0x20)
 
-static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
-
 static inline u32 le_size(u8 name_len)
 {
 	return ALIGN(offsetof(struct ATTR_LIST_ENTRY, name) +
-- 
2.43.0


