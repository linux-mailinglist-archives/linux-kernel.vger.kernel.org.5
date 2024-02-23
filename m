Return-Path: <linux-kernel+bounces-77691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADEF86090C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01626285500
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C6811199;
	Fri, 23 Feb 2024 02:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH6omqY0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997611185
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656851; cv=none; b=m/027FHn6M6LavKW2P60SMxNkyQSNDbRpWq+t1DD4GHjgMvMRJstnXyOZweVXx4VzXWxCXGOs9nw1WjgsIh950t1pmjUiH9z+cMbARPPcE2R8OCD+j+1FrnqlL8d8kH3Zjd+ZTUg+54K3sMubt7499iVzfygUMPVsNIO5EsYmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656851; c=relaxed/simple;
	bh=MtfIvW3ZInRpl5iX8uy2azMoMXfPseve2FHzcWCecMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1OEVnfnJg8EPfk2ra0vjK2gZ9KgBpDI9S0mz1Z5uLm7uNOSXA1bTvgQsolDsyWVHqNQG7ilb+KwDfd3sQK7Sx8CbO0z/vgHzoCPapSHvDqbZPcUYjD2kB+zD7iZtceAhAZ7niJmI/FilAT5460ueMmBIL7hhor3FaA+y4Iiq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH6omqY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2DCC433C7;
	Fri, 23 Feb 2024 02:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708656850;
	bh=MtfIvW3ZInRpl5iX8uy2azMoMXfPseve2FHzcWCecMY=;
	h=From:To:Cc:Subject:Date:From;
	b=FH6omqY0SODN7lStTxvDfIWw8IYve+dQJ55KIhtdpcLxcL0VzlW3FT8NTghAq0Ci+
	 7HBjwq/UTV8RTUWZTu/r+CwK7DTelSMsLFlIxDcuRQt/rdwkdQpg71xO+wYXhBQ90O
	 G5/kUPbkiOynTfIJN1Pvu/p9d3FK/+v2GnZ0IQvS6q8PLdoLKEH4h8q2c4lLESZm8M
	 vQJHGsg+NonHzD2REEYQ+UMi1QaNIJ/XDgGLWtxrs8SOJmEkLQPbIC5ACduYeBdMSm
	 WoP43snOalEKqDxHHfwKYOWR1R1zdQqMXyubCC0uz0KT706RvB++ugxxv77bidCyFV
	 kSStx7lgMlo8A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to use correct segment type in f2fs_allocate_data_block()
Date: Fri, 23 Feb 2024 10:54:03 +0800
Message-Id: <20240223025403.1180558-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@type in f2fs_allocate_data_block() indicates log header's type, it
can be CURSEG_COLD_DATA_PINNED or CURSEG_ALL_DATA_ATGC, rather than
type of data/node, however IS_DATASEG()/IS_NODESEG() only accept later
one, fix it.

Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d0209ea77dd2..76422f50e6cc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3505,12 +3505,12 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
 
-	if (IS_DATASEG(type))
+	if (IS_DATASEG(se->type))
 		atomic64_inc(&sbi->allocated_data_blocks);
 
 	up_write(&sit_i->sentry_lock);
 
-	if (page && IS_NODESEG(type)) {
+	if (page && IS_NODESEG(se->type)) {
 		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
 
 		f2fs_inode_chksum_set(sbi, page);
-- 
2.40.1


