Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7A87D11ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377603AbjJTO5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377529AbjJTO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:57:14 -0400
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43C2D46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1697813828;
        bh=JHbwUQb8lD1tTuEb5a8cmghLPuMYhOm9x0/pntObncg=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=uxSF6WrwYctZlChw7piyjZL3T4n6sMLbQzZCeEN9haHN1R+4FLXl5giJKUIfsDX3B
         ZwWrXq+FpQL+s2EKqcEylSpnyveny9DxZJohfQINChYEP4Wbv8oJleucEzHieUP4xt
         tNw+N9W6JUcyHe9MvaSCM0G3MlM42BX8NOJOwn+k=
Received: from rtoax.lan ([120.245.114.36])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id AE3AEEEC; Fri, 20 Oct 2023 22:43:35 +0800
X-QQ-mid: xmsmtpt1697813020tebywjqps
Message-ID: <tencent_3B1BE2B20183906E56D9E58C4AE4EBC62806@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujuOVB48/Os70qsluFoiNYAhE4QPkzGQOyy7m7FTfareKCeYGFHS
         HihtYz16ET3FQGu+TcR4ZrkeLHMvR6w0pcQuzzfvQSdHaRxbOo6o1yPVU5pTQ5QlVkiMKQv5dAMn
         GhJXqifhL+hBkHmCIgvbYC3GAZRl2sKa7cUz5mJRxRJQ0Nt/sH/UlofAUWa40yiF19hmfF/niNg7
         gNmRK68X9WtPa1HhNrnUBUvm9204LQXbd3Yinskj+MuYafHaHmeCcmcPzGIRNhAKP7HgWfLcZoLh
         2CrOg1vLWd34j2oLvek9cUbR9DmfBrS2C6T56Hd2yXLQhDr4T8g+oeAtmvGM7O9OqXJyILhhDz0A
         x+fsPRqLJIudCt7PLGnLb2YUqCycL7DM5SWvbKedg3mb6KXqbzhjcng6qaqxQmqfQP14vUB087WW
         XoR6VbsEq+FL6IzFREdS4dSQNY3M2Cy50PlRzk5C4c8uz79jAmf9aNQotrjTxFrYeVfLxbQ/renI
         HCYl27eHbP0yTzUEdcAP595is+6SVJcN14Sz0J61IqSUaPeTTg/VBVlGRMxKOpKBWJwUTgpmrxHs
         jtSnuOmausx72KeWPXeRVaI0lvxIAoJWJwMIEHSw4tMARTnlEf0zma9MQksyAY3dXaKo5UfaU6nF
         o4k7VZZzeeFkglSuRcNWx7w0GubTN6Skng3sEHlxUEiAxpyHMhd+Xz9WpI6VbJq5qsjCExPg1YVB
         ZjhJgBsiiq7GxSZkTDyd9bt6OlHPcKC8mgradRT9aHlCgWnUwHddtbS/FSghaiXD+NSHIjHaaudd
         7PVrtsasopKMr2nV8y3JVb7Q2e0Bv0h5SKEQw/fevxCLUTX0rVvvd3KtRsVIiZXDP7oViUuNOBT8
         u846eVq0Griww4+dqLJUXrKJT0RA2VE3WI1v1+9TIAj/97l0xTL7TVPfvT7P/ikzhBWxzh+Jpvn/
         tyrheEl15NJr2PttV3SBFZd9vEHMF0DYojW0yW/X7+BlU1c5GndAU7K1di62v2uvp2kp7Fma6dYE
         GzVLxEq0PW5O52yLfX8/BAqN9xunw=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Rong Tao <rtoax@foxmail.com>
To:     mark.rutland@arm.com, elver@google.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rongtao@cestc.cn, rtoax@foxmail.com, tglx@linutronix.de
Subject: [PATCH 2/2] stop_machine: Apply smp_store_release() to multi_stop_data::state
Date:   Fri, 20 Oct 2023 22:43:34 +0800
X-OQ-MSGID: <f86cefda1e6d0b29a444c5b7451d0222d686fd36.1697811778.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697811778.git.rongtao@cestc.cn>
References: <cover.1697811778.git.rongtao@cestc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Replace smp_wmb()+WRITE_ONCE() with smp_store_release() and add comment.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/stop_machine.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 268c2e581698..cdf4a3fe0348 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -183,8 +183,10 @@ static void set_state(struct multi_stop_data *msdata,
 {
 	/* Reset ack counter. */
 	atomic_set(&msdata->thread_ack, msdata->num_threads);
-	smp_wmb();
-	WRITE_ONCE(msdata->state, newstate);
+	/* This smp_store_release() pair with READ_ONCE() in multi_cpu_stop().
+	 * Avoid potential access multi_stop_data::state race behaviour.
+	 */
+	smp_store_release(&msdata->state, newstate);
 }
 
 /* Last one to ack a state moves to the next state. */
-- 
2.41.0

