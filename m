Return-Path: <linux-kernel+bounces-146423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858E38A650A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3894B21F61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374F015AAA5;
	Tue, 16 Apr 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNr7HcJx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DFA158D98
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252217; cv=none; b=RTECXWDBvN8qHUFDQgvhtVWKze/97mFPFyMzh9dymxFcL0eSY3xrI2cR27L6gt2d/GeTwQHwrAoLHhhtLbN12I1AuE2OTGNfxEf0sMPixqCv2C4XG0ZUKgCEiJz2MKfamcwuxyOlo2qBPtHexj3XT5Y2IkcMenOs1BXkRP7LDJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252217; c=relaxed/simple;
	bh=yUmaqz0X2leLyEtaGKKFRv7XkWM87V0UO7GQWcOJJgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJY/Zb7twTKJBRcu9tjU+dc13b9tRTH35lPQnk+XuXtosqovv6zWhLQYL0M4EXqmtFIjxTYuHDuN9ENehjZW3+350WU+JuDCavEiwgM32KO3VEMgPsG3o8ZAB5+JXBmyoaQMpRhqpE38ySji5zaYdvXXqipcVuIjLu1PFiAPa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNr7HcJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21E4C32781;
	Tue, 16 Apr 2024 07:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713252217;
	bh=yUmaqz0X2leLyEtaGKKFRv7XkWM87V0UO7GQWcOJJgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNr7HcJx5M5YA+w5jFOmPY72vMb7k70IPgptRYiFc4faHnpDQpE67a9nGIM8jgYOq
	 +4PqtM0v3T+Mec0qeWCD41e2oND6173A09YEnMf0TQa66AwKUwpCWYo8ZB7MhylIXw
	 0uesNtuMjEdd68M7k0G90bPqmOxndJctPQdjSdak7omhbWDp21BxH1CFhp78EhxIPo
	 6BT+MtPaFKuawTILlY6fCKFkz94sbW1YBN2KKVf2NBGRO+2JSv9f9IMvRNfb0LKgcG
	 aryb9tGw9QVtMa22lJr0y5g1QxGdvmJJ84z9wreAVPa/0bT6R06S7XXrRGcBLZXqmu
	 GinxU2m2lvHkA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] f2fs: convert f2fs__page tracepoint class to use folio
Date: Tue, 16 Apr 2024 15:23:18 +0800
Message-Id: <20240416072318.6486-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416072318.6486-1-chao@kernel.org>
References: <20240416072318.6486-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert f2fs__page tracepoint class() and its instances to use folio
and related functionality, and rename it to f2fs__folio().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c        |  4 ++--
 fs/f2fs/data.c              | 10 ++++-----
 fs/f2fs/node.c              |  4 ++--
 include/trace/events/f2fs.h | 42 ++++++++++++++++++-------------------
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index eac698b8dd38..5d05a413f451 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -345,7 +345,7 @@ static int __f2fs_write_meta_page(struct page *page,
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
-	trace_f2fs_writepage(page, META);
+	trace_f2fs_writepage(page_folio(page), META);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
@@ -492,7 +492,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 static bool f2fs_dirty_meta_folio(struct address_space *mapping,
 		struct folio *folio)
 {
-	trace_f2fs_set_page_dirty(&folio->page, META);
+	trace_f2fs_set_page_dirty(folio, META);
 
 	if (!folio_test_uptodate(folio))
 		folio_mark_uptodate(folio);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3eb90b9b0f8b..cf6d31e3e630 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2490,7 +2490,7 @@ static int f2fs_read_data_folio(struct file *file, struct folio *folio)
 	struct inode *inode = folio_file_mapping(folio)->host;
 	int ret = -EAGAIN;
 
-	trace_f2fs_readpage(&folio->page, DATA);
+	trace_f2fs_readpage(folio, DATA);
 
 	if (!f2fs_is_compress_backend_ready(inode)) {
 		folio_unlock(folio);
@@ -2739,7 +2739,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		} else {
 			set_inode_flag(inode, FI_UPDATE_WRITE);
 		}
-		trace_f2fs_do_write_data_page(fio->page, IPU);
+		trace_f2fs_do_write_data_page(page_folio(page), IPU);
 		return err;
 	}
 
@@ -2768,7 +2768,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 
 	/* LFS mode write path */
 	f2fs_outplace_write_data(&dn, fio);
-	trace_f2fs_do_write_data_page(page, OPU);
+	trace_f2fs_do_write_data_page(page_folio(page), OPU);
 	set_inode_flag(inode, FI_APPEND_WRITE);
 out_writepage:
 	f2fs_put_dnode(&dn);
@@ -2815,7 +2815,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.last_block = last_block,
 	};
 
-	trace_f2fs_writepage(page, DATA);
+	trace_f2fs_writepage(page_folio(page), DATA);
 
 	/* we should bypass data pages to proceed the kworker jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -3789,7 +3789,7 @@ static bool f2fs_dirty_data_folio(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 
-	trace_f2fs_set_page_dirty(&folio->page, DATA);
+	trace_f2fs_set_page_dirty(folio, DATA);
 
 	if (!folio_test_uptodate(folio))
 		folio_mark_uptodate(folio);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3b9eb5693683..95cecf08cb37 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1624,7 +1624,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	};
 	unsigned int seq;
 
-	trace_f2fs_writepage(page, NODE);
+	trace_f2fs_writepage(page_folio(page), NODE);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		/* keep node pages in remount-ro mode */
@@ -2171,7 +2171,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 static bool f2fs_dirty_node_folio(struct address_space *mapping,
 		struct folio *folio)
 {
-	trace_f2fs_set_page_dirty(&folio->page, NODE);
+	trace_f2fs_set_page_dirty(folio, NODE);
 
 	if (!folio_test_uptodate(folio))
 		folio_mark_uptodate(folio);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 7ed0fc430dc6..371ba28415f5 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1304,11 +1304,11 @@ TRACE_EVENT(f2fs_write_end,
 		__entry->copied)
 );
 
-DECLARE_EVENT_CLASS(f2fs__page,
+DECLARE_EVENT_CLASS(f2fs__folio,
 
-	TP_PROTO(struct page *page, int type),
+	TP_PROTO(struct folio *folio, int type),
 
-	TP_ARGS(page, type),
+	TP_ARGS(folio, type),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -1321,14 +1321,14 @@ DECLARE_EVENT_CLASS(f2fs__page,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= page_file_mapping(page)->host->i_sb->s_dev;
-		__entry->ino	= page_file_mapping(page)->host->i_ino;
+		__entry->dev	= folio_file_mapping(folio)->host->i_sb->s_dev;
+		__entry->ino	= folio_file_mapping(folio)->host->i_ino;
 		__entry->type	= type;
 		__entry->dir	=
-			S_ISDIR(page_file_mapping(page)->host->i_mode);
-		__entry->index	= page->index;
-		__entry->dirty	= PageDirty(page);
-		__entry->uptodate = PageUptodate(page);
+			S_ISDIR(folio_file_mapping(folio)->host->i_mode);
+		__entry->index	= folio_index(folio);
+		__entry->dirty	= folio_test_dirty(folio);
+		__entry->uptodate = folio_test_uptodate(folio);
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, %s, %s, index = %lu, "
@@ -1341,32 +1341,32 @@ DECLARE_EVENT_CLASS(f2fs__page,
 		__entry->uptodate)
 );
 
-DEFINE_EVENT(f2fs__page, f2fs_writepage,
+DEFINE_EVENT(f2fs__folio, f2fs_writepage,
 
-	TP_PROTO(struct page *page, int type),
+	TP_PROTO(struct folio *folio, int type),
 
-	TP_ARGS(page, type)
+	TP_ARGS(folio, type)
 );
 
-DEFINE_EVENT(f2fs__page, f2fs_do_write_data_page,
+DEFINE_EVENT(f2fs__folio, f2fs_do_write_data_page,
 
-	TP_PROTO(struct page *page, int type),
+	TP_PROTO(struct folio *folio, int type),
 
-	TP_ARGS(page, type)
+	TP_ARGS(folio, type)
 );
 
-DEFINE_EVENT(f2fs__page, f2fs_readpage,
+DEFINE_EVENT(f2fs__folio, f2fs_readpage,
 
-	TP_PROTO(struct page *page, int type),
+	TP_PROTO(struct folio *folio, int type),
 
-	TP_ARGS(page, type)
+	TP_ARGS(folio, type)
 );
 
-DEFINE_EVENT(f2fs__page, f2fs_set_page_dirty,
+DEFINE_EVENT(f2fs__folio, f2fs_set_page_dirty,
 
-	TP_PROTO(struct page *page, int type),
+	TP_PROTO(struct folio *folio, int type),
 
-	TP_ARGS(page, type)
+	TP_ARGS(folio, type)
 );
 
 TRACE_EVENT(f2fs_replace_atomic_write_block,
-- 
2.40.1


