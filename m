Return-Path: <linux-kernel+bounces-137600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D36389E476
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB7A1C20D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20291586E4;
	Tue,  9 Apr 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYS5yUbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E331586D2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694857; cv=none; b=AwCJCXIMXwaJdoRBobOfWcsox40Q61S0T8HHElNy1NmMrdA2AcI5M73sEj8NCFzIbGrDcX6JEpFy1SdC7WUgTehlF/wN7GQSKn7RlzDkfI8Fe4TV51syFxqYys4b+cDJfL/IP/1VWvUdYWSPKjIvykW+7YHWVBcELp72FXblbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694857; c=relaxed/simple;
	bh=yuHHraFJs2uSx9hQ7hdbnjpoe1/DllEgPkr59YJ8+BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCmerm1a5dNKkwjppy3HjetQIRkvnhPSl7DJ62jvf5gph3Kc/85hFexvQaaNueagxJ80LSAXTlMa1obSkVTqwwKzrAjuRnFeO3oKuoUUfzYOV8OnPn5yf/bgy6qTEDn5Fs1heW9jEUDoyWGKK7GzCMaE7QMmuJQCB7h0P1e2NSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYS5yUbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A76CC433F1;
	Tue,  9 Apr 2024 20:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712694856;
	bh=yuHHraFJs2uSx9hQ7hdbnjpoe1/DllEgPkr59YJ8+BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYS5yUbp2j2MUkMS/chiuO59dZHMJNSE+6fhRmIqgrmpMsWsXPq11EPlEQFcnkp99
	 HnWtx8P31Ejg/zj46124biFba+Pz96KQDjmJKVU+nC6XcSZQgQBrrOUWr6bTKqcOpt
	 4DY6avaWW08lHV6cty4FKMK6+zo/lsMlbAqXZ2QUptl3W5G26MOWu3+z2vGtX2oXDs
	 4Id09by82cRuUMnEwQIiKdAKmEs7Wbybyr9PlYxfKOX5+66+MMC2k6H+jG2kqlTWlM
	 f9eIVPMnKbWIBXfIGJ1Eg7iK8YGSTc0vbg1Dk3wDgGQL3U2XskeK37fh4nEmZ5AnTu
	 exkNMIRLiJeUg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: clear writeback when compression failed
Date: Tue,  9 Apr 2024 20:34:10 +0000
Message-ID: <20240409203411.1885121-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240409203411.1885121-1-jaegeuk@kernel.org>
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's stop issuing compressed writes and clear their writeback flags.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d67c471ab5df..3a8ecc6aee84 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1031,6 +1031,25 @@ static void set_cluster_writeback(struct compress_ctx *cc)
 	}
 }
 
+static void cancel_cluster_writeback(struct compress_ctx *cc, int submitted)
+{
+	int i;
+
+	for (i = 0; i < cc->cluster_size; i++) {
+		if (!cc->rpages[i])
+			continue;
+		if (i < submitted) {
+			if (i)
+				f2fs_wait_on_page_writeback(cc->rpages[i],
+						DATA, true, true);
+			inode_inc_dirty_pages(cc->inode);
+			lock_page(cc->rpages[i]);
+		}
+		clear_page_private_gcing(cc->rpages[i]);
+		end_page_writeback(cc->rpages[i]);
+	}
+}
+
 static void set_cluster_dirty(struct compress_ctx *cc)
 {
 	int i;
@@ -1232,7 +1251,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		.page = NULL,
 		.encrypted_page = NULL,
 		.compressed_page = NULL,
-		.submitted = 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
 		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode) ?
@@ -1358,7 +1376,15 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 			fio.compressed_page = cc->cpages[i - 1];
 
 		cc->cpages[i - 1] = NULL;
+		fio.submitted = 0;
 		f2fs_outplace_write_data(&dn, &fio);
+		if (unlikely(!fio.submitted)) {
+			cancel_cluster_writeback(cc, i);
+
+			/* To call fscrypt_finalize_bounce_page */
+			i = cc->valid_nr_cpages;
+			goto out_destroy_crypt;
+		}
 		(*submitted)++;
 unlock_continue:
 		inode_dec_dirty_pages(cc->inode);
@@ -1392,8 +1418,11 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 out_destroy_crypt:
 	page_array_free(cc->inode, cic->rpages, cc->cluster_size);
 
-	for (--i; i >= 0; i--)
+	for (--i; i >= 0; i--) {
+		if (!cc->cpages[i])
+			continue;
 		fscrypt_finalize_bounce_page(&cc->cpages[i]);
+	}
 out_put_cic:
 	kmem_cache_free(cic_entry_slab, cic);
 out_put_dnode:
-- 
2.44.0.478.gd926399ef9-goog


