Return-Path: <linux-kernel+bounces-44596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE62B8424CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A817289E21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA78B6A32E;
	Tue, 30 Jan 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="uStG4m2O"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206167E9C;
	Tue, 30 Jan 2024 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617440; cv=none; b=NUOu7lHQqmJnEjS3w+D5AajlHIkzFLD1IsrzkVVLdCUe2//MQRZN9aiv6AE0kJHohR5Egx8uhMGWTKXpeKzvZQj3spmE50n8urcDlAUfrHBHg6v3HEumh3vd/u46elOpejjIqqGj3DO8FQllhbQrgWnuUjH37KZsj2b/54SwMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617440; c=relaxed/simple;
	bh=66FzAt7nJpAY9ka7VMdHoplxE2iQOAZv1WQkaTZVLTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNYstDiDeY2lAtcY3BsXlFC2k6xw59IVAIq3RgQ9Bh9kXP2KIyQY7heV35BMYFGZ2ynhKPKI/RsJb0DLN/Vsk2BJkID+yRDYLND1vQeNZbOb6Z0/VUpdbrWfMg1Xl2hBH/1vf0wofzciBj5mTk1S9cbJ7oNADKHBqeU7ilEX7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=uStG4m2O; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1706617428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqXbfp61fzBHWNEqVrElLd46cr7HG/1wYVIvKKSn5jY=;
	b=uStG4m2OiYDXjAnbZhvlePwi6RCL5a65XfVMHf3kIDQFND4jkC6cwEBz0jaA9AW1MZbf1/
	2u/o3/68rPjN5owEZJ5rGx2hINs1wO31bHkjYDAEEB8LZF+afk4mDgWOr+EQfngv9sqZL3
	QFrIivxNGWeocp6JrbECrSQlqQxE4YQ=
From: Paul Cercueil <paul@crapouillou.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 1/4] usb: gadget: Support already-mapped DMA SGs
Date: Tue, 30 Jan 2024 13:23:37 +0100
Message-ID: <20240130122340.54813-2-paul@crapouillou.net>
In-Reply-To: <20240130122340.54813-1-paul@crapouillou.net>
References: <20240130122340.54813-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new 'sg_was_mapped' field to the struct usb_request. This field
can be used to indicate that the scatterlist associated to the USB
transfer has already been mapped into the DMA space, and it does not
have to be done internally.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/gadget/udc/core.c | 7 ++++++-
 include/linux/usb/gadget.h    | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d59f94464b87..9d4150124fdb 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -903,6 +903,11 @@ int usb_gadget_map_request_by_dev(struct device *dev,
 	if (req->length == 0)
 		return 0;
 
+	if (req->sg_was_mapped) {
+		req->num_mapped_sgs = req->num_sgs;
+		return 0;
+	}
+
 	if (req->num_sgs) {
 		int     mapped;
 
@@ -948,7 +953,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_map_request);
 void usb_gadget_unmap_request_by_dev(struct device *dev,
 		struct usb_request *req, int is_in)
 {
-	if (req->length == 0)
+	if (req->length == 0 || req->sg_was_mapped)
 		return;
 
 	if (req->num_mapped_sgs) {
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index a771ccc038ac..c529e4e06997 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -52,6 +52,7 @@ struct usb_ep;
  * @short_not_ok: When reading data, makes short packets be
  *     treated as errors (queue stops advancing till cleanup).
  * @dma_mapped: Indicates if request has been mapped to DMA (internal)
+ * @sg_was_mapped: Set if the scatterlist has been mapped before the request
  * @complete: Function called when request completes, so this request and
  *	its buffer may be re-used.  The function will always be called with
  *	interrupts disabled, and it must not sleep.
@@ -111,6 +112,7 @@ struct usb_request {
 	unsigned		zero:1;
 	unsigned		short_not_ok:1;
 	unsigned		dma_mapped:1;
+	unsigned		sg_was_mapped:1;
 
 	void			(*complete)(struct usb_ep *ep,
 					struct usb_request *req);
-- 
2.43.0


