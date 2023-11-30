Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31E57FEDD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345292AbjK3L2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbjK3L2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:28:38 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41A710F5;
        Thu, 30 Nov 2023 03:28:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VxROoMX_1701343715;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VxROoMX_1701343715)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 19:28:37 +0800
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
Subject: [PATCH net-next v3 6/7] net/smc: disable SEID on non-s390 archs where virtual ISM may be used
Date:   Thu, 30 Nov 2023 19:28:14 +0800
Message-Id: <1701343695-122657-7-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system EID (SEID) is an internal EID used by SMC-D to represent the
s390 physical machine that OS is executing on. On s390 architecture, it
predefined by fixed string and part of cpuid and is enabled regardless
of whether underlay device is virtual ISM or platform firmware ISM.

However on non-s390 architectures where SMC-D can be used with virtual
ISM devices, there is no similar information to identify physical
machines, especially in virtualization scenarios. So in such cases, SEID
is forcibly disabled and the user-defined UEID will be used to represent
the communicable space.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_clc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 2d8bc0b..ead2e2e 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -155,10 +155,12 @@ static int smc_clc_ueid_remove(char *ueid)
 			rc = 0;
 		}
 	}
+#if IS_ENABLED(CONFIG_S390)
 	if (!rc && !smc_clc_eid_table.ueid_cnt) {
 		smc_clc_eid_table.seid_enabled = 1;
 		rc = -EAGAIN;	/* indicate success and enabling of seid */
 	}
+#endif
 	write_unlock(&smc_clc_eid_table.lock);
 	return rc;
 }
@@ -273,22 +275,30 @@ int smc_nl_dump_seid(struct sk_buff *skb, struct netlink_callback *cb)
 
 int smc_nl_enable_seid(struct sk_buff *skb, struct genl_info *info)
 {
+#if IS_ENABLED(CONFIG_S390)
 	write_lock(&smc_clc_eid_table.lock);
 	smc_clc_eid_table.seid_enabled = 1;
 	write_unlock(&smc_clc_eid_table.lock);
 	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 int smc_nl_disable_seid(struct sk_buff *skb, struct genl_info *info)
 {
 	int rc = 0;
 
+#if IS_ENABLED(CONFIG_S390)
 	write_lock(&smc_clc_eid_table.lock);
 	if (!smc_clc_eid_table.ueid_cnt)
 		rc = -ENOENT;
 	else
 		smc_clc_eid_table.seid_enabled = 0;
 	write_unlock(&smc_clc_eid_table.lock);
+#else
+	rc = -EOPNOTSUPP;
+#endif
 	return rc;
 }
 
@@ -1300,7 +1310,11 @@ void __init smc_clc_init(void)
 	INIT_LIST_HEAD(&smc_clc_eid_table.list);
 	rwlock_init(&smc_clc_eid_table.lock);
 	smc_clc_eid_table.ueid_cnt = 0;
+#if IS_ENABLED(CONFIG_S390)
 	smc_clc_eid_table.seid_enabled = 1;
+#else
+	smc_clc_eid_table.seid_enabled = 0;
+#endif
 }
 
 void smc_clc_exit(void)
-- 
1.8.3.1

