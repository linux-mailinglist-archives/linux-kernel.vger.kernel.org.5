Return-Path: <linux-kernel+bounces-28963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094FC830542
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309F31C24097
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C884620300;
	Wed, 17 Jan 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="r779x7mk"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3840200D9;
	Wed, 17 Jan 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494449; cv=none; b=cvVJnvPyIggL1ePe1Dxm2Ck/sL93g/J417S3ZfHBqgMTkvWIL/kI9B9xVzWIo+G/A29yT9Dbmca2oVye22aERJ4n6aOqOmfp6Ohd6Kbo1NyX8v4JnGVKrCJInHyxBrVOZpE99qf1JwZLkqUfTevrZBLQFmwD+dTNWaKv4TkefsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494449; c=relaxed/simple;
	bh=cJbgWol1KPqWfYEC1f0fo3P+Gvr3uUpwLWEV8WXaueM=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Spam; b=Gb3mn5ZWsD6UqqZGxUScc/DmdAmA9YoXPLYs/PsTIcI2ZGevJzK5JdxwhQb4Jpy+vd2OZjMhxLbTtzfukJRZVIcqrZ44A8hmAeZ2hNoIAe5XnPQVMIlyKM7/sGBEmMdTP5YimDEI11tw4n7jeQKcM3ZYutGQOijOUzxU+VNP2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=r779x7mk; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1705494415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zL3Tp6j0FI2WH0LNy5N+K5/yV+yjLiDhRH8Apc3kyR0=;
	b=r779x7mkgifHJMN6ShIX7jeNnvVGK0qxFXSIORj1ezPRQH3QT8H7kkaH2RvoSB3uULlm4u
	3jbtB/thCBhngkDbpQM6jMgmXDO7BGFfxMPUGf0jX/gTjCDgcj+CXtfNgfwc7Vigz8aFuE
	OofQGjqzjXAa2mfCrHjY5ykmLYedP+c=
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
Subject: [PATCH v4 4/4] Documentation: usb: Document FunctionFS DMABUF API
Date: Wed, 17 Jan 2024 13:26:46 +0100
Message-ID: <20240117122646.41616-5-paul@crapouillou.net>
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

Add documentation for the three ioctls used to attach or detach
externally-created DMABUFs, and to request transfers from/to previously
attached DMABUFs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v3: New patch
---
 Documentation/usb/functionfs.rst | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/usb/functionfs.rst b/Documentation/usb/functionfs.rst
index a3054bea38f3..d05a775bc45b 100644
--- a/Documentation/usb/functionfs.rst
+++ b/Documentation/usb/functionfs.rst
@@ -2,6 +2,9 @@
 How FunctionFS works
 ====================
 
+Overview
+========
+
 From kernel point of view it is just a composite function with some
 unique behaviour.  It may be added to an USB configuration only after
 the user space driver has registered by writing descriptors and
@@ -66,3 +69,36 @@ have been written to their ep0's.
 
 Conversely, the gadget is unregistered after the first USB function
 closes its endpoints.
+
+DMABUF interface
+================
+
+FunctionFS additionally supports a DMABUF based interface, where the
+userspace can attach DMABUF objects (externally created) to an endpoint,
+and subsequently use them for data transfers.
+
+A userspace application can then use this interface to share DMABUF
+objects between several interfaces, allowing it to transfer data in a
+zero-copy fashion, for instance between IIO and the USB stack.
+
+As part of this interface, three new IOCTLs have been added. These three
+IOCTLs have to be performed on a data endpoint (ie. not ep0). They are:
+
+  ``FUNCTIONFS_DMABUF_ATTACH(int)``
+    Attach the DMABUF object, identified by its file descriptor, to the
+    data endpoint. Returns zero on success, and a negative errno value
+    on error.
+
+  ``FUNCTIONFS_DMABUF_DETACH(int)``
+    Detach the given DMABUF object, identified by its file descriptor,
+    from the data endpoint. Returns zero on success, and a negative
+    errno value on error. Note that closing the endpoint's file
+    descriptor will automatically detach all attached DMABUFs.
+
+  ``FUNCTIONFS_DMABUF_TRANSFER(struct usb_ffs_dmabuf_transfer_req *)``
+    Enqueue the previously attached DMABUF to the transfer queue.
+    The argument is a structure that packs the DMABUF's file descriptor,
+    the size in bytes to transfer (which should generally correspond to
+    the size of the DMABUF), and a 'flags' field which is unused
+    for now. Returns zero on success, and a negative errno value on
+    error.
-- 
2.43.0


