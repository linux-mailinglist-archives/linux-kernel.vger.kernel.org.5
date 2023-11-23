Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D258F7F5EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345257AbjKWMGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345243AbjKWMG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:06:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1FD9D56
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:06:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B457D1042;
        Thu, 23 Nov 2023 04:07:18 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.3.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A56DA3F7A6;
        Thu, 23 Nov 2023 04:06:30 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 3/4] coresight: Fix undeclared variable warnings from sparse checker
Date:   Thu, 23 Nov 2023 12:04:58 +0000
Message-Id: <20231123120459.287578-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123120459.287578-1-james.clark@arm.com>
References: <20231123120459.287578-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including the header with the declarations fixes the following warning
with a C=1 build:

  coresight-cfg-afdo.c:102:27: warning: symbol 'strobe_etm4x' was not declared. Should it be static?
  coresight-cfg-afdo.c:141:26: warning: symbol 'afdo_etm4x' was not declared. Should it be static?

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-cfg-afdo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-cfg-afdo.c b/drivers/hwtracing/coresight/coresight-cfg-afdo.c
index 84b31184252b..e794f2e145fa 100644
--- a/drivers/hwtracing/coresight/coresight-cfg-afdo.c
+++ b/drivers/hwtracing/coresight/coresight-cfg-afdo.c
@@ -9,6 +9,7 @@
 /* ETMv4 includes and features */
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 #include "coresight-etm4x-cfg.h"
+#include "coresight-cfg-preload.h"
 
 /* preload configurations and features */
 
-- 
2.34.1

