Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE5756BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGQSUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGQSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9C10D8;
        Mon, 17 Jul 2023 11:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75742611D4;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D529AC433C7;
        Mon, 17 Jul 2023 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618043;
        bh=9N1zqkCJH9SNDZWV9ht6RHlfnWm8AY70Ut+G1/Medxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntGTK4Mrf1jtLI7Q9eH7uIuHF9R9DVeH/IdbtxBupgd7RiHAmlQ1jYMpPva1d3IEV
         57vbKFGHgjGrvxsAyK4Bw/oRn7eIIqgaVpxYEGaLXn12ejGNU8Tp3CP71HdhNt7ROK
         BQyOKUdZDEkmVHZateVDNVohqzi62Z06/KJVXr+9k2TuPFgFg5Q6WjlkcMrOEgVFBk
         shLGvrzTfS03ghw9qtZ2d/+JfFGmhiu1uKy2UzoAmAujAHDKUW+W++ixJsvBtF7Zfn
         lnqsO0Jz8Ik8kAxu4Xf3BTLdz8ZT4kMWgyYfmQievGiwiKTq8QkSBvaJVSdX26SeI1
         duixVXVgLvpdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C099CE03F1; Mon, 17 Jul 2023 11:20:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/9] rcutorture: Dump grace-period state upon rtort_pipe_count incidents
Date:   Mon, 17 Jul 2023 11:20:34 -0700
Message-Id: <20230717182042.1098651-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
References: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtort_pipe_count WARN() indicates that grace periods were unable
to invoke all callbacks during a stutter_wait() interval.  But it is
sometimes helpful to have a bit more information as to why.  This commit
therefore invokes show_rcu_gp_kthreads() immediately before that WARN()
in order to dump out some relevant information.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 147551c23baf..d291a1438c30 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1581,6 +1581,7 @@ rcu_torture_writer(void *arg)
 				    rcu_access_pointer(rcu_torture_current) !=
 				    &rcu_tortures[i]) {
 					tracing_off();
+					show_rcu_gp_kthreads();
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 					rcu_ftrace_dump(DUMP_ALL);
 				}
-- 
2.40.1

