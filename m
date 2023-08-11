Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576FF779586
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjHKRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjHKRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA45530F0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A59B67759
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C77C433CA;
        Fri, 11 Aug 2023 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773272;
        bh=U6FUfmWsk+FhGtzYnlY3GoE5tLhV5tMKcMnNpThTCkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZV58pxKmzLSPMaZiCldsycJVqKgIEqoKHshWDQ8vgXi1SSW2VWucBhgjWu0xTUAfX
         pJRibgZKZPYK7uZQPAIniijse8V4bO/cabLnzly0V7fwRfipt0EweNB8BM0mzbR8q9
         +WfUOBx/78Qwz7EYKih5hY6fmZLBv1mPX8+oaa8JG8vBgNNUAGPfdGgxklEqOTjubV
         MGSzQA7TiORxR1kMRo5VA6drktmP7P/Usn0lNP8qIZIRNSo4KR4j5NwJzua0IDSjSW
         dmL1lK9qdaQsOE0Q66DOfOwtOzDD3elojxy+XAnIIVxxT5Iw2ee9Zi0H+2BAUfWR5A
         qWldTTNg4CfQw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 08/10] x86: Remove __current_clr_polling() from mwait_idle()
Date:   Fri, 11 Aug 2023 19:00:47 +0200
Message-Id: <20230811170049.308866-9-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811170049.308866-1-frederic@kernel.org>
References: <20230811170049.308866-1-frederic@kernel.org>
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

mwait_idle() is only ever called through by cpuidle, either from
default_idle_call() or from cpuidle_enter(). In any case
cpuidle_idle_call() sets again TIF_NR_POLLING after calling it so there
is no point for this atomic operation upon idle exit.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 72015dba72ab..f1eb769770b1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -918,7 +918,6 @@ static __cpuidle void mwait_idle(void)
 			raw_local_irq_disable();
 		}
 	}
-	__current_clr_polling();
 }
 
 void select_idle_routine(const struct cpuinfo_x86 *c)
-- 
2.34.1

