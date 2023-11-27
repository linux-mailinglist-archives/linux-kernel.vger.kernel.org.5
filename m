Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B197F9FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjK0Mp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjK0Mpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:45:52 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED63198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:45:58 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d30d9f4549so2577195a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089157; x=1701693957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah8iq1Txz+5feKQ56aPHrEDMCkBylT8O2PmEcpgbM28=;
        b=RuXvUBGAKjjtt2WFuHTMGCEakadqjzI5hBbsshSwCsGVPxJUrrRoHPAwEoQNbE+mn2
         0PE1tUs8o4ndBJ0Aq1vSJB2DEJu9+7YBMEPXL3LTCE4gYvrQ7ZGr2VHsfueiohs3kzN8
         YkL9FYSepfSdRNlek8TI2UsJVIJG1HOWwSb1rLZEqtAdaimu0qMRzylJ29AABlUTDVW4
         /VdgPlb5Y9GO2q0A5Kpg9oRfjmn9dODyckzwxhlLgdZEB1+XeaKbQOSSeyFhn4du3vEY
         /Uf/QIa363jhYvqLHtARPTEjx/uzFW58k0axdx1I0U/zSargvJ9fjAymQWIRxZtMOg3b
         RAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089157; x=1701693957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah8iq1Txz+5feKQ56aPHrEDMCkBylT8O2PmEcpgbM28=;
        b=QlWs2XJZCX5qNILHSvHaQEYuULh1tjXGWsXd4QFgB/giR/OS9A07yBp0AbJrxr3dyK
         Mw9l4rzjb1bB93S5BAsgyrvVTZp0fWDG6ASVI7bPDGVYxt1oDuLTn891mJtv/PXE9yI9
         B7Qmb9x2QPo/duSvTVnPVxtAuMoeOhNMpPE8VcYO6JaQCYItJySmBmi5//Dyqw7wMCf4
         ruZv//qdtW9DAfRy65Fne2nQRgxYjzBXjMc+crkIRNCfIQ9hg0yxSXK6Hx4unhCXU+8a
         JgT5tNiIuATXsle9g96Tl8lsQ87LTbP09A3MYg7WmE9CyBPKOc3LjZuskknfS6N3s0+j
         BV6A==
X-Gm-Message-State: AOJu0YwxYh+i3PqhEr1eJnXjBiJfdqsFzXVt5a/g0KLOfwZUHNKnEkNu
        s4dy4SSvml82xi+YUVe7TDS0
X-Google-Smtp-Source: AGHT+IG8yTjpBWVehWRL+B7ZcIXrUSuHpjOgGUeYzRMY3Yi+8iNrXtu1MquzIqT++f3DfkvIy4QlUQ==
X-Received: by 2002:a9d:7d96:0:b0:6d7:f8c1:e473 with SMTP id j22-20020a9d7d96000000b006d7f8c1e473mr14360011otn.19.1701089157632;
        Mon, 27 Nov 2023 04:45:57 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:45:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/9] bus: mhi: ep: Introduce async read/write callbacks
Date:   Mon, 27 Nov 2023 18:15:23 +0530
Message-Id: <20231127124529.78203-4-manivannan.sadhasivam@linaro.org>
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

These callbacks can be implemented by the controller drivers to perform
async read/write operation that increases the throughput.

For aiding the async operation, a completion callback is also introduced.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/linux/mhi_ep.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index b96b543bf2f6..14c6e8d3f573 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -54,11 +54,16 @@ struct mhi_ep_db_info {
  * @dev_addr: Address of the buffer in endpoint
  * @host_addr: Address of the bufffer in host
  * @size: Size of the buffer
+ * @cb: Callback to be executed by controller drivers after transfer completion (async)
+ * @cb_buf: Opaque buffer to be passed to the callback
  */
 struct mhi_ep_buf_info {
 	void *dev_addr;
 	u64 host_addr;
 	size_t size;
+
+	void (*cb)(struct mhi_ep_buf_info *buf_info);
+	void *cb_buf;
 };
 
 /**
@@ -96,6 +101,8 @@ struct mhi_ep_buf_info {
  * @unmap_free: CB function to unmap and free the allocated memory in endpoint for storing host context
  * @read_sync: CB function for reading from host memory synchronously
  * @write_sync: CB function for writing to host memory synchronously
+ * @read_async: CB function for reading from host memory asynchronously
+ * @write_async: CB function for writing to host memory asynchronously
  * @mhi_state: MHI Endpoint state
  * @max_chan: Maximum channels supported by the endpoint controller
  * @mru: MRU (Maximum Receive Unit) value of the endpoint controller
@@ -151,6 +158,8 @@ struct mhi_ep_cntrl {
 			   void __iomem *virt, size_t size);
 	int (*read_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
 	int (*write_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
+	int (*read_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
+	int (*write_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
 
 	enum mhi_state mhi_state;
 
-- 
2.25.1

