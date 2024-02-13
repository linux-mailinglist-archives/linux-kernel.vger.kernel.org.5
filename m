Return-Path: <linux-kernel+bounces-62638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AADD8523E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4CD1C2239B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F585FB86;
	Tue, 13 Feb 2024 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBAN8GB5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D331170B;
	Tue, 13 Feb 2024 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783661; cv=none; b=WgS7IaVTyTVqsAfiMR9qq0sK/EonW9ob5YNKFFpAnnZrUdagYJZ1oV80d1RNcykf+zEHde+5JuUgm5fZLAckorFPrHlIYwvzsFj/71g2nnyXzvFS1fILW8LwQ0m4BH59Nahq9i3scDW75OCz+eCiNVyWoVWwQcg9tc4keuDOI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783661; c=relaxed/simple;
	bh=mEZhJ+CMAS0d+aoCaCr5xPrw3Uxvg+w87QQyeITvjjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjAWDG89YYTpq4OxR6rf30xil5hdW7nXkb3gc5xNdxYY/E8sbMiJYU4uSkrVnHpjcbu5uS7Ckzhs3DKjuY3dO+nDrHnRKPGEHzH8iw/iDcAUU9BB8Q700x7PpLFirMlgR8JKL+wfR1JlJ0J+5IwMMPCOqZji4LCyi6dle7T4pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBAN8GB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67088C433F1;
	Tue, 13 Feb 2024 00:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783661;
	bh=mEZhJ+CMAS0d+aoCaCr5xPrw3Uxvg+w87QQyeITvjjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBAN8GB5Sfy1OnCnX5JK6vHuiAnVnyMXqJqwa4v2tDL/CIMcHtKHj9lalT6XfQYWt
	 2IBrB1AChZWVJEzwef5HDJJu8L02xwtcMgqWCyedRYQ3qfb5r2zp0cDr8AmFynkaCj
	 jJbqp9gm0dzPrEXvzT95rLmld9wV1IYd2yHQk23m1oXS8ngulc7d8pYSUISXlRQ+/X
	 Egql/H2pBIgeBU5DC4YW38XW69eGt+DfdpmTYIUEpn7gLMOMNU12XN5qdRQUS6m+QC
	 7F53zfw+GJLf3lFwwHKpcaeZnxrxVHFzkublXz1fu/wveoLkbB0wVK90HG6TmbpRzv
	 50l+F4ysImyaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 07/51] fs/ntfs3: Fix multithreaded stress test
Date: Mon, 12 Feb 2024 19:19:44 -0500
Message-ID: <20240213002052.670571-7-sashal@kernel.org>
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

[ Upstream commit a8b0c9fc3a2dba07f697ef7825e04363ff12f071 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 63f70259edc0..4b78b669a3bd 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -886,7 +886,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	struct runs_tree *run = &ni->file.run;
 	struct ntfs_sb_info *sbi;
 	u8 cluster_bits;
-	struct ATTRIB *attr = NULL, *attr_b;
+	struct ATTRIB *attr, *attr_b;
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
 	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end, vcn0, alen;
@@ -904,12 +904,8 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		*len = 0;
 	up_read(&ni->file.run_lock);
 
-	if (*len) {
-		if (*lcn != SPARSE_LCN || !new)
-			return 0; /* Fast normal way without allocation. */
-		else if (clen > *len)
-			clen = *len;
-	}
+	if (*len && (*lcn != SPARSE_LCN || !new))
+		return 0; /* Fast normal way without allocation. */
 
 	/* No cluster in cache or we need to allocate cluster in hole. */
 	sbi = ni->mi.sbi;
@@ -918,6 +914,17 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	ni_lock(ni);
 	down_write(&ni->file.run_lock);
 
+	/* Repeat the code above (under write lock). */
+	if (!run_lookup_entry(run, vcn, lcn, len, NULL))
+		*len = 0;
+
+	if (*len) {
+		if (*lcn != SPARSE_LCN || !new)
+			goto out; /* normal way without allocation. */
+		if (clen > *len)
+			clen = *len;
+	}
+
 	le_b = NULL;
 	attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL, &mi_b);
 	if (!attr_b) {
-- 
2.43.0


