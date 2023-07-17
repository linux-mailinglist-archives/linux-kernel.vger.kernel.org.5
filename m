Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B20756BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjGQSUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGQSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D5A1;
        Mon, 17 Jul 2023 11:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D2CF611EC;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0864BC433CC;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618044;
        bh=iHNmBa5tMI1wuSUKoilqIbnxR2gN+BPPdLAg8CpbuqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oT+mWmZo0G+GJOjCsxtjOtAnu3MLgCvdPcgj96HKkkxDbsoJPuI4pDIjxhWItNQFV
         PtcA2oDvnJVDJWxbk6MTWGhqKSIGbtfzXz2dhkFyHIIVCvKFz0l2fnePBTn7OZcDRr
         57810WoY+7n7zfMKTZg/a0Yzm9UBZIDSfRbW8I6oZBSgC5AAeQdVVvsIaXsKgdfuR2
         /No8QlypXYybViq53nziKVyECTA3ugWtB4XXuiNlAfQuT+u2OI3YBl8IxMLQycQNnk
         G9h7/j7DI7CGWxbScOAFYY4vt1SlRh49KxByvOCB/u6a1tc5RxfychLZvOtOhuYXq4
         b+ZnQIpI6u7cQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 93017CE0836; Mon, 17 Jul 2023 11:20:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/9] torture: Make torture_hrtimeout_*() use TASK_IDLE
Date:   Mon, 17 Jul 2023 11:20:37 -0700
Message-Id: <20230717182042.1098651-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
References: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that it is expected that more code will use torture_hrtimeout_*(),
including for longer timeouts, make it use TASK_IDLE instead of
TASK_UNINTERRUPTIBLE.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index db79197e257a..836fefa44373 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -96,7 +96,7 @@ int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, struct torture_random_s
 
 	if (trsp)
 		hto += (torture_random(trsp) >> 3) % fuzzt_ns;
-	set_current_state(TASK_UNINTERRUPTIBLE);
+	set_current_state(TASK_IDLE);
 	return schedule_hrtimeout(&hto, HRTIMER_MODE_REL);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_ns);
-- 
2.40.1

