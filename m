Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CDB7AF0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjIZQkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjIZQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF99A13A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=av4Q5tr0bnozwSJldJa/tKMZzYdZGmoPuhbGkeCDqlg=;
        b=iqTAIiHu1L5lsyMuMYmLo9rlkzA14940/mL6uHrTALweAdGUiFBpyUscoySoYDu6TD1YZq
        5/twkDvqivabkP23XEWqHJSpERcPjN//x4x9RgszEAry2aehAwx8IfovaFyvZIYjwf3oag
        xkGRQN3kRkN+Tm/FC3x2Bh2c05y/QLE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-QQJJ75rdNhuIs1BMOT2tiQ-1; Tue, 26 Sep 2023 12:39:23 -0400
X-MC-Unique: QQJJ75rdNhuIs1BMOT2tiQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32006e08483so7257776f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746362; x=1696351162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av4Q5tr0bnozwSJldJa/tKMZzYdZGmoPuhbGkeCDqlg=;
        b=qBbcqzKNrFF0f/Xqwmg+1v2r22YWrun666/WejoyckccvjPuQTs1iYJO7d4MUyQpGb
         DvxrJo5aM9JS892yf1emryzA3hkovxAP112hG8L4amuPixnpUUWtZMbpyHzfPdGb07Ym
         iXwIwJtI8j5pWyiPX4NCwdqMQcT9KDzXuHgeeChj63GCgSYzdgoGRKE7Tep7CP9tHnN9
         3BYSVWuCfOGzUhg0tTD9PbAN2QYHMCglW7kg4wt5hNCCOqpJDHrwQHMZrD2+7t0XnNl4
         66r9j3YCD3+WmxgTbgHQsPUMEdqR9fD9kmkqUc2/Osyc3Wrg+jy9s8VFAcHjF700sEj8
         QfXw==
X-Gm-Message-State: AOJu0Yy2SimQBK557IRW/2tzY4t3HqmHfgf5DUvh3s6P082J+pQd3Rz+
        Fjpt2ze9WERUolsyuElSumyaB45vMUGZsf5maWDsmQrektGK/RtauGTYFa/qS6PZLCW9XqfW504
        jMFn31RiqSk2RUrILBOdAzNY=
X-Received: by 2002:adf:f891:0:b0:320:66:cf67 with SMTP id u17-20020adff891000000b003200066cf67mr8551634wrp.18.1695746362264;
        Tue, 26 Sep 2023 09:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4ila2SCVWp13EofwUd5ovY7r6En2sCXu1+29pWKRQjRuQNyl9s1EJv237ExyfKfZoffbgNA==
X-Received: by 2002:adf:f891:0:b0:320:66:cf67 with SMTP id u17-20020adff891000000b003200066cf67mr8551628wrp.18.1695746362039;
        Tue, 26 Sep 2023 09:39:22 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0031fba0a746bsm15171803wrl.9.2023.09.26.09.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:39:21 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH 1/4] fpga: add helpers for the FPGA KUnit test suites.
Date:   Tue, 26 Sep 2023 18:39:08 +0200
Message-ID: <20230926163911.66114-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926163911.66114-1-marpagan@redhat.com>
References: <20230926163911.66114-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to facilitate the registration of minimal platform drivers
to support the parent platform devices used for testing.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-test-helpers.h | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-test-helpers.h

diff --git a/drivers/fpga/tests/fpga-test-helpers.h b/drivers/fpga/tests/fpga-test-helpers.h
new file mode 100644
index 000000000000..fcad3249be68
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
+#ifndef FPGA_KUNIT_HELPERS_
+#define FPGA_KUNIT_HELPERS_
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
+#endif	/* FPGA_KUNIT_HELPERS_ */
-- 
2.41.0

