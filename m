Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200347541B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjGNRwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbjGNRwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:31 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622F035B3;
        Fri, 14 Jul 2023 10:51:59 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-78625caa702so86594139f.1;
        Fri, 14 Jul 2023 10:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356998; x=1691948998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEIKeE5pM9zn9D8Srf35AY3/pDLGKpItW+k06EDlZ4c=;
        b=T+glcA/GY2in6tncWfqRwgewx+njuySKLH4W/3brlllKqRKpl4oN8siRhvtlbHky9T
         xoQJCcaYRmqJ52iDvSz7rqMEL05L8AasBVietGVMwEbPi6qOa961SzhZ/CVIGWV7jKtv
         dF3XYBMtFGB9PLS5g2vqw6saaqtHMZT7rPuZP/60nHW4XTHpc0ui6SixthLwjbjdUilg
         eUkXwqFO7HvPIX1RmxW3Eno0KipOaBBxAYqb7EB7ub/r37M8q7+ug5l5827qYI1uPaGk
         CN/cKpkpveLwKvKogIJt4EKFIvF3MCPVncqtbtTVI5WARCkxt12ZyD7bjzLpMi8ZIFoj
         I41A==
X-Gm-Message-State: ABy/qLYVawoLV4jRHHGINCr3dQRUs6FzT1MKtR+Oqf+gh4pWDe1/Cwoc
        9vcDqwigf4WlG6tcRQSGTg==
X-Google-Smtp-Source: APBJJlF8MQmWVa6E2TnegdqPcO3I1VDTQ1vLGqnfLDaaes0YHjMlxxjcIMvwXsd2XFLbvrUUN/Wh3Q==
X-Received: by 2002:a6b:5b08:0:b0:787:1990:d2ec with SMTP id v8-20020a6b5b08000000b007871990d2ecmr5563567ioh.12.1689356998520;
        Fri, 14 Jul 2023 10:49:58 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x25-20020a6bda19000000b00786dffc04e2sm2772310iob.25.2023.07.14.10.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:49:57 -0700 (PDT)
Received: (nullmailer pid 4063275 invoked by uid 1000);
        Fri, 14 Jul 2023 17:49:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Richard Cochran <richardcochran@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ptp: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:49:22 -0600
Message-Id: <20230714174922.4063153-1-robh@kernel.org>
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
 drivers/ptp/ptp_qoriq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 350154e4c2b5..a52859d024f0 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
-- 
2.40.1

