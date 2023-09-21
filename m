Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10EB7AA3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjIUVya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjIUVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:53:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5B3AAE;
        Thu, 21 Sep 2023 14:49:43 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LLlR97010420;
        Thu, 21 Sep 2023 21:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=b7UX4xEqbpTE5ZLVwG0WlXP9YxrfFv516hblPuLU3KQ=;
 b=axZU5I3trJE4Kon+Gn7D8XLr6u/tUFG/MU4Az0ldmO8B9tt4cr+HiAxGx7rLOKArpR78
 xuGQyAKdh2agqKZNcaSD64k5aFpJGgOVcKPdN+hKHdtMic0hjXPar4xZ/vQ0Wsi/GZCL
 YObGLPmytAVLgLY4kj7tCs05uEm1B3h4loEIdRADt8WqR3kHXURENI+mWNKLvI6X5xoK
 LWHhKy8kzIMadF15ARKcPYm90AnoxACQJftK2krpIL262ll23wLzIiP8MFTidLA5xQhg
 Lh0lWLezFlTHJMxs13fHu7wpgJVPy72ejIG2Y7JeZgH1/7JNrifrHouTi1qfhGlQ1v/V EA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8uknr96q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:48:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LLmsnb012377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:48:54 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 21 Sep 2023 14:48:53 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v7 03/33] xhci: sideband: add initial api to register a sideband entity
Date:   Thu, 21 Sep 2023 14:48:13 -0700
Message-ID: <20230921214843.18450-4-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921214843.18450-1-quic_wcheng@quicinc.com>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YWI75WEk4JPNjD4eb5j1DVHqv2Z9Ulie
X-Proofpoint-ORIG-GUID: YWI75WEk4JPNjD4eb5j1DVHqv2Z9Ulie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=995 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Introduce XHCI sideband, which manages the USB endpoints being requested by
a client driver.  This is used for when client drivers are attempting to
offload USB endpoints to another entity for handling USB transfers.  XHCI
sideband will allow for drivers to fetch the required information about the
transfer ring, so the user can submit transfers independently.  Expose the
required APIs for drivers to register and request for a USB endpoint.

Multiple ring segment page linking and proper endpoint clean up added by
Wesley Cheng to complete original concept code by Mathias Nyman.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/Kconfig          |   9 ++
 drivers/usb/host/Makefile         |   4 +
 drivers/usb/host/xhci-sideband.c  | 198 ++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h           |  23 +---
 include/linux/usb/xhci-sideband.h |  57 +++++++++
 5 files changed, 273 insertions(+), 18 deletions(-)
 create mode 100644 drivers/usb/host/xhci-sideband.c
 create mode 100644 include/linux/usb/xhci-sideband.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 4448d0ab06f0..83be56c27d64 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -104,6 +104,15 @@ config USB_XHCI_RZV2M
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in Renesas RZ/V2M SoC.
 
+config USB_XHCI_SIDEBAND
+	bool "xHCI support for sideband"
+	help
+	  Say 'Y' to enable the support for the xHCI sideband capability.
+	  Provide a mechanism for a sideband datapath for payload associated
+	  with audio class endpoints. This allows for an audio DSP to use
+	  xHCI USB endpoints directly, allowing CPU to sleep while playing
+	  audio.
+
 config USB_XHCI_TEGRA
 	tristate "xHCI support for NVIDIA Tegra SoCs"
 	depends on PHY_TEGRA_XUSB
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index be4e5245c52f..4df946c05ba0 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -32,6 +32,10 @@ endif
 xhci-rcar-hcd-y				+= xhci-rcar.o
 xhci-rcar-hcd-$(CONFIG_USB_XHCI_RZV2M)	+= xhci-rzv2m.o
 
+ifneq ($(CONFIG_USB_XHCI_SIDEBAND),)
+	xhci-hcd-y		+= xhci-sideband.o
+endif
+
 obj-$(CONFIG_USB_PCI)	+= pci-quirks.o
 
 obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
new file mode 100644
index 000000000000..937ae627947a
--- /dev/null
+++ b/drivers/usb/host/xhci-sideband.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * xHCI host controller sideband support
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ *
+ * Author: Mathias Nyman
+ */
+#include <linux/usb.h>
+#include <linux/dma-direct.h>
+
+#include "xhci.h"
+
+static int
+xhci_ring_to_sgtable(struct xhci_sideband *sb, struct xhci_ring *ring, struct device *dev)
+{
+	struct sg_table	*sgt;
+	struct xhci_segment *seg;
+	struct page **pages;
+	unsigned int n_pages;
+	size_t sz;
+	int i;
+
+	sz = ring->num_segs * TRB_SEGMENT_SIZE;
+	n_pages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+	pages = kvmalloc_array(n_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return 0;
+
+	sgt = kzalloc(sizeof(struct sg_table), GFP_KERNEL);
+	if (!sgt) {
+		kvfree(pages);
+		return 0;
+	}
+
+	seg = ring->first_seg;
+
+	/*
+	 * Rings can potentially have multiple segments, create an array that
+	 * carries page references to allocated segments.  Utilize the
+	 * sg_alloc_table_from_pages() to create the sg table, and to ensure
+	 * that page links are created.
+	 */
+	for (i = 0; i < ring->num_segs; i++) {
+		dma_get_sgtable(dev, sgt, seg->trbs, seg->dma,
+					TRB_SEGMENT_SIZE);
+		pages[i] = sg_page(sgt->sgl);
+		sg_free_table(sgt);
+		seg = seg->next;
+	}
+
+	if (sg_alloc_table_from_pages(sgt, pages, n_pages, 0, sz, GFP_KERNEL)) {
+		kvfree(pages);
+		kfree(sgt);
+
+		return 0;
+	}
+
+	sb->sgt = sgt;
+
+	return 0;
+}
+
+static int __xhci_sideband_remove_endpoint(struct xhci_sideband *sb,
+						int idx)
+{
+	struct xhci_virt_ep *ep = sb->eps[idx];
+
+	/*
+	 * Issue a stop endpoint command when an endpoint is removed.
+	 * The stop ep cmd handler will handle the ring cleanup.
+	 */
+	xhci_stop_endpoint_sync(sb->xhci, ep, 0);
+
+	sg_free_table(sb->sgt);
+	ep->sideband = NULL;
+	sb->eps[idx] = NULL;
+
+	return 0;
+}
+
+/* sidband api functions */
+struct xhci_sideband *
+xhci_sideband_register(struct usb_device *udev)
+{
+	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct xhci_virt_device *vdev;
+	struct xhci_sideband *sb;
+
+	/* make sure the usb device is connected to a xhci controller */
+	if (!udev->slot_id)
+		return NULL;
+
+	/* check this device isn't already controller via sideband */
+	vdev = xhci->devs[udev->slot_id];
+
+	if (!vdev || vdev->sideband) {
+		xhci_warn(xhci, "XHCI sideband slot already in use %d\n",
+				udev->slot_id);
+		return NULL;
+	}
+
+	sb = kzalloc_node(sizeof(*sb), GFP_KERNEL, dev_to_node(hcd->self.sysdev));
+	if (!sb)
+		return NULL;
+
+	sb->xhci = xhci;
+	sb->vdev = vdev;
+	vdev->sideband = sb;
+
+	return sb;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_register);
+
+void
+xhci_sideband_unregister(struct xhci_sideband *sb)
+{
+	int i;
+
+	for (i = 0; i < EP_CTX_PER_DEV; i++)
+		if (sb->eps[i])
+			__xhci_sideband_remove_endpoint(sb, i);
+
+	sb->vdev->sideband = NULL;
+	kfree(sb);
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_unregister);
+
+int
+xhci_sideband_add_endpoint(struct xhci_sideband *sb,
+			   struct usb_host_endpoint *host_ep)
+{
+	struct xhci_hcd *xhci = sb->xhci;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+	struct xhci_virt_ep *ep;
+	unsigned int ep_index;
+
+	ep_index = xhci_get_endpoint_index(&host_ep->desc);
+	ep = &sb->vdev->eps[ep_index];
+
+	/*
+	 * Note, we don't know the DMA mask of the audio DSP device, if its
+	 * smaller than for xhci it won't be able to access the endpoint ring
+	 * buffer. This could be solved by not allowing the audio class driver
+	 * to add the endpoint the normal way, but instead offload it immediately,
+	 * and let this function add the endpoint and allocate the ring buffer
+	 * with the smallest common DMA mask
+	 */
+	if (sb->eps[ep_index] || ep->sideband)
+		return -EBUSY;
+
+	ep->sideband = sb;
+	sb->eps[ep_index] = ep;
+	sb->ring = ep->ring;
+	xhci_ring_to_sgtable(sb, ep->ring, dev);
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_add_endpoint);
+
+int
+xhci_sideband_remove_endpoint(struct xhci_sideband *sb,
+			      struct usb_host_endpoint *host_ep)
+{
+	struct xhci_virt_ep *ep;
+	unsigned int ep_index;
+
+	ep_index = xhci_get_endpoint_index(&host_ep->desc);
+	ep = sb->eps[ep_index];
+
+	if (!ep || !ep->sideband || sb->vdev != ep->sideband->vdev)
+		return -ENODEV;
+
+	__xhci_sideband_remove_endpoint(sb, ep_index);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_remove_endpoint);
+
+int
+xhci_sideband_stop_endpoint(struct xhci_sideband *sb,
+			    struct usb_host_endpoint *host_ep)
+{
+	struct xhci_virt_ep *ep;
+	unsigned int ep_index;
+
+	ep_index = xhci_get_endpoint_index(&host_ep->desc);
+	ep = sb->eps[ep_index];
+
+
+	if (!ep || ep->sideband != sb || sb->vdev != ep->sideband->vdev)
+		return -EINVAL;
+
+	return xhci_stop_endpoint_sync(sb->xhci, ep, 0);
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_stop_endpoint);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 898b6434dc27..15ade8ec6b6c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -18,6 +18,7 @@
 #include <linux/usb/hcd.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/usb/xhci-intr.h>
+#include <linux/usb/xhci-sideband.h>
 
 /* Code sharing between pci-quirks and xhci hcd */
 #include	"xhci-ext-caps.h"
@@ -975,6 +976,8 @@ struct xhci_virt_ep {
 	int			next_frame_id;
 	/* Use new Isoch TRB layout needed for extended TBC support */
 	bool			use_extended_tbc;
+	/* set if this endpoint is controlled via sideband access*/
+	struct xhci_sideband			*sideband;
 };
 
 enum xhci_overhead_type {
@@ -1004,8 +1007,6 @@ struct xhci_interval_bw_table {
 	unsigned int		ss_bw_out;
 };
 
-#define EP_CTX_PER_DEV		31
-
 struct xhci_virt_device {
 	int				slot_id;
 	struct usb_device		*udev;
@@ -1038,6 +1039,8 @@ struct xhci_virt_device {
 	u16				current_mel;
 	/* Used for the debugfs interfaces. */
 	void				*debugfs_private;
+	/* set if this device is registered for sideband access */
+	struct xhci_sideband			*sideband;
 };
 
 /*
@@ -1518,22 +1521,6 @@ static inline const char *xhci_trb_type_string(u8 type)
 #define NEC_FW_MINOR(p)		(((p) >> 0) & 0xff)
 #define NEC_FW_MAJOR(p)		(((p) >> 8) & 0xff)
 
-/*
- * TRBS_PER_SEGMENT must be a multiple of 4,
- * since the command ring is 64-byte aligned.
- * It must also be greater than 16.
- */
-#define TRBS_PER_SEGMENT	256
-/* Allow two commands + a link TRB, along with any reserved command TRBs */
-#define MAX_RSVD_CMD_TRBS	(TRBS_PER_SEGMENT - 3)
-#define TRB_SEGMENT_SIZE	(TRBS_PER_SEGMENT*16)
-#define TRB_SEGMENT_SHIFT	(ilog2(TRB_SEGMENT_SIZE))
-/* TRB buffer pointers can't cross 64KB boundaries */
-#define TRB_MAX_BUFF_SHIFT		16
-#define TRB_MAX_BUFF_SIZE	(1 << TRB_MAX_BUFF_SHIFT)
-/* How much data is left before the 64KB boundary? */
-#define TRB_BUFF_LEN_UP_TO_BOUNDARY(addr)	(TRB_MAX_BUFF_SIZE - \
-					(addr & (TRB_MAX_BUFF_SIZE - 1)))
 #define MAX_SOFT_RETRY		3
 /*
  * Limits of consecutive isoc trbs that can Block Event Interrupt (BEI) if
diff --git a/include/linux/usb/xhci-sideband.h b/include/linux/usb/xhci-sideband.h
new file mode 100644
index 000000000000..d6b2cc91666f
--- /dev/null
+++ b/include/linux/usb/xhci-sideband.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * xHCI host controller sideband support
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ *
+ * Author: Mathias Nyman <mathias.nyman@linux.intel.com>
+ */
+
+#ifndef __LINUX_XHCI_SIDEBAND_H  // fixme check ok
+#define __LINUX_XHCI_SIDEBAND_H
+
+#include <linux/dma-mapping.h>
+/*
+ * TRBS_PER_SEGMENT must be a multiple of 4,
+ * since the command ring is 64-byte aligned.
+ * It must also be greater than 16.
+ */
+#define TRBS_PER_SEGMENT	256
+/* Allow two commands + a link TRB, along with any reserved command TRBs */
+#define MAX_RSVD_CMD_TRBS	(TRBS_PER_SEGMENT - 3)
+#define TRB_SEGMENT_SIZE	(TRBS_PER_SEGMENT*16)
+#define TRB_SEGMENT_SHIFT	(ilog2(TRB_SEGMENT_SIZE))
+/* TRB buffer pointers can't cross 64KB boundaries */
+#define TRB_MAX_BUFF_SHIFT		16
+#define TRB_MAX_BUFF_SIZE	(1 << TRB_MAX_BUFF_SHIFT)
+/* How much data is left before the 64KB boundary? */
+#define TRB_BUFF_LEN_UP_TO_BOUNDARY(addr)	(TRB_MAX_BUFF_SIZE - \
+					(addr & (TRB_MAX_BUFF_SIZE - 1)))
+
+#define EP_CTX_PER_DEV		31
+
+struct xhci_sideband {
+	struct xhci_hcd                 *xhci;
+	struct xhci_virt_device         *vdev;
+	struct xhci_virt_ep             *eps[EP_CTX_PER_DEV];
+	struct xhci_interrupter         *ir;
+	struct sg_table			*sgt;
+	struct xhci_ring		*ring;
+	dma_addr_t dma;
+};
+
+struct xhci_sideband *
+xhci_sideband_register(struct usb_device *udev);
+void
+xhci_sideband_unregister(struct xhci_sideband *sb);
+int
+xhci_sideband_add_endpoint(struct xhci_sideband *sb,
+			   struct usb_host_endpoint *host_ep);
+int
+xhci_sideband_remove_endpoint(struct xhci_sideband *sb,
+			      struct usb_host_endpoint *host_ep);
+int
+xhci_sideband_stop_endpoint(struct xhci_sideband *sb,
+			    struct usb_host_endpoint *host_ep);
+#endif /* __LINUX_XHCI_SIDEBAND_H */
+
