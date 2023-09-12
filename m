Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F011B79CEAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjILKpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjILKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:44:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520A11982
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:44:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36007C433C7;
        Tue, 12 Sep 2023 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694515462;
        bh=wNRp0lSuxwMF/JBQ5Mv5SUmlz7jkA1SazJ3u0SEnyQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRiMFQ3TZg0b5e2/UXpeqpL962IQg/Dw5AKU6Z6/L9QPyYyo5R/qFsbM+dIFQKsCT
         ctbs2cJujr/63bxzP1T1GNjK0rVUGAkCoWGd00x1CzZK2R+YISC8hZXIBqlh7AIRMm
         voH1VupgLpwxumQEJPwbP9D0FMv9hOLHM4E9o70nPc4T8sbucC6iyRV8ERv+Uus/tJ
         8jNVqm1tm/q52P/qzjGJMi8+US5jZ+7Pseb0ol1SmDb3qEb/j3GaBJOfJQu913qb/0
         2j4m74AB9JhG3BGCXZ/wbs88J4wdIgVx2H9UlBNYD5mqTpEF43sjB2ow3cOFbSjR1q
         JCY7cTnrD5Pwg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Xueshi Hu <xueshi.hu@smartx.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>, vineethrp@gmail.com
Subject: [PATCH 4/5] tick/nohz: remove unused tick_nohz_idle_stop_tick_protected()
Date:   Tue, 12 Sep 2023 12:44:05 +0200
Message-Id: <20230912104406.312185-5-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912104406.312185-1-frederic@kernel.org>
References: <20230912104406.312185-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xueshi Hu <xueshi.hu@smartx.com>

All the caller has been removed since commit 336f560a8917 ("x86/xen: don't
let xen_pv_play_dead() return")

Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/tick.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 9459fef5b857..716d17f31c45 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -140,14 +140,6 @@ extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
-
-static inline void tick_nohz_idle_stop_tick_protected(void)
-{
-	local_irq_disable();
-	tick_nohz_idle_stop_tick();
-	local_irq_enable();
-}
-
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
@@ -170,8 +162,6 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
-
-static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
-- 
2.34.1

