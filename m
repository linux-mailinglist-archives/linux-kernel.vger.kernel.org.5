Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC807F06AD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjKSN6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjKSN6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:58:24 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FF9D5B;
        Sun, 19 Nov 2023 05:58:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VweihWZ_1700402287;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VweihWZ_1700402287)
          by smtp.aliyun-inc.com;
          Sun, 19 Nov 2023 21:58:09 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, raspl@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/7] net/smc: define a reserved CHID range for virtual ISM devices
Date:   Sun, 19 Nov 2023 21:57:54 +0800
Message-Id: <1700402277-93750-5-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
References: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to virtual ISM support feature defined by SMCv2.1, CHIDs in
the range 0xFF00 to 0xFFFF are reserved for use by virtual ISM devices.

And two helpers are introduced to distinguish virtual ISM devices from
the existing platform firmware ISM devices.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 832b2f4..d1228a6 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -15,6 +15,8 @@
 
 #include "smc.h"
 
+#define SMC_VIRTUAL_ISM_CHID_MASK	0xFF00
+
 struct smcd_dev_list {	/* List of SMCD devices */
 	struct list_head list;
 	struct mutex mutex;	/* Protects list of devices */
@@ -56,4 +58,22 @@ static inline int smc_ism_write(struct smcd_dev *smcd, u64 dmb_tok,
 	return rc < 0 ? rc : 0;
 }
 
+static inline bool __smc_ism_is_virtual(u16 chid)
+{
+	/* CHIDs in range of 0xFF00 to 0xFFFF are reserved
+	 * for virtual ISM device.
+	 *
+	 * loopback-ism:	0xFFFF
+	 * virtio-ism:		0xFF00 ~ 0xFFFE
+	 */
+	return ((chid & 0xFF00) == 0xFF00);
+}
+
+static inline bool smc_ism_is_virtual(struct smcd_dev *smcd)
+{
+	u16 chid = smcd->ops->get_chid(smcd);
+
+	return __smc_ism_is_virtual(chid);
+}
+
 #endif
-- 
1.8.3.1

