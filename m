Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E6F7BFA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjJJMBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjJJMBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:01:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A049183;
        Tue, 10 Oct 2023 05:00:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E92AC433C8;
        Tue, 10 Oct 2023 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939232;
        bh=WjajcRSI0f6RpjQNiJdpi/EFUKeHV3KUSmO6ZEPHXJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SevFf07qfzV2qTiFE9fXw9e6IR+4fkyxBlhySJCNXIhwT4PZBAqNrh4SUOD0tLRUD
         /ZF7HtUlGMz4rFj2HbfuY6MkDOIClndbUOS2oycNRsFLfpWdMx5fOc6Z9/OcueeNth
         Q9A/nLfYQBHa27C1KPuOjzp1yo/ncLqTEXc35E1u8LQAEXSwQDMuOPpO8shZYMPIQa
         PelcEAmuHe8MKOLrM7TUPmV+cOExoWLSwZ/pVJ4ZYutDkn8OITZ5VPZsfuE3wcVU9l
         dZ+p7DFDqpuglf63lcFh2RihU3zgf/3V7mnpFe1cYOC7vGZEUW6b8iS7M3Tz+fMXii
         Oau8KEtqgbaXQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Zqiang <qiang.zhang1211@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 21/23] rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()
Date:   Tue, 10 Oct 2023 13:59:19 +0200
Message-Id: <20231010115921.988766-22-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang1211@gmail.com>

Currently, the maxcpu is set by traversing online CPUs, however, if the
rcutorture.onoff_holdoff is set zero and onoff_interval is set non-zero,
and the some CPUs with larger cpuid has been offline before setting
maxcpu, for these CPUs, even if they are online again, also cannot
be offload or deoffload.  This can result in rcutorture attempting to
(de-)offload CPUs that have never been online, but the (de-)offload code
handles this.

This commit therefore use for_each_possible_cpu() instead of
for_each_online_cpu() in rcu_nocb_toggle().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8136fec0310b..b17ad45cd67e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2126,7 +2126,7 @@ static int rcu_nocb_toggle(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
 	while (!rcu_inkernel_boot_has_ended())
 		schedule_timeout_interruptible(HZ / 10);
-	for_each_online_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		maxcpu = cpu;
 	WARN_ON(maxcpu < 0);
 	if (toggle_interval > ULONG_MAX)
-- 
2.34.1

