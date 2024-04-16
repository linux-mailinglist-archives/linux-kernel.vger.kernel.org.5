Return-Path: <linux-kernel+bounces-147261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA678A71A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA8C1C20962
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964186255;
	Tue, 16 Apr 2024 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c11lxcyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A57FC1F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286145; cv=none; b=KwNybDgUFDDC/e4QkcmgvN5xf5GLf16k+dR21i6adKxmn8r2K3WjlQcfiq2EY1djgNzk0/uwlWe+jsczNfUHdi6iobNfyYJO9XqUxGlegi++7xfCuWjBFzcp2/OKfQprj7+di+6x3khpuxX1iXcWTGMmGDWBNcdZydQN0Skh6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286145; c=relaxed/simple;
	bh=HAesg3qRZc7lQplWbxqms8wxUlus9BS8t2j/gdAeWJs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuYkOYYCIoKoQhEseWf1kpkEQju52lYQKB4k0ujcL/QJyENvCXZYQ9HKggzj1nP7s+i7zdJxE0bFnT0zMxH7mm6fhNNO50mK69/1P+Y4OjCuZ14okBif1Erp6aJgNRpBWKh6p1vIAQYq/p0blKB4VGQ8cUYhpFBAI/Y2iJ/dj6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c11lxcyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0474C113CE;
	Tue, 16 Apr 2024 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713286144;
	bh=HAesg3qRZc7lQplWbxqms8wxUlus9BS8t2j/gdAeWJs=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=c11lxcyGVB6UA+AdljlYDtaJ9Rin2zGn20+yuOq0VpmK0Mpu7ThJO3lSev5W/K4AP
	 IRW1Yo5mDJKGDM9wb+fak8Ki3XZhuYOrJpOuDBxa6aPIRAvL8a2dhVwwmgI2ZqLCMJ
	 WpisGNxpjqjmIMljr52uOZKL6KDOTRvnChiXnWZLBRXI50+h0ZIiFxFRyMAdNNzjgX
	 HTPhx80A6+36tkz3YT6NGcByUM1mw1OOGOnuUyESWSlhBueMfjOBoaS7sVFneVzFkI
	 FwQRo481Ghx4vz7ztFrqGPPEwTSAaZAqBky0mkQS8RBv5y4AoxbZaBjFUNTPIUIena
	 PtXJEUw0P6lqQ==
Date: Tue, 16 Apr 2024 16:49:03 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/3 v2] f2fs: clear writeback when compression failed
Message-ID: <Zh6r_yLKOnNkMedZ@google.com>
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
 <20240409203411.1885121-2-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409203411.1885121-2-jaegeuk@kernel.org>

Let's stop issuing compressed writes and clear their writeback flags.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Now, I don't see any kernel hang for 24hours.

 Change log from v1:
  - fix bugs

 fs/f2fs/compress.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d67c471ab5df..b12d3a49bfda 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1031,6 +1031,31 @@ static void set_cluster_writeback(struct compress_ctx *cc)
 	}
 }
 
+static void cancel_cluster_writeback(struct compress_ctx *cc,
+			struct compress_io_ctx *cic, int submitted)
+{
+	int i;
+
+	/* Wait for submitted IOs. */
+	if (submitted > 1) {
+		f2fs_submit_merged_write(F2FS_I_SB(cc->inode), DATA);
+		while (atomic_read(&cic->pending_pages) !=
+					(cc->valid_nr_cpages - submitted + 1))
+			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+	}
+
+	/* Cancel writeback and stay locked. */
+	for (i = 0; i < cc->cluster_size; i++) {
+		if (i < submitted) {
+			inode_inc_dirty_pages(cc->inode);
+			lock_page(cc->rpages[i]);
+		}
+		clear_page_private_gcing(cc->rpages[i]);
+		if (folio_test_writeback(page_folio(cc->rpages[i])))
+			end_page_writeback(cc->rpages[i]);
+	}
+}
+
 static void set_cluster_dirty(struct compress_ctx *cc)
 {
 	int i;
@@ -1232,7 +1257,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		.page = NULL,
 		.encrypted_page = NULL,
 		.compressed_page = NULL,
-		.submitted = 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
 		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode) ?
@@ -1358,7 +1382,16 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 			fio.compressed_page = cc->cpages[i - 1];
 
 		cc->cpages[i - 1] = NULL;
+		fio.submitted = 0;
 		f2fs_outplace_write_data(&dn, &fio);
+		if (unlikely(!fio.submitted)) {
+			cancel_cluster_writeback(cc, cic, i);
+
+			/* To call fscrypt_finalize_bounce_page */
+			i = cc->valid_nr_cpages;
+			*submitted = 0;
+			goto out_destroy_crypt;
+		}
 		(*submitted)++;
 unlock_continue:
 		inode_dec_dirty_pages(cc->inode);
@@ -1392,8 +1425,11 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
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
2.44.0.683.g7961c838ac-goog


