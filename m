Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EA17541E5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjGNRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbjGNRzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:55:23 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CBD3A9B;
        Fri, 14 Jul 2023 10:54:46 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-78654448524so85131339f.2;
        Fri, 14 Jul 2023 10:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356914; x=1691948914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCdm/lGSXcdU0qxB1c5esfZmTh7WAzDMe8njjEfNYZc=;
        b=ZzFq/lwEbt+qtdJwxaPuwQH6JhXcVVCoJw37ZgW8ZH/NLflbOyTvYeTSOJhPUucOnT
         82/jX9c5E4JtD0I2f4XA9O12GjyK66g18zbuNvJHKv8FCkqgZ6xMD5KQNHpfKS+/6u81
         TJCQZZG9KhlMNyVEIF6OXSt3eazn0PGXZevFe6+jp+np9oZ4Z7z+AhYlZUmN9pInDdDA
         H/B33JqiEklzXyBINUugweeh7AyaJcLd40D95A9vd6wCQcM36XaBAeOjtL82yZMF31V3
         NTSlVPgFKbEbNS12C/oPYefPrfi+zqEBxSF3UizHZQC/a0zuGTGynPVjokoCWOSheh71
         wBRg==
X-Gm-Message-State: ABy/qLZV0CFCsDxTuBVPDgybxxNAgWyVH2h0RPPYYHxELZOodljPJ0rj
        mn0ajDP9IrQCqfH9PDjcVQ==
X-Google-Smtp-Source: APBJJlFiKPEzsdA66+J+nkgsHoevEAp0S1+ccXmnkcPLRisdk5hiACZtuahO2gtQNu2JO5ENJ5PaaQ==
X-Received: by 2002:a6b:c40a:0:b0:783:344d:6b46 with SMTP id y10-20020a6bc40a000000b00783344d6b46mr5083783ioa.21.1689356914002;
        Fri, 14 Jul 2023 10:48:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u6-20020a02cb86000000b0042b298507b3sm2736649jap.42.2023.07.14.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:48:33 -0700 (PDT)
Received: (nullmailer pid 4061344 invoked by uid 1000);
        Fri, 14 Jul 2023 17:48:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     devicetree@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvdimm: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:48:13 -0600
Message-Id: <20230714174813.4061206-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/nvdimm/of_pmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 10dbdcdfb9ce..1b9f5b8a6167 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -2,11 +2,11 @@
 
 #define pr_fmt(fmt) "of_pmem: " fmt
 
-#include <linux/of_platform.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/libnvdimm.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 struct of_pmem_private {
-- 
2.40.1

