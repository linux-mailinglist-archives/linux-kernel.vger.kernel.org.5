Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC70776058F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGYChD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjGYCgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:36:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30E1FFA;
        Mon, 24 Jul 2023 19:35:25 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P1a6Z3028832;
        Tue, 25 Jul 2023 02:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0uysnpMII+2AtMmYtePeOauv8jOSHqmZ6ITk34jIVe0=;
 b=nH9KqVmnYVvpffkro8yyvF6PRNePL2FZOECz4EGyW+L5ltSxtZbEbaXnDzdTLRtLK3Pm
 NbQIk7iyHo5R36dhmShQAozug2PhvcJH7icmZr/8+ArnrbTNyC2vV9JxFagST+scuyYW
 E5fjtdXl60ov8nEwjytKT7bc/zf0+mO1PhX6NkSqcOIZrx6oSGYYmfS27On2RsLaRNCs
 nfxb/LEuOTHcPV08HpxtqQbRIJN4zg70VZpznTnJEolXUb/Ez7YiNc1g2aq5OxShDp1G
 bJKo/pKIlcKHHV/hcOISefN25NKjpdgRJC/AKSbofl3ts8teY+zXg39Uz6iXgyryxlkV DA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1s1jsn6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:40 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P2YVlr015040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:31 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 19:34:30 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <bgoswami@quicinc.com>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <quic_jackp@quicinc.com>, <pierre-louis.bossart@linux.intel.com>,
        <oneukum@suse.com>, <albertccwang@google.com>,
        <o-takashi@sakamocchi.jp>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v4 03/32] xhci: sideband: add initial api to register a sideband entity
Date:   Mon, 24 Jul 2023 19:33:47 -0700
Message-ID: <20230725023416.11205-4-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230725023416.11205-1-quic_wcheng@quicinc.com>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Eu8-OUnDEs5bTIDx1-QbAiYswYpgxIyV
X-Proofpoint-ORIG-GUID: Eu8-OUnDEs5bTIDx1-QbAiYswYpgxIyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250021
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/usb/host/xhci-sideband.c  | 195 ++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h           |  23 +---
 include/linux/usb/xhci-sideband.h |  90 ++++++++++++++
 5 files changed, 303 insertions(+), 18 deletions(-)
 create mode 100644 drivers/usb/host/xhci-sideband.c
 create mode 100644 include/linux/usb/xhci-sideband.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index c170672f847e..d9dc92bea525 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -104,6 +104,15 @@ config USB_XHCI_RZV2M
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in Renesas RZ/V2M SoC.
 
+config USB_XHCI_SIDEBAND
+	bool "xHCI support for sideband"
+	help
+	  Say 'Y' to enable the support for the xHCI sideband capability.
+	  provide a mechanism for a sideband datapath for payload associated
+	  with audio class endpoints. This allows for an audio DSP to use
+	  xHCI USB endpoints directly, allowing CPU to sleep while playing
+	  audio
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
index 000000000000..a077eb8783cc
--- /dev/null
+++ b/drivers/usb/host/xhci-sideband.c
@@ -0,0 +1,195 @@
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
+		pages[i] = vmalloc_to_page(seg->trbs);
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
index 000000000000..1c8c103dc91c
--- /dev/null
+++ b/include/linux/usb/xhci-sideband.h
@@ -0,0 +1,90 @@
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
+#if IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND)
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
+#else
+static struct xhci_sideband *
+xhci_sideband_register(struct usb_device *udev)
+{
+	return NULL;
+}
+
+static void
+xhci_sideband_unregister(struct xhci_sideband *sb)
+{ }
+
+static int
+xhci_sideband_add_endpoint(struct xhci_sideband *sb,
+			   struct usb_host_endpoint *host_ep)
+{
+	return 0;
+}
+
+static int
+xhci_sideband_remove_endpoint(struct xhci_sideband *sb,
+			      struct usb_host_endpoint *host_ep)
+{
+	return 0;
+}
+
+static int
+xhci_sideband_stop_endpoint(struct xhci_sideband *sb,
+			    struct usb_host_endpoint *host_ep)
+{
+	return 0;
+}
+#endif
+#endif /* __LINUX_XHCI_SIDEBAND_H */
+
