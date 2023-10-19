Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223337CECA6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjJSAPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSAPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:15:16 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D76E114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1697674509;
        bh=hnxxIpZ8NjvfQ45DRLgFlfpkz9K7rWLl47wksLh86AY=;
        h=From:To:Subject:Date;
        b=fu9rVy88v3T1/hGl2JJFv3UE/gyolWc90RuwNpcE4yWVpIEIQHfMCz7tpFlByJ/il
         s2jM+IFwXU2ze0X+y7/hCb+1ZYsxZXk9ysedMY2qyvD+hucua1mRyGkPS9ZDWa/h3N
         PrPXsSFZVa7iGOCGl9ZeiaDWi7V7hDZeMQ7RuD7U=
Received: from RT-NUC.. ([39.156.73.12])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 2DAA0C4A; Thu, 19 Oct 2023 08:11:26 +0800
X-QQ-mid: xmsmtpt1697674286tihb8ygf5
Message-ID: <tencent_4CD220721A6C0B39670D5D52AAE4BD2A8F0A@qq.com>
X-QQ-XMAILINFO: NiAdzfE16ND44TJ/oeIGmlBa/ESiFxlAPa2rvifXfxu47kULg2W/yRCHdaIjBp
         fU821CkTQSeMqlajNZOASck+jit4Bv8D+lnvI9JhdQKiOLgzdMpScUeGQtcYLb7X7pieUHR55Eih
         Sh9G0UNONQGUEYfm6sKkhoByvCxqM3/j3PcIng6UDw3aOPtsKlPh9JWfiRk0TVFJj6JLz1pk7Wdw
         QrljA31fjPbaUdyXNcQiuiMLoyjsM9YDw4p/NcH0GeZOBQeFByQ+1hZl8ToKbIBv7S9YEvQxPLsV
         cZhx/0AEIJGBsEPYRoZGiNVhVeaA2QJALbBNj475wyhzcOi4cIgGiF154n5nuGpdcZVGiuW85kQs
         gefeZGS0pAEtiThIm6CC78mqzEW5Y+v9VtTFxNpy8yp8FPBqYsNkW71oVwsW4yaICqpDOdFZkNcb
         EVZtYmfBy0xYxsnw5RXtA0qtg1Pae5Bdu2KtFtTQah3HebHk8CB1BPDvzJ1b2iu6poE8A2Ev+qvh
         9cyQ9tab/dPdOhbVapLUVzXpV2ANz+5yhfKgPzobMwtcIMrpZegaI3LmX0fl6i4NlOGD5kfu8TV1
         Figg3VHGrPphupYuFgPALhOhS9vAAq9a9ZVWVRN1ARvBq5s27jykHDCABYzmq8FHKU/cVkukRL5E
         +1U+fizpadtJ5pkyEmFt9lkL1EWNq0FPGsN9eex2Q5Cg4jPpFKoL4vHqpc1cpdkOK8zLrHQvIFR1
         1C4JYrXLOj2ytZWEZJeKADu9hX7lcjVteFLZfOtLW5Mu478DoKYdvLROfC7nsqHU/CBwvS5TTz5q
         1z3zGqCBAeLvmwnz1yDcZpfFvzFSeoe6naaBCk54OZaYDEhjUT9WZH5xkgIE5HcaNnGeTEtTS/c4
         JiGH3WpWLHXQYvfa6J9H/4BYWXihg5UDwgGA/NEeDJoJM4FJ7ygmPqWfmtiXiyEjybPD28lzZvTi
         5yR8u7/7dFZKbS5BLYAU9L/sNhIBvj
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Rong Tao <rtoax@foxmail.com>
To:     elver@google.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, rongtao@cestc.cn,
        tglx@linutronix.de
Subject: [PATCH v2] stop_machine: Avoid potential non-atomic read of multi_stop_data::state
Date:   Thu, 19 Oct 2023 08:11:23 +0800
X-OQ-MSGID: <20231019001123.289324-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

In commit b1fc58333575 ("stop_machine: Avoid potential race behaviour")
fix both multi_cpu_stop() and set_state() access multi_stop_data::state,
Pass curstate as a parameter to ack_state(), to avoid the non-atomic read.

And replace smp_wmb()+WRITE_ONCE() with smp_store_release().

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v1: stop_machine: Avoid potential race behaviour of multi_stop_data::state
    https://lore.kernel.org/lkml/tencent_705C16DF25978ACAEBD1E83E228881901006@qq.com/
---
 kernel/stop_machine.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..35a122ce2cbd 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -183,15 +183,15 @@ static void set_state(struct multi_stop_data *msdata,
 {
 	/* Reset ack counter. */
 	atomic_set(&msdata->thread_ack, msdata->num_threads);
-	smp_wmb();
-	WRITE_ONCE(msdata->state, newstate);
+	smp_store_release(&msdata->state, newstate);
 }
 
 /* Last one to ack a state moves to the next state. */
-static void ack_state(struct multi_stop_data *msdata)
+static void ack_state(struct multi_stop_data *msdata,
+		      enum multi_stop_state curstate)
 {
 	if (atomic_dec_and_test(&msdata->thread_ack))
-		set_state(msdata, msdata->state + 1);
+		set_state(msdata, curstate + 1);
 }
 
 notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
@@ -242,7 +242,7 @@ static int multi_cpu_stop(void *data)
 			default:
 				break;
 			}
-			ack_state(msdata);
+			ack_state(msdata, curstate);
 		} else if (curstate > MULTI_STOP_PREPARE) {
 			/*
 			 * At this stage all other CPUs we depend on must spin
-- 
2.42.0

