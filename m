Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98A755C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjGQGzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGQGzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:55:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4C170A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:55:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6686c74183cso4262873b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689576919; x=1692168919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjtjOezI/tJCSlnQI9LmJZKtZfC531WE24MAnZrZ1ew=;
        b=DwtVNkdhmkQfgM/0GPujCvSZ/8i2A7UkYKN5NNNFSs6fzjfTx8nVe0CcindieQcJYE
         29UHAFL1tKAIuK3tXbi8THx4HzmyCKaoJfoNK1zquw/0MhL73VULrydxaXFc4Jx2ecc7
         0QzrYDHJCOm5kupiX1Gf1teg+q4lqN/tvU5XwYG6ZXJPBHvPuuggx1t5/cQ1mw6KNXqH
         dlxVIEQfVIB0NxMhKgStrOkIMWG3AllBi/PcRNJHZdXgUeW+DSjfTrFXLFaLJo+2QmJA
         Q+lCIKXVox/OGeGtul7Kae6WuAVGWY8GyNmvLQxZwi1cLpysWtcUH+Dz2gBEDCvKXVK2
         8SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689576919; x=1692168919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjtjOezI/tJCSlnQI9LmJZKtZfC531WE24MAnZrZ1ew=;
        b=OJFde0H/wjZoWYoiHNbJUU6I7MFVx9G3HtWxDlqr/fOELCUk8UW6rnMww0O/fw8sNs
         JJzhtYaYhmmom+q1470YnIS8QPy4mMAD30C8CZZBdG0U6fuEsDzg5EhtYevgCi1UZ2AT
         euej/6h3fXq7OBh57eFuHMDW14Ln/Gj+r0EazYM+iQRY6HHlEIRbhWPhKWjRzyPU44PF
         WC0ce6h4dWOb/73j7eXRVvBGSBWfdYl3QUm3fpEDQQlU6oEuiBku8NIiavAcOKpQkc4F
         EkAfh8msyJPzBSW4bOf9wLVrbzb6sEgQBAwRdBe2Lm1XqXWgPR03aWkNM+Q7XTnDuMPe
         9Ocw==
X-Gm-Message-State: ABy/qLZOzF4bUgtLNmr3vLLIsZpbDfQcG/NQkTmRiEXlmqn9EXByCoVT
        eWDQb03KEzp+PeZcbe6Shpeh
X-Google-Smtp-Source: APBJJlGRESHmMDN6JiG0d3oLqzLrSISuG61WXvHrIsqR2rnHvadyLPpKSNNmcxpE65jnDxhmsXVYFg==
X-Received: by 2002:a05:6a00:1951:b0:668:731b:517e with SMTP id s17-20020a056a00195100b00668731b517emr14299584pfk.24.1689576919541;
        Sun, 16 Jul 2023 23:55:19 -0700 (PDT)
Received: from localhost.localdomain ([117.193.215.209])
        by smtp.gmail.com with ESMTPSA id x7-20020a62fb07000000b006675c242548sm11196422pfm.182.2023.07.16.23.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:55:19 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/7] PCI: epf-mhi: Add eDMA support
Date:   Mon, 17 Jul 2023 12:24:56 +0530
Message-Id: <20230717065459.14138-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717065459.14138-1-manivannan.sadhasivam@linaro.org>
References: <20230717065459.14138-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Embedded DMA (eDMA) available in the Designware PCIe IP to
transfer the MHI buffers between host and the endpoint. Use of eDMA helps
in achieving greater throughput as the transfers are offloaded from CPUs.

For differentiating the iATU and eDMA APIs, the pci_epf_mhi_{read/write}
APIs are renamed to pci_epf_mhi_iatu_{read/write} and separate eDMA
specific APIs pci_epf_mhi_edma_{read/write} are introduced.

Platforms that require eDMA support can pass the MHI_EPF_USE_DMA flag
through pci_epf_mhi_ep_info.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 237 ++++++++++++++++++-
 1 file changed, 231 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index bb7de6884824..abebe44d0061 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -6,8 +6,10 @@
  * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  */
 
+#include <linux/dmaengine.h>
 #include <linux/mhi_ep.h>
 #include <linux/module.h>
+#include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
@@ -16,6 +18,9 @@
 
 #define to_epf_mhi(cntrl) container_of(cntrl, struct pci_epf_mhi, cntrl)
 
+/* Platform specific flags */
+#define MHI_EPF_USE_DMA BIT(0)
+
 struct pci_epf_mhi_ep_info {
 	const struct mhi_ep_cntrl_config *config;
 	struct pci_epf_header *epf_header;
@@ -23,6 +28,7 @@ struct pci_epf_mhi_ep_info {
 	u32 epf_flags;
 	u32 msi_count;
 	u32 mru;
+	u32 flags;
 };
 
 #define MHI_EP_CHANNEL_CONFIG(ch_num, ch_name, direction)	\
@@ -98,6 +104,8 @@ struct pci_epf_mhi {
 	struct mutex lock;
 	void __iomem *mmio;
 	resource_size_t mmio_phys;
+	struct dma_chan *dma_chan_tx;
+	struct dma_chan *dma_chan_rx;
 	u32 mmio_size;
 	int irq;
 };
@@ -186,8 +194,8 @@ static void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
 			  vector + 1);
 }
 
-static int pci_epf_mhi_read_from_host(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
-				      void *to, size_t size)
+static int pci_epf_mhi_iatu_read(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
+				 void *to, size_t size)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
 	struct pci_epc *epc = epf_mhi->epf->epc;
@@ -215,8 +223,8 @@ static int pci_epf_mhi_read_from_host(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
 	return 0;
 }
 
-static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
-				     void *from, u64 to, size_t size)
+static int pci_epf_mhi_iatu_write(struct mhi_ep_cntrl *mhi_cntrl,
+				  void *from, u64 to, size_t size)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
 	struct pci_epc *epc = epf_mhi->epf->epc;
@@ -244,6 +252,200 @@ static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
 	return 0;
 }
 
+static void pci_epf_mhi_dma_callback(void *param)
+{
+	complete(param);
+}
+
+static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
+				 void *to, size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
+	struct dma_chan *chan = epf_mhi->dma_chan_rx;
+	struct device *dev = &epf_mhi->epf->dev;
+	DECLARE_COMPLETION_ONSTACK(complete);
+	struct dma_async_tx_descriptor *desc;
+	struct dma_slave_config config = {};
+	dma_cookie_t cookie;
+	dma_addr_t dst_addr;
+	int ret;
+
+	mutex_lock(&epf_mhi->lock);
+
+	config.direction = DMA_DEV_TO_MEM;
+	config.src_addr = from;
+
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret) {
+		dev_err(dev, "Failed to configure DMA channel\n");
+		goto err_unlock;
+	}
+
+	dst_addr = dma_map_single(dma_dev, to, size, DMA_FROM_DEVICE);
+	ret = dma_mapping_error(dma_dev, dst_addr);
+	if (ret) {
+		dev_err(dev, "Failed to map remote memory\n");
+		goto err_unlock;
+	}
+
+	desc = dmaengine_prep_slave_single(chan, dst_addr, size, DMA_DEV_TO_MEM,
+					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dev, "Failed to prepare DMA\n");
+		ret = -EIO;
+		goto err_unmap;
+	}
+
+	desc->callback = pci_epf_mhi_dma_callback;
+	desc->callback_param = &complete;
+
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(dev, "Failed to do DMA submit\n");
+		goto err_unmap;
+	}
+
+	dma_async_issue_pending(chan);
+	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
+	if (!ret) {
+		dev_err(dev, "DMA transfer timeout\n");
+		dmaengine_terminate_sync(chan);
+		ret = -ETIMEDOUT;
+	}
+
+err_unmap:
+	dma_unmap_single(dma_dev, dst_addr, size, DMA_FROM_DEVICE);
+err_unlock:
+	mutex_unlock(&epf_mhi->lock);
+
+	return ret;
+}
+
+static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl, void *from,
+				  u64 to, size_t size)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
+	struct dma_chan *chan = epf_mhi->dma_chan_tx;
+	struct device *dev = &epf_mhi->epf->dev;
+	DECLARE_COMPLETION_ONSTACK(complete);
+	struct dma_async_tx_descriptor *desc;
+	struct dma_slave_config config = {};
+	dma_cookie_t cookie;
+	dma_addr_t src_addr;
+	int ret;
+
+	mutex_lock(&epf_mhi->lock);
+
+	config.direction = DMA_MEM_TO_DEV;
+	config.dst_addr = to;
+
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret) {
+		dev_err(dev, "Failed to configure DMA channel\n");
+		goto err_unlock;
+	}
+
+	src_addr = dma_map_single(dma_dev, from, size, DMA_TO_DEVICE);
+	ret = dma_mapping_error(dma_dev, src_addr);
+	if (ret) {
+		dev_err(dev, "Failed to map remote memory\n");
+		goto err_unlock;
+	}
+
+	desc = dmaengine_prep_slave_single(chan, src_addr, size, DMA_MEM_TO_DEV,
+					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dev, "Failed to prepare DMA\n");
+		ret = -EIO;
+		goto err_unmap;
+	}
+
+	desc->callback = pci_epf_mhi_dma_callback;
+	desc->callback_param = &complete;
+
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(dev, "Failed to do DMA submit\n");
+		goto err_unmap;
+	}
+
+	dma_async_issue_pending(chan);
+	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
+	if (!ret) {
+		dev_err(dev, "DMA transfer timeout\n");
+		dmaengine_terminate_sync(chan);
+		ret = -ETIMEDOUT;
+	}
+
+err_unmap:
+	dma_unmap_single(dma_dev, src_addr, size, DMA_FROM_DEVICE);
+err_unlock:
+	mutex_unlock(&epf_mhi->lock);
+
+	return ret;
+}
+
+struct epf_dma_filter {
+	struct device *dev;
+	u32 dma_mask;
+};
+
+static bool pci_epf_mhi_filter(struct dma_chan *chan, void *node)
+{
+	struct epf_dma_filter *filter = node;
+	struct dma_slave_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	dma_get_slave_caps(chan, &caps);
+
+	return chan->device->dev == filter->dev && filter->dma_mask &
+					caps.directions;
+}
+
+static int pci_epf_mhi_dma_init(struct pci_epf_mhi *epf_mhi)
+{
+	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
+	struct device *dev = &epf_mhi->epf->dev;
+	struct epf_dma_filter filter;
+	dma_cap_mask_t mask;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	filter.dev = dma_dev;
+	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
+	epf_mhi->dma_chan_tx = dma_request_channel(mask, pci_epf_mhi_filter,
+						   &filter);
+	if (IS_ERR_OR_NULL(epf_mhi->dma_chan_tx)) {
+		dev_err(dev, "Failed to request tx channel\n");
+		return -ENODEV;
+	}
+
+	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
+	epf_mhi->dma_chan_rx = dma_request_channel(mask, pci_epf_mhi_filter,
+						   &filter);
+	if (IS_ERR_OR_NULL(epf_mhi->dma_chan_rx)) {
+		dev_err(dev, "Failed to request rx channel\n");
+		dma_release_channel(epf_mhi->dma_chan_tx);
+		epf_mhi->dma_chan_tx = NULL;
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
+{
+	dma_release_channel(epf_mhi->dma_chan_tx);
+	dma_release_channel(epf_mhi->dma_chan_rx);
+	epf_mhi->dma_chan_tx = NULL;
+	epf_mhi->dma_chan_rx = NULL;
+}
+
 static int pci_epf_mhi_core_init(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
@@ -289,6 +491,14 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	struct device *dev = &epf->dev;
 	int ret;
 
+	if (info->flags & MHI_EPF_USE_DMA) {
+		ret = pci_epf_mhi_dma_init(epf_mhi);
+		if (ret) {
+			dev_err(dev, "Failed to initialize DMA: %d\n", ret);
+			return ret;
+		}
+	}
+
 	mhi_cntrl->mmio = epf_mhi->mmio;
 	mhi_cntrl->irq = epf_mhi->irq;
 	mhi_cntrl->mru = info->mru;
@@ -298,13 +508,20 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
 	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
 	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
-	mhi_cntrl->read_from_host = pci_epf_mhi_read_from_host;
-	mhi_cntrl->write_to_host = pci_epf_mhi_write_to_host;
+	if (info->flags & MHI_EPF_USE_DMA) {
+		mhi_cntrl->read_from_host = pci_epf_mhi_edma_read;
+		mhi_cntrl->write_to_host = pci_epf_mhi_edma_write;
+	} else {
+		mhi_cntrl->read_from_host = pci_epf_mhi_iatu_read;
+		mhi_cntrl->write_to_host = pci_epf_mhi_iatu_write;
+	}
 
 	/* Register the MHI EP controller */
 	ret = mhi_ep_register_controller(mhi_cntrl, info->config);
 	if (ret) {
 		dev_err(dev, "Failed to register MHI EP controller: %d\n", ret);
+		if (info->flags & MHI_EPF_USE_DMA)
+			pci_epf_mhi_dma_deinit(epf_mhi);
 		return ret;
 	}
 
@@ -314,10 +531,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 static int pci_epf_mhi_link_down(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
 	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
 
 	if (mhi_cntrl->mhi_dev) {
 		mhi_ep_power_down(mhi_cntrl);
+		if (info->flags & MHI_EPF_USE_DMA)
+			pci_epf_mhi_dma_deinit(epf_mhi);
 		mhi_ep_unregister_controller(mhi_cntrl);
 	}
 
@@ -327,6 +547,7 @@ static int pci_epf_mhi_link_down(struct pci_epf *epf)
 static int pci_epf_mhi_bme(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
 	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
 	struct device *dev = &epf->dev;
 	int ret;
@@ -339,6 +560,8 @@ static int pci_epf_mhi_bme(struct pci_epf *epf)
 		ret = mhi_ep_power_up(mhi_cntrl);
 		if (ret) {
 			dev_err(dev, "Failed to power up MHI EP: %d\n", ret);
+			if (info->flags & MHI_EPF_USE_DMA)
+				pci_epf_mhi_dma_deinit(epf_mhi);
 			mhi_ep_unregister_controller(mhi_cntrl);
 		}
 	}
@@ -389,6 +612,8 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 	 */
 	if (mhi_cntrl->mhi_dev) {
 		mhi_ep_power_down(mhi_cntrl);
+		if (info->flags & MHI_EPF_USE_DMA)
+			pci_epf_mhi_dma_deinit(epf_mhi);
 		mhi_ep_unregister_controller(mhi_cntrl);
 	}
 
-- 
2.25.1

