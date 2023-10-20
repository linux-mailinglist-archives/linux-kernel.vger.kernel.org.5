Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B8A7D08B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376449AbjJTGo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347047AbjJTGoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:44:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD71729
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:43:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso3733775ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697784233; x=1698389033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBfG7y1wS6npxpsDoB4LPtvQaNRqYIKOIQ4wevmC8p0=;
        b=KUfRVSopeS9Tjh+EHJvDjLv1SdPKOkt+uEn2D2FIg5SH2o1cARYB7l6fwhQCuqkNVY
         wy8LKSZVfALz7zseTynqeuI3SsPADQyAx2/+YV9Yjgy3ijRuDfyx+Q6eM2XpLq+/HWO3
         1hTU09KyzaMuGOKZifs/9e7W2r29RCUXm1ghgSmzkS1hPQMPAP27JMR47c6D887iFU9A
         aFMUJx9amGhJCjPmI/7skuUL9myinyCfjrnV5AWa0jWg6DNib93F+ugSYwOffIFCr7dT
         8gCwpiXqYTtYoRXaR4jQois9ocGtW9gNN/PWkm/qzGiFWdIiN30k4dM2+ZO+7zmZUzjc
         Gfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784233; x=1698389033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBfG7y1wS6npxpsDoB4LPtvQaNRqYIKOIQ4wevmC8p0=;
        b=aaApOasPIB8brnTsAoa/ezoOu/G1j7fhB3bFlEV9vSk5GSPfqgxveCP8/bGj4QjvyS
         FuLiauXQwt0/oijG/J7YqTWY1AunClLE2a/GeS30NBzaxb7ky97ZqFrxewlLu5UA4Gp/
         SmoUx5eQOVw+ip/sQzxdlpW/PI8YIvaYoL9uM1wl1NmwqbiCvABoMKy4ac+/b2IJpaSs
         M7wKoc6o7t4a5o8FRZSAe3WIn3atu7nxH0brbmoWGNcMa9g3aU8er/OaOpqYg3pXXoRz
         gBKJ004dUaHeEiYjB1NN5DrqxS1bdKYYM9vOD476PplwP0i1XRY/uVJp2e38RxhdbSGo
         6u7w==
X-Gm-Message-State: AOJu0YyIxcCwVfVDp/ECIsTExrjPl1WeAwAgKnhwpCeJ61P7qCoQu7uz
        KY3dRJFgC9K73fNq6iCDtEFP
X-Google-Smtp-Source: AGHT+IHBnmxbWanPC5CN2BOkeTciCen2gLcMRjhDdIc93xy8/IDPdeFK5Ms03eR3Kq0WAmKzTno+ZA==
X-Received: by 2002:a17:902:ea95:b0:1c9:d90b:c3e4 with SMTP id x21-20020a170902ea9500b001c9d90bc3e4mr996805plb.10.1697784232954;
        Thu, 19 Oct 2023 23:43:52 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.40])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902bc4300b001c60ba709b7sm760951plz.125.2023.10.19.23.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 23:43:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vidyas@nvidia.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 3/3] PCI: tegra194: Refactor EP initialization completion
Date:   Fri, 20 Oct 2023 12:13:20 +0530
Message-Id: <20231020064320.5302-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020064320.5302-1-manivannan.sadhasivam@linaro.org>
References: <20231020064320.5302-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vidya Sagar <vidyas@nvidia.com>

Instead of doing the initialization complete and notifying it to the EPF
drivers separately, let's call the dw_pcie_ep_init_notify() function that
takes care of both.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
[mani: modified the commit message]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index a962f2c7794f..a8835287fc3a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1897,14 +1897,12 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = (upper_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
 	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_HIGH_OFF, val);
 
-	ret = dw_pcie_ep_init_complete(ep);
+	ret = dw_pcie_ep_init_notify(ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
 		goto fail_init_complete;
 	}
 
-	dw_pcie_ep_init_notify(ep);
-
 	/* Program the private control to allow sending LTR upstream */
 	if (pcie->of_data->has_ltr_req_fix) {
 		val = appl_readl(pcie, APPL_LTR_MSG_2);
-- 
2.25.1

