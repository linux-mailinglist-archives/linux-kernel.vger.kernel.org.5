Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D117C50BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbjJKLCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbjJKLCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:02:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4880898
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022132; x=1728558132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jX49b7tx6A7Zo7jAUVrcHlfA6tQul/wKjIem8aDMzX0=;
  b=UPzaMpsvTLrfxBDZRT7mvEKvkBH2tK8E5V93SW+4u+Ik1oBtuJXYMH/z
   hIyqbVm5A5NxfwNjkj9mlU9IlSqZrAq5EVrUDk/g01elFAFDvlJbYKd/D
   nm0EjTSgxs+ltd+6b17xcByn+DU1gWOU84LezMCRxoPx8co0e3fZH0M+V
   aRu2Muv1jpTz5bldHe8WgRmoDBychLvZQ4+cD0ynMPZ/P9oyMx38SLdnq
   cM7k6p8bSuS+qri3kONH7GieI55YtFPMKP789tASXaIZ+OETxbx4wae5N
   rCLUsvwTCRfzzO5XmYeBzbuWjBjG8PWj73mzhkx5yjpvMikUIAjBhZuUj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369696904"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="369696904"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788960271"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788960271"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:02:09 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/4] mei: bus: add send and recv api with timeout
Date:   Wed, 11 Oct 2023 14:01:54 +0300
Message-ID: <20231011110157.247552-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011110157.247552-1-tomas.winkler@intel.com>
References: <20231011110157.247552-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add variation of the send and recv functions on bus
that define timeout.
Caller can use such functions in flow that can stuck
to bail out and not to put down the whole system.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c     | 88 +++++++++++++++++++++++++++++++++++++-
 include/linux/mei_cl_bus.h |  8 ++++
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 67557c67bd214415b8dc6747..f9bcff197615128d72f17590 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -257,7 +257,7 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length, u8 *vtag,
 }
 
 /**
- * mei_cldev_send_vtag - me device send with vtag  (write)
+ * mei_cldev_send_vtag - me device send with vtag (write)
  *
  * @cldev: me client device
  * @buf: buffer to send
@@ -278,6 +278,29 @@ ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, const u8 *buf,
 }
 EXPORT_SYMBOL_GPL(mei_cldev_send_vtag);
 
+/**
+ * mei_cldev_send_vtag_timeout - me device send with vtag and timeout (write)
+ *
+ * @cldev: me client device
+ * @buf: buffer to send
+ * @length: buffer length
+ * @vtag: virtual tag
+ * @timeout: send timeout in milliseconds, 0 for infinite timeout
+ *
+ * Return:
+ *  * written size in bytes
+ *  * < 0 on error
+ */
+
+ssize_t mei_cldev_send_vtag_timeout(struct mei_cl_device *cldev, const u8 *buf,
+				    size_t length, u8 vtag, unsigned long timeout)
+{
+	struct mei_cl *cl = cldev->cl;
+
+	return __mei_cl_send_timeout(cl, buf, length, vtag, MEI_CL_IO_TX_BLOCKING, timeout);
+}
+EXPORT_SYMBOL_GPL(mei_cldev_send_vtag_timeout);
+
 /**
  * mei_cldev_recv_vtag - client receive with vtag (read)
  *
@@ -323,7 +346,49 @@ ssize_t mei_cldev_recv_nonblock_vtag(struct mei_cl_device *cldev, u8 *buf,
 EXPORT_SYMBOL_GPL(mei_cldev_recv_nonblock_vtag);
 
 /**
- * mei_cldev_send - me device send  (write)
+ * mei_cldev_recv_timeout - client receive with timeout (read)
+ *
+ * @cldev: me client device
+ * @buf: buffer to receive
+ * @length: buffer length
+ * @timeout: send timeout in milliseconds, 0 for infinite timeout
+ *
+ * Return:
+ * * read size in bytes
+ * *  < 0 on error
+ */
+ssize_t mei_cldev_recv_timeout(struct mei_cl_device *cldev, u8 *buf, size_t length,
+			       unsigned long timeout)
+{
+	return mei_cldev_recv_vtag_timeout(cldev, buf, length, NULL, timeout);
+}
+EXPORT_SYMBOL_GPL(mei_cldev_recv_timeout);
+
+/**
+ * mei_cldev_recv_vtag_timeout - client receive with vtag (read)
+ *
+ * @cldev: me client device
+ * @buf: buffer to receive
+ * @length: buffer length
+ * @vtag: virtual tag
+ * @timeout: recv timeout in milliseconds, 0 for infinite timeout
+ *
+ * Return:
+ * * read size in bytes
+ * *  < 0 on error
+ */
+
+ssize_t mei_cldev_recv_vtag_timeout(struct mei_cl_device *cldev, u8 *buf, size_t length,
+				    u8 *vtag, unsigned long timeout)
+{
+	struct mei_cl *cl = cldev->cl;
+
+	return __mei_cl_recv(cl, buf, length, vtag, 0, timeout);
+}
+EXPORT_SYMBOL_GPL(mei_cldev_recv_vtag_timeout);
+
+/**
+ * mei_cldev_send - me device send (write)
  *
  * @cldev: me client device
  * @buf: buffer to send
@@ -339,6 +404,25 @@ ssize_t mei_cldev_send(struct mei_cl_device *cldev, const u8 *buf, size_t length
 }
 EXPORT_SYMBOL_GPL(mei_cldev_send);
 
+/**
+ * mei_cldev_send_timeout - me device send with timeout (write)
+ *
+ * @cldev: me client device
+ * @buf: buffer to send
+ * @length: buffer length
+ * @timeout: send timeout in milliseconds, 0 for infinite timeout
+ *
+ * Return:
+ *  * written size in bytes
+ *  * < 0 on error
+ */
+ssize_t mei_cldev_send_timeout(struct mei_cl_device *cldev, const u8 *buf, size_t length,
+			       unsigned long timeout)
+{
+	return mei_cldev_send_vtag_timeout(cldev, buf, length, 0, timeout);
+}
+EXPORT_SYMBOL_GPL(mei_cldev_send_timeout);
+
 /**
  * mei_cldev_recv - client receive (read)
  *
diff --git a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h
index c9af62e54577033bf9bae0e4..b38a56a13f39277f948c53b8 100644
--- a/include/linux/mei_cl_bus.h
+++ b/include/linux/mei_cl_bus.h
@@ -94,15 +94,23 @@ void mei_cldev_driver_unregister(struct mei_cl_driver *cldrv);
 
 ssize_t mei_cldev_send(struct mei_cl_device *cldev, const u8 *buf,
 		       size_t length);
+ssize_t mei_cldev_send_timeout(struct mei_cl_device *cldev, const u8 *buf,
+			       size_t length, unsigned long timeout);
 ssize_t mei_cldev_recv(struct mei_cl_device *cldev, u8 *buf, size_t length);
 ssize_t mei_cldev_recv_nonblock(struct mei_cl_device *cldev, u8 *buf,
 				size_t length);
+ssize_t mei_cldev_recv_timeout(struct mei_cl_device *cldev, u8 *buf, size_t length,
+			       unsigned long timeout);
 ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, const u8 *buf,
 			    size_t length, u8 vtag);
+ssize_t mei_cldev_send_vtag_timeout(struct mei_cl_device *cldev, const u8 *buf,
+				    size_t length, u8 vtag, unsigned long timeout);
 ssize_t mei_cldev_recv_vtag(struct mei_cl_device *cldev, u8 *buf, size_t length,
 			    u8 *vtag);
 ssize_t mei_cldev_recv_nonblock_vtag(struct mei_cl_device *cldev, u8 *buf,
 				     size_t length, u8 *vtag);
+ssize_t mei_cldev_recv_vtag_timeout(struct mei_cl_device *cldev, u8 *buf, size_t length,
+			    u8 *vtag, unsigned long timeout);
 
 int mei_cldev_register_rx_cb(struct mei_cl_device *cldev, mei_cldev_cb_t rx_cb);
 int mei_cldev_register_notif_cb(struct mei_cl_device *cldev,
-- 
2.41.0

