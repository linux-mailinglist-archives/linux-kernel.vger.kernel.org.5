Return-Path: <linux-kernel+bounces-8132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C318C81B277
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA761F25849
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724044F5E3;
	Thu, 21 Dec 2023 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jgJvYVOI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496D4EB36;
	Thu, 21 Dec 2023 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL6ILkW019367;
	Thu, 21 Dec 2023 01:29:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=mUfAn8NIuXuRNm9SbvSqDbWH2z8IYlh8EPrim0iIgtE=; b=jgJ
	vYVOIHiRzGLi9aPViRksRQraojAWkpAHThZRSpBWteX+h/u5v7HLiEp9i4GWLj72
	jAjIAH7GMy60XrbkHmgQtgNk3VudtGoPb8ZEDifnpI6fe+Q7vTur7ajkbSFYOuqc
	xSXjM54SN+pUPb2PX2Onr1t7HeChtvdc9N68QFZW+/07rcUjJlAXUNca2qijDpW1
	R287+Kv7AjzMYcLnbpoMngeRtSgSd5RaE9dtcKN3pg6NbJdiaHOLaZtc2uPIuVGo
	US8XW/BovugZSgqu00dIMATch7l+Jx82HN3BIjjT3km6SMP0jPCyuCwTzioV39EN
	+7HHcqczWYVvFXkS4tA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3v4fyr1480-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 01:29:52 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Dec
 2023 01:29:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 21 Dec 2023 01:29:50 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 3CD383F7048;
	Thu, 21 Dec 2023 01:29:50 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>
Subject: [PATCH net-next v1 6/8] octeon_ep_vf: add Tx/Rx processing and interrupt support
Date: Thu, 21 Dec 2023 01:28:42 -0800
Message-ID: <20231221092844.2885872-7-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221092844.2885872-1-srasheed@marvell.com>
References: <20231221092844.2885872-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ud-yzcJ05uf_cZ3N4DkYnQfmh3joDctZ
X-Proofpoint-ORIG-GUID: Ud-yzcJ05uf_cZ3N4DkYnQfmh3joDctZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Add support to enable MSI-x and register interrupts.
Add support to process Tx and Rx traffic. Includes processing
Tx completions and Rx refill.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../ethernet/marvell/octeon_ep_vf/Makefile    |   2 +-
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 544 ++++++++++++++++++
 .../marvell/octeon_ep_vf/octep_vf_mbox.c      |   2 +-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 247 ++++++++
 .../marvell/octeon_ep_vf/octep_vf_tx.c        |  72 +++
 5 files changed, 865 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/Makefile b/drivers/net/ethernet/marvell/octeon_ep_vf/Makefile
index 694eb9b46e99..46e87e1f4773 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/Makefile
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/Makefile
@@ -6,4 +6,4 @@
 obj-$(CONFIG_OCTEON_EP_VF) += octeon_ep_vf.o
 
 octeon_ep_vf-y := octep_vf_main.o octep_vf_cn9k.o octep_vf_cnxk.o \
-		  octep_vf_tx.o octep_vf_rx.o octep_vf_mbox.o
+		  octep_vf_tx.o octep_vf_rx.o
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index c29f99e8f121..e98ec8e8df9c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -37,6 +37,371 @@ MODULE_AUTHOR("Veerasenareddy Burru <vburru@marvell.com>");
 MODULE_DESCRIPTION(OCTEP_VF_DRV_STRING);
 MODULE_LICENSE("GPL");
 
+/**
+ * octep_vf_alloc_ioq_vectors() - Allocate Tx/Rx Queue interrupt info.
+ *
+ * @oct: Octeon device private data structure.
+ *
+ * Allocate resources to hold per Tx/Rx queue interrupt info.
+ * This is the information passed to interrupt handler, from which napi poll
+ * is scheduled and includes quick access to private data of Tx/Rx queue
+ * corresponding to the interrupt being handled.
+ *
+ * Return: 0, on successful allocation of resources for all queue interrupts.
+ *         -1, if failed to allocate any resource.
+ */
+static int octep_vf_alloc_ioq_vectors(struct octep_vf_device *oct)
+{
+	struct octep_vf_ioq_vector *ioq_vector;
+	int i;
+
+	for (i = 0; i < oct->num_oqs; i++) {
+		oct->ioq_vector[i] = vzalloc(sizeof(*oct->ioq_vector[i]));
+		if (!oct->ioq_vector[i])
+			goto free_ioq_vector;
+
+		ioq_vector = oct->ioq_vector[i];
+		ioq_vector->iq = oct->iq[i];
+		ioq_vector->oq = oct->oq[i];
+		ioq_vector->octep_vf_dev = oct;
+	}
+
+	dev_info(&oct->pdev->dev, "Allocated %d IOQ vectors\n", oct->num_oqs);
+	return 0;
+
+free_ioq_vector:
+	while (i) {
+		i--;
+		vfree(oct->ioq_vector[i]);
+		oct->ioq_vector[i] = NULL;
+	}
+	return -1;
+}
+
+/**
+ * octep_vf_free_ioq_vectors() - Free Tx/Rx Queue interrupt vector info.
+ *
+ * @oct: Octeon device private data structure.
+ */
+static void octep_vf_free_ioq_vectors(struct octep_vf_device *oct)
+{
+	int i;
+
+	for (i = 0; i < oct->num_oqs; i++) {
+		if (oct->ioq_vector[i]) {
+			vfree(oct->ioq_vector[i]);
+			oct->ioq_vector[i] = NULL;
+		}
+	}
+	netdev_info(oct->netdev, "Freed IOQ Vectors\n");
+}
+
+/**
+ * octep_vf_enable_msix_range() - enable MSI-x interrupts.
+ *
+ * @oct: Octeon device private data structure.
+ *
+ * Allocate and enable all MSI-x interrupts (queue and non-queue interrupts)
+ * for the Octeon device.
+ *
+ * Return: 0, on successfully enabling all MSI-x interrupts.
+ *         -1, if failed to enable any MSI-x interrupt.
+ */
+static int octep_vf_enable_msix_range(struct octep_vf_device *oct)
+{
+	int num_msix, msix_allocated;
+	int i;
+
+	/* Generic interrupts apart from input/output queues */
+	//num_msix = oct->num_oqs + CFG_GET_NON_IOQ_MSIX(oct->conf);
+	num_msix = oct->num_oqs;
+	oct->msix_entries = kcalloc(num_msix, sizeof(struct msix_entry), GFP_KERNEL);
+	if (!oct->msix_entries)
+		goto msix_alloc_err;
+
+	for (i = 0; i < num_msix; i++)
+		oct->msix_entries[i].entry = i;
+
+	msix_allocated = pci_enable_msix_range(oct->pdev, oct->msix_entries,
+					       num_msix, num_msix);
+	if (msix_allocated != num_msix) {
+		dev_err(&oct->pdev->dev,
+			"Failed to enable %d msix irqs; got only %d\n",
+			num_msix, msix_allocated);
+		goto enable_msix_err;
+	}
+	oct->num_irqs = msix_allocated;
+	dev_info(&oct->pdev->dev, "MSI-X enabled successfully\n");
+
+	return 0;
+
+enable_msix_err:
+	if (msix_allocated > 0)
+		pci_disable_msix(oct->pdev);
+	kfree(oct->msix_entries);
+	oct->msix_entries = NULL;
+msix_alloc_err:
+	return -1;
+}
+
+/**
+ * octep_vf_disable_msix() - disable MSI-x interrupts.
+ *
+ * @oct: Octeon device private data structure.
+ *
+ * Disable MSI-x on the Octeon device.
+ */
+static void octep_vf_disable_msix(struct octep_vf_device *oct)
+{
+	pci_disable_msix(oct->pdev);
+	kfree(oct->msix_entries);
+	oct->msix_entries = NULL;
+	dev_info(&oct->pdev->dev, "Disabled MSI-X\n");
+}
+
+/**
+ * octep_vf_ioq_intr_handler() - handler for all Tx/Rx queue interrupts.
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data contains pointers to Tx/Rx queue private data
+ *         and correspong NAPI context.
+ *
+ * this is common handler for all non-queue (generic) interrupts.
+ */
+static irqreturn_t octep_vf_ioq_intr_handler(int irq, void *data)
+{
+	struct octep_vf_ioq_vector *ioq_vector = data;
+	struct octep_vf_device *oct = ioq_vector->octep_vf_dev;
+
+	return oct->hw_ops.ioq_intr_handler(ioq_vector);
+}
+
+/**
+ * octep_vf_request_irqs() - Register interrupt handlers.
+ *
+ * @oct: Octeon device private data structure.
+ *
+ * Register handlers for all queue and non-queue interrupts.
+ *
+ * Return: 0, on successful registration of all interrupt handlers.
+ *         -1, on any error.
+ */
+static int octep_vf_request_irqs(struct octep_vf_device *oct)
+{
+	struct net_device *netdev = oct->netdev;
+	struct octep_vf_ioq_vector *ioq_vector;
+	struct msix_entry *msix_entry;
+	int ret, i;
+
+	/* Request IRQs for Tx/Rx queues */
+	for (i = 0; i < oct->num_oqs; i++) {
+		ioq_vector = oct->ioq_vector[i];
+		msix_entry = &oct->msix_entries[i];
+
+		snprintf(ioq_vector->name, sizeof(ioq_vector->name),
+			 "%s-q%d", netdev->name, i);
+		ret = request_irq(msix_entry->vector,
+				  octep_vf_ioq_intr_handler, 0,
+				  ioq_vector->name, ioq_vector);
+		if (ret) {
+			netdev_err(netdev,
+				   "request_irq failed for Q-%d; err=%d",
+				   i, ret);
+			goto ioq_irq_err;
+		}
+
+		cpumask_set_cpu(i % num_online_cpus(),
+				&ioq_vector->affinity_mask);
+		irq_set_affinity_hint(msix_entry->vector,
+				      &ioq_vector->affinity_mask);
+	}
+
+	return 0;
+ioq_irq_err:
+	while (i) {
+		--i;
+		free_irq(oct->msix_entries[i].vector, oct);
+	}
+	return -1;
+}
+
+/**
+ * octep_vf_free_irqs() - free all registered interrupts.
+ *
+ * @oct: Octeon device private data structure.
+ *
+ * Free all queue and non-queue interrupts of the Octeon device.
+ */
+static void octep_vf_free_irqs(struct octep_vf_device *oct)
+{
+	int i;
+
+	for (i = 0; i < oct->num_irqs; i++) {
+		irq_set_affinity_hint(oct->msix_entries[i].vector, NULL);
+		free_irq(oct->msix_entries[i].vector, oct->ioq_vector[i]);
+	}
+	netdev_info(oct->netdev, "IRQs freed\n");
+}
+
+/**
+ * octep_vf_setup_irqs() - setup interrupts for the Octeon device.
+ *
+ * @oct: Octeon device private data structure.
+ *
+ * Allocate data structures to hold per interrupt information, allocate/enable
+ * MSI-x interrupt and register interrupt handlers.
+ *
+ * Return: 0, on successful allocation and registration of all interrupts.
+ *         -1, on any error.
+ */
+static int octep_vf_setup_irqs(struct octep_vf_device *oct)
+{
+	if (octep_vf_alloc_ioq_vectors(oct))
+		goto ioq_vector_err;
+
+	if (octep_vf_enable_msix_range(oct))
+		goto enable_msix_err;
+
+	if (octep_vf_request_irqs(oct))
+		goto request_irq_err;
+
+	return 0;
+
+request_irq_err:
+	octep_vf_disable_msix(oct);
+enable_msix_err:
+	octep_vf_free_ioq_vectors(oct);
+ioq_vector_err:
+	return -1;
+}
+
+/**
+ * octep_vf_clean_irqs() - free all interrupts and its resources.
+ *
+ * @oct: Octeon device private data structure.
+ */
+static void octep_vf_clean_irqs(struct octep_vf_device *oct)
+{
+	octep_vf_free_irqs(oct);
+	octep_vf_disable_msix(oct);
+	octep_vf_free_ioq_vectors(oct);
+}
+
+/**
+ * octep_vf_enable_ioq_irq() - Enable MSI-x interrupt of a Tx/Rx queue.
+ *
+ * @iq: Octeon Tx queue data structure.
+ * @oq: Octeon Rx queue data structure.
+ */
+static void octep_vf_enable_ioq_irq(struct octep_vf_iq *iq, struct octep_vf_oq *oq)
+{
+	u32 pkts_pend = oq->pkts_pending;
+
+	netdev_dbg(iq->netdev, "enabling intr for Q-%u\n", iq->q_no);
+	if (iq->pkts_processed) {
+		writel(iq->pkts_processed, iq->inst_cnt_reg);
+		iq->pkt_in_done -= iq->pkts_processed;
+		iq->pkts_processed = 0;
+	}
+	if (oq->last_pkt_count - pkts_pend) {
+		writel(oq->last_pkt_count - pkts_pend, oq->pkts_sent_reg);
+		oq->last_pkt_count = pkts_pend;
+	}
+
+	/* Flush the previous wrties before writing to RESEND bit */
+	smp_wmb();
+	writeq(1UL << OCTEP_VF_OQ_INTR_RESEND_BIT, oq->pkts_sent_reg);
+	writeq(1UL << OCTEP_VF_IQ_INTR_RESEND_BIT, iq->inst_cnt_reg);
+}
+
+/**
+ * octep_vf_napi_poll() - NAPI poll function for Tx/Rx.
+ *
+ * @napi: pointer to napi context.
+ * @budget: max number of packets to be processed in single invocation.
+ */
+static int octep_vf_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct octep_vf_ioq_vector *ioq_vector =
+		container_of(napi, struct octep_vf_ioq_vector, napi);
+	u32 tx_pending, rx_done;
+
+	tx_pending = octep_vf_iq_process_completions(ioq_vector->iq, budget);
+	rx_done = octep_vf_oq_process_rx(ioq_vector->oq, budget);
+
+	/* need more polling if tx completion processing is still pending or
+	 * processed at least 'budget' number of rx packets.
+	 */
+	if (tx_pending || rx_done >= budget)
+		return budget;
+
+	napi_complete(napi);
+	octep_vf_enable_ioq_irq(ioq_vector->iq, ioq_vector->oq);
+	return rx_done;
+}
+
+/**
+ * octep_vf_napi_add() - Add NAPI poll for all Tx/Rx queues.
+ *
+ * @oct: Octeon device private data structure.
+ */
+static void octep_vf_napi_add(struct octep_vf_device *oct)
+{
+	int i;
+
+	for (i = 0; i < oct->num_oqs; i++) {
+		netdev_dbg(oct->netdev, "Adding NAPI on Q-%d\n", i);
+		netif_napi_add(oct->netdev, &oct->ioq_vector[i]->napi, octep_vf_napi_poll);
+		oct->oq[i]->napi = &oct->ioq_vector[i]->napi;
+	}
+}
+
+/**
+ * octep_vf_napi_delete() - delete NAPI poll callback for all Tx/Rx queues.
+ *
+ * @oct: Octeon device private data structure.
+ */
+static void octep_vf_napi_delete(struct octep_vf_device *oct)
+{
+	int i;
+
+	for (i = 0; i < oct->num_oqs; i++) {
+		netdev_dbg(oct->netdev, "Deleting NAPI on Q-%d\n", i);
+		netif_napi_del(&oct->ioq_vector[i]->napi);
+		oct->oq[i]->napi = NULL;
+	}
+}
+
+/**
+ * octep_vf_napi_enable() - enable NAPI for all Tx/Rx queues.
+ *
+ * @oct: Octeon device private data structure.
+ */
+static void octep_vf_napi_enable(struct octep_vf_device *oct)
+{
+	int i;
+
+	for (i = 0; i < oct->num_oqs; i++) {
+		netdev_dbg(oct->netdev, "Enabling NAPI on Q-%d\n", i);
+		napi_enable(&oct->ioq_vector[i]->napi);
+	}
+}
+
+/**
+ * octep_vf_napi_disable() - disable NAPI for all Tx/Rx queues.
+ *
+ * @oct: Octeon device private data structure.
+ */
+static void octep_vf_napi_disable(struct octep_vf_device *oct)
+{
+	int i;
+
+	for (i = 0; i < oct->num_oqs; i++) {
+		netdev_dbg(oct->netdev, "Disabling NAPI on Q-%d\n", i);
+		napi_disable(&oct->ioq_vector[i]->napi);
+	}
+}
+
 static void octep_vf_link_up(struct net_device *netdev)
 {
 	netif_carrier_on(netdev);
@@ -99,6 +464,8 @@ static int octep_vf_open(struct net_device *netdev)
 		goto setup_iq_err;
 	if (octep_vf_setup_oqs(oct))
 		goto setup_oq_err;
+	if (octep_vf_setup_irqs(oct))
+		goto setup_irq_err;
 
 	err = netif_set_real_num_tx_queues(netdev, oct->num_oqs);
 	if (err)
@@ -107,6 +474,9 @@ static int octep_vf_open(struct net_device *netdev)
 	if (err)
 		goto set_queues_err;
 
+	octep_vf_napi_add(oct);
+	octep_vf_napi_enable(oct);
+
 	oct->link_info.admin_up = 1;
 	octep_vf_set_rx_state(oct, true);
 
@@ -129,6 +499,10 @@ static int octep_vf_open(struct net_device *netdev)
 	return 0;
 
 set_queues_err:
+	octep_vf_napi_disable(oct);
+	octep_vf_napi_delete(oct);
+	octep_vf_clean_irqs(oct);
+setup_irq_err:
 	octep_vf_free_oqs(oct);
 setup_oq_err:
 	octep_vf_free_iqs(oct);
@@ -162,7 +536,10 @@ static int octep_vf_stop(struct net_device *netdev)
 	oct->link_info.oper_up = 0;
 
 	oct->hw_ops.disable_interrupts(oct);
+	octep_vf_napi_disable(oct);
+	octep_vf_napi_delete(oct);
 
+	octep_vf_clean_irqs(oct);
 	octep_vf_clean_iqs(oct);
 
 	oct->hw_ops.disable_io_queues(oct);
@@ -173,6 +550,36 @@ static int octep_vf_stop(struct net_device *netdev)
 	return 0;
 }
 
+/**
+ * octep_vf_iq_full_check() - check if a Tx queue is full.
+ *
+ * @iq: Octeon Tx queue data structure.
+ *
+ * Return: 0, if the Tx queue is not full.
+ *         1, if the Tx queue is full.
+ */
+static int octep_vf_iq_full_check(struct octep_vf_iq *iq)
+{
+	if (likely((IQ_INSTR_SPACE(iq)) >
+		   OCTEP_VF_WAKE_QUEUE_THRESHOLD))
+		return 0;
+
+	/* Stop the queue if unable to send */
+	netif_stop_subqueue(iq->netdev, iq->q_no);
+
+	/* check again and restart the queue, in case NAPI has just freed
+	 * enough Tx ring entries.
+	 */
+	if (unlikely(IQ_INSTR_SPACE(iq) >
+		     OCTEP_VF_WAKE_QUEUE_THRESHOLD)) {
+		netif_start_subqueue(iq->netdev, iq->q_no);
+		iq->stats.restart_cnt++;
+		return 0;
+	}
+
+	return 1;
+}
+
 /**
  * octep_vf_start_xmit() - Enqueue packet to Octoen hardware Tx Queue.
  *
@@ -185,6 +592,143 @@ static int octep_vf_stop(struct net_device *netdev)
 static netdev_tx_t octep_vf_start_xmit(struct sk_buff *skb,
 				       struct net_device *netdev)
 {
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	netdev_features_t feat  = netdev->features;
+	struct octep_vf_tx_sglist_desc *sglist;
+	struct octep_vf_tx_buffer *tx_buffer;
+	struct octep_vf_tx_desc_hw *hw_desc;
+	struct skb_shared_info *shinfo;
+	struct octep_vf_instr_hdr *ih;
+	struct octep_vf_iq *iq;
+	skb_frag_t *frag;
+	u16 nr_frags, si;
+	int xmit_more;
+	u16 q_no, wi;
+
+	if (skb_put_padto(skb, ETH_ZLEN))
+		return NETDEV_TX_OK;
+
+	q_no = skb_get_queue_mapping(skb);
+	if (q_no >= oct->num_iqs) {
+		netdev_err(netdev, "Invalid Tx skb->queue_mapping=%d\n", q_no);
+		q_no = q_no % oct->num_iqs;
+	}
+
+	iq = oct->iq[q_no];
+	if (octep_vf_iq_full_check(iq)) {
+		iq->stats.tx_busy++;
+		return NETDEV_TX_BUSY;
+	}
+
+	shinfo = skb_shinfo(skb);
+	nr_frags = shinfo->nr_frags;
+
+	wi = iq->host_write_index;
+	hw_desc = &iq->desc_ring[wi];
+	hw_desc->ih64 = 0;
+
+	tx_buffer = iq->buff_info + wi;
+	tx_buffer->skb = skb;
+
+	ih = &hw_desc->ih;
+	ih->tlen = skb->len;
+	ih->pkind = oct->fw_info.pkind;
+	ih->fsz = oct->fw_info.fsz;
+	ih->tlen = skb->len + ih->fsz;
+
+	if (!nr_frags) {
+		tx_buffer->gather = 0;
+		tx_buffer->dma = dma_map_single(iq->dev, skb->data,
+						skb->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(iq->dev, tx_buffer->dma))
+			goto dma_map_err;
+		hw_desc->dptr = tx_buffer->dma;
+	} else {
+		/* Scatter/Gather */
+		dma_addr_t dma;
+		u16 len;
+
+		sglist = tx_buffer->sglist;
+
+		ih->gsz = nr_frags + 1;
+		ih->gather = 1;
+		tx_buffer->gather = 1;
+
+		len = skb_headlen(skb);
+		dma = dma_map_single(iq->dev, skb->data, len, DMA_TO_DEVICE);
+		if (dma_mapping_error(iq->dev, dma))
+			goto dma_map_err;
+
+		memset(sglist, 0, OCTEP_VF_SGLIST_SIZE_PER_PKT);
+		sglist[0].len[3] = len;
+		sglist[0].dma_ptr[0] = dma;
+
+		si = 1; /* entry 0 is main skb, mapped above */
+		frag = &shinfo->frags[0];
+		while (nr_frags--) {
+			len = skb_frag_size(frag);
+			dma = skb_frag_dma_map(iq->dev, frag, 0,
+					       len, DMA_TO_DEVICE);
+			if (dma_mapping_error(iq->dev, dma))
+				goto dma_map_sg_err;
+
+			sglist[si >> 2].len[3 - (si & 3)] = len;
+			sglist[si >> 2].dma_ptr[si & 3] = dma;
+
+			frag++;
+			si++;
+		}
+		hw_desc->dptr = tx_buffer->sglist_dma;
+	}
+	if (oct->fw_info.tx_ol_flags) {
+		if ((feat & (NETIF_F_TSO)) && (skb_is_gso(skb))) {
+			hw_desc->txm.ol_flags = OCTEP_VF_TX_OFFLOAD_CKSUM;
+			hw_desc->txm.ol_flags |= OCTEP_VF_TX_OFFLOAD_TSO;
+			hw_desc->txm.gso_size =  skb_shinfo(skb)->gso_size;
+			hw_desc->txm.gso_segs =  skb_shinfo(skb)->gso_segs;
+		} else if (feat & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
+			hw_desc->txm.ol_flags = OCTEP_VF_TX_OFFLOAD_CKSUM;
+		}
+		/* due to ESR txm will be swappeed by hw */
+		hw_desc->txm64[0] = (__force u64)cpu_to_be64(hw_desc->txm64[0]);
+	}
+
+	netdev_tx_sent_queue(iq->netdev_q, skb->len);
+
+	xmit_more = netdev_xmit_more();
+
+	skb_tx_timestamp(skb);
+	iq->fill_cnt++;
+	wi++;
+	iq->host_write_index = wi & iq->ring_size_mask;
+	if (xmit_more &&
+	    (IQ_INSTR_PENDING(iq) <
+	     (iq->max_count - OCTEP_VF_WAKE_QUEUE_THRESHOLD)) &&
+	    iq->fill_cnt < iq->fill_threshold)
+		return NETDEV_TX_OK;
+
+	/* Flush the hw descriptors before writing to doorbell */
+	smp_wmb();
+	writel(iq->fill_cnt, iq->doorbell_reg);
+	iq->stats.instr_posted += iq->fill_cnt;
+	iq->fill_cnt = 0;
+	return NETDEV_TX_OK;
+
+dma_map_sg_err:
+	if (si > 0) {
+		dma_unmap_single(iq->dev, sglist[0].dma_ptr[0],
+				 sglist[0].len[0], DMA_TO_DEVICE);
+		sglist[0].len[0] = 0;
+	}
+	while (si > 1) {
+		dma_unmap_page(iq->dev, sglist[si >> 2].dma_ptr[si & 3],
+			       sglist[si >> 2].len[si & 3], DMA_TO_DEVICE);
+		sglist[si >> 2].len[si & 3] = 0;
+		si--;
+	}
+	tx_buffer->gather = 0;
+dma_map_err:
+	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
index 594bee15bd36..2eab21e43048 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
@@ -114,7 +114,7 @@ static int __octep_vf_mbox_send_cmd(struct octep_vf_device *oct,
 {
 	struct octep_vf_mbox *mbox = oct->mbox;
 	u64 reg_val = 0ull;
-	int count = 0;
+	int count;
 
 	if (!mbox)
 		return OCTEP_PFVF_MBOX_CMD_STATUS_NOT_SETUP;
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index 54e6935c6ee8..d618cce6a910 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -68,6 +68,50 @@ static int octep_vf_oq_fill_ring_buffers(struct octep_vf_oq *oq)
 	return -1;
 }
 
+/**
+ * octep_vf_oq_refill() - refill buffers for used Rx ring descriptors.
+ *
+ * @oct: Octeon device private data structure.
+ * @oq: Octeon Rx queue data structure.
+ *
+ * Return: number of descriptors successfully refilled with receive buffers.
+ */
+static int octep_vf_oq_refill(struct octep_vf_device *oct, struct octep_vf_oq *oq)
+{
+	struct octep_vf_oq_desc_hw *desc_ring = oq->desc_ring;
+	struct page *page;
+	u32 refill_idx, i;
+
+	refill_idx = oq->host_refill_idx;
+	for (i = 0; i < oq->refill_count; i++) {
+		page = dev_alloc_page();
+		if (unlikely(!page)) {
+			dev_err(oq->dev, "refill: rx buffer alloc failed\n");
+			oq->stats.alloc_failures++;
+			break;
+		}
+
+		desc_ring[refill_idx].buffer_ptr = dma_map_page(oq->dev, page, 0,
+								PAGE_SIZE, DMA_FROM_DEVICE);
+		if (dma_mapping_error(oq->dev, desc_ring[refill_idx].buffer_ptr)) {
+			dev_err(oq->dev,
+				"OQ-%d buffer refill: DMA mapping error!\n",
+				oq->q_no);
+			put_page(page);
+			oq->stats.alloc_failures++;
+			break;
+		}
+		oq->buff_info[refill_idx].page = page;
+		refill_idx++;
+		if (refill_idx == oq->max_count)
+			refill_idx = 0;
+	}
+	oq->host_refill_idx = refill_idx;
+	oq->refill_count -= i;
+
+	return i;
+}
+
 /**
  * octep_vf_setup_oq() - Setup a Rx queue.
  *
@@ -262,3 +306,206 @@ void octep_vf_free_oqs(struct octep_vf_device *oct)
 			"Successfully freed OQ(RxQ)-%d.\n", i);
 	}
 }
+
+/**
+ * octep_vf_oq_check_hw_for_pkts() - Check for new Rx packets.
+ *
+ * @oct: Octeon device private data structure.
+ * @oq: Octeon Rx queue data structure.
+ *
+ * Return: packets received after previous check.
+ */
+static int octep_vf_oq_check_hw_for_pkts(struct octep_vf_device *oct,
+					 struct octep_vf_oq *oq)
+{
+	u32 pkt_count, new_pkts;
+
+	pkt_count = readl(oq->pkts_sent_reg);
+	new_pkts = pkt_count - oq->last_pkt_count;
+
+	/* Clear the hardware packets counter register if the rx queue is
+	 * being processed continuously with-in a single interrupt and
+	 * reached half its max value.
+	 * this counter is not cleared every time read, to save write cycles.
+	 */
+	if (unlikely(pkt_count > 0xF0000000U)) {
+		writel(pkt_count, oq->pkts_sent_reg);
+		pkt_count = readl(oq->pkts_sent_reg);
+		new_pkts += pkt_count;
+	}
+	oq->last_pkt_count = pkt_count;
+	oq->pkts_pending += new_pkts;
+	return new_pkts;
+}
+
+/**
+ * __octep_vf_oq_process_rx() - Process hardware Rx queue and push to stack.
+ *
+ * @oct: Octeon device private data structure.
+ * @oq: Octeon Rx queue data structure.
+ * @pkts_to_process: number of packets to be processed.
+ *
+ * Process the new packets in Rx queue.
+ * Packets larger than single Rx buffer arrive in consecutive descriptors.
+ * But, count returned by the API only accounts full packets, not fragments.
+ *
+ * Return: number of packets processed and pushed to stack.
+ */
+static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
+				    struct octep_vf_oq *oq, u16 pkts_to_process)
+{
+	struct octep_vf_oq_resp_hw_ext *resp_hw_ext = NULL;
+	netdev_features_t feat = oq->netdev->features;
+	struct octep_vf_rx_buffer *buff_info;
+	struct octep_vf_oq_resp_hw *resp_hw;
+	u32 pkt, rx_bytes, desc_used;
+	u16 data_offset, rx_ol_flags;
+	struct sk_buff *skb;
+	u32 read_idx;
+
+	read_idx = oq->host_read_idx;
+	rx_bytes = 0;
+	desc_used = 0;
+	for (pkt = 0; pkt < pkts_to_process; pkt++) {
+		buff_info = (struct octep_vf_rx_buffer *)&oq->buff_info[read_idx];
+		dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
+			       PAGE_SIZE, DMA_FROM_DEVICE);
+		resp_hw = page_address(buff_info->page);
+		buff_info->page = NULL;
+
+		/* Swap the length field that is in Big-Endian to CPU */
+		buff_info->len = be64_to_cpu(resp_hw->length);
+		if (oct->fw_info.rx_ol_flags) {
+			/* Extended response header is immediately after
+			 * response header (resp_hw)
+			 */
+			resp_hw_ext = (struct octep_vf_oq_resp_hw_ext *)
+				      (resp_hw + 1);
+			buff_info->len -= OCTEP_VF_OQ_RESP_HW_EXT_SIZE;
+			/* Packet Data is immediately after
+			 * extended response header.
+			 */
+			data_offset = OCTEP_VF_OQ_RESP_HW_SIZE +
+				      OCTEP_VF_OQ_RESP_HW_EXT_SIZE;
+			rx_ol_flags = resp_hw_ext->rx_ol_flags;
+		} else {
+			/* Data is immediately after
+			 * Hardware Rx response header.
+			 */
+			data_offset = OCTEP_VF_OQ_RESP_HW_SIZE;
+			rx_ol_flags = 0;
+		}
+		rx_bytes += buff_info->len;
+
+		if (buff_info->len <= oq->max_single_buffer_size) {
+			skb = build_skb((void *)resp_hw, PAGE_SIZE);
+			skb_reserve(skb, data_offset);
+			skb_put(skb, buff_info->len);
+			read_idx++;
+			desc_used++;
+			if (read_idx == oq->max_count)
+				read_idx = 0;
+		} else {
+			struct skb_shared_info *shinfo;
+			u16 data_len;
+
+			skb = build_skb((void *)resp_hw, PAGE_SIZE);
+			skb_reserve(skb, data_offset);
+			/* Head fragment includes response header(s);
+			 * subsequent fragments contains only data.
+			 */
+			skb_put(skb, oq->max_single_buffer_size);
+			read_idx++;
+			desc_used++;
+			if (read_idx == oq->max_count)
+				read_idx = 0;
+
+			shinfo = skb_shinfo(skb);
+			data_len = buff_info->len - oq->max_single_buffer_size;
+			while (data_len) {
+				dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
+				buff_info = (struct octep_vf_rx_buffer *)
+					    &oq->buff_info[read_idx];
+				if (data_len < oq->buffer_size) {
+					buff_info->len = data_len;
+					data_len = 0;
+				} else {
+					buff_info->len = oq->buffer_size;
+					data_len -= oq->buffer_size;
+				}
+
+				skb_add_rx_frag(skb, shinfo->nr_frags,
+						buff_info->page, 0,
+						buff_info->len,
+						buff_info->len);
+				buff_info->page = NULL;
+				read_idx++;
+				desc_used++;
+				if (read_idx == oq->max_count)
+					read_idx = 0;
+			}
+		}
+
+		skb->dev = oq->netdev;
+		skb->protocol =  eth_type_trans(skb, skb->dev);
+		if (feat & NETIF_F_RXCSUM &&
+		    OCTEP_VF_RX_CSUM_VERIFIED(rx_ol_flags))
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		else
+			skb->ip_summed = CHECKSUM_NONE;
+		napi_gro_receive(oq->napi, skb);
+	}
+
+	oq->host_read_idx = read_idx;
+	oq->refill_count += desc_used;
+	oq->stats.packets += pkt;
+	oq->stats.bytes += rx_bytes;
+
+	return pkt;
+}
+
+/**
+ * octep_vf_oq_process_rx() - Process Rx queue.
+ *
+ * @oq: Octeon Rx queue data structure.
+ * @budget: max number of packets can be processed in one invocation.
+ *
+ * Check for newly received packets and process them.
+ * Keeps checking for new packets until budget is used or no new packets seen.
+ *
+ * Return: number of packets processed.
+ */
+int octep_vf_oq_process_rx(struct octep_vf_oq *oq, int budget)
+{
+	u32 pkts_available, pkts_processed, total_pkts_processed;
+	struct octep_vf_device *oct = oq->octep_vf_dev;
+
+	pkts_available = 0;
+	pkts_processed = 0;
+	total_pkts_processed = 0;
+	while (total_pkts_processed < budget) {
+		 /* update pending count only when current one exhausted */
+		if (oq->pkts_pending == 0)
+			octep_vf_oq_check_hw_for_pkts(oct, oq);
+		pkts_available = min(budget - total_pkts_processed,
+				     oq->pkts_pending);
+		if (!pkts_available)
+			break;
+
+		pkts_processed = __octep_vf_oq_process_rx(oct, oq,
+							  pkts_available);
+		oq->pkts_pending -= pkts_processed;
+		total_pkts_processed += pkts_processed;
+	}
+
+	if (oq->refill_count >= oq->refill_threshold) {
+		u32 desc_refilled = octep_vf_oq_refill(oct, oq);
+
+		/* flush pending writes before updating credits */
+		smp_wmb();
+		writel(desc_refilled, oq->pkts_credit_reg);
+	}
+
+	return total_pkts_processed;
+}
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
index 787132ffd708..bfb1449f30d4 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
@@ -23,6 +23,78 @@ static void octep_vf_iq_reset_indices(struct octep_vf_iq *iq)
 	iq->pkt_in_done = 0;
 }
 
+/**
+ * octep_vf_iq_process_completions() - Process Tx queue completions.
+ *
+ * @iq: Octeon Tx queue data structure.
+ * @budget: max number of completions to be processed in one invocation.
+ */
+int octep_vf_iq_process_completions(struct octep_vf_iq *iq, u16 budget)
+{
+	u32 compl_pkts, compl_bytes, compl_sg;
+	struct octep_vf_device *oct = iq->octep_vf_dev;
+	struct octep_vf_tx_buffer *tx_buffer;
+	struct skb_shared_info *shinfo;
+	u32 fi = iq->flush_index;
+	struct sk_buff *skb;
+	u8 frags, i;
+
+	compl_pkts = 0;
+	compl_sg = 0;
+	compl_bytes = 0;
+	iq->octep_vf_read_index = oct->hw_ops.update_iq_read_idx(iq);
+
+	while (likely(budget && (fi != iq->octep_vf_read_index))) {
+		tx_buffer = iq->buff_info + fi;
+		skb = tx_buffer->skb;
+
+		fi++;
+		if (unlikely(fi == iq->max_count))
+			fi = 0;
+		compl_bytes += skb->len;
+		compl_pkts++;
+		budget--;
+
+		if (!tx_buffer->gather) {
+			dma_unmap_single(iq->dev, tx_buffer->dma,
+					 tx_buffer->skb->len, DMA_TO_DEVICE);
+			dev_kfree_skb_any(skb);
+			continue;
+		}
+
+		/* Scatter/Gather */
+		shinfo = skb_shinfo(skb);
+		frags = shinfo->nr_frags;
+		compl_sg++;
+
+		dma_unmap_single(iq->dev, tx_buffer->sglist[0].dma_ptr[0],
+				 tx_buffer->sglist[0].len[3], DMA_TO_DEVICE);
+
+		i = 1; /* entry 0 is main skb, unmapped above */
+		while (frags--) {
+			dma_unmap_page(iq->dev, tx_buffer->sglist[i >> 2].dma_ptr[i & 3],
+				       tx_buffer->sglist[i >> 2].len[3 - (i & 3)], DMA_TO_DEVICE);
+			i++;
+		}
+
+		dev_kfree_skb_any(skb);
+	}
+
+	iq->pkts_processed += compl_pkts;
+	iq->stats.instr_completed += compl_pkts;
+	iq->stats.bytes_sent += compl_bytes;
+	iq->stats.sgentry_sent += compl_sg;
+	iq->flush_index = fi;
+
+	netdev_tx_completed_queue(iq->netdev_q, compl_pkts, compl_bytes);
+
+	if (unlikely(__netif_subqueue_stopped(iq->netdev, iq->q_no)) &&
+	    (IQ_INSTR_SPACE(iq) >
+	     OCTEP_VF_WAKE_QUEUE_THRESHOLD))
+		netif_wake_subqueue(iq->netdev, iq->q_no);
+	return !budget;
+}
+
 /**
  * octep_vf_iq_free_pending() - Free Tx buffers for pending completions.
  *
-- 
2.25.1


