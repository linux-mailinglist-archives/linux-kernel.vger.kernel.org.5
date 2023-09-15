Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61C17A1CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjIOK6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOK6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:58:45 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21E2BC1;
        Fri, 15 Sep 2023 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hVRnp
        EUZSCPA491Uf7WZAIn/tXpJjt1+TU/JWu95kNM=; b=niYCBME7bGc3O+96PWUUH
        fGFTppRL+yCXCyLA+4OnaziiD6fR4nQ32CAtEivYgB/Bq5W9wRO9+oHWqpu3D9ix
        tyMif4hlud9B1qq22AR897pjDiXtoI+6ET2i9csNVAo/GDGkBkbHmx2dFbFQoxOI
        Nvooe1bahrEMRqDxE4jY+k=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wDHwtj1NARlVoxVAQ--.3032S4;
        Fri, 15 Sep 2023 18:42:08 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] net: sched: drr: dont intepret cls results when asked to drop
Date:   Fri, 15 Sep 2023 18:41:56 +0800
Message-Id: <20230915104156.3406380-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHwtj1NARlVoxVAQ--.3032S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW7ur45AF1xtF17JFyftFb_yoW3GFX_ua
        4rGFZ3Jr4xuF1UCw47tF4UC395GF1Iv3W8Jwn7tFyDW3yFvr98Jr1kWFZ3X3s5Gr42kFyU
        XrnFgFyrKr9FgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKpnQ7UUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRDrC2B9oIcHeQAAsh
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
assume res.class contains a valid pointer.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/sched/sch_drr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 19901e77cd3b..2b854cb6edf9 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -309,6 +309,8 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	fl = rcu_dereference_bh(q->filter_list);
 	result = tcf_classify(skb, NULL, fl, &res, false);
+	if (result == TC_ACT_SHOT)
+		return NULL;
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
-- 
2.37.2

