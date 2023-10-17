Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA9A7CCD20
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjJQUCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjJQUBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:01:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31112C6;
        Tue, 17 Oct 2023 13:01:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJswqQ012414;
        Tue, 17 Oct 2023 20:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/kvvFezgpBXW1+RQKxidZjutgIkMSZf6DnjF6YfB/v0=;
 b=gOegxzyp5H757g2hwzteb3NrVCNlY96Esrg993ujcmXHTvh0TC9Jc82hCh0WMqKqbdX2
 eX9K+xzLHd1x0V0DJuMWPAyEYIImFVuFgnCgQOmcJV+9+AyvyDDXBlRk9UwFZ060aks2
 VpoIPeBo0aOGGIwAjOQ5VXMr0+P7QYoVPKzxCOBdBCQ/Sh1T7b7IxhtBHFQSV8UX6+bD
 Uy7V5/ldHzQFTxlIAItMC8P4wLykwAwj7AERAesf6XVW0djRZErOb0h972ttHeFIzHVP
 4sPCzhkkA62WHDCMw+TXS9GpAOUlswgBgr4eGqHM4c7zkrWHDPc0rt6XQzqocMzJjV5b Ew== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsneasquh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:01:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HK1Kni003184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:01:20 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 13:01:20 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v9 04/34] xhci: sideband: add initial api to register a sideband entity
Date:   Tue, 17 Oct 2023 13:00:39 -0700
Message-ID: <20231017200109.11407-5-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231017200109.11407-1-quic_wcheng@quicinc.com>
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t8HwZk60uz6u9t1aLPyjXWtIKR_hoHzI
X-Proofpoint-ORIG-GUID: t8HwZk60uz6u9t1aLPyjXWtIKR_hoHzI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170170
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
required APIs for drivers to register and request for a USB endpoint and to
manage XHCI secondary interrupters.

Multiple ring segment page linking and proper endpoint clean up added by
Wesley Cheng to complete original concept code by Mathias Nyman.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/Kconfig          |   9 +
 drivers/usb/host/Makefile         |   4 +
 drivers/usb/host/xhci-sideband.c  | 371 ++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h           |   4 +
 include/linux/usb/xhci-sideband.h |  66 ++++++
 5 files changed, 454 insertions(+)
 create mode 100644 drivers/usb/host/xhci-sideband.c
 create mode 100644 include/linux/usb/xhci-sideband.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 4448d0ab06f0..923af11c1982 100644
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
index 000000000000..cc4f90375e00
--- /dev/null
+++ b/drivers/usb/host/xhci-sideband.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * xHCI host controller sideband support
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ *
+ * Author: Mathias Nyman
+ */
+
+#include <linux/usb/xhci-sideband.h>
+#include <linux/dma-direct.h>
+
+#include "xhci.h"
+
+/* sideband internal helpers */
+static struct sg_table *
+xhci_ring_to_sgtable(struct xhci_sideband *sb, struct xhci_ring *ring)
+{
+	struct xhci_segment *seg;
+	struct sg_table	*sgt;
+	unsigned int n_pages;
+	struct page **pages;
+	struct device *dev;
+	size_t sz;
+	int i;
+
+	dev = xhci_to_hcd(sb->xhci)->self.sysdev;
+	sz = ring->num_segs * TRB_SEGMENT_SIZE;
+	n_pages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+	pages = kvmalloc_array(n_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	sgt = kzalloc(sizeof(struct sg_table), GFP_KERNEL);
+	if (!sgt) {
+		kvfree(pages);
+		return NULL;
+	}
+
+	seg = ring->first_seg;
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
+		return NULL;
+	}
+	/*
+	 * Save first segment dma address to sg dma_address field for the sideband
+	 * client to have access to the IOVA of the ring.
+	 */
+	sg_dma_address(sgt->sgl) = ring->first_seg->dma;
+
+	return sgt;
+}
+
+static void
+__xhci_sideband_remove_endpoint(struct xhci_sideband *sb, struct xhci_virt_ep *ep)
+{
+	/*
+	 * Issue a stop endpoint command when an endpoint is removed.
+	 * The stop ep cmd handler will handle the ring cleanup.
+	 */
+	xhci_stop_endpoint_sync(sb->xhci, ep, 0, GFP_KERNEL);
+
+	ep->sideband = NULL;
+	sb->eps[ep->ep_index] = NULL;
+}
+
+/* sideband api functions */
+
+/**
+ * xhci_sideband_add_endpoint - add endpoint to sideband access list
+ * @sb: sideband instance for this usb device
+ * @host_ep: usb host endpoint
+ *
+ * Adds an endpoint to the list of sideband accessed endpoints for this usb
+ * device.
+ * After an endpoint is added the sideband client can get the endpoint transfer
+ * ring buffer by calling xhci_sideband_endpoint_buffer()
+ *
+ * Return: 0 on success, negative error otherwise.
+ */
+int
+xhci_sideband_add_endpoint(struct xhci_sideband *sb,
+			   struct usb_host_endpoint *host_ep)
+{
+	struct xhci_virt_ep *ep;
+	unsigned int ep_index;
+
+	ep_index = xhci_get_endpoint_index(&host_ep->desc);
+	ep = &sb->vdev->eps[ep_index];
+
+	if (ep->ep_state & EP_HAS_STREAMS)
+		return -EINVAL;
+
+	/*
+	 * Note, we don't know the DMA mask of the audio DSP device, if its
+	 * smaller than for xhci it won't be able to access the endpoint ring
+	 * buffer. This could be solved by not allowing the audio class driver
+	 * to add the endpoint the normal way, but instead offload it immediately,
+	 * and let this function add the endpoint and allocate the ring buffer
+	 * with the smallest common DMA mask
+	 */
+
+	if (sb->eps[ep_index] || ep->sideband)
+		return -EBUSY;
+
+	ep->sideband = sb;
+	sb->eps[ep_index] = ep;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_add_endpoint);
+
+/**
+ * xhci_sideband_remove_endpoint - remove endpoint from sideband access list
+ * @sb: sideband instance for this usb device
+ * @host_ep: usb host endpoint
+ *
+ * Removes an endpoint from the list of sideband accessed endpoints for this usb
+ * device.
+ * sideband client should no longer touch the endpoint transfer buffer after
+ * calling this.
+ *
+ * Return: 0 on success, negative error otherwise.
+ */
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
+	if (!ep || !ep->sideband)
+		return -ENODEV;
+
+	__xhci_sideband_remove_endpoint(sb, ep);
+	xhci_initialize_ring_info(ep->ring, 1);
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
+	if (!ep || ep->sideband != sb)
+		return -EINVAL;
+
+	return xhci_stop_endpoint_sync(sb->xhci, ep, 0);
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_stop_endpoint);
+
+/**
+ * xhci_sideband_get_endpoint_buffer - gets the endpoint transfer buffer address
+ * @sb: sideband instance for this usb device
+ * @host_ep: usb host endpoint
+ *
+ * Returns the address of the endpoint buffer where xHC controller reads queued
+ * transfer TRBs from. This is the starting address of the ringbuffer where the
+ * sidband cliend should write TRBs to.
+ *
+ * Caller needs to free the returned sg_table
+ *
+ * Return: struct sg_table * if successful. NULL otherwise.
+ */
+struct sg_table *
+xhci_sideband_get_endpoint_buffer(struct xhci_sideband *sb,
+			      struct usb_host_endpoint *host_ep)
+{
+	struct xhci_virt_ep *ep;
+	unsigned int ep_index;
+
+	ep_index = xhci_get_endpoint_index(&host_ep->desc);
+	ep = sb->eps[ep_index];
+
+	if (!ep)
+		return NULL;
+
+	return xhci_ring_to_sgtable(sb, ep->ring);
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_get_endpoint_buffer);
+
+/**
+ * xhci_sideband_get_event_buffer - return the event buffer for this device
+ * @sb: sideband instance for this usb device
+ *
+ * If a secondary xhci interupter is set up for this usb device then this
+ * function returns the address of the event buffer where xHC writes
+ * the transfer completion events.
+ *
+ * Caller needs to free the returned sg_table
+ *
+ * Return: struct sg_table * if successful. NULL otherwise.
+ */
+struct sg_table *
+xhci_sideband_get_event_buffer(struct xhci_sideband *sb)
+{
+	if (!sb->ir)
+		return NULL;
+
+	return xhci_ring_to_sgtable(sb, sb->ir->event_ring);
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_get_event_buffer);
+
+/**
+ * xhci_sideband_create_interrupter - creates a new interrupter for this sideband
+ * @sb: sideband instance for this usb device
+ *
+ * Sets up a xhci interrupter that can be used for this sideband accessed usb
+ * device. Transfer events for this device can be routed to this interrupters
+ * event ring by setting the 'Interrupter Target' field correctly when queueing
+ * the transfer TRBs.
+ * Once this interrupter is created the interrupter target ID can be obtained
+ * by calling xhci_sideband_interrupter_id()
+ *
+ * Returns 0 on success, negative error otherwise
+ */
+int
+xhci_sideband_create_interrupter(struct xhci_sideband *sb)
+{
+	if (sb->ir)
+		return -EBUSY;
+
+	sb->ir = xhci_create_secondary_interrupter(xhci_to_hcd(sb->xhci));
+	if (!sb->ir)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
+
+/**
+ * xhci_sideband_remove_interrupter - remove the interrupter from a sideband
+ * @sb: sideband instance for this usb device
+ *
+ * Removes a registered interrupt for a sideband.  This would allow for other
+ * sideband users to utilize this interrupter.
+ */
+void
+xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
+{
+	if (!sb || !sb->ir)
+		return;
+
+	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
+
+	sb->ir = NULL;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_remove_interrupter);
+
+/**
+ * xhci_sideband_interrupter_id - return the interrupter target id
+ * @sb: sideband instance for this usb device
+ *
+ * If a secondary xhci interrupter is set up for this usb device then this
+ * function returns the ID used by the interrupter. The sideband client
+ * needs to write this ID to the 'Interrupter Target' field of the transfer TRBs
+ * it queues on the endpoints transfer ring to ensure transfer completion event
+ * are written by xHC to the correct interrupter event ring.
+ *
+ * Returns interrupter id on success, negative error othgerwise
+ */
+int
+xhci_sideband_interrupter_id(struct xhci_sideband *sb)
+{
+	if (!sb || !sb->ir)
+		return -ENODEV;
+
+	return sb->ir->intr_num;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_interrupter_id);
+
+/**
+ * xhci_sideband_register - register a sideband for a usb device
+ * @udev: usb device to be accessed via sideband
+ *
+ * Allows for clients to utilize XHCI interrupters and fetch transfer and event
+ * ring parameters for executing data transfers.
+ *
+ * Return: pointer to a new xhci_sideband instance if successful. NULL otherwise.
+ */
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
+	sb = kzalloc_node(sizeof(*sb), GFP_KERNEL, dev_to_node(hcd->self.sysdev));
+	if (!sb)
+		return NULL;
+
+	/* check this device isn't already controlled via sideband */
+	spin_lock_irq(&xhci->lock);
+
+	vdev = xhci->devs[udev->slot_id];
+
+	if (!vdev || vdev->sideband) {
+		xhci_warn(xhci, "XHCI sideband for slot %d already in use\n",
+			  udev->slot_id);
+		spin_unlock_irq(&xhci->lock);
+		kfree(sb);
+		return NULL;
+	}
+
+	sb->xhci = xhci;
+	sb->vdev = vdev;
+	vdev->sideband = sb;
+
+	spin_unlock_irq(&xhci->lock);
+
+	return sb;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_register);
+
+/**
+ * xhci_sideband_unregister - unregister sideband access to a usb device
+ * @sb: sideband instance to be unregistered
+ *
+ * Unregisters sideband access to a usb device and frees the sideband
+ * instance.
+ * After this the endpoint and interrupter event buffers should no longer
+ * be accessed via sideband. The xhci driver can now take over handling
+ * the buffers.
+ */
+void
+xhci_sideband_unregister(struct xhci_sideband *sb)
+{
+	int i;
+
+	for (i = 0; i < EP_CTX_PER_DEV; i++)
+		if (sb->eps[i])
+			__xhci_sideband_remove_endpoint(sb, sb->eps[i]);
+
+	xhci_sideband_remove_interrupter(sb);
+
+	sb->vdev->sideband = NULL;
+	kfree(sb);
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_unregister);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 4b8caaed6f95..339d37c3a3d9 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -947,6 +947,8 @@ struct xhci_virt_ep {
 	int			next_frame_id;
 	/* Use new Isoch TRB layout needed for extended TBC support */
 	bool			use_extended_tbc;
+	/* set if this endpoint is controlled via sideband access*/
+	struct xhci_sideband			*sideband;
 };
 
 enum xhci_overhead_type {
@@ -1010,6 +1012,8 @@ struct xhci_virt_device {
 	u16				current_mel;
 	/* Used for the debugfs interfaces. */
 	void				*debugfs_private;
+	/* set if this device is registered for sideband access */
+	struct xhci_sideband			*sideband;
 };
 
 /*
diff --git a/include/linux/usb/xhci-sideband.h b/include/linux/usb/xhci-sideband.h
new file mode 100644
index 000000000000..c1457d1800f4
--- /dev/null
+++ b/include/linux/usb/xhci-sideband.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * xHCI host controller sideband support
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ *
+ * Author: Mathias Nyman <mathias.nyman@linux.intel.com>
+ */
+
+#ifndef __LINUX_XHCI_SIDEBAND_H
+#define __LINUX_XHCI_SIDEBAND_H
+
+#include <linux/scatterlist.h>
+#include <linux/usb.h>
+
+#define	EP_CTX_PER_DEV		31	/* FIMXME defined twice, from xhci.h */
+
+struct xhci_sideband;
+
+/**
+ * struct xhci_sideband - representation of a sideband accessed usb device.
+ * @xhci: The xhci host controller the usb device is connected to
+ * @vdev: the usb device accessed via sideband
+ * @eps: array of endpoints controlled via sideband
+ * @ir: event handling and buffer for sideband accessed device
+ *
+ * FIXME usb device accessed via sideband Keeping track of sideband accessed usb devices.
+ */
+
+struct xhci_sideband {
+	struct xhci_hcd                 *xhci;
+	struct xhci_virt_device         *vdev;
+	struct xhci_virt_ep             *eps[EP_CTX_PER_DEV];
+	struct xhci_interrupter         *ir;
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
+struct sg_table *
+xhci_sideband_get_endpoint_buffer(struct xhci_sideband *sb,
+				  struct usb_host_endpoint *host_ep);
+struct sg_table *
+xhci_sideband_get_event_buffer(struct xhci_sideband *sb);
+
+int
+xhci_sideband_create_interrupter(struct xhci_sideband *sb);
+
+void
+xhci_sideband_remove_interrupter(struct xhci_sideband *sb);
+
+int
+xhci_sideband_interrupter_id(struct xhci_sideband *sb);
+
+#endif /* __LINUX_XHCI_SIDEBAND_H */
+
