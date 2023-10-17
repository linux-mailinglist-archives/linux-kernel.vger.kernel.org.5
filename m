Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6857CBAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJQGS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjJQGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:18:25 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB6DB0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:18:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7742be66bd3so382180885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697523503; x=1698128303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lhtaXzzZVdki7ialq2pIqDq/s9Xa0PvlTZMBvawHvU=;
        b=K4764VyMiI+1yKiv0/tGgAuUPYkwm9vC6P0v/GvfqF2b+sgzkGszp7YPfzXVlThges
         CLzLyf6Kx0kGspEXzjltJmnpj8+LF62tnQFHw19amHzQBp7JgTZt9hagR5FwUY7PmzII
         ODDqb7WsLTan1tl4CzJmH4yGZkeZajC7vKopbN/pa2yRBcp4VzqkyVPVEDvp2vN2wc9n
         OsK1wcj3za3mIeMkI2CB/imkittcSj9esQiPlQIOoWVmaRTGLZwfbCWdKJblVaF2GEPA
         NzlJ7V9RO8BQ8NBVr20r9JcgbhAKrng1xxLozFhPLZnMe5BE1EnjVxaDHQxzdHNtSUhL
         8g1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697523503; x=1698128303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lhtaXzzZVdki7ialq2pIqDq/s9Xa0PvlTZMBvawHvU=;
        b=UOoD3eJ97Olsqk4iOEdSSL1D3QXSxoHAdV9SeEGwh0XyYIkd/ioYFgv9L5N4FkaIH9
         w4VSptztMW9NIeK3RSGfKHLVuvYoX88IUni36WlhL286zsIzU2XbN6Z1UiSvAvcIeXAd
         l/kW8X6Z5BILxILgZeFMetmP0bu9uvOD9s8n5mvVk34UH54JNYxtBVG0KEcqVqF7/DVH
         SQ9sVBASIZMKUxKUBAJLf0WjmjquokFW1CahXounh+yoUdsqoTF6tWH84MuglY83zTvP
         Kg9rbZ5hQLoDqIn8d8kSup4PNX6NFzLPul9H75fN2vXzOyaTW/WwvTBj585oD/1WLzFS
         fAnw==
X-Gm-Message-State: AOJu0YypL2yKz++0zbpcAQbLV/92a+tFsiGkUXVP5Pc20NClkWf0mgCD
        RldNIeHIGVbgAMVEAwxe7OMs
X-Google-Smtp-Source: AGHT+IFMHnn7z9hd+i8JZG0ZGEEVpik1Rf7d/Lu9VUoVHUgImk0zu0NndUlG1arkkyNIg58tYFDnEQ==
X-Received: by 2002:a05:620a:4050:b0:775:9036:60f3 with SMTP id i16-20020a05620a405000b00775903660f3mr1621244qko.16.1697523503221;
        Mon, 16 Oct 2023 23:18:23 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.31.199])
        by smtp.gmail.com with ESMTPSA id f22-20020a05620a12f600b00765aa3ffa07sm390304qkl.98.2023.10.16.23.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 23:18:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Tue, 17 Oct 2023 11:47:54 +0530
Subject: [PATCH 1/2] PCI: dwc: Add new accessors to enable/disable DBI CS2
 while setting the BAR size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-pcie-qcom-bar-v1-1-3e26de07bec0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=OP4W5AEhgUSDaHDy2B4OZk3Grr6XP1yl9oNf0R8rWUQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlLicmILNyHAyc5XZnCRhkGM2ygXAYYTDPEUJfF
 otuvUxk3HuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZS4nJgAKCRBVnxHm/pHO
 9VDZCACPrTqVHF2758C661bi9dz+Xl3g3KKSa/tO6cUWWRo87iggp2VrgX4Ph9hdg7fGjHoY5O/
 7g0tAocoLXawOXjvADKmqAljh0tuTaQO9ks9Ers8xrSfa26mmgWxojG1c9jPHS0ac3uaG+YJdm+
 /Bd0UVcVlrp60NpTBwDklAbuSU/KeAXPwYElDVe0JwwQ8tcYy6/3fgE7c0mbcSugF6V1fDIZ6Ei
 eJQRYvXUdY4czYybme0NxNol/uz5ZxMZf63BQ7cbv9i2PK5UqrRCI7k+cxMriTDLDP5zRP7fA8z
 WH/0kI7KuwagZa8T+f5beHAqmtoE8kWClmpJnrZwX6DdJ9NW
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

As per the DWC databook v4.21a, section M.4.1, in order to write some read
only and shadow registers through application DBI, the device driver should
assert DBI Chip Select 2 (CS2) in addition to DBI Chip Select (CS).

This is a requirement at least on the Qcom platforms while programming the
BAR size, as the BAR mask registers are marked RO. So let's add two new
accessors dw_pcie_dbi_cs2_{en/dis} to enable/disable CS2 access in a vendor
specific way while programming the BAR size.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c |  6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h    | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d34a5e87ad18..1874fb3d8df4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -269,11 +269,17 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
+	dw_pcie_dbi_cs2_en(pci);
 	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
+	dw_pcie_dbi_cs2_dis(pci);
+
 	dw_pcie_writel_dbi(pci, reg, flags);
 
 	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		dw_pcie_dbi_cs2_en(pci);
 		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
+		dw_pcie_dbi_cs2_dis(pci);
+
 		dw_pcie_writel_dbi(pci, reg + 4, 0);
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 55ff76e3d384..3cba27b5bbe5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -379,6 +379,7 @@ struct dw_pcie_ops {
 			     size_t size, u32 val);
 	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			      size_t size, u32 val);
+	void	(*dbi_cs2_access)(struct dw_pcie *pcie, bool enable);
 	int	(*link_up)(struct dw_pcie *pcie);
 	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
@@ -508,6 +509,18 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+static inline void dw_pcie_dbi_cs2_en(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->dbi_cs2_access)
+		pci->ops->dbi_cs2_access(pci, true);
+}
+
+static inline void dw_pcie_dbi_cs2_dis(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->dbi_cs2_access)
+		pci->ops->dbi_cs2_access(pci, false);
+}
+
 static inline int dw_pcie_start_link(struct dw_pcie *pci)
 {
 	if (pci->ops && pci->ops->start_link)

-- 
2.25.1

