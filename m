Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445507E43AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjKGPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbjKGPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:41:18 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57889F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:41:15 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d17bdabe1so40535746d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699371675; x=1699976475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObVN4OHcPVQWsUpE/966fOo3IFl5zYaTQP4Ff/lWTe4=;
        b=bobyiEHOE/h+zyutQu+5a0gnvPgFSPrrT4+U1u8DurMIYe4ptBGJeD+tik60wnZi14
         72omqUgdyTtzYvpf356qjrkRaVws/loTRdm5KlRyVpTBW0zhKE5JbLFKRZkFfrOdKDFU
         W0pVty06+n2qHyLea6AMNi7REzYHFBeIxO+mDMaV9Wph0PJB//g1q0VcLoshD6I3LKzm
         UJCEjASGjIMYX4c53LIdEGBwkdutXq6GtDzYcXQuQf1AHeuB9swVe8xmvYLeHw+XN97j
         E11QS5WUQCHpoCiOI1HdaofNcbwYI3R4xJfEHc4xCizsje8/mdPL1VIg7PUNnrR/gYOd
         /pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699371675; x=1699976475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObVN4OHcPVQWsUpE/966fOo3IFl5zYaTQP4Ff/lWTe4=;
        b=gDYGKuGZc33IComrSjmUIJ7lbVIMRq/nl0aN/7pKg5RbOarwxV3lzG4hnekDqdr0Db
         /GJk5L7FxPZVmp8tt5d31QFAXl3e66smcHjtkmUpi4lNI6g/aLaBSNAlfUM1FpR/cIvm
         II1ZKhESjxY48D1f8291Io891ZUAIG/awYl2mFEgscHMWamFT0wE+6qeKCSYei1hSojA
         p8Usy7m2D7LO81/SDq6dSZV5/AdQ0vx6bMe8zkG/ziIWCfYLSZ0vZ3kjV4ZghbFyo9j1
         EhT/TcrBHVTTx0c66eX3ssydx+pOh4DmdSjqkqZf6A9yhrvFxohof7d3zOOd++kVZiGo
         Rp3Q==
X-Gm-Message-State: AOJu0YxV8aUJa8PHpTfSJ10rqMbpbHG+8jBZ90YErIzAxfUqbH9LzGwX
        rx7UEu9U1nV9lDc1l/XkG9TFOdbRGOGUg5u0SA==
X-Google-Smtp-Source: AGHT+IHHqmworfLQWEekvi8UO9gWd02E+Uc289e8Y39lqPlgbomqRT6SyOFmuPC/YBTPy52YJ0fB4w==
X-Received: by 2002:ad4:5ca2:0:b0:66d:3723:294b with SMTP id q2-20020ad45ca2000000b0066d3723294bmr34665070qvh.64.1699371674936;
        Tue, 07 Nov 2023 07:41:14 -0800 (PST)
Received: from localhost.localdomain ([117.217.186.253])
        by smtp.gmail.com with ESMTPSA id u3-20020a0cb403000000b0064f43efc844sm4565789qve.32.2023.11.07.07.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:41:14 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] bus: mhi: host: pci_generic: Add local VID definitions for Telit and Sierra
Date:   Tue,  7 Nov 2023 21:11:00 +0530
Message-Id: <20231107154100.154492-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the definitions locally for now since it was agreed earlier that we
keep it this way until the definitions show up in other drivers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/host/pci_generic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 08f3f039dbdd..58ce1ecddd19 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -25,6 +25,8 @@
 
 /* PCI VID definitions */
 #define PCI_VENDOR_ID_THALES	0x1269
+#define PCI_VENDOR_ID_SIERRA	0x18d7
+#define PCI_VENDOR_ID_TELIT	0x1c5d
 #define PCI_VENDOR_ID_QUECTEL	0x1eac
 
 /**
@@ -585,18 +587,18 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, PCI_VENDOR_ID_QCOM, 0x010c),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
 	/* EM919x (sdx55), use the same vid:pid as qcom-sdx55m */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, 0x18d7, 0x0200),
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, PCI_VENDOR_ID_SIERRA, 0x0200),
 		.driver_data = (kernel_ulong_t) &mhi_sierra_em919x_info },
 	/* Telit FN980 hardware revision v1 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, 0x1C5D, 0x2000),
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, PCI_VENDOR_ID_TELIT, 0x2000),
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn980_hw_v1_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0306),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx55_info },
 	/* Telit FN990 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2010),
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, PCI_VENDOR_ID_TELIT, 0x2010),
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
 	/* Telit FE990 */
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2015),
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, PCI_VENDOR_ID_TELIT, 0x2015),
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
-- 
2.25.1

