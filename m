Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3F7CBE16
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjJQIvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjJQIvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:51:03 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F50ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1697532658;
        bh=9uFm1swz/WuySLvKGXHbXWNCQTdIg19qp5EJ/O34ajM=;
        h=From:To:Subject:Date;
        b=BKRcoewoyh47KFeApgMNZ1G63acF/V+DNlaQ1/0h/GrGh2BprmZP3ySAX0eRrw9RR
         G/ZQNGAleU3e2LSg2llJx9JCSaIsDH8/W9n9xuvj2PRkz9xskTRSgWybxmc+iyogOg
         fosNjUDAnhV4jCxE/xdqQAf+OvEqBM6IRwT5Ku5I=
Received: from RT-NUC.. ([39.156.73.12])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id CB837072; Tue, 17 Oct 2023 16:50:56 +0800
X-QQ-mid: xmsmtpt1697532656ti2ncg7rd
Message-ID: <tencent_705C16DF25978ACAEBD1E83E228881901006@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtt4y1uxNGwZpRB3usmzxHRUaiJ+PZ0Y6gfxbVLShGIS5D6Yyldu
         aWbS43+6OvJjA9YQ3nK4x8QBLmqvkx3a9iPvIBrXfO1WiQuzHq/WhTlqvLcIlk0pzk3o62bJ+3o9
         wiXzBI0+i+L2t70AmnUW6C80wO6izz6Hwh6h0qscGqRJB5g7edjcE9h/7xJnlCOuBd5PWEv775jG
         Vq6eDiRRPZj81D63BiX5nEkF5dGUpNs6NYx0Cz86foBbQtHpk7aBCjXSF0h4lc8Oaw3byjJAi34y
         nNC+IpKFnVGFiKRFtGiDS3YdIq/0EktKed+lUfNcZ2mlJ3KtchAqnPDMFWOfDJ6XKRhmYQIDTqgc
         po5iHAawCC2DHvkquY+cj/swh2YNCVzC/DdvJIuRRDt7CPfFsFs5yNUS7D26CN6yO0NZ0eyiztqE
         8ijyplOxawiTUgP6os1l+5Ry/zBsa+12D7r/AZFHaZJqoe/q9HEphNf8pOUQuLBxWKUKRaFoPIl9
         Lyw/S94gFR9smyjBeVlAA6A44n0tBF/e0bzGqUBVTssmmL0CCzsTXryGMWFJAFTHFLz2prvoXIEI
         YUDnN/Q4iiIoDQSMkHHKi1f0pVUATWegwqF5LOn2WPrKHIb3mcMye5s31Fn1UCqsNevOLBarR492
         oCa2t8i+B+NCLvIl2ZE2U4yiS8L6IJKIzIJTrA8rdVWrvd0xi1f0UgZF/DmrCjyecFxaaB18MPa4
         4yg+x7jtDX2Fv6udOTcEHhkmo3nalpaE5xVJ6X9/GBL/7Y4l5cCpNCSL6yueGc0ji6InaMluL7jp
         sHOz1+5XzqY1qzlO2g9yljiQCbF1x+mz2j1ShTUu0BjoZXiuLYsY54satbG7AR+S2q8ADOOISM+I
         JW5PDwakYLPQO7HSScp3Jq4bEWjr948udXtSsoOioMuYcERKQduHreIoVY0DPWu/0TXhCR5n6LQq
         wyk9KRkNXlBq/W/oMu7Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Rong Tao <rtoax@foxmail.com>
To:     mark.rutland@arm.com, elver@google.com, tglx@linutronix.de,
        peterz@infradead.org, Rong Tao <rongtao@cestc.cn>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] stop_machine: Avoid potential race behaviour of multi_stop_data::state
Date:   Tue, 17 Oct 2023 16:50:52 +0800
X-OQ-MSGID: <20231017085053.263070-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.42.0
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

In commit b1fc58333575 ("stop_machine: Avoid potential race behaviour")
fix both multi_cpu_stop() and set_state() access multi_stop_data::state,
We should ensure that multi_stop_data::state is accessed using the rwonce
method.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/stop_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..73de9ab77132 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -191,7 +191,7 @@ static void set_state(struct multi_stop_data *msdata,
 static void ack_state(struct multi_stop_data *msdata)
 {
 	if (atomic_dec_and_test(&msdata->thread_ack))
-		set_state(msdata, msdata->state + 1);
+		set_state(msdata, READ_ONCE(msdata->state) + 1);
 }
 
 notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
-- 
2.42.0

