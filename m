Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FBE7A1CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjIOK5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOK5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:57:54 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E644C1;
        Fri, 15 Sep 2023 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=K1WVK
        BLMutY4DqmK6xRjujxKt6vIdorbFmbMAqFpgAA=; b=G63GLx9GmkBYqRUVmi76r
        lLUNWLCFHMEGj7ctPoAKrwQY/y4BfhHQff3tSj7o1K+apdWy3T3wdNnRRGthxz7u
        NNj6RTNeBXMpv0FVXc5ebM9JIc1nyqB+tK6r445qHG08iCogM8XWM1dSZftp9i1N
        /Lgb/hDJKtseniVbn1EZ5M=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wB3NjN9OARlbOJwCA--.60164S4;
        Fri, 15 Sep 2023 18:57:12 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] net: sched: htb: dont intepret cls results when asked to drop
Date:   Fri, 15 Sep 2023 18:56:58 +0800
Message-Id: <20230915105658.3407020-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3NjN9OARlbOJwCA--.60164S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW7ury8Jr43Ar1kKw43trb_yoW3JFc_A3
        s7GFs3CF1xCFn5Gw47Ar40kryFk3WSv3Z7J39xKrs7Xw1FkrZ8Gr1kWFs3J393Wr42kFyU
        ZasFga45GrnIkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKfHUJUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFQTrC2B9oIcqyQAAso
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If asked to drop a packet via TC_ACT_SHOT it is unsafe to
assume that res.class contains a valid pointer.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/sched/sch_htb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 0d947414e616..5e8bd23d972f 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -243,6 +243,8 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
+		if (result == TC_ACT_SHOT)
+			return NULL;
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
-- 
2.37.2

