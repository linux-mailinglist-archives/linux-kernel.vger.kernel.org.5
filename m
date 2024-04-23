Return-Path: <linux-kernel+bounces-155210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A756E8AE6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAF71F227E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CB61350C7;
	Tue, 23 Apr 2024 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tF260L/O"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20912E1EF;
	Tue, 23 Apr 2024 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876377; cv=none; b=XInFzUVryyYUR4S/OQLgaZbA0kTlQec1B7WIWpqFntnW+kDxZ/0bOUmZwJ521afvOxpjXNs1QMYh9kTTvD8IaloJvlm/4uPVgk8YktzOvKsvsEny/ASPTKqQvsVPTpNNCL4xdYGJpcVdMp7u1mFs4YnmGyHfOChv5dr0i+f0w6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876377; c=relaxed/simple;
	bh=YCrPInPCHmbNAGTO0pwrdC/DY12ez8aLSvn5l1ptCFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kN0zF7kHee10iu1AXCs/zrTVZTqOaHxDNq/GdhsWy1GGvjmjV9P4EkJLCZBTdTdpthRGCcF9SWKxHKXQuu6XTXxu7UHfs97Mr6wk+9gIp0VLTORtHQRkez7Epd8abnDavu91PfG59Yfpz/jaN78ZW6crEB+0lvSVuY1EXYjiqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tF260L/O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9zAs9nEF7+ZOwjOZ2w7w+qyprP5j4a39o/xYjvgq0/s=; b=tF260L/O/9u26/h5GIpG8IWBoa
	nMhHXZn0xnAXeK1L7iaSnFE8J4LfbRJkLYT4yGhBqf9okdEpTiR31ToXV7FZiPbRFwn3XFw1whFad
	KvesdV2A1D8SXwT8OWWtBYVMOAP+mez13194NbJURZAcGN1hYXn/s4CPKCZcCeBfjsvS7bD7jWZ1o
	MMHrh3KkuOfZ4eHeCgcnDpaBYfIZBoO8TGwXojzRMi/AfnShr4OTlkXYy1PLoS8tGSblf9t5jP7BH
	XI4cCOucOSd7rz4PyyOytG2mTctFYJinDrGorxixQzulPmM1F9XM8WP4aAGKov2k71n36U6kxLoew
	yZkUAyWg==;
Received: from [2001:4bb8:188:6493:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFXK-0000000HULf-2ygG;
	Tue, 23 Apr 2024 12:46:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <christian@brauner.io>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] xfs: fix overly long line in the file_operations
Date: Tue, 23 Apr 2024 14:46:06 +0200
Message-Id: <20240423124608.537794-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240423124608.537794-1-hch@lst.de>
References: <20240423124608.537794-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Re-wrap the newly added fop_flags fields to not go over 80 characters.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 147439ad358138..c6b6809c1ffebd 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1496,8 +1496,8 @@ const struct file_operations xfs_file_operations = {
 	.fallocate	= xfs_file_fallocate,
 	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
-	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC |
-			  FOP_DIO_PARALLEL_WRITE,
+	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
+			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE,
 };
 
 const struct file_operations xfs_dir_file_operations = {
@@ -1510,6 +1510,6 @@ const struct file_operations xfs_dir_file_operations = {
 	.compat_ioctl	= xfs_file_compat_ioctl,
 #endif
 	.fsync		= xfs_dir_fsync,
-	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC |
-			  FOP_DIO_PARALLEL_WRITE,
+	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
+			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE,
 };
-- 
2.39.2


