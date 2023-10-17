Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43467CBAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjJQGSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjJQGSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:18:31 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A886100
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:18:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-777506c6109so239733585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697523508; x=1698128308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkYO1bScO1Nh1mhDBKqPQqvg77TORt1VTesmsXej5Zo=;
        b=dTuXzuC3INnkIprgzXvracvFSF04kECIJ8BA4oSoNMt+bNrU7McpJRrQBI/9f298l9
         SgLo7KBsiiSMz34zSW4AI/PHbWlp8UHkxBnjCfyZyeaeHHIeNDYx2B12Z0uyEGvfRhSK
         iopsIaX6xJ9DWdjwOIu7N0wX37ZMNEBCwRyiUtJQh9TDyU4H3NMqcVvOCtv1ly6jQoo+
         qdlr2iZnj04wVOjpbKqKDj+eMnqbP1CvOwajMMW4QRmED3Mdn335mExrWGbn5iAr/zMP
         GFxzzs4oI/tuv+hQtH/CYeVLKcedeLBlZLC1e/HZXo2fi/wiEIjvEExdIGabS7VueLtH
         FgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697523508; x=1698128308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkYO1bScO1Nh1mhDBKqPQqvg77TORt1VTesmsXej5Zo=;
        b=hG70zFkHGjqnz/i/AQFB5ts+xHWrd5p97vb4dxwhHBo2XHbRmDR2lc2Hu2VDfQTHfA
         Itzxb2eeV8IES3fx8hDYpbxJmapM7VWVdqNutnKAwJ/b4Jqq6kqWgQI4P0CsX4Q0RYvl
         j2SypmNtji6eVEQRn9Kx419SB2sp5fr4LZVkttR6O4zQvrX+bdLI+L3P1CtLzp0iXB1P
         nJ1DUQtaaR5AmdfH/WT6sc0/QPhPMJTXfsGsfasp0rkaQ2hdFs2IJs3r3Z8LJdut2nvV
         pG0DFNS3GvvQ/dyG7ED4DcBP2XHD+ZXJ6mFjqEB/2F7W/4ZRCTHAOzycqtsWp3rwHtNL
         CHiA==
X-Gm-Message-State: AOJu0YyG+uNYZIPER5fQggwtb6ak+Mi3Tzj12kl4vwiEV5UB8tJtocbW
        cV5jxKWDjSP2urvPnvSTm6XU4p5gixd0Eg/0DQ==
X-Google-Smtp-Source: AGHT+IE8JNfcV/3+8U1FvlX+VKyD7qEPDGyQ4gecDrqoHYxxyu96tXS/s5DhEzcvVTbUIfkdAwriEg==
X-Received: by 2002:a05:620a:2a0b:b0:76d:5126:65d8 with SMTP id o11-20020a05620a2a0b00b0076d512665d8mr1615376qkp.6.1697523507999;
        Mon, 16 Oct 2023 23:18:27 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.31.199])
        by smtp.gmail.com with ESMTPSA id f22-20020a05620a12f600b00765aa3ffa07sm390304qkl.98.2023.10.16.23.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 23:18:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Tue, 17 Oct 2023 11:47:55 +0530
Subject: [PATCH 2/2] PCI: qcom-ep: Implement dbi_cs2_access() function
 callback for DBI CS2 access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-pcie-qcom-bar-v1-2-3e26de07bec0@linaro.org>
References: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
In-Reply-To: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=T4a7lgG8ADnBOXiiRIvPHtgQQvh1D/dQF3320fos0xc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlLicmGF31I/FDgbYgWQOFxOQucjTRctHyuLkNx
 yHPARkm4AuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZS4nJgAKCRBVnxHm/pHO
 9ekTCACOVYldI/Jbzvfj0Br85YHE10/BeAbFb0Bw8D/TRVjTHodwXArult4wCKHRG9u38cBK+YW
 6u4Rd85AmgXvmLuNxJIdBdb3IJ2xLC3xK9BUUrDp3BQxtgxJiXkO/iK74LeIoYJUeCp5yGSAD85
 dTUsY81gs6PExIsrrcJO0Ya0tB4zMVOq6VLCN2zWk/VWDKGqf+5Os3qzFj3CLbGeAcwt8uvF4/G
 m08NZAqU5eaW6fQ4YvB1CzR/fxrJ3mz3zchFRoRxtnVlCOr6i80Gzd3mT77vtYN1lqCUSLoFXae
 bpvuSLn1LIxXDD4foOUAJ1j7Qiq9yoeTDA+2Ych8vojNsrw1
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Qcom EP platforms require enabling/disabling the DBI CS2 access while
programming some read only and shadow registers through DBI. So let's
implement the dbi_cs2_access() callback that will be called by the DWC core
while programming such registers like BAR mask register.

Without DBI CS2 access, writes to those registers will not be reflected.

Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 32c8d9e37876..4653cbf7f9ed 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -124,6 +124,7 @@
 
 /* ELBI registers */
 #define ELBI_SYS_STTS				0x08
+#define ELBI_CS2_ENABLE				0xa4
 
 /* DBI registers */
 #define DBI_CON_STATUS				0x44
@@ -262,6 +263,18 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
 	disable_irq(pcie_ep->perst_irq);
 }
 
+static void qcom_pcie_dbi_cs2_access(struct dw_pcie *pci, bool enable)
+{
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+
+	writel_relaxed(enable, pcie_ep->elbi + ELBI_CS2_ENABLE);
+	/*
+	 * Do a dummy read to make sure that the previous write has reached the
+	 * memory before returning.
+	 */
+	readl_relaxed(pcie_ep->elbi + ELBI_CS2_ENABLE);
+}
+
 static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
 {
 	struct dw_pcie *pci = &pcie_ep->pci;
@@ -500,6 +513,7 @@ static const struct dw_pcie_ops pci_ops = {
 	.link_up = qcom_pcie_dw_link_up,
 	.start_link = qcom_pcie_dw_start_link,
 	.stop_link = qcom_pcie_dw_stop_link,
+	.dbi_cs2_access = qcom_pcie_dbi_cs2_access,
 };
 
 static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,

-- 
2.25.1

