Return-Path: <linux-kernel+bounces-31251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527D832B34
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17F51F21D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B92254F8E;
	Fri, 19 Jan 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Gt2xMOok"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027053E2F;
	Fri, 19 Jan 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673686; cv=none; b=B83061s2Z1lL93iMb02zGzujE0tVOmX4uqlaxUpGXD/yGZk+goS0wOf3GYZTCwA9uweGAMlFhEtpHjaBRa38x4jrk6GGaPlYKsGPHrUWqhrjrZch//2M8/STG8nym0aQx75wALEeBT7J3w9KFMCZ9ubt2ZcGm0nVdzuRMfonzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673686; c=relaxed/simple;
	bh=ulEjlAZ2D8bQ3nhph/YUQbd+dlZj+pir5iq1If3tF7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zts1r2xNlGjNnPaFm60209cbQstRdYQ/w2qf1FKTy/uIBGnExonr6DIcuaeUVSes8UYIgoNW2Ne5hGiDxOIksXRPCST8wJhIjXknvOICd1YLgfrkVmDJ7OBMquvwrRj+1QZWguJ+HUb6QYJ6tMcUR8sq8FtOTyWiwPDJTovdEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=Gt2xMOok; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1705673653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFENih9XWAd70944xbCOau+9oHw/D103WR9u3LQvnx8=;
	b=Gt2xMOokNy++NJFR1tq2AUBcDdKRgJGiiz5FSZvayuQanfDZYEBEehUt+TLwRdtKYYMQX0
	N+tcnAwYsDx961blLSEEEMkDtaedDVVXIhQ3h6d+0+HHoJaBgCZxoP1TkzfBHso6z1qKo7
	EDDtwRL25WF5+PCGPOhNibxKGarkIyE=
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
Subject: [PATCH v5 4/6] usb: gadget: functionfs: Factorize wait-for-endpoint code
Date: Fri, 19 Jan 2024 15:14:00 +0100
Message-ID: <20240119141402.44262-5-paul@crapouillou.net>
In-Reply-To: <20240119141402.44262-1-paul@crapouillou.net>
References: <20240119141402.44262-1-paul@crapouillou.net>
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


