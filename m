Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2297A0BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbjINRZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239798AbjINRZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:25:12 -0400
X-Greylist: delayed 80218 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 10:23:59 PDT
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DBE30D2;
        Thu, 14 Sep 2023 10:23:59 -0700 (PDT)
Received: from ritsuko.sh.sumomo.pri (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id 8A939300227;
        Fri, 15 Sep 2023 02:23:43 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 8A939300227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1694712224; bh=j3cXdDXlXtGM24L87BIaZF4xE90ce3LP9T6Em1o+1lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7HQiwHVtd/ry7I6rWuDVwqBBhIOJNqxgPOfm5OUGNQBvyUtJGWlR/GWnTxayr8jS
         87hNlsfs/8WJRmeEhNfOtKNJYebCPtHmnpZ6V25MWweUUau2Do2oSpMQsHwFshOMdE
         pJ8Z1uvfTYn/EpR4KbSliash7sZsl23+qvtrtzNg=
From:   Randy Li <ayaka@soulik.info>
To:     linux-usb@vger.kernel.org
Cc:     Randy Li <ayaka@soulik.info>, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] docs: driver-api: usb: update dma info
Date:   Fri, 15 Sep 2023 01:23:24 +0800
Message-ID: <20230914172336.18761-3-ayaka@soulik.info>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914172336.18761-1-ayaka@soulik.info>
References: <20230914172336.18761-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not hide the recommend APIs in a obscure place.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 Documentation/driver-api/usb/dma.rst | 48 +++++++---------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/Documentation/driver-api/usb/dma.rst b/Documentation/driver-api/usb/dma.rst
index d32c27e11b90..02f6825ff830 100644
--- a/Documentation/driver-api/usb/dma.rst
+++ b/Documentation/driver-api/usb/dma.rst
@@ -93,44 +93,18 @@ DMA address space of the device.  However, most buffers passed to your
 driver can safely be used with such DMA mapping.  (See the first section
 of Documentation/core-api/dma-api-howto.rst, titled "What memory is DMA-able?")
 
-- When you're using scatterlists, you can map everything at once.  On some
-  systems, this kicks in an IOMMU and turns the scatterlists into single
-  DMA transactions::
+- When you have the scatterlists which have been mapped for the USB controller,
+  you could use the new ``usb_sg_*()`` calls, which would turn scatterlist
+  into URBs::
 
-	int usb_buffer_map_sg (struct usb_device *dev, unsigned pipe,
-		struct scatterlist *sg, int nents);
+	int usb_sg_init(struct usb_sg_request *io, struct usb_device *dev,
+		unsigned pipe, unsigned	period, struct scatterlist *sg,
+		int nents, size_t length, gfp_t mem_flags);
 
-	void usb_buffer_dmasync_sg (struct usb_device *dev, unsigned pipe,
-		struct scatterlist *sg, int n_hw_ents);
+	void usb_sg_wait(struct usb_sg_request *io);
 
-	void usb_buffer_unmap_sg (struct usb_device *dev, unsigned pipe,
-		struct scatterlist *sg, int n_hw_ents);
+	void usb_sg_cancel(struct usb_sg_request *io);
 
-  It's probably easier to use the new ``usb_sg_*()`` calls, which do the DMA
-  mapping and apply other tweaks to make scatterlist i/o be fast.
-
-- Some drivers may prefer to work with the model that they're mapping large
-  buffers, synchronizing their safe re-use.  (If there's no re-use, then let
-  usbcore do the map/unmap.)  Large periodic transfers make good examples
-  here, since it's cheaper to just synchronize the buffer than to unmap it
-  each time an urb completes and then re-map it on during resubmission.
-
-  These calls all work with initialized urbs:  ``urb->dev``, ``urb->pipe``,
-  ``urb->transfer_buffer``, and ``urb->transfer_buffer_length`` must all be
-  valid when these calls are used (``urb->setup_packet`` must be valid too
-  if urb is a control request)::
-
-	struct urb *usb_buffer_map (struct urb *urb);
-
-	void usb_buffer_dmasync (struct urb *urb);
-
-	void usb_buffer_unmap (struct urb *urb);
-
-  The calls manage ``urb->transfer_dma`` for you, and set
-  ``URB_NO_TRANSFER_DMA_MAP`` so that usbcore won't map or unmap the buffer.
-  They cannot be used for setup_packet buffers in control requests.
-
-Note that several of those interfaces are currently commented out, since
-they don't have current users.  See the source code.  Other than the dmasync
-calls (where the underlying DMA primitives have changed), most of them can
-easily be commented back in if you want to use them.
+  When the USB controller doesn't support DMA, the ``usb_sg_init()`` would try
+  to submit URBs in PIO way as long as the page in scatterlists is not in the
+  Highmem, which could be very rare in modern architectures.
-- 
2.41.0

