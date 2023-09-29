Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FB57B3692
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjI2PWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjI2PWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E1FDD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696000879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DUH2bfyE6C8uTlVJHwvrkC7QPYIHAMcvQVh1UrVCss=;
        b=HeM1+WIosXRa2nsxhpl3wUxVclD9nCovhiDx/W46O/en/eeWmLhFXlOQYHDKtw47iV9oob
        lmPCELMMTVgkDyQ4XxFthSMUz9dXMg4H5li6IMs3psaqzOUOFT7M786fiPeViCAWKOsw76
        WF3jvdnvTdWGdEzIr25cwaMb/wZE8Zc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-nkowmXDEN-SdAGwCAHYSpw-1; Fri, 29 Sep 2023 11:21:18 -0400
X-MC-Unique: nkowmXDEN-SdAGwCAHYSpw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4180b3a5119so185010141cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000878; x=1696605678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DUH2bfyE6C8uTlVJHwvrkC7QPYIHAMcvQVh1UrVCss=;
        b=srqCD+sPuz1iIFqLlCTihApYRg93y7NxH97GF9QDJEyc/drpDQVTEUY2j8xSL5k/DF
         tjX3h0s7JqeWHAF2uYpv07cX8Dse5cDUl+V/eiXuovax6OWilmuOzz3rR8S31MHdgNGh
         xVwdIOLjOCcfUiU4Xpd6zrbikpL6NdBpoIh2VpHELm91IlBrKUIbjDEJvgxU68h856ay
         OIn3uqwcxI+wQJ/6gTEYXnG4ewbMIaAYEVAXzD/7ipp4xvI+R5GwVI+BwdyZ/yqQQ0VP
         N01H3oeEJY7kJBoADzJAiQTRNNj7H55AjpSSRyxINlr4udrVS9SAFrXmGRFkVajiT6tb
         Ci0A==
X-Gm-Message-State: AOJu0Yx9oTn0zhZyoVFglle1WGSJy1QDRo8I6OpMJqSq2Yh5YN+JSw/6
        ip2RNcsfYb/P3Nref2UZE660bZHFVJHFYH4Nihti16M3b1e6wo1H/0a5SI2xuGATb7refl9lnhX
        mnHXAhoBWASSjw/rDn33ytjM=
X-Received: by 2002:a05:622a:118e:b0:418:11ab:1c00 with SMTP id m14-20020a05622a118e00b0041811ab1c00mr5502844qtk.49.1696000878151;
        Fri, 29 Sep 2023 08:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZlhCTSd6qQ+sjvWEHY9Ok3klVHcIN817mjhPcqv1+65iA9JVgEHlreisFjo/ADJxKpJMnEg==
X-Received: by 2002:a05:622a:118e:b0:418:11ab:1c00 with SMTP id m14-20020a05622a118e00b0041811ab1c00mr5502823qtk.49.1696000877846;
        Fri, 29 Sep 2023 08:21:17 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id bq14-20020a05622a1c0e00b00419801b1094sm287053qtb.13.2023.09.29.08.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:21:17 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v2 1/4] fpga: add helpers for the FPGA KUnit test suites.
Date:   Fri, 29 Sep 2023 17:20:54 +0200
Message-ID: <20230929152057.85047-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929152057.85047-1-marpagan@redhat.com>
References: <20230929152057.85047-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to facilitate the registration of minimal platform drivers
to support parent platform devices used for testing.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-test-helpers.h | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-test-helpers.h

diff --git a/drivers/fpga/tests/fpga-test-helpers.h b/drivers/fpga/tests/fpga-test-helpers.h
new file mode 100644
index 000000000000..6a28ed30bf71
--- /dev/null
+++ b/drivers/fpga/tests/fpga-test-helpers.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit test for the FPGA Manager
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#ifndef _FPGA_KUNIT_HELPERS_H
+#define _FPGA_KUNIT_HELPERS_H
+
+#define TEST_PDEV_NAME	"fpga-test-pdev"
+
+#define TEST_PLATFORM_DRIVER(__drv_name)			\
+	__TEST_PLATFORM_DRIVER(__drv_name, TEST_PDEV_NAME)
+/*
+ * Helper macro for defining a minimal platform driver that can
+ * be registered to support the parent platform devices used for
+ * testing.
+ */
+#define __TEST_PLATFORM_DRIVER(__drv_name, __dev_name)		\
+static struct platform_driver __drv_name = {			\
+	.driver = {						\
+		.name = __dev_name,				\
+	},							\
+}
+
+#endif	/* _FPGA_KUNIT_HELPERS_H */
-- 
2.41.0

