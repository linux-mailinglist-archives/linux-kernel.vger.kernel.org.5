Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203BA7980FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 05:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjIHDcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 23:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjIHDcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 23:32:03 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8971BDA;
        Thu,  7 Sep 2023 20:31:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vrb2bYr_1694143916;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vrb2bYr_1694143916)
          by smtp.aliyun-inc.com;
          Fri, 08 Sep 2023 11:31:56 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net/smc: bugfix for smcr v2 server connect success statistic
Date:   Fri,  8 Sep 2023 11:31:42 +0800
Message-Id: <20230908033143.89489-2-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230908033143.89489-1-guangguan.wang@linux.alibaba.com>
References: <20230908033143.89489-1-guangguan.wang@linux.alibaba.com>
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

In the macro SMC_STAT_SERV_SUCC_INC, the smcd_version is used
to determin whether to increase the v1 statistic or the v2
statistic. It is correct for SMCD. But for SMCR, smcr_version
should be used.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
---
 net/smc/smc_stats.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index b60fe1eb37ab..aa8928975cc6 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -243,8 +243,9 @@ while (0)
 #define SMC_STAT_SERV_SUCC_INC(net, _ini) \
 do { \
 	typeof(_ini) i = (_ini); \
-	bool is_v2 = (i->smcd_version & SMC_V2); \
 	bool is_smcd = (i->is_smcd); \
+	u8 version = is_smcd ? i->smcd_version : i->smcr_version; \
+	bool is_v2 = (version & SMC_V2); \
 	typeof(net->smc.smc_stats) smc_stats = (net)->smc.smc_stats; \
 	if (is_v2 && is_smcd) \
 		this_cpu_inc(smc_stats->smc[SMC_TYPE_D].srv_v2_succ_cnt); \
-- 
2.24.3 (Apple Git-128)

