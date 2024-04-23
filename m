Return-Path: <linux-kernel+bounces-155211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC38AE6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CB21C22C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E08135417;
	Tue, 23 Apr 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l1OdYKnp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A921350F2;
	Tue, 23 Apr 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876380; cv=none; b=SBDE9RLy9tBmA/g8q0hEOOYz9qRtLU5uuRG8BjTGdqESk/dD074p9HrD1WcQnqZvw3q0I81zBEmYWFegd4QCFBrG18aSGDeEm9PmwOTzHn+y0N00aYMWtMy+ptEb/r9VKBZAGIzq16lFyYXQM5BVDC0X5y+VGYkXlSqYmYhkaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876380; c=relaxed/simple;
	bh=BxMAkpca3ViBiB6fVCh7/U85g5Tb9bPwlOKo1lpb7+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+bi9ggfrR5+MqdMhEVmB8nWHDOB22kiJWWDao6zwIORbvvQd/rdEnYvEaX+mwN/iXwEUQPAuZcgt/AMMstV9GOETvLOhAM1yjmLK8K1wz4M4ukxxxXHwm+A4sA6Z6aKBkMR9vVm6800Cdql6ZuCcWcH/rQBhu4iyrbu/H9WFYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l1OdYKnp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OmGSpkukveGFv9lLJp3G3giV3zXbdzKjM6lWU4kc0BY=; b=l1OdYKnpocA3B/3EMb3Pb05kHS
	H0syQOPBFHEO2MjbCbmedPI/LA1P73j8jMg08rASmhCJM6L6+ao+axsYXhKP0qihhwW2wfHtukAzk
	OKe4Ki3xG2JA2/NYD8H0+fTWT8k7HkCpP02Tty6vJQKfiaJpoP3PmXnmOLs2Dcu9pEOuNMO3gBWgB
	rh+Y+B978i1WfbK8FOuCYc3vUIkyoXVBW0oRCLwJIZ5CResnP7pDec5/mdVqvoUpBuIG3RsKTa4GG
	Jd7lBRUNAoKxDb0OGe7F1LLxnzmpZsuj1esKBkoKGW5xed+OUgW8JCZiuigbufybDsogyQY66NhQH
	H94SXLJA==;
Received: from [2001:4bb8:188:6493:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFXN-0000000HUO3-2rUa;
	Tue, 23 Apr 2024 12:46:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <christian@brauner.io>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] xfs: drop fop_flags for directories
Date: Tue, 23 Apr 2024 14:46:07 +0200
Message-Id: <20240423124608.537794-3-hch@lst.de>
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

Directories have non of the capabilities, so drop the flags.  Note that
the current state is harmless as no one actually checks for the flags
either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c6b6809c1ffebd..4415d0f3bbc51b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1510,6 +1510,4 @@ const struct file_operations xfs_dir_file_operations = {
 	.compat_ioctl	= xfs_file_compat_ioctl,
 #endif
 	.fsync		= xfs_dir_fsync,
-	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
-			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE,
 };
-- 
2.39.2


