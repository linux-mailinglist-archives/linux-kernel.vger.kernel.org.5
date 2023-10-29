Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5967E7DABBA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 09:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjJ2IBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 04:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjJ2IBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 04:01:02 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A772F3;
        Sun, 29 Oct 2023 01:00:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vv31XX4_1698566453;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0Vv31XX4_1698566453)
          by smtp.aliyun-inc.com;
          Sun, 29 Oct 2023 16:00:53 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     dave.jiang@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com
Cc:     jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        tglx@linutronix.de
Subject: [PATCH v1 2/2] dmaengine: idxd: Fix the incorrect descriptions
Date:   Sun, 29 Oct 2023 16:00:49 +0800
Message-Id: <20231029080049.1482701-3-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231029080049.1482701-1-guanjun@linux.alibaba.com>
References: <20231029080049.1482701-1-guanjun@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guanjun <guanjun@linux.alibaba.com>

Fix the incorrect descriptions for the GRPCFG register.
No functional changes

Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 drivers/dma/idxd/registers.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 7b54a3939ea1..385a162a55f2 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -440,12 +440,15 @@ union wqcfg {
 /*
  * This macro calculates the offset into the GRPCFG register
  * idxd - struct idxd *
- * n - wq id
- * ofs - the index of the 32b dword for the config register
+ * n - group id
+ * ofs - the index of the 64b qword for the config register
  *
- * The WQCFG register block is divided into groups per each wq. The n index
- * allows us to move to the register group that's for that particular wq.
- * Each register is 32bits. The ofs gives us the number of register to access.
+ * The GRPCFG register block is divided into three different types, that
+ * includes GRPWQCFG, GRPENGCFG and GRPFLGCFG. The n index in each group
+ * allows us to move to the register group that's for that particular wq,
+ * engine or group flag.
+ * Each register is 64bits. And the ofs in GRPWQCFG gives us the number
+ * of register to access.
  */
 #define GRPWQCFG_OFFSET(idxd_dev, n, ofs) ((idxd_dev)->grpcfg_offset +\
 					   (n) * GRPCFG_SIZE + sizeof(u64) * (ofs))
-- 
2.39.3

