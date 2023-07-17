Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C87756BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjGQSS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjGQSSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AD41703;
        Mon, 17 Jul 2023 11:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0E0D611EB;
        Mon, 17 Jul 2023 18:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28798C433CD;
        Mon, 17 Jul 2023 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617903;
        bh=9le1Yp2JqpCktuy/Ds5vAtG09Rigc3XXHuPHaCwxaUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XiLrTR1Hxqlw5Mvng+sDv4ZxMSlNGj1ERs+NHyMPyNOyHi0NQw3n19yWc3iMT6xtu
         XUztLwl/+1x2MlS7gBaqT7wTrfgvqzltAT0hsd2fM0nbbQgg6PfckN1d6LB4ewsHfc
         oSyA0ubQXFSlL+RIpq7H2JO07YClNxD4sHM1CoioR/Z0iaClvUAsZHmulFWOtHlbjK
         CCxEvlpctS7aGWnmFoU+hk70oulENHpNkHdaC8+5PzLQmyTVYr3UKX0gMeGG3DCpNJ
         b1B3vQSypoY9Ivx4kvgh9D+8dLiKTTun6NFfw69g87Kqw4vOmRtnUu515hW2JGmH6t
         dgG6kSUJm/Jjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B07B7CE0836; Mon, 17 Jul 2023 11:18:22 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/4] scftorture: Add CONFIG_PREEMPT_DYNAMIC=n to NOPREEMPT scenario
Date:   Mon, 17 Jul 2023 11:18:20 -0700
Message-Id: <20230717181820.1098541-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <38be0135-a7a4-4c16-b2c6-1b3817c3067f@paulmck-laptop>
References: <38be0135-a7a4-4c16-b2c6-1b3817c3067f@paulmck-laptop>
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

It is no longer possible to build a kernel with a preemption-disabled
RCU without use of CONFIG_PREEMPT_DYNAMIC=n.  This commit therefore
adds CONFIG_PREEMPT_DYNAMIC=n to the scf torture type's NOPREEMPT
scenario file.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
index 3a59346b3de7..6133f54ce2a7 100644
--- a/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT
@@ -2,6 +2,8 @@ CONFIG_SMP=y
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
+#CHECK#CONFIG_PREEMPT_RCU=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
-- 
2.40.1

