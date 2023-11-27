Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5517F9FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjK0MqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjK0MqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:46:08 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65231B4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:07 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d81580d696so1075928a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089166; x=1701693966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39EwDzZn0NPRyj1qXqtCdOxw1lfeEL1OF+pNH5oiRHU=;
        b=B5epaKsa3Sajl6ClCAlaYWAXke2IRjMH+wcLP7UjNScqemLiyeR3rLuY3vG3BCjzj1
         EOrXxEkT6Tj45hguTlKcO8ZEw86TUzU2N0aKoDtpPAROlDplR8stcHJEqDsjjyFPksLr
         KR4iH3dEcmD+MocDq+Gwwi6Dnq0fEf5FUNTOus8BbYtMYV72wEuytJ2cWVxmUy6NKtCL
         cRh4ys7DS1IiVmQooDkVRCAO7LQAsUutlGHkOywOO/zh42fS32wO6ewyK5OCK2CIgIul
         UNeb53o367S/bhHoDgsCDHul/Mo5L8OvvPaC72d/iN8alHS8Mc0FabUFgZTIFU759RZk
         Vmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089166; x=1701693966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39EwDzZn0NPRyj1qXqtCdOxw1lfeEL1OF+pNH5oiRHU=;
        b=l1Z7cHOc09CCvKPdEHvhaD6/qW9zVVbCK9zvnCimBjFm6fJbeiWAfRm/NYL1xmmBRr
         +5/B+YVgsnK30NADfXKSTDg+k31mQnk1CpObWNR38vbZPJix8oZlKDPq8Cw02gh8TQe9
         qszAZhj++hHj2GyuvxouKFLVRlkjOSYei+15RQTBI7vHas6nEb+bLf4TYDskS/G6IMRx
         C6L3ERxwEmXFnggB9awDS9A858D/7WFYebgVeCbBm4YzOkrp2xsJuUS7+kWcRO2J7/T7
         iDEyDcc68fs+vFdna8A4jESCGxlFV523j2LQvKEiw9WG/wtK72Z9dMDRrJ1bJmF/nc3Q
         2SRQ==
X-Gm-Message-State: AOJu0YzDu4/fWPqNkjRf0z9qaIhg0ugbGYjLGPn3RCKHPIy9wRKcbTua
        pTw158HC2xu+kFJLjtVk5E2/72Jmqj3MOjFYfA==
X-Google-Smtp-Source: AGHT+IEf9XxgXqwBznbFGVOrIEZhtalj01eODY8VxfKTHk4t+FUDBuAKGwYEb/qCa5BZABeEE4aKxA==
X-Received: by 2002:a9d:6c91:0:b0:6bc:63c9:7946 with SMTP id c17-20020a9d6c91000000b006bc63c97946mr12684837otr.14.1701089166388;
        Mon, 27 Nov 2023 04:46:06 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:46:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/9] PCI: epf-mhi: Add support for DMA async read/write operation
Date:   Mon, 27 Nov 2023 18:15:25 +0530
Message-Id: <20231127124529.78203-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently supports only the sync read/write operation i.e., it
waits for the DMA transfer to complete before returning to the caller
(MHI stack). But it is sub-optimal and defeats the actual purpose of using
DMA.

So let's add support for DMA async read/write operation by skipping the DMA
transfer completion and returning to the caller immediately. When the
completion actually happens later, the driver will be notified using the
DMA completion handler and in turn it will notify the caller using the
newly introduced callback in "struct mhi_ep_buf_info".

Since the DMA completion handler is invoked from the interrupt context, a
separate workqueue (epf_mhi->dma_wq) is used to notify the caller about the
completion of the transfer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 231 ++++++++++++++++++-
 1 file changed, 228 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 7214f4da733b..3d09a37e5f7c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -21,6 +21,15 @@
 /* Platform specific flags */
 #define MHI_EPF_USE_DMA BIT(0)
 
+struct pci_epf_mhi_dma_transfer {
+	struct pci_epf_mhi *epf_mhi;
+	struct mhi_ep_buf_info buf_info;
+	struct list_head node;
+	dma_addr_t paddr;
+	enum dma_data_direction dir;
+	size_t size;
+};
+
 struct pci_epf_mhi_ep_info {
 	const struct mhi_ep_cntrl_config *config;
 	struct pci_epf_header *epf_header;
@@ -124,6 +133,10 @@ struct pci_epf_mhi {
 	resource_size_t mmio_phys;
 	struct dma_chan *dma_chan_tx;
 	struct dma_chan *dma_chan_rx;
+	struct workqueue_struct *dma_wq;
+	struct work_struct dma_work;
+	struct list_head dma_list;
+	spinlock_t list_lock;
 	u32 mmio_size;
 	int irq;
 };
@@ -418,6 +431,198 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	return ret;
 }
 
+static void pci_epf_mhi_dma_worker(struct work_struct *work)
+{
+	struct pci_epf_mhi *epf_mhi = container_of(work, struct pci_epf_mhi, dma_work);
+	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
+	struct pci_epf_mhi_dma_transfer *itr, *tmp;
+	struct mhi_ep_buf_info *buf_info;
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&epf_mhi->list_lock, flags);
+	list_splice_tail_init(&epf_mhi->dma_list, &head);
+	spin_unlock_irqrestore(&epf_mhi->list_lock, flags);
+
+	list_for_each_entry_safe(itr, tmp, &head, node) {
+		list_del(&itr->node);
+		dma_unmap_single(dma_dev, itr->paddr, itr->size, itr->dir);
+		buf_info = &itr->buf_info;
+		buf_info->cb(buf_info);
+		kfree(itr);
+	}
+}
+
+static void pci_epf_mhi_dma_async_callback(void *param)
+{
+	struct pci_epf_mhi_dma_transfer *transfer = param;
+	struct pci_epf_mhi *epf_mhi = transfer->epf_mhi;
+
+	spin_lock(&epf_mhi->list_lock);
+	list_add_tail(&transfer->node, &epf_mhi->dma_list);
+	spin_unlock(&epf_mhi->list_lock);
+
+	queue_work(epf_mhi->dma_wq, &epf_mhi->dma_work);
+}
+
+static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
+				       struct mhi_ep_buf_info *buf_info)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
+	struct pci_epf_mhi_dma_transfer *transfer = NULL;
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
+	config.src_addr = buf_info->host_addr;
+
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret) {
+		dev_err(dev, "Failed to configure DMA channel\n");
+		goto err_unlock;
+	}
+
+	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
+				  DMA_FROM_DEVICE);
+	ret = dma_mapping_error(dma_dev, dst_addr);
+	if (ret) {
+		dev_err(dev, "Failed to map remote memory\n");
+		goto err_unlock;
+	}
+
+	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
+					   DMA_DEV_TO_MEM,
+					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dev, "Failed to prepare DMA\n");
+		ret = -EIO;
+		goto err_unmap;
+	}
+
+	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
+	if (!transfer) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
+
+	transfer->epf_mhi = epf_mhi;
+	transfer->paddr = dst_addr;
+	transfer->size = buf_info->size;
+	transfer->dir = DMA_FROM_DEVICE;
+	memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
+
+	desc->callback = pci_epf_mhi_dma_async_callback;
+	desc->callback_param = transfer;
+
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(dev, "Failed to do DMA submit\n");
+		goto err_free_transfer;
+	}
+
+	dma_async_issue_pending(chan);
+
+	goto err_unlock;
+
+err_free_transfer:
+	kfree(transfer);
+err_unmap:
+	dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
+err_unlock:
+	mutex_unlock(&epf_mhi->lock);
+
+	return ret;
+}
+
+static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
+					struct mhi_ep_buf_info *buf_info)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
+	struct pci_epf_mhi_dma_transfer *transfer = NULL;
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
+	config.dst_addr = buf_info->host_addr;
+
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret) {
+		dev_err(dev, "Failed to configure DMA channel\n");
+		goto err_unlock;
+	}
+
+	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
+				  DMA_TO_DEVICE);
+	ret = dma_mapping_error(dma_dev, src_addr);
+	if (ret) {
+		dev_err(dev, "Failed to map remote memory\n");
+		goto err_unlock;
+	}
+
+	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
+					   DMA_MEM_TO_DEV,
+					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dev, "Failed to prepare DMA\n");
+		ret = -EIO;
+		goto err_unmap;
+	}
+
+	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);
+	if (!transfer) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
+
+	transfer->epf_mhi = epf_mhi;
+	transfer->paddr = src_addr;
+	transfer->size = buf_info->size;
+	transfer->dir = DMA_TO_DEVICE;
+	memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
+
+	desc->callback = pci_epf_mhi_dma_async_callback;
+	desc->callback_param = transfer;
+
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(dev, "Failed to do DMA submit\n");
+		goto err_free_transfer;
+	}
+
+	dma_async_issue_pending(chan);
+
+	goto err_unlock;
+
+err_free_transfer:
+	kfree(transfer);
+err_unmap:
+	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
+err_unlock:
+	mutex_unlock(&epf_mhi->lock);
+
+	return ret;
+}
+
 struct epf_dma_filter {
 	struct device *dev;
 	u32 dma_mask;
@@ -441,6 +646,7 @@ static int pci_epf_mhi_dma_init(struct pci_epf_mhi *epf_mhi)
 	struct device *dev = &epf_mhi->epf->dev;
 	struct epf_dma_filter filter;
 	dma_cap_mask_t mask;
+	int ret;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -459,16 +665,35 @@ static int pci_epf_mhi_dma_init(struct pci_epf_mhi *epf_mhi)
 						   &filter);
 	if (IS_ERR_OR_NULL(epf_mhi->dma_chan_rx)) {
 		dev_err(dev, "Failed to request rx channel\n");
-		dma_release_channel(epf_mhi->dma_chan_tx);
-		epf_mhi->dma_chan_tx = NULL;
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_release_tx;
+	}
+
+	epf_mhi->dma_wq = alloc_workqueue("pci_epf_mhi_dma_wq", 0, 0);
+	if (!epf_mhi->dma_wq) {
+		ret = -ENOMEM;
+		goto err_release_rx;
 	}
 
+	INIT_LIST_HEAD(&epf_mhi->dma_list);
+	INIT_WORK(&epf_mhi->dma_work, pci_epf_mhi_dma_worker);
+	spin_lock_init(&epf_mhi->list_lock);
+
 	return 0;
+
+err_release_rx:
+	dma_release_channel(epf_mhi->dma_chan_rx);
+	epf_mhi->dma_chan_rx = NULL;
+err_release_tx:
+	dma_release_channel(epf_mhi->dma_chan_tx);
+	epf_mhi->dma_chan_tx = NULL;
+
+	return ret;
 }
 
 static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
 {
+	destroy_workqueue(epf_mhi->dma_wq);
 	dma_release_channel(epf_mhi->dma_chan_tx);
 	dma_release_channel(epf_mhi->dma_chan_rx);
 	epf_mhi->dma_chan_tx = NULL;
-- 
2.25.1

