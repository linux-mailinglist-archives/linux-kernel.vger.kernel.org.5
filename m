Return-Path: <linux-kernel+bounces-28961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 383E2830539
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C475F2814C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADEF1F60C;
	Wed, 17 Jan 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="zdpoXYtl"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7041F5F0;
	Wed, 17 Jan 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494433; cv=none; b=dO9Ru4yXe3QfwdxIiDiI7e3TXOkEtn5qKigIWIV0y6sxzHWPd9V66O+bKCE1VgCpxYx/VnFYzyP21Rg9EV0OyAUcjIVOULfXYLw+ZQC2VSUj3tsyhNVhglvuE40xPRMtYGZx2b/8yX4Pf78Xmm4WxXS/QyfMGdscpZ8FyybMPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494433; c=relaxed/simple;
	bh=ulEjlAZ2D8bQ3nhph/YUQbd+dlZj+pir5iq1If3tF7Q=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Spam; b=lhrHsH9ouXM/bqcsTnKuL4HFY/YadpcrH9du4cQ+5mbIxkPkuQTtMTv4vNFVu0riIEJUFXuWk7IvLDfBarCTE7nclacnlBjKSEjnAcRaCJ87yPuDSmhPnI0zyb0OxNsCCxjoSdyZCX3inPf5jgjjNewBAAuiEsLxvsur7gSJ2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=zdpoXYtl; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1705494414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFENih9XWAd70944xbCOau+9oHw/D103WR9u3LQvnx8=;
	b=zdpoXYtlbEWohSWSZ5pcgUFvnMyEH/qg+1FZLH9oUOoWLl4KS13vJWJKFNo++e7pm0lgbD
	6vlH83/2CrpoOyg5jRst4DT2dCK5WthcOzUHt2MLFOGo6EIHTxPBm48rnnjDiRDLtXtZ7h
	7WccjouMbwBKfABUgZkLYSmkfPGUuVs=
From: Paul Cercueil <paul@crapouillou.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 2/4] usb: gadget: functionfs: Factorize wait-for-endpoint code
Date: Wed, 17 Jan 2024 13:26:44 +0100
Message-ID: <20240117122646.41616-3-paul@crapouillou.net>
In-Reply-To: <20240117122646.41616-1-paul@crapouillou.net>
References: <20240117122646.41616-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

This exact same code was duplicated in two different places.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/gadget/function/f_fs.c | 48 +++++++++++++++++-------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6bff6cb93789..ed2a6d5fcef7 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -934,31 +934,44 @@ static ssize_t __ffs_epfile_read_data(struct ffs_epfile *epfile,
 	return ret;
 }
 
-static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
+static struct ffs_ep *ffs_epfile_wait_ep(struct file *file)
 {
 	struct ffs_epfile *epfile = file->private_data;
-	struct usb_request *req;
 	struct ffs_ep *ep;
-	char *data = NULL;
-	ssize_t ret, data_len = -EINVAL;
-	int halt;
-
-	/* Are we still active? */
-	if (WARN_ON(epfile->ffs->state != FFS_ACTIVE))
-		return -ENODEV;
+	int ret;
 
 	/* Wait for endpoint to be enabled */
 	ep = epfile->ep;
 	if (!ep) {
 		if (file->f_flags & O_NONBLOCK)
-			return -EAGAIN;
+			return ERR_PTR(-EAGAIN);
 
 		ret = wait_event_interruptible(
 				epfile->ffs->wait, (ep = epfile->ep));
 		if (ret)
-			return -EINTR;
+			return ERR_PTR(-EINTR);
 	}
 
+	return ep;
+}
+
+static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
+{
+	struct ffs_epfile *epfile = file->private_data;
+	struct usb_request *req;
+	struct ffs_ep *ep;
+	char *data = NULL;
+	ssize_t ret, data_len = -EINVAL;
+	int halt;
+
+	/* Are we still active? */
+	if (WARN_ON(epfile->ffs->state != FFS_ACTIVE))
+		return -ENODEV;
+
+	ep = ffs_epfile_wait_ep(file);
+	if (IS_ERR(ep))
+		return PTR_ERR(ep);
+
 	/* Do we halt? */
 	halt = (!io_data->read == !epfile->in);
 	if (halt && epfile->isoc)
@@ -1280,16 +1293,9 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 		return -ENODEV;
 
 	/* Wait for endpoint to be enabled */
-	ep = epfile->ep;
-	if (!ep) {
-		if (file->f_flags & O_NONBLOCK)
-			return -EAGAIN;
-
-		ret = wait_event_interruptible(
-				epfile->ffs->wait, (ep = epfile->ep));
-		if (ret)
-			return -EINTR;
-	}
+	ep = ffs_epfile_wait_ep(file);
+	if (IS_ERR(ep))
+		return PTR_ERR(ep);
 
 	spin_lock_irq(&epfile->ffs->eps_lock);
 
-- 
2.43.0


