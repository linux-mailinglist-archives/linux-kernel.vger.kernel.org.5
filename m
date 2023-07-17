Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D19755C26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGQGzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjGQGzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:55:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39608E47
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:55:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-66767d628e2so2566167b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689576910; x=1692168910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIQbVzJDtQSLAjOmeG/MuTeyAG4mQGjdI8C010Z2eIw=;
        b=UFMVPuRT1vwBT6WcyU1rl+qgHXKkfojP83VPshcp2cwXes6ul+kRV05GZKAUFec+4h
         CneFfJe0sEDye/vnfoAuBBWb7u1OQ9XodxMCMi8juMsKL84ESG7j61XcHSDzHaYmeA1D
         aw6Xu1bQiHFPDYBRT7dVtbYPBMsKq5kmi+FA6tMVYpxMiSugjIadlhM6JmFAYfA1QAB9
         TP6s1/9CwjQEnOISa0V3gOhlQoS4B8HPgfx1rNOAOwQ/7Me/tzJDe6AvC9Zrr2stkn2h
         Wma9tGAWzXXmjOckOWrkbCyKlHGnzdTvKo1T6EPPh+iwAKqEYtNRUQYyejXf2VxrOlVU
         4wTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689576910; x=1692168910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIQbVzJDtQSLAjOmeG/MuTeyAG4mQGjdI8C010Z2eIw=;
        b=OwHfK9HitW/8cdNm/uaVWvq2TIiKauyDtqpIY2uthRITQuaoYrMSuthA3fQw0zzeQG
         87Yly/zpVJdziRWEw09mz/nY8U6J3M6EWQ6llSlB0B+IPAN7IYtD3pnsGkOPXh/sio9d
         8PiEXVZcE4i5TwFrV9uT2OJSOgYu1P4s9NVAEoDkjZ19aflW46Uw61Cgb4QtGY31pYwe
         N8GsqobSwbMsdtPP4euuSf0TV1tnVVeBZ+37Fy+W91qzrF+IxydmDXjZhkWM/NM1eWyC
         PF693u2UM4cYtS1HNLuSVqZnk8aoRMzPdXkl2/2ctMJBT6uvoexDIvkMbt1ILzLdbNkW
         kqyg==
X-Gm-Message-State: ABy/qLbiWrHtdik2sU+eZkLy6isfeAV6SO9kESCtgEmONtnXAoXf7XyK
        dUX+NbweSurxmv8m6GkV/IGc
X-Google-Smtp-Source: APBJJlE0nveJAQFhJWfXJ2pXIKRUaR22158RQz5B6tYHzqziQIaLTWZnuEN+O69BYpxfUpKDam8nvQ==
X-Received: by 2002:a05:6a00:3989:b0:67a:a4d1:e70 with SMTP id fi9-20020a056a00398900b0067aa4d10e70mr10863192pfb.16.1689576910693;
        Sun, 16 Jul 2023 23:55:10 -0700 (PDT)
Received: from localhost.localdomain ([117.193.215.209])
        by smtp.gmail.com with ESMTPSA id x7-20020a62fb07000000b006675c242548sm11196422pfm.182.2023.07.16.23.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:55:10 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/7] PCI: qcom-ep: Pass alignment restriction to the EPF core
Date:   Mon, 17 Jul 2023 12:24:53 +0530
Message-Id: <20230717065459.14138-2-manivannan.sadhasivam@linaro.org>
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

Qcom PCIe EP controllers have 4K alignment restriction for the outbound
window address. Hence, pass this info to the EPF core so that the EPF
drivers can make use of this info.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 0fe7f06f2102..736be5bee458 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -706,6 +706,7 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.core_init_notifier = true,
 	.msi_capable = true,
 	.msix_capable = false,
+	.align = SZ_4K,
 };
 
 static const struct pci_epc_features *
-- 
2.25.1

