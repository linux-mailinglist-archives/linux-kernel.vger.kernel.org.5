Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335B87A20CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjIOOZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjIOOZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:25:26 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B8991FC9;
        Fri, 15 Sep 2023 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Dsb+v
        Z/wNzxU+PGqZgtnw0b5y8BiUmIVmNV8m8fD/4g=; b=KnI4wj6V3Xatl0tegnaIJ
        jDxAWlPaNZm8QNOt929kp+5bVpIqfSQp4p7vBv7yNF8QEo0J4B/GUkfauS3V2Yd5
        jmQnhHd/9ZPtd9KC430EwFtXJE/qTcgSWk2Rubijmx31ojCVfJwq8/r8vOQ+VY+W
        w70YknHulaJ4JikROVQLvo=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wDHjD39aARla9iYCA--.9810S4;
        Fri, 15 Sep 2023 22:24:08 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] net: sched: qfq: dont intepret cls results when asked to drop
Date:   Fri, 15 Sep 2023 22:23:55 +0800
Message-Id: <20230915142355.3411527-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHjD39aARla9iYCA--.9810S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW7uryUXr13uryUKrW7Arb_yoWDWFc_ua
        4v9r4fAr4fCr1rCw45Ar4qkrZ5KF92vw1fAanFyr9rJw1rAr93Ar1kC39xJ395WF1IkryU
        Xr90gan8GFnI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtdgA7UUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyAvrC1p7Lw-xjAAAsf
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If asked to drop a packet via TC_ACT_SHOT it is unsafe to
assume that res.class contains a valid pointer.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/sched/sch_qfq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 546c10adcacd..91c323eff012 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -696,6 +696,8 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 	fl = rcu_dereference_bh(q->filter_list);
 	result = tcf_classify(skb, NULL, fl, &res, false);
 	if (result >= 0) {
+		if (result == TC_ACT_SHOT)
+			return NULL;
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
@@ -703,8 +705,6 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 		case TC_ACT_TRAP:
 			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
 			fallthrough;
-		case TC_ACT_SHOT:
-			return NULL;
 		}
 #endif
 		cl = (struct qfq_class *)res.class;
-- 
2.37.2

