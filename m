Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74711757F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjGROct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjGROcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2088F19A8;
        Tue, 18 Jul 2023 07:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FEE9615F1;
        Tue, 18 Jul 2023 14:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9420C433CA;
        Tue, 18 Jul 2023 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689690693;
        bh=ba3m1s5WPrhUSyocwM9OpDXR60J3dyTCWqkB5ZsXqTU=;
        h=From:To:Cc:Subject:Date:From;
        b=CGkea7uNB7yXm/lGqzPbFWkizwThuRpV+QhDaIu4p4CI2EPiB+OHxY1rP+QppgZ6s
         29N9d99mnaHOO6e7pHcv1IcEHIYTTgxtaqtLfjbHJZKe/WJwNWmQf3a8bOiPBDRR+M
         CLb0cSSK/Z80pqabj2JeEIa/nsPZS2uIW3ZrEtFpv+u6xwfQf0RBtTwpeTe9umOTn8
         5CGT0wD6WVp+OPTQsSXtMd6Hi7C7EXQSrzXgoPOrkbh/zz3ykiUk0elWSlbAbFDM5j
         sCdcUFTfSz98Ka2/n5N9ZghuI1SdyK5t2muCjC6XzgS7OfthUru8wGznBVkb4vNGho
         tyqz2MaAJWG2w==
Received: (nullmailer pid 1066123 invoked by uid 1000);
        Tue, 18 Jul 2023 14:31:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     devicetree@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwtracing: coresight: Explicitly include correct DT includes
Date:   Tue, 18 Jul 2023 08:31:24 -0600
Message-Id: <20230718143124.1065949-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
v2:
- Fix double include of of.h
---
 drivers/hwtracing/coresight/coresight-core.c     | 2 +-
 drivers/hwtracing/coresight/coresight-platform.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 118fcf27854d..9fabe00a40d6 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -17,7 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/coresight.h>
-#include <linux/of_platform.h>
+#include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
 
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 3e2e135cb8f6..27ca22c5104f 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -9,9 +9,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_graph.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 #include <linux/coresight.h>
-- 
2.40.1

