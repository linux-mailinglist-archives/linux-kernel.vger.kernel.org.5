Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7F771A55
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjHGG1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjHGG1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:27:36 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862BE10F9;
        Sun,  6 Aug 2023 23:27:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpANHwl_1691389649;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpANHwl_1691389649)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 14:27:29 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 net-next 6/6] net/smc: Extend SMCR v2 linkgroup netlink attribute
Date:   Mon,  7 Aug 2023 14:27:20 +0800
Message-Id: <20230807062720.20555-7-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
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

Add SMC_NLA_LGR_R_V2_MAX_CONNS and SMC_NLA_LGR_R_V2_MAX_LINKS
to SMCR v2 linkgroup netlink attribute SMC_NLA_LGR_R_V2 for
linkgroup's detail info showing.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
---
 include/uapi/linux/smc.h | 2 ++
 net/smc/smc_core.c       | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index bb4dacca31e7..837fcd4b0abc 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -107,6 +107,8 @@ enum {
 enum {
 	SMC_NLA_LGR_R_V2_UNSPEC,
 	SMC_NLA_LGR_R_V2_DIRECT,	/* u8 */
+	SMC_NLA_LGR_R_V2_MAX_CONNS,	/* u8 */
+	SMC_NLA_LGR_R_V2_MAX_LINKS,	/* u8 */
 	__SMC_NLA_LGR_R_V2_MAX,
 	SMC_NLA_LGR_R_V2_MAX = __SMC_NLA_LGR_R_V2_MAX - 1
 };
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d5967826bcdf..182ac69d25c8 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -319,6 +319,10 @@ static int smc_nl_fill_smcr_lgr_v2(struct smc_link_group *lgr,
 		goto errattr;
 	if (nla_put_u8(skb, SMC_NLA_LGR_R_V2_DIRECT, !lgr->uses_gateway))
 		goto errv2attr;
+	if (nla_put_u8(skb, SMC_NLA_LGR_R_V2_MAX_CONNS, lgr->max_conns))
+		goto errv2attr;
+	if (nla_put_u8(skb, SMC_NLA_LGR_R_V2_MAX_LINKS, lgr->max_links))
+		goto errv2attr;
 
 	nla_nest_end(skb, v2_attrs);
 	return 0;
-- 
2.24.3 (Apple Git-128)

