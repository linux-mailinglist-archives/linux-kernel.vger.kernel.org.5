Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07017F9FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjK0Mpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjK0Mps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:45:48 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2965183
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:45:53 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-778927f2dd3so183501185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089153; x=1701693953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJdqJoClpTS7fqDf791uIaijLcGC8pNYAqyRdW5OMs4=;
        b=vjniASW2b0aS9pB9ayNFz4LW3kj9xZenT9qAym/OSGHUXTbVxFmrLQV3SjchhEjNvU
         CYehKqp6uoY0Lo+xflNl1p/6/r/e6b2O9D7Im/H6jcKZ4V66YnOUUy6GTHJ6wlAetkqc
         o4t8qSF12je2Dcs6NBD7C+D27UtdhGgdPqd8/EhOHowEMK3n4NTc9YU4JdcnOqwd4EYp
         ll3LXOLlp0Joly0hM4cRROngajMh7DHUoBrP1TM925mSeqYmYEuW8NfsS2jLVingx7xm
         1F8t32ABBbrY9D77M4hrJPCaufiD6jcyAQyDNmjFMwoPWWoqeGGONDObl1dcG9SdVsJ8
         b2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089153; x=1701693953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJdqJoClpTS7fqDf791uIaijLcGC8pNYAqyRdW5OMs4=;
        b=C+04e/z5cxwVOinr28W5RzEnF0qC6l6QqOFgDV2E78bzL6BuLi0DPk2Fa+WnXq3GZr
         kx6VtxjjGdzQsy4J5NcqLqAks85eY8vlUWZ3ab+JJV+gtBCInEtucQx3BE6BQLYPpnLH
         ki1Q70xcXrgES84Y7Mq6xABls9de9M0txUt9i7/tLYpzLBGS96vdJ5DXDrvn7Ink1UmF
         vfsTdhLajWds3oHR34botL+76TOhayRqk/L8umi9rEJkMTL61Y3EXvyU6a81vC7QujvD
         fNSYr3SxISuDIFlFS5JaQGWPB4+5BHYCE8+Uji6CoYa0gQdP3qh1SS7fQqA65uGlzFMY
         WNCw==
X-Gm-Message-State: AOJu0Yxhu0TkyvtMa0aOz+qkrRFNKQkrG85x4QuF7pGcz0TZkjx1Vpzx
        /xBsVvXT/QT7WeiszBTo0Mwi
X-Google-Smtp-Source: AGHT+IHHFiydlH5dK8iSV8PMwXuYzFkx7SuLOEGF/fo5W8bAxDfHHMiuC2aBFQbxTuWHYuWWal/HtA==
X-Received: by 2002:ad4:452c:0:b0:67a:338d:2efc with SMTP id l12-20020ad4452c000000b0067a338d2efcmr5135972qvu.11.1701089152934;
        Mon, 27 Nov 2023 04:45:52 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:45:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/9] bus: mhi: ep: Rename read_from_host() and write_to_host() APIs
Date:   Mon, 27 Nov 2023 18:15:22 +0530
Message-Id: <20231127124529.78203-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the preparation for adding async API support, let's rename the existing
APIs to read_sync() and write_sync() to make it explicit that these APIs
are used for synchronous read/write.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c                    | 4 ++--
 drivers/bus/mhi/ep/ring.c                    | 8 ++++----
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 8 ++++----
 include/linux/mhi_ep.h                       | 8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index cdf5a84d1f21..5748a1da0803 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -381,7 +381,7 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 		buf_info.size = tr_len;
 
 		dev_dbg(dev, "Reading %zd bytes from channel (%u)\n", tr_len, ring->ch_id);
-		ret = mhi_cntrl->read_from_host(mhi_cntrl, &buf_info);
+		ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
 		if (ret < 0) {
 			dev_err(&mhi_chan->mhi_dev->dev, "Error reading from channel\n");
 			return ret;
@@ -543,7 +543,7 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 		buf_info.size = tr_len;
 
 		dev_dbg(dev, "Writing %zd bytes to channel (%u)\n", tr_len, ring->ch_id);
-		ret = mhi_cntrl->write_to_host(mhi_cntrl, &buf_info);
+		ret = mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
 		if (ret < 0) {
 			dev_err(dev, "Error writing to the channel\n");
 			goto err_exit;
diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index 7ea952860def..aeb53b2c34a8 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -48,7 +48,7 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 		buf_info.host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
 		buf_info.dev_addr = &ring->ring_cache[start];
 
-		ret = mhi_cntrl->read_from_host(mhi_cntrl, &buf_info);
+		ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
 		if (ret < 0)
 			return ret;
 	} else {
@@ -56,7 +56,7 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 		buf_info.host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
 		buf_info.dev_addr = &ring->ring_cache[start];
 
-		ret = mhi_cntrl->read_from_host(mhi_cntrl, &buf_info);
+		ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
 		if (ret < 0)
 			return ret;
 
@@ -65,7 +65,7 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 			buf_info.dev_addr = &ring->ring_cache[0];
 			buf_info.size = end * sizeof(struct mhi_ring_element);
 
-			ret = mhi_cntrl->read_from_host(mhi_cntrl, &buf_info);
+			ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
 			if (ret < 0)
 				return ret;
 		}
@@ -143,7 +143,7 @@ int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *e
 	buf_info.dev_addr = el;
 	buf_info.size = sizeof(*el);
 
-	return mhi_cntrl->write_to_host(mhi_cntrl, &buf_info);
+	return mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
 }
 
 void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id)
diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 6dc918a8a023..34e7191f9508 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -536,11 +536,11 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
 	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
 	if (info->flags & MHI_EPF_USE_DMA) {
-		mhi_cntrl->read_from_host = pci_epf_mhi_edma_read;
-		mhi_cntrl->write_to_host = pci_epf_mhi_edma_write;
+		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
+		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
 	} else {
-		mhi_cntrl->read_from_host = pci_epf_mhi_iatu_read;
-		mhi_cntrl->write_to_host = pci_epf_mhi_iatu_write;
+		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
+		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
 	}
 
 	/* Register the MHI EP controller */
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 96f3a133540d..b96b543bf2f6 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -94,8 +94,8 @@ struct mhi_ep_buf_info {
  * @raise_irq: CB function for raising IRQ to the host
  * @alloc_map: CB function for allocating memory in endpoint for storing host context and mapping it
  * @unmap_free: CB function to unmap and free the allocated memory in endpoint for storing host context
- * @read_from_host: CB function for reading from host memory from endpoint
- * @write_to_host: CB function for writing to host memory from endpoint
+ * @read_sync: CB function for reading from host memory synchronously
+ * @write_sync: CB function for writing to host memory synchronously
  * @mhi_state: MHI Endpoint state
  * @max_chan: Maximum channels supported by the endpoint controller
  * @mru: MRU (Maximum Receive Unit) value of the endpoint controller
@@ -149,8 +149,8 @@ struct mhi_ep_cntrl {
 			 void __iomem **virt, size_t size);
 	void (*unmap_free)(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t phys,
 			   void __iomem *virt, size_t size);
-	int (*read_from_host)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
-	int (*write_to_host)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
+	int (*read_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
+	int (*write_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
 
 	enum mhi_state mhi_state;
 
-- 
2.25.1

