Return-Path: <linux-kernel+bounces-127828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCC6895183
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398D91C230BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F02757EF;
	Tue,  2 Apr 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="g7XpqR7H"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1A60BB6;
	Tue,  2 Apr 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056225; cv=none; b=Rlu6QFS4XmDSoencnkxSlgMacLLm79jE8PgzO6rBVvjBbvD629hjUXrnhcZm4k2x1EDyYhkdkkTvCtqX+IOmPjHOtXV2WKttPR2dEl5OAJy6TKNBzsvSdc1xFruRXZnqSAHKtl1ECMyZRxH7CziYn6n6QHu0V2PtTbmibpX0wiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056225; c=relaxed/simple;
	bh=IGW/Tgw3LKn4iDk4deu6yKg+dfrx6dGlK8tei77dph4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsVT+nB7ENe/zTWfbX66EidSKlmEVGZigfviB4/TL/P3M9NGojt5jjfJxnLBqRLATInvgBE5CF397JZ54WRsJ/BUCKPAv1yglJhZIqEx3lmAQy2cX6IuQLA1VX3iUVwN6/D/VRzpSdAX+n7mqqJmz/6ExYKIUIBZ4WfizoX41ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=g7XpqR7H; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1712056198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDZK/XR7slMHOlGgiaonL0K8BbhEPN6m1IkTdq5tuvI=;
	b=g7XpqR7HdYUpjaqw0O3K+zbvlbBQwmOQnas0xCsgRtICOsIHC9wCqyEJqNY60jrPrueGoy
	IXnpu6YIAlruEquZ50uq3n+Tf+aG7gexuUqZuRBYRmgIZHATn2uuxYKoaEZqNculp32UC7
	zJRTmCJCrdeqf/2jut6Jiy8HvXUsVQk=
From: Paul Cercueil <paul@crapouillou.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] usb: gadget: functionfs: Wait for fences before enqueueing DMABUF
Date: Tue,  2 Apr 2024 13:09:51 +0200
Message-ID: <20240402110951.16376-3-paul@crapouillou.net>
In-Reply-To: <20240402110951.16376-1-paul@crapouillou.net>
References: <20240402110951.16376-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of bailing when fences have already been installed on the
DMABUF, wait for them (with a timeout) when doing a blocking operation.

This fixes the issue where userspace would submit a DMABUF with fences
already installed, with the (correct) expectation that it would just
work.

Fixes: 7b07a2a7ca02 ("usb: gadget: functionfs: Add DMABUF import interface")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/gadget/function/f_fs.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 70e8532127ad..f855f1fc8e5e 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -46,6 +46,8 @@
 
 #define FUNCTIONFS_MAGIC	0xa647361 /* Chosen by a honest dice roll ;) */
 
+#define DMABUF_ENQUEUE_TIMEOUT_MS 5000
+
 MODULE_IMPORT_NS(DMA_BUF);
 
 /* Reference counter handling */
@@ -1580,9 +1582,11 @@ static int ffs_dmabuf_transfer(struct file *file,
 	struct usb_request *usb_req;
 	enum dma_resv_usage resv_dir;
 	struct dma_buf *dmabuf;
+	unsigned long timeout;
 	struct ffs_ep *ep;
 	bool cookie;
 	u32 seqno;
+	long retl;
 	int ret;
 
 	if (req->flags & ~USB_FFS_DMABUF_TRANSFER_MASK)
@@ -1616,17 +1620,14 @@ static int ffs_dmabuf_transfer(struct file *file,
 		goto err_attachment_put;
 
 	/* Make sure we don't have writers */
-	if (!dma_resv_test_signaled(dmabuf->resv, DMA_RESV_USAGE_WRITE)) {
-		pr_vdebug("FFS WRITE fence is not signaled\n");
-		ret = -EBUSY;
-		goto err_resv_unlock;
-	}
-
-	/* If we're writing to the DMABUF, make sure we don't have readers */
-	if (epfile->in &&
-	    !dma_resv_test_signaled(dmabuf->resv, DMA_RESV_USAGE_READ)) {
-		pr_vdebug("FFS READ fence is not signaled\n");
-		ret = -EBUSY;
+	timeout = nonblock ? 0 : msecs_to_jiffies(DMABUF_ENQUEUE_TIMEOUT_MS);
+	retl = dma_resv_wait_timeout(dmabuf->resv,
+				     dma_resv_usage_rw(epfile->in),
+				     true, timeout);
+	if (retl == 0)
+		retl = -EBUSY;
+	if (retl < 0) {
+		ret = (int)retl;
 		goto err_resv_unlock;
 	}
 
-- 
2.43.0


