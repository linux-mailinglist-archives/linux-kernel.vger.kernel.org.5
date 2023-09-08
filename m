Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440BF799110
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbjIHUhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbjIHUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:37:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B71E65;
        Fri,  8 Sep 2023 13:36:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF15FC433CC;
        Fri,  8 Sep 2023 20:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205397;
        bh=Myb0x4KbAYJfwZIc0cipS2HFSdskG2s5T9FsIJvmid8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0sLQb1ovYq4ry65mQo6nbCRm0BjIK14Q2Y2YTtP6N/G9GgJYl8Prsmdnw+BDxezF
         Suqz6NvTkljdrVQtGPL8+4AfFKJXj8JkWH2EKQSP3VrWg8X/MEx/RF/Kr8qn3IHOph
         xktc8JtPLSuSDv9HSn3VpgfpKVkyekrfBMUlFL8eCi2MXlBXisR3d7r2jwOUdolRd+
         e6irVd/fD8CK/MYu3uyV7sX9ofnl6AWI0WpzEI1ydA3ScvxKGBA7LAvzy2osae359i
         G8YDLc+OkrB8xt9vsPXMtjdTWF/vTZNg7kIBPM4xwn5k9frlEm5V80/6/0k4bThKf6
         6nzjFgjkIwhVw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 10/10] rcu: Comment why callbacks migration can't wait for CPUHP_RCUTREE_PREP
Date:   Fri,  8 Sep 2023 22:36:03 +0200
Message-ID: <20230908203603.5865-11-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908203603.5865-1-frederic@kernel.org>
References: <20230908203603.5865-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callbacks migration is performed through an explicit call from
the hotplug control CPU right after the death of the target CPU and
before proceeding with the CPUHP_ teardown functions.

This is unusual but necessary and yet uncommented. Summarize the reason
as explained in the changelog of:

	a58163d8ca2c (rcu: Migrate callbacks earlier in the CPU-offline timeline)

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index a41a6fff3c91..b135bb481be1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1352,7 +1352,14 @@ static int takedown_cpu(unsigned int cpu)
 	cpuhp_bp_sync_dead(cpu);
 
 	tick_cleanup_dead_cpu(cpu);
+
+	/*
+	 * Callbacks must be re-integrated right away to the RCU state machine.
+	 * Otherwise an RCU callback could block a further teardown function
+	 * waiting for its completion.
+	 */
 	rcutree_migrate_callbacks(cpu);
+
 	return 0;
 }
 
-- 
2.41.0

