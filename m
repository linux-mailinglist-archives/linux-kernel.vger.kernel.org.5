Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BC77DC48D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjJaChW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjJaChR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:37:17 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB712E;
        Mon, 30 Oct 2023 19:37:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvFb6Hm_1698719824;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VvFb6Hm_1698719824)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 10:37:05 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     dave.jiang@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com
Cc:     jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        tglx@linutronix.de
Subject: [PATCH v3 2/2] dmaengine: idxd: Fix incorrect descriptions for GRPCFG register
Date:   Tue, 31 Oct 2023 10:37:00 +0800
Message-Id: <20231031023700.1515974-3-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231031023700.1515974-1-guanjun@linux.alibaba.com>
References: <20231031023700.1515974-1-guanjun@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guanjun <guanjun@linux.alibaba.com>

Fix incorrect descriptions for the GRPCFG register which has three
sub-registers (GRPWQCFG, GRPENGCFG and GRPFLGCFG).
No functional changes

Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/registers.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 7b54a3939ea1..315c004f58e4 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -440,12 +440,14 @@ union wqcfg {
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
+ * The GRPCFG register block is divided into three sub-registers, which
+ * are GRPWQCFG, GRPENGCFG and GRPFLGCFG. The n index allows us to move
+ * to the register block that contains the three sub-registers.
+ * Each register block is 64bits. And the ofs gives us the offset
+ * within the GRPWQCFG register to access.
  */
 #define GRPWQCFG_OFFSET(idxd_dev, n, ofs) ((idxd_dev)->grpcfg_offset +\
 					   (n) * GRPCFG_SIZE + sizeof(u64) * (ofs))
-- 
2.39.3

