Return-Path: <linux-kernel+bounces-163145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3BA8B6653
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377F21F22A35
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651D919DF6E;
	Mon, 29 Apr 2024 23:33:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A76194C6B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433628; cv=none; b=cj17Kew8DibGoQnRsKoUYY2YHPJvtyYwepBT2LeCCQmJSP8868QsNhAWnWuYCVjHwuF+LduVM+v2zPA2Xs+qoc1pVhHeZ02hLx1O3AtPClDZxhNab3YMQ0UKCGyG7RYo2bpY7n6mS2G89VAkrpuIJAz+k6/d5C4bRsm+n0En700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433628; c=relaxed/simple;
	bh=xY/cH0tfEKi7DyHxt5AnTEMHiYNr4cvHSabNkCYj/H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7xEHZvt/JH5HyrnbJ2TkfVoxBBIhuLYvC6j9Emr8F8x7RFJLm8iIakHuEt7zhbMwT47VXVoBgjpL9KndolsuiHWjdlamkUvO+wIz2hMQ5Kaf2RlGmEU6/HxyxOrwJq/7ec3S7jxRczu3jQusDO5FDkMObfujkCexTxwQFRGLy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1s1aV3-0000Et-9F; Tue, 30 Apr 2024 01:33:33 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1s1aUy-00F42j-T8; Tue, 30 Apr 2024 01:33:28 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1s1aUy-004m1K-1A;
	Tue, 30 Apr 2024 01:33:28 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 30 Apr 2024 01:33:27 +0200
Subject: [PATCH v4 2/3] net/9p/usbg: Add new usb gadget function transport
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v4-2-722ed28b0ade@pengutronix.de>
References: <20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=30403;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=xY/cH0tfEKi7DyHxt5AnTEMHiYNr4cvHSabNkCYj/H8=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmMC5I3G3+RCa30ELZclpCdnpVpN3ddwpFfMEUC
 kIlSGbK5p2JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZjAuSAAKCRC/aVhE+XH0
 q6NuD/wOJpd3CsAl4wtTgdZJ/Oc+t4lVRgH7heY5tAtET0Lgp6yIKx4AHZWRBKhMaVEDf26fSww
 wFfWKsjjBNbNCdwDn+5lMFI7lo6fwlAwrgGoJKghx7yw/t0tjjPC9pLsLh6F+Fu0z4h+tb7TtS6
 NI+7XKtZxt6/BsYby/JRer1sWImeQlL1QllaNvLs5zjTaEDrFjuEeiCaEZvGGBBilwFrHTTySUB
 5LEYLsq5xf4MjlApSGDUkpEUwW2pnFoGdpU5txuHpCASzgajXxUcka3XDz1QdABTfcl84N2A2F6
 QSMj3OWH0yeh280JZTJXOi1JmWE56YXDK0xL9SV5XTVpXsegjnEI5w/0sg+uAfgf7N5fL8W3/DE
 h6AD6HDM/gYX4BfZy6vclulygjmTz7sMuG33//Ve1WVf3JliCoB7rHN2haASDJr8cO11mnJ2h1q
 GnopEWME3VQjDgI9xZObb2cbAri/rdvh79scx81RN6ovISvG6QFAR30/o4MtlOlhfHy4+hlqmKE
 ++RyhFCswZLkq+PLd/yIgACWKvmlJjQUKD/Ww8UewAAcPuA9jE7qMQJ8KH/lN45CVXTYCFk5NsM
 qic1UDYphw1a9KwUxx86dCu5/2zYIMnok2I5rAdjm9aMpAbXk2cDFtwczMVi1FAQ+rGwdxIJ41+
 nA9RQunqrSnDgSA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add the new gadget function for 9pfs transport. This function is
defining an simple 9pfs transport interface that consists of one in and
one out endpoint. The endpoints transmit and receive the 9pfs protocol
payload when mounting a 9p filesystem over usb.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v3 -> v4:
  - implemented conn_cancel
  - moved from mount_tag to device name like ffs does
  - renamed function_list to usb9pfs_instance
  - renamed usbg_function_list to usb9pfs_instance_list
  - renamed rx/tx_fill to queue_rx/tx
  - added use of retvals
  - added locking comment over usb9pfs_transmit
  - using if_else instead of two pathed switch calls
  - fixed return values of completion handler
  - using void pointer as parameter in rx_header
  - added a missed req_put in rx_header
  - removed extra disable function but call disable_ep directly
  - repaired several return values
  - remove the suspicious disable / enable path in usbg_create
v2 -> v3: -
v1 -> v2:
  - move the driver to net/9p/trans_usbg.c
  - fixed the commit title
  - fix %zu usage in p9_debug for size_t type
  - define functions static that are only used localy
  - return 0 in alloc_requests
  - use id_alloc_max instead of ida_simple_get
  - call ida_free in usb9pfs_free_func
  - call kfree for usb9pfs->tag and usb9pfs in usb9pfs_free_func
  - add MODULE_ALIAS_9P to load this module automatic when mounting
  - improved the documentation
  - added depends on USB_GADGET in Kconfig
---
 Documentation/filesystems/9p.rst |  17 +-
 net/9p/Kconfig                   |   6 +
 net/9p/Makefile                  |   4 +
 net/9p/trans_usbg.c              | 983 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 1009 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 1e0e0bb6fdf91..10cf79dc287f8 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -48,11 +48,25 @@ For server running on QEMU host with virtio transport::
 
 	mount -t 9p -o trans=virtio <mount_tag> /mnt/9
 
-where mount_tag is the tag associated by the server to each of the exported
+where mount_tag is the tag generated by the server to each of the exported
 mount points. Each 9P export is seen by the client as a virtio device with an
 associated "mount_tag" property. Available mount tags can be
 seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount_tag files.
 
+USBG Usage
+==========
+
+To mount a 9p FS on a USB Host accessible via the gadget at runtime::
+
+	mount -t 9p -o trans=usbg,aname=/path/to/fs <device> /mnt/9
+
+To mount a 9p FS on a USB Host accessible via the gadget as root filesystem::
+
+	root=<device> rootfstype=9p rootflags=trans=usbg,cache=loose,uname=root,access=0,dfltuid=0,dfltgid=0,aname=/path/to/rootfs
+
+where <device> is the tag associated by the usb gadget transport.
+It is defined by the configfs instance name.
+
 Options
 =======
 
@@ -68,6 +82,7 @@ Options
 			virtio	  connect to the next virtio channel available
 				  (from QEMU with trans_virtio module)
 			rdma	  connect to a specified RDMA channel
+			usbg	  connect to a specified usb gadget channel
 			========  ============================================
 
   uname=name	user name to attempt mount as on the remote server.  The
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index 00ebce9e5a657..c3d357eb8bb37 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -39,6 +39,12 @@ config NET_9P_XEN
 	  This builds support for a transport for 9pfs between
 	  two Xen domains.
 
+config NET_9P_USBG
+	bool "9P USB Gadget Transport"
+	depends on USB_GADGET
+	help
+	  This builds support for a transport for 9pfs over
+	  usb gadget.
 
 config NET_9P_RDMA
 	depends on INET && INFINIBAND && INFINIBAND_ADDR_TRANS
diff --git a/net/9p/Makefile b/net/9p/Makefile
index 1df9b344c30bd..22794a451c3f7 100644
--- a/net/9p/Makefile
+++ b/net/9p/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_NET_9P_FD) += 9pnet_fd.o
 obj-$(CONFIG_NET_9P_XEN) += 9pnet_xen.o
 obj-$(CONFIG_NET_9P_VIRTIO) += 9pnet_virtio.o
 obj-$(CONFIG_NET_9P_RDMA) += 9pnet_rdma.o
+obj-$(CONFIG_NET_9P_USBG) += 9pnet_usbg.o
 
 9pnet-objs := \
 	mod.o \
@@ -23,3 +24,6 @@ obj-$(CONFIG_NET_9P_RDMA) += 9pnet_rdma.o
 
 9pnet_rdma-objs := \
 	trans_rdma.o \
+
+9pnet_usbg-objs := \
+	trans_usbg.o \
diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
new file mode 100644
index 0000000000000..bc440033cbe68
--- /dev/null
+++ b/net/9p/trans_usbg.c
@@ -0,0 +1,983 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * trans_usbg.c - USB peripheral usb9pfs configuration driver and transport.
+ *
+ * Copyright (C) 2024 Michael Grzeschik <m.grzeschik@pengutronix.de>
+ */
+
+/* Gadget usb9pfs only needs two bulk endpoints, and will use the usb9pfs
+ * transport to mount host exported filesystem via usb gadget.
+ */
+
+/*     +--------------------------+    |    +--------------------------+
+ *     |  9PFS mounting client    |    |    |  9PFS exporting server   |
+ *  SW |                          |    |    |                          |
+ *     |   (this:trans_usbg)      |    |    |(e.g. diod or nfs-ganesha)|
+ *     +-------------^------------+    |    +-------------^------------+
+ *                   |                 |                  |
+ * ------------------|------------------------------------|-------------
+ *                   |                 |                  |
+ *     +-------------v------------+    |    +-------------v------------+
+ *     |                          |    |    |                          |
+ *  HW |   USB Device Controller  <--------->   USB Host Controller    |
+ *     |                          |    |    |                          |
+ *     +--------------------------+    |    +--------------------------+
+ */
+
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/usb/composite.h>
+#include <linux/usb/u_f.h>
+
+#include <net/9p/9p.h>
+#include <net/9p/client.h>
+#include <net/9p/transport.h>
+
+#define DEFAULT_BUFLEN        16384
+
+struct f_usb9pfs {
+	struct p9_client *client;
+
+	struct p9_req_t *p9_tx_req;
+
+	struct list_head tx_req_list;
+
+	/* 9p request lock for en/dequeue */
+	spinlock_t lock;
+	/* usb request lock for en/dequeue */
+	spinlock_t req_lock;
+
+	struct usb_request *in_req;
+	struct usb_request *out_req;
+
+	struct usb_ep *in_ep;
+	struct usb_ep *out_ep;
+
+	unsigned int buflen;
+
+	struct usb_function function;
+};
+
+static inline struct f_usb9pfs *func_to_usb9pfs(struct usb_function *f)
+{
+	return container_of(f, struct f_usb9pfs, function);
+}
+
+struct f_usb9pfs_opts {
+	struct usb_function_instance func_inst;
+	unsigned int buflen;
+
+	struct f_usb9pfs_dev *dev;
+
+	/* Read/write access to configfs attributes is handled by configfs.
+	 *
+	 * This is to protect the data from concurrent access by read/write
+	 * and create symlink/remove symlink.
+	 */
+	struct mutex lock;
+	int refcnt;
+};
+
+struct f_usb9pfs_dev {
+	struct f_usb9pfs *usb9pfs;
+	struct f_usb9pfs_opts *opts;
+	char tag[41];
+	bool inuse;
+
+	struct list_head usb9pfs_instance;
+};
+
+static DEFINE_MUTEX(usb9pfs_lock);
+static struct list_head usbg_instance_list;
+
+static int usb9pfs_queue_tx(struct f_usb9pfs *usb9pfs, struct usb_request *req,
+			    gfp_t gfp_flags)
+{
+	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
+	int ret = -ENOMEM;
+
+	if (!(usb9pfs->p9_tx_req->tc.size % usb9pfs->in_ep->maxpacket))
+		req->zero = 1;
+
+	req->buf = usb9pfs->p9_tx_req->tc.sdata;
+	req->length = usb9pfs->p9_tx_req->tc.size;
+
+	dev_dbg(&cdev->gadget->dev, "%s usb9pfs send --> %d/%d, zero: %d\n",
+		usb9pfs->in_ep->name, req->actual, req->length, req->zero);
+
+	ret = usb_ep_queue(usb9pfs->in_ep, req, gfp_flags);
+
+	dev_dbg(&cdev->gadget->dev, "tx submit --> %d\n", ret);
+
+	return ret;
+}
+
+static int usb9pfs_queue_rx(struct f_usb9pfs *usb9pfs, struct usb_request *req,
+			    gfp_t gfp_flags)
+{
+	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
+	int ret = -ENOMEM;
+
+	ret = usb_ep_queue(usb9pfs->out_ep, req, gfp_flags);
+
+	dev_dbg(&cdev->gadget->dev, "rx submit --> %d\n", ret);
+
+	return ret;
+}
+
+/* This needs to be called with usb9pfs->req_lock held */
+static int usb9pfs_transmit(struct f_usb9pfs *usb9pfs)
+{
+	struct p9_req_t *p9_req = NULL;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&usb9pfs->lock, flags);
+
+	if (usb9pfs->p9_tx_req) {
+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
+		return -EBUSY;
+	}
+
+	p9_req = list_first_entry_or_null(&usb9pfs->tx_req_list,
+					  struct p9_req_t, req_list);
+	if (!p9_req) {
+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
+		return -ENOENT;
+	}
+
+	list_del(&p9_req->req_list);
+
+	usb9pfs->p9_tx_req = p9_req;
+
+	p9_req_get(usb9pfs->p9_tx_req);
+
+	ret = usb9pfs_queue_tx(usb9pfs, usb9pfs->in_req, GFP_ATOMIC);
+
+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
+
+	return ret;
+}
+
+static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct f_usb9pfs *usb9pfs = ep->driver_data;
+	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
+	int ret = 0;
+
+	if (req->status) {
+		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
+			ep->name, req->status, req->actual, req->length);
+		goto free_req;
+	}
+
+	/* reset zero packages */
+	req->zero = 0;
+
+	dev_dbg(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
+		ep->name, req->status, req->actual, req->length);
+
+	spin_lock(&usb9pfs->req_lock);
+
+	WRITE_ONCE(usb9pfs->p9_tx_req->status, REQ_STATUS_SENT);
+
+	p9_req_put(usb9pfs->client, usb9pfs->p9_tx_req);
+
+	ret = usb9pfs_queue_rx(usb9pfs, usb9pfs->out_req, GFP_ATOMIC);
+	if (ret) {
+		spin_unlock(&usb9pfs->req_lock);
+		goto free_req;
+	}
+
+	spin_unlock(&usb9pfs->req_lock);
+
+	return;
+
+free_req:
+	usb_ep_free_request(ep == usb9pfs->in_ep ?
+			    usb9pfs->out_ep : usb9pfs->in_ep,
+			    req->context);
+	free_ep_req(ep, req);
+}
+
+static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
+{
+	struct p9_req_t *p9_rx_req;
+	struct p9_fcall	rc;
+	int ret;
+
+	/* start by reading header */
+	rc.sdata = buf;
+	rc.offset = 0;
+	rc.capacity = P9_HDRSZ;
+	rc.size = P9_HDRSZ;
+
+	p9_debug(P9_DEBUG_TRANS, "mux %p got %zu bytes\n", usb9pfs,
+		 rc.capacity - rc.offset);
+
+	ret = p9_parse_header(&rc, &rc.size, NULL, NULL, 0);
+	if (ret) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "error parsing header: %d\n", ret);
+		return NULL;
+	}
+
+	p9_debug(P9_DEBUG_TRANS,
+		 "mux %p pkt: size: %d bytes tag: %d\n",
+		 usb9pfs, rc.size, rc.tag);
+
+	p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
+	if (!p9_rx_req || p9_rx_req->status != REQ_STATUS_SENT) {
+		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
+		return NULL;
+	}
+
+	if (rc.size > p9_rx_req->rc.capacity) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "requested packet size too big: %d for tag %d with capacity %zd\n",
+			 rc.size, rc.tag, p9_rx_req->rc.capacity);
+		p9_req_put(usb9pfs->client, p9_rx_req);
+		return NULL;
+	}
+
+	if (!p9_rx_req->rc.sdata) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "No recv fcall for tag %d (req %p), disconnecting!\n",
+			 rc.tag, p9_rx_req);
+		p9_req_put(usb9pfs->client, p9_rx_req);
+		return NULL;
+	}
+
+	return p9_rx_req;
+}
+
+static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct f_usb9pfs *usb9pfs = ep->driver_data;
+	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
+	struct p9_req_t *p9_rx_req;
+	unsigned long flags;
+	int ret = 0;
+
+	if (req->status) {
+		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
+			ep->name, req->status, req->actual, req->length);
+		goto free_req;
+	}
+
+	spin_lock_irqsave(&usb9pfs->req_lock, flags);
+
+	p9_rx_req = usb9pfs_rx_header(usb9pfs, req->buf);
+	if (!p9_rx_req) {
+		spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
+		goto free_req;
+	}
+
+	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
+
+	p9_rx_req->rc.size = req->actual;
+
+	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
+	p9_req_put(usb9pfs->client, p9_rx_req);
+
+	usb9pfs->p9_tx_req = NULL;
+
+	ret = usb9pfs_transmit(usb9pfs);
+	if (ret) {
+		spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
+		return;
+	}
+
+	spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
+
+	return;
+
+free_req:
+	usb_ep_free_request(ep == usb9pfs->in_ep ?
+			    usb9pfs->out_ep : usb9pfs->in_ep,
+			    req->context);
+	free_ep_req(ep, req);
+
+	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_ERROR);
+}
+
+static void disable_ep(struct usb_composite_dev *cdev, struct usb_ep *ep)
+{
+	int value;
+
+	value = usb_ep_disable(ep);
+	if (value < 0)
+		dev_info(&cdev->gadget->dev,
+			 "disable %s --> %d\n", ep->name, value);
+}
+
+static void disable_usb9pfs(struct f_usb9pfs *usb9pfs)
+{
+	struct usb_composite_dev *cdev =
+		usb9pfs->function.config->cdev;
+
+	disable_ep(cdev, usb9pfs->in_ep);
+	disable_ep(cdev, usb9pfs->out_ep);
+	dev_dbg(&cdev->gadget->dev, "%s disabled\n",
+		usb9pfs->function.name);
+}
+
+static int alloc_requests(struct usb_composite_dev *cdev,
+			  struct f_usb9pfs *usb9pfs)
+{
+	int ret = 0;
+
+	usb9pfs->in_req = usb_ep_alloc_request(usb9pfs->in_ep, GFP_ATOMIC);
+	if (!usb9pfs->in_req) {
+		ret = -ENOENT;
+		goto fail;
+	}
+
+	usb9pfs->out_req = alloc_ep_req(usb9pfs->out_ep, usb9pfs->buflen);
+	if (!usb9pfs->out_req) {
+		ret = -ENOENT;
+		goto fail_in;
+	}
+
+	usb9pfs->in_req->complete = usb9pfs_tx_complete;
+	usb9pfs->out_req->complete = usb9pfs_rx_complete;
+
+	/* length will be set in complete routine */
+	usb9pfs->in_req->context = usb9pfs;
+	usb9pfs->out_req->context = usb9pfs;
+
+	return ret;
+
+fail_in:
+	usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
+fail:
+	return ret;
+}
+
+static int enable_endpoint(struct usb_composite_dev *cdev,
+			   struct f_usb9pfs *usb9pfs, struct usb_ep *ep)
+{
+	int ret;
+
+	ret = config_ep_by_speed(cdev->gadget, &usb9pfs->function, ep);
+	if (ret)
+		return ret;
+
+	ret = usb_ep_enable(ep);
+	if (ret < 0)
+		return ret;
+
+	ep->driver_data = usb9pfs;
+
+	return ret;
+}
+
+static int
+enable_usb9pfs(struct usb_composite_dev *cdev, struct f_usb9pfs *usb9pfs)
+{
+	int result = 0;
+
+	result = enable_endpoint(cdev, usb9pfs, usb9pfs->in_ep);
+	if (result)
+		goto out;
+
+	result = enable_endpoint(cdev, usb9pfs, usb9pfs->out_ep);
+	if (result)
+		goto disable_in;
+
+	result = alloc_requests(cdev, usb9pfs);
+	if (result)
+		goto disable_out;
+
+	dev_dbg(&cdev->gadget->dev, "%s enabled\n", usb9pfs->function.name);
+	return 0;
+
+disable_out:
+	usb_ep_disable(usb9pfs->out_ep);
+disable_in:
+	usb_ep_disable(usb9pfs->in_ep);
+out:
+	return result;
+}
+
+static int p9_usbg_create(struct p9_client *client, const char *devname, char *args)
+{
+	struct usb_composite_dev *cdev;
+	struct f_usb9pfs_dev *dev;
+	struct f_usb9pfs_dev *tmp;
+	struct f_usb9pfs *usb9pfs;
+	struct usb_function *f;
+	int ret = -ENOENT;
+	int found = 0;
+
+	if (!devname)
+		return -EINVAL;
+
+	mutex_lock(&usb9pfs_lock);
+	list_for_each_entry_safe(dev, tmp, &usbg_instance_list, usb9pfs_instance) {
+		if (!strncmp(devname, dev->tag, strlen(devname))) {
+			if (!dev->inuse) {
+				dev->inuse = true;
+				found = 1;
+				break;
+			}
+			ret = -EBUSY;
+			break;
+		}
+	}
+	mutex_unlock(&usb9pfs_lock);
+
+	if (!found) {
+		pr_err("no channels available for device %s\n", devname);
+		return ret;
+	}
+
+	usb9pfs = dev->usb9pfs;
+	if (!usb9pfs)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&usb9pfs->tx_req_list);
+
+	spin_lock_init(&usb9pfs->lock);
+	spin_lock_init(&usb9pfs->req_lock);
+
+	f = &usb9pfs->function;
+	cdev = f->config->cdev;
+
+	client->trans = (void *)usb9pfs;
+	client->status = Connected;
+	usb9pfs->client = client;
+
+	client->trans_mod->maxsize = usb9pfs->buflen;
+
+	return enable_usb9pfs(cdev, usb9pfs);
+}
+
+static void p9_usbg_close(struct p9_client *client)
+{
+	struct f_usb9pfs *usb9pfs;
+	struct f_usb9pfs_dev *dev;
+	struct p9_req_t *req;
+	struct f_usb9pfs_opts *opts;
+
+	if (!client)
+		return;
+
+	usb9pfs = client->trans;
+	if (!usb9pfs)
+		return;
+
+	client->status = Disconnected;
+
+	spin_lock(&usb9pfs->req_lock);
+
+	req = usb9pfs->p9_tx_req;
+	if (req) {
+		if (!req->t_err)
+			req->t_err = -ECONNRESET;
+		p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
+	}
+
+	spin_unlock(&usb9pfs->req_lock);
+
+	disable_usb9pfs(usb9pfs);
+
+	opts = container_of(usb9pfs->function.fi,
+			    struct f_usb9pfs_opts, func_inst);
+
+	dev = opts->dev;
+
+	mutex_lock(&usb9pfs_lock);
+	dev->inuse = false;
+	mutex_unlock(&usb9pfs_lock);
+}
+
+static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)
+{
+	struct f_usb9pfs *usb9pfs = client->trans;
+	unsigned long flags;
+
+	if (client->status != Connected)
+		return -EBUSY;
+
+	spin_lock_irqsave(&usb9pfs->lock, flags);
+	list_add_tail(&p9_req->req_list, &usb9pfs->tx_req_list);
+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
+
+	spin_lock_irqsave(&usb9pfs->req_lock, flags);
+	usb9pfs_transmit(usb9pfs);
+	spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
+
+	return 0;
+}
+
+static int p9_usbg_cancel(struct p9_client *client, struct p9_req_t *req)
+{
+	struct f_usb9pfs *usb9pfs = client->trans;
+	int ret = 1;
+
+	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
+
+	spin_lock(&usb9pfs->req_lock);
+
+	if (req->status == REQ_STATUS_UNSENT) {
+		list_del(&req->req_list);
+		WRITE_ONCE(req->status, REQ_STATUS_FLSHD);
+		p9_req_put(client, req);
+		ret = 0;
+	}
+	spin_unlock(&usb9pfs->req_lock);
+
+	return ret;
+}
+
+static struct p9_trans_module p9_usbg_trans = {
+	.name = "usbg",
+	.create = p9_usbg_create,
+	.close = p9_usbg_close,
+	.request = p9_usbg_request,
+	.cancel = p9_usbg_cancel,
+	.owner = THIS_MODULE,
+};
+
+/*-------------------------------------------------------------------------*/
+
+#define USB_PROTOCOL_9PFS	0x09
+
+static struct usb_interface_descriptor usb9pfs_intf = {
+	.bLength =		sizeof(usb9pfs_intf),
+	.bDescriptorType =	USB_DT_INTERFACE,
+
+	.bNumEndpoints =	2,
+	.bInterfaceClass =	USB_CLASS_VENDOR_SPEC,
+	.bInterfaceSubClass =	USB_SUBCLASS_VENDOR_SPEC,
+	.bInterfaceProtocol =   USB_PROTOCOL_9PFS,
+
+	/* .iInterface = DYNAMIC */
+};
+
+/* full speed support: */
+
+static struct usb_endpoint_descriptor fs_usb9pfs_source_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	.bEndpointAddress =	USB_DIR_IN,
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+};
+
+static struct usb_endpoint_descriptor fs_usb9pfs_sink_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	.bEndpointAddress =	USB_DIR_OUT,
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+};
+
+static struct usb_descriptor_header *fs_usb9pfs_descs[] = {
+	(struct usb_descriptor_header *)&usb9pfs_intf,
+	(struct usb_descriptor_header *)&fs_usb9pfs_sink_desc,
+	(struct usb_descriptor_header *)&fs_usb9pfs_source_desc,
+	NULL,
+};
+
+/* high speed support: */
+
+static struct usb_endpoint_descriptor hs_usb9pfs_source_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =	cpu_to_le16(512),
+};
+
+static struct usb_endpoint_descriptor hs_usb9pfs_sink_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =	cpu_to_le16(512),
+};
+
+static struct usb_descriptor_header *hs_usb9pfs_descs[] = {
+	(struct usb_descriptor_header *)&usb9pfs_intf,
+	(struct usb_descriptor_header *)&hs_usb9pfs_source_desc,
+	(struct usb_descriptor_header *)&hs_usb9pfs_sink_desc,
+	NULL,
+};
+
+/* super speed support: */
+
+static struct usb_endpoint_descriptor ss_usb9pfs_source_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =	cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor ss_usb9pfs_source_comp_desc = {
+	.bLength =		USB_DT_SS_EP_COMP_SIZE,
+	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
+	.bMaxBurst =		0,
+	.bmAttributes =		0,
+	.wBytesPerInterval =	0,
+};
+
+static struct usb_endpoint_descriptor ss_usb9pfs_sink_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =	cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor ss_usb9pfs_sink_comp_desc = {
+	.bLength =		USB_DT_SS_EP_COMP_SIZE,
+	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
+	.bMaxBurst =		0,
+	.bmAttributes =		0,
+	.wBytesPerInterval =	0,
+};
+
+static struct usb_descriptor_header *ss_usb9pfs_descs[] = {
+	(struct usb_descriptor_header *)&usb9pfs_intf,
+	(struct usb_descriptor_header *)&ss_usb9pfs_source_desc,
+	(struct usb_descriptor_header *)&ss_usb9pfs_source_comp_desc,
+	(struct usb_descriptor_header *)&ss_usb9pfs_sink_desc,
+	(struct usb_descriptor_header *)&ss_usb9pfs_sink_comp_desc,
+	NULL,
+};
+
+/* function-specific strings: */
+static struct usb_string strings_usb9pfs[] = {
+	[0].s = "usb9pfs input to output",
+	{  }			/* end of list */
+};
+
+static struct usb_gadget_strings stringtab_usb9pfs = {
+	.language	= 0x0409,	/* en-us */
+	.strings	= strings_usb9pfs,
+};
+
+static struct usb_gadget_strings *usb9pfs_strings[] = {
+	&stringtab_usb9pfs,
+	NULL,
+};
+
+/*-------------------------------------------------------------------------*/
+
+static int usb9pfs_func_bind(struct usb_configuration *c,
+			     struct usb_function *f)
+{
+	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
+	struct f_usb9pfs_opts *opts;
+	struct usb_composite_dev *cdev = c->cdev;
+	int ret;
+	int id;
+
+	/* allocate interface ID(s) */
+	id = usb_interface_id(c, f);
+	if (id < 0)
+		return id;
+	usb9pfs_intf.bInterfaceNumber = id;
+
+	id = usb_string_id(cdev);
+	if (id < 0)
+		return id;
+	strings_usb9pfs[0].id = id;
+	usb9pfs_intf.iInterface = id;
+
+	/* allocate endpoints */
+	usb9pfs->in_ep = usb_ep_autoconfig(cdev->gadget,
+					   &fs_usb9pfs_source_desc);
+	if (!usb9pfs->in_ep)
+		goto autoconf_fail;
+
+	usb9pfs->out_ep = usb_ep_autoconfig(cdev->gadget,
+					    &fs_usb9pfs_sink_desc);
+	if (!usb9pfs->out_ep)
+		goto autoconf_fail;
+
+	/* support high speed hardware */
+	hs_usb9pfs_source_desc.bEndpointAddress =
+		fs_usb9pfs_source_desc.bEndpointAddress;
+	hs_usb9pfs_sink_desc.bEndpointAddress =
+		fs_usb9pfs_sink_desc.bEndpointAddress;
+
+	/* support super speed hardware */
+	ss_usb9pfs_source_desc.bEndpointAddress =
+		fs_usb9pfs_source_desc.bEndpointAddress;
+	ss_usb9pfs_sink_desc.bEndpointAddress =
+		fs_usb9pfs_sink_desc.bEndpointAddress;
+
+	ret = usb_assign_descriptors(f, fs_usb9pfs_descs, hs_usb9pfs_descs,
+				     ss_usb9pfs_descs, ss_usb9pfs_descs);
+	if (ret)
+		return ret;
+
+	opts = container_of(f->fi, struct f_usb9pfs_opts, func_inst);
+	opts->dev->usb9pfs = usb9pfs;
+
+	dev_dbg(&cdev->gadget->dev, "%s speed %s: IN/%s, OUT/%s\n",
+		(gadget_is_superspeed(c->cdev->gadget) ? "super" :
+		(gadget_is_dualspeed(c->cdev->gadget) ? "dual" : "full")),
+			f->name, usb9pfs->in_ep->name, usb9pfs->out_ep->name);
+
+	return 0;
+
+autoconf_fail:
+	ERROR(cdev, "%s: can't autoconfigure on %s\n",
+	      f->name, cdev->gadget->name);
+	return -ENODEV;
+}
+
+static void usb9pfs_free_func(struct usb_function *f)
+{
+	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
+	struct f_usb9pfs_opts *opts;
+
+	kfree(usb9pfs);
+
+	opts = container_of(f->fi, struct f_usb9pfs_opts, func_inst);
+
+	mutex_lock(&opts->lock);
+	opts->refcnt--;
+	mutex_unlock(&opts->lock);
+
+	usb_free_all_descriptors(f);
+}
+
+static int usb9pfs_set_alt(struct usb_function *f,
+			   unsigned int intf, unsigned int alt)
+{
+	return 0;
+}
+
+static void usb9pfs_disable(struct usb_function *f)
+{
+	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
+	struct p9_req_t *req;
+
+	spin_lock(&usb9pfs->req_lock);
+
+	req = usb9pfs->p9_tx_req;
+
+	if (!req->t_err)
+		req->t_err = -ECONNRESET;
+	p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
+
+	spin_unlock(&usb9pfs->req_lock);
+}
+
+static struct usb_function *usb9pfs_alloc(struct usb_function_instance *fi)
+{
+	struct f_usb9pfs_opts *usb9pfs_opts;
+	struct f_usb9pfs *usb9pfs;
+
+	usb9pfs = kzalloc(sizeof(*usb9pfs), GFP_KERNEL);
+	if (!usb9pfs)
+		return ERR_PTR(-ENOMEM);
+
+	usb9pfs_opts = container_of(fi, struct f_usb9pfs_opts, func_inst);
+
+	mutex_lock(&usb9pfs_opts->lock);
+	usb9pfs_opts->refcnt++;
+	mutex_unlock(&usb9pfs_opts->lock);
+
+	usb9pfs->buflen = usb9pfs_opts->buflen;
+
+	usb9pfs->function.name = "usb9pfs";
+	usb9pfs->function.bind = usb9pfs_func_bind;
+	usb9pfs->function.set_alt = usb9pfs_set_alt;
+	usb9pfs->function.disable = usb9pfs_disable;
+	usb9pfs->function.strings = usb9pfs_strings;
+
+	usb9pfs->function.free_func = usb9pfs_free_func;
+
+	return &usb9pfs->function;
+}
+
+static inline struct f_usb9pfs_opts *to_f_usb9pfs_opts(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct f_usb9pfs_opts,
+			    func_inst.group);
+}
+
+static inline struct f_usb9pfs_opts *fi_to_f_usb9pfs_opts(struct usb_function_instance *fi)
+{
+	return container_of(fi, struct f_usb9pfs_opts, func_inst);
+}
+
+static void usb9pfs_attr_release(struct config_item *item)
+{
+	struct f_usb9pfs_opts *usb9pfs_opts = to_f_usb9pfs_opts(item);
+
+	usb_put_function_instance(&usb9pfs_opts->func_inst);
+}
+
+static struct configfs_item_operations usb9pfs_item_ops = {
+	.release		= usb9pfs_attr_release,
+};
+
+static ssize_t f_usb9pfs_opts_buflen_show(struct config_item *item, char *page)
+{
+	struct f_usb9pfs_opts *opts = to_f_usb9pfs_opts(item);
+	int result;
+
+	mutex_lock(&opts->lock);
+	result = sprintf(page, "%d\n", opts->buflen);
+	mutex_unlock(&opts->lock);
+
+	return result;
+}
+
+static ssize_t f_usb9pfs_opts_buflen_store(struct config_item *item,
+					   const char *page, size_t len)
+{
+	struct f_usb9pfs_opts *opts = to_f_usb9pfs_opts(item);
+	int ret;
+	u32 num;
+
+	mutex_lock(&opts->lock);
+	if (opts->refcnt) {
+		ret = -EBUSY;
+		goto end;
+	}
+
+	ret = kstrtou32(page, 0, &num);
+	if (ret)
+		goto end;
+
+	opts->buflen = num;
+	ret = len;
+end:
+	mutex_unlock(&opts->lock);
+	return ret;
+}
+
+CONFIGFS_ATTR(f_usb9pfs_opts_, buflen);
+
+static struct configfs_attribute *usb9pfs_attrs[] = {
+	&f_usb9pfs_opts_attr_buflen,
+	NULL,
+};
+
+static const struct config_item_type usb9pfs_func_type = {
+	.ct_item_ops	= &usb9pfs_item_ops,
+	.ct_attrs	= usb9pfs_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct f_usb9pfs_dev *_usb9pfs_do_find_dev(const char *tag)
+{
+	struct f_usb9pfs_dev *usb9pfs_dev;
+	struct f_usb9pfs_dev *tmp;
+
+	if (!tag)
+		return NULL;
+
+	list_for_each_entry_safe(usb9pfs_dev, tmp, &usbg_instance_list, usb9pfs_instance) {
+		if (strcmp(usb9pfs_dev->tag, tag) == 0)
+			return usb9pfs_dev;
+	}
+
+	return NULL;
+}
+
+static int usb9pfs_tag_instance(struct f_usb9pfs_dev *dev, const char *tag)
+{
+	struct f_usb9pfs_dev *existing;
+	int ret = 0;
+
+	mutex_lock(&usb9pfs_lock);
+	existing = _usb9pfs_do_find_dev(tag);
+	if (!existing)
+		strscpy(dev->tag, tag, ARRAY_SIZE(dev->tag));
+	else if (existing != dev)
+		ret = -EBUSY;
+	mutex_unlock(&usb9pfs_lock);
+
+	return ret;
+}
+
+static int usb9pfs_set_inst_tag(struct usb_function_instance *fi, const char *tag)
+{
+	if (strlen(tag) >= sizeof_field(struct f_usb9pfs_dev, tag))
+		return -ENAMETOOLONG;
+	return usb9pfs_tag_instance(fi_to_f_usb9pfs_opts(fi)->dev, tag);
+}
+
+static void usb9pfs_free_instance(struct usb_function_instance *fi)
+{
+	struct f_usb9pfs_opts *usb9pfs_opts;
+
+	usb9pfs_opts = container_of(fi, struct f_usb9pfs_opts, func_inst);
+	kfree(usb9pfs_opts);
+}
+
+static struct usb_function_instance *usb9pfs_alloc_instance(void)
+{
+	struct f_usb9pfs_opts *usb9pfs_opts;
+	struct f_usb9pfs_dev *dev;
+
+	usb9pfs_opts = kzalloc(sizeof(*usb9pfs_opts), GFP_KERNEL);
+	if (!usb9pfs_opts)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&usb9pfs_opts->lock);
+
+	usb9pfs_opts->func_inst.set_inst_name = usb9pfs_set_inst_tag;
+	usb9pfs_opts->func_inst.free_func_inst = usb9pfs_free_instance;
+
+	usb9pfs_opts->buflen = DEFAULT_BUFLEN;
+
+	mutex_lock(&usb9pfs_lock);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (IS_ERR(dev)) {
+		mutex_unlock(&usb9pfs_lock);
+		kfree(usb9pfs_opts);
+		return ERR_CAST(dev);
+	}
+	list_add_tail(&dev->usb9pfs_instance, &usbg_instance_list);
+	mutex_unlock(&usb9pfs_lock);
+
+	usb9pfs_opts->dev = dev;
+	dev->opts = usb9pfs_opts;
+
+	config_group_init_type_name(&usb9pfs_opts->func_inst.group, "",
+				    &usb9pfs_func_type);
+
+	return &usb9pfs_opts->func_inst;
+}
+DECLARE_USB_FUNCTION(usb9pfs, usb9pfs_alloc_instance, usb9pfs_alloc);
+
+static int __init usb9pfs_modinit(void)
+{
+	int ret;
+
+	INIT_LIST_HEAD(&usbg_instance_list);
+
+	ret = usb_function_register(&usb9pfsusb_func);
+	if (!ret)
+		v9fs_register_trans(&p9_usbg_trans);
+
+	return ret;
+}
+
+static void __exit usb9pfs_modexit(void)
+{
+	usb_function_unregister(&usb9pfsusb_func);
+	v9fs_unregister_trans(&p9_usbg_trans);
+}
+
+module_init(usb9pfs_modinit);
+module_exit(usb9pfs_modexit);
+
+MODULE_ALIAS_9P("usbg");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("USB gadget 9pfs transport");
+MODULE_AUTHOR("Michael Grzeschik");

-- 
2.39.2


