Return-Path: <linux-kernel+bounces-62579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB016852335
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780BA1F226E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163611724;
	Tue, 13 Feb 2024 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIGMWuQZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA760F512;
	Tue, 13 Feb 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783530; cv=none; b=pt7oRgPun+kVWPz525KpR+kMICkAR1emZ1dHaNy0vJuVwk1bXh9IBmBKwg1DPc0JmoQRKkd2uF3YDQviDI8aAwFICsKH5NrpIFmWNuO0QZhFt7faLbi/bBcEE5gbGt05HCuJ3vXsOS+DU1Itn96JzVRJQE3Vul381eswmmLepHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783530; c=relaxed/simple;
	bh=vCOzZk42nDcyd88R9Ruft8XsjXzk7xpMx7KZ1pLSdV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQLFsKr5V2eoCtRksnN1O3be8vZ/uEHsLNeqqXXRSgLEwFJQGlllU+INjnu8f+lvKfg1gY9a2wf41v5O9bG2+lqgI9qAeHeL50wykcE1FQIv8EILz6eSepWb4Kv6/zB3xyCgVTNwB0DKpqLVZEmIQcJnOqgEV/+ax5K0X4tPm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIGMWuQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E91C43390;
	Tue, 13 Feb 2024 00:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783530;
	bh=vCOzZk42nDcyd88R9Ruft8XsjXzk7xpMx7KZ1pLSdV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIGMWuQZkxtGeEKL3cwv9Ui+VIXm26CFsf7d1dsgGegGbTnZJ+lWMCgGCb/fWpBlB
	 l46y4AXGMri5Rsc7ifQtdDb3DBSvbS0P43cIhzvtAtm72sK92ARJYrooqWaR9wlzTC
	 woMpxPi9ckj9xZUi1gMDyFR1rstbPiXJTkbbgyveeBsGOBSF34PWL6mYNVAdrCsPzl
	 WB7MpMcVH+LxR6kdanqOsz3tU5isltkPm7xZ1UB8TapMT+pZWzIeY5UyjfcIEXyYni
	 1o8GmaApq6qyBPv/RUm/lgqH8RG5rwQK+SjB1ohG6LccN1OIuech9nHSvbcYW5+ap0
	 8zsJboKialG2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 10/58] fs/ntfs3: Add file_modified
Date: Mon, 12 Feb 2024 19:17:16 -0500
Message-ID: <20240213001837.668862-10-sashal@kernel.org>
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

[ Upstream commit 4dea9cd522424d3002894c20b729c6fbfb6fc22b ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 5691f04e6751..bb80ce2eec2f 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -632,11 +632,17 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 					    &ni->file.run, i_size, &ni->i_valid,
 					    true, NULL);
 			ni_unlock(ni);
+			if (err)
+				goto out;
 		} else if (new_size > i_size) {
 			inode->i_size = new_size;
 		}
 	}
 
+	err = file_modified(file);
+	if (err)
+		goto out;
+
 out:
 	if (map_locked)
 		filemap_invalidate_unlock(mapping);
@@ -1040,6 +1046,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
+	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
 	if (is_encrypted(ni)) {
@@ -1067,6 +1074,12 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret <= 0)
 		goto out;
 
+	err = file_modified(iocb->ki_filp);
+	if (err) {
+		ret = err;
+		goto out;
+	}
+
 	if (WARN_ON(ni->ni_flags & NI_FLAG_COMPRESSED_MASK)) {
 		/* Should never be here, see ntfs_file_open(). */
 		ret = -EOPNOTSUPP;
-- 
2.43.0


