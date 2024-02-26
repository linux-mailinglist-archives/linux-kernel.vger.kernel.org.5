Return-Path: <linux-kernel+bounces-81547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A156186775D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187191F245AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E6F12B151;
	Mon, 26 Feb 2024 13:56:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29F129A9C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955784; cv=none; b=SDwSgDW3lUw0aPF+PUJhMZ9OOtXwbNEFcDkpi4eF9jm4rWb5CO5fgGXnBRyo2gTb5fA3rziRpzyrL+B+TazjklriYW6LubZfhtqEeMF8SKYOKRzmN9sm3T0AI4a8pLc8yhxVSQe87c4vmee/wst95E0AztnZX5Of662HMqgjREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955784; c=relaxed/simple;
	bh=kjr905LHmc827KieiAGN8KQloY9cnLGOiPgC7TVjXds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0Ke/Z0BkfRWXIrvAORUCcUEsrz9RRxqjUB16ObmIjcNBNx6UxZkusgCmKUgCCt/TVEsItCYo/4Zi3wkOW/JZbIUmP0AMtvdbdtrd3TOq9CLY+RrT/NQjIEzZ+i7D4KDfNvVDBlzHgZiy4GjDbkrxjYFVaxNgsfKi3p641BPWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSh-00047E-FK; Mon, 26 Feb 2024 14:56:07 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSg-0030Qf-C3; Mon, 26 Feb 2024 14:56:06 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSg-009FzF-10;
	Mon, 26 Feb 2024 14:56:06 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Mon, 26 Feb 2024 14:56:05 +0100
Subject: [PATCH v3 2/3] net/9p/usbg: Add new usb gadget function transport
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v3-2-c62a36eccda1@pengutronix.de>
References: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=27169;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=kjr905LHmc827KieiAGN8KQloY9cnLGOiPgC7TVjXds=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl3Jh1ITAtfoBMYBFz3YX65rC3dmRxDBXrqLFe0
 2gIYZ08qBSJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZdyYdQAKCRC/aVhE+XH0
 q+FKEACyASNn/msGkWdTEnv3L4el2Qf00EjTDex4btidgBvRB1npuPHbT64Ej3Z7kFWEDKz+S4s
 tVdJzXrvUWO4xnh03nX9Gp+t2iD9UMDrGNP5Jr7r/WCzt3vGKHps5Ii77/L+C/byzhteZ+BvJEr
 X+vvahK8UnVWuDWzK0LFBcB68Zvh1KNhg0818/te7dYpHsjgzxfbFH1GyLrxEmI+UGYv0MdYQz2
 fhqJv2bFS6djb3qjoLiz3IotVoTsXrwgJnH9C6vL5KzL7fd3Vh6jdSS0Po30ROxzxlW46gqUG7G
 9syWo+cIBrzUtVrHWv5svgtDsXw1CwsdoM0sToovjW9bjcx3ClvEth2Yy29qpXEckiazg4b+50h
 yQQ26TpD/lrkpWuehE813ESzJ6wLR8QTHa0Vr2EYxvYeb0qH1FZTTuCWHQtYSWnwViciAR92eX6
 7p0YzTRPHUQBxitJ8oDJi7Z8TNwnLJmMZa+QdjC7XwOV+1iFKmBtAQsVeAR2XTDVjSfi3kdu+Ky
 mAqUJw21xNWKaE4fWPhUVyxPMwmP9bQlBu/cMyT3cjsqEk0cktCHR9uFsPovf6RG/irrFLs2uWU
 mLALTdIkwmwy4Zs2Jsi1N15aHVH0C5fr6Gc8tCljrTyioD/UaZKK8WZHUYrWh7o45xyTOBkW6Y/
 tcfY6qRF6PGlx+g==
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
 Documentation/filesystems/9p.rst |  15 +
 net/9p/Kconfig                   |   6 +
 net/9p/Makefile                  |   4 +
 net/9p/trans_usbg.c              | 871 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 896 insertions(+)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 1e0e0bb6fdf91..64439068a8fc5 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -53,6 +53,20 @@ mount points. Each 9P export is seen by the client as a virtio device with an
 associated "mount_tag" property. Available mount tags can be
 seen by reading /sys/bus/virtio/drivers/9pnet_virtio/virtio<n>/mount_tag files.
 
+USBG Usage
+==========
+
+To mount a 9p FS on a USB Host accessible via the gadget at runtime::
+
+	mount -t 9p -o trans=usbg,aname=/path/to/fs <mount_tag> /mnt/9
+
+To mount a 9p FS on a USB Host accessible via the gadget as root filesystem::
+
+	root=<mount_tag> rootfstype=9p rootflags=trans=usbg,cache=loose,uname=root,access=0,dfltuid=0,dfltgid=0,aname=/path/to/rootfs
+
+where mount_tag is the tag associated by the usb gadget transport. The
+pattern is usb9pfs0, usb9pfs1, ...
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
index 0000000000000..93d9606a806d8
--- /dev/null
+++ b/net/9p/trans_usbg.c
@@ -0,0 +1,871 @@
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
+	bool inuse;
+	char *tag;
+
+	int index;
+
+	struct usb_function function;
+
+	struct list_head function_list;
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
+	/* Read/write access to configfs attributes is handled by configfs.
+	 *
+	 * This is to protect the data from concurrent access by read/write
+	 * and create symlink/remove symlink.
+	 */
+	struct mutex lock;
+	int refcnt;
+};
+
+static DEFINE_IDA(usb9pfs_ida);
+static DEFINE_MUTEX(usb9pfs_ida_lock); /* protects access do usb9pfs_ida */
+
+static DEFINE_MUTEX(usb9pfs_lock);
+static struct list_head usbg_function_list;
+
+static int usb9pfs_tx_fill(struct f_usb9pfs *usb9pfs, struct usb_request *req,
+			   gfp_t gfp_flags)
+{
+	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
+	int retval = -ENOMEM;
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
+	retval = usb_ep_queue(usb9pfs->in_ep, req, gfp_flags);
+
+	dev_dbg(&cdev->gadget->dev, "tx submit --> %d\n", retval);
+
+	return retval;
+}
+
+static int usb9pfs_rx_fill(struct f_usb9pfs *usb9pfs, struct usb_request *req,
+			   gfp_t gfp_flags)
+{
+	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
+	int retval = -ENOMEM;
+
+	retval = usb_ep_queue(usb9pfs->out_ep, req, gfp_flags);
+
+	dev_dbg(&cdev->gadget->dev, "rx submit --> %d\n", retval);
+
+	return retval;
+}
+
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
+	p9_req = list_first_entry_or_null(&usb9pfs->tx_req_list, struct p9_req_t, req_list);
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
+	usb9pfs_tx_fill(usb9pfs, usb9pfs->in_req, GFP_ATOMIC);
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
+
+	/* reset zero packages */
+	req->zero = 0;
+
+	dev_dbg(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
+		ep->name, req->status, req->actual, req->length);
+
+	switch (req->status) {
+	case 0:				/* normal completion? */
+		spin_lock(&usb9pfs->req_lock);
+
+		WRITE_ONCE(usb9pfs->p9_tx_req->status, REQ_STATUS_SENT);
+
+		p9_req_put(usb9pfs->client, usb9pfs->p9_tx_req);
+
+		usb9pfs_rx_fill(usb9pfs, usb9pfs->out_req, GFP_ATOMIC);
+
+		spin_unlock(&usb9pfs->req_lock);
+
+		break;
+
+	default:
+		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
+			ep->name, req->status, req->actual, req->length);
+		usb_ep_free_request(ep == usb9pfs->in_ep ?
+				    usb9pfs->out_ep : usb9pfs->in_ep,
+				    req->context);
+		free_ep_req(ep, req);
+		return;
+	}
+}
+
+static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs,
+					  struct usb_request *req)
+{
+	struct p9_req_t *p9_rx_req;
+	struct p9_fcall	rc;
+	int ret;
+
+	/* start by reading header */
+	rc.sdata = req->buf;
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
+
+	switch (req->status) {
+	case 0:				/* normal completion? */
+		spin_lock_irqsave(&usb9pfs->req_lock, flags);
+		p9_rx_req = usb9pfs_rx_header(usb9pfs, req);
+		if (!p9_rx_req) {
+			spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
+			goto free_req;
+		}
+
+		memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
+		p9_rx_req->rc.size = req->actual;
+
+		p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
+		p9_req_put(usb9pfs->client, p9_rx_req);
+
+		usb9pfs->p9_tx_req = NULL;
+
+		usb9pfs_transmit(usb9pfs);
+
+		spin_unlock_irqrestore(&usb9pfs->req_lock, flags);
+
+		return;
+free_req:
+	default:
+		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
+			ep->name, req->status, req->actual, req->length);
+		usb_ep_free_request(ep == usb9pfs->in_ep ?
+				    usb9pfs->out_ep : usb9pfs->in_ep,
+				    req->context);
+		free_ep_req(ep, req);
+		return;
+	}
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
+		dev_info(&cdev->gadget->dev, "disable %s --> %d\n", ep->name, value);
+}
+
+static void disable_endpoints(struct usb_composite_dev *cdev,
+			      struct usb_ep *in, struct usb_ep *out,
+			      struct usb_ep *iso_in, struct usb_ep *iso_out)
+{
+	disable_ep(cdev, in);
+	disable_ep(cdev, out);
+}
+
+static void disable_usb9pfs(struct f_usb9pfs *usb9pfs)
+{
+	struct usb_composite_dev *cdev;
+
+	cdev = usb9pfs->function.config->cdev;
+	disable_endpoints(cdev, usb9pfs->in_ep, usb9pfs->out_ep, NULL, NULL);
+	dev_dbg(&cdev->gadget->dev, "%s disabled\n", usb9pfs->function.name);
+}
+
+static inline struct usb_request *usb9pfs_alloc_ep_req(struct usb_ep *ep, int len)
+{
+	return alloc_ep_req(ep, len);
+}
+
+static int alloc_requests(struct usb_composite_dev *cdev,
+			  struct f_usb9pfs *usb9pfs)
+{
+	usb9pfs->in_req = usb_ep_alloc_request(usb9pfs->in_ep, GFP_ATOMIC);
+	if (!usb9pfs->in_req)
+		goto fail;
+
+	usb9pfs->out_req = usb9pfs_alloc_ep_req(usb9pfs->out_ep, usb9pfs->buflen);
+	if (!usb9pfs->out_req)
+		goto fail_in;
+
+	usb9pfs->in_req->complete = usb9pfs_tx_complete;
+	usb9pfs->out_req->complete = usb9pfs_rx_complete;
+
+	/* length will be set in complete routine */
+	usb9pfs->in_req->context = usb9pfs;
+	usb9pfs->out_req->context = usb9pfs;
+
+	return 0;
+
+fail_in:
+	usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
+fail:
+	return 0;
+}
+
+static int enable_endpoint(struct usb_composite_dev *cdev,
+			   struct f_usb9pfs *usb9pfs, struct usb_ep *ep)
+{
+	int result;
+
+	result = config_ep_by_speed(cdev->gadget, &usb9pfs->function, ep);
+	if (result)
+		goto out;
+
+	result = usb_ep_enable(ep);
+	if (result < 0)
+		goto out;
+
+	ep->driver_data = usb9pfs;
+
+	result = 0;
+
+out:
+	return result;
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
+	struct f_usb9pfs *usb9pfs;
+	struct f_usb9pfs *tmp;
+	struct usb_function *f;
+	int ret = -ENOENT;
+	int found = 0;
+
+	if (!devname)
+		return -EINVAL;
+
+	mutex_lock(&usb9pfs_lock);
+	list_for_each_entry_safe(usb9pfs, tmp, &usbg_function_list, function_list) {
+		if (!usb9pfs->tag)
+			continue;
+		if (!strncmp(devname, usb9pfs->tag, strlen(devname))) {
+			if (!usb9pfs->inuse) {
+				usb9pfs->inuse = true;
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
+	disable_usb9pfs(usb9pfs);
+
+	return enable_usb9pfs(cdev, usb9pfs);
+}
+
+static void p9_usbg_close(struct p9_client *client)
+{
+	struct f_usb9pfs *usb9pfs = client->trans;
+
+	disable_usb9pfs(usb9pfs);
+}
+
+static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)
+{
+	struct f_usb9pfs *usb9pfs = client->trans;
+	unsigned long flags;
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
+/* We don't currently allow canceling of requests */
+static int p9_usbg_cancel(struct p9_client *client, struct p9_req_t *req)
+{
+	return 1;
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
+	hs_usb9pfs_sink_desc.bEndpointAddress = fs_usb9pfs_sink_desc.bEndpointAddress;
+
+	/* support super speed hardware */
+	ss_usb9pfs_source_desc.bEndpointAddress =
+		fs_usb9pfs_source_desc.bEndpointAddress;
+	ss_usb9pfs_sink_desc.bEndpointAddress = fs_usb9pfs_sink_desc.bEndpointAddress;
+
+	ret = usb_assign_descriptors(f, fs_usb9pfs_descs, hs_usb9pfs_descs,
+				     ss_usb9pfs_descs, ss_usb9pfs_descs);
+	if (ret)
+		return ret;
+
+	dev_dbg(&cdev->gadget->dev, "%s speed %s: IN/%s, OUT/%s\n",
+		(gadget_is_superspeed(c->cdev->gadget) ? "super" :
+		(gadget_is_dualspeed(c->cdev->gadget) ? "dual" : "full")),
+			f->name, usb9pfs->in_ep->name, usb9pfs->out_ep->name);
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
+	ida_free(&usb9pfs_ida, usb9pfs->index);
+	kfree(usb9pfs->tag);
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
+	mutex_lock(&usb9pfs_ida_lock);
+
+	usb9pfs->index = ida_alloc_max(&usb9pfs_ida, U8_MAX, GFP_KERNEL);
+	if (usb9pfs->index < 0) {
+		struct usb_function *ret = ERR_PTR(usb9pfs->index);
+
+		kfree(usb9pfs);
+		mutex_unlock(&usb9pfs_ida_lock);
+		return ret;
+	}
+
+	mutex_unlock(&usb9pfs_ida_lock);
+
+	usb9pfs->tag = kasprintf(GFP_KERNEL, "%s%d", usb9pfs->function.name,
+				 usb9pfs->index);
+
+	INIT_LIST_HEAD(&usb9pfs->function_list);
+
+	mutex_lock(&usb9pfs_lock);
+	list_add_tail(&usb9pfs->function_list, &usbg_function_list);
+	mutex_unlock(&usb9pfs_lock);
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
+
+	usb9pfs_opts = kzalloc(sizeof(*usb9pfs_opts), GFP_KERNEL);
+	if (!usb9pfs_opts)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&usb9pfs_opts->lock);
+
+	usb9pfs_opts->func_inst.free_func_inst = usb9pfs_free_instance;
+
+	usb9pfs_opts->buflen = DEFAULT_BUFLEN;
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
+	INIT_LIST_HEAD(&usbg_function_list);
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


