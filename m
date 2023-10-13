Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DDD7C8521
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjJML7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjJML7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872BBC9;
        Fri, 13 Oct 2023 04:59:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9F8C433C8;
        Fri, 13 Oct 2023 11:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198351;
        bh=3eBYDTkgQaXsYR67+otBc1WF4QZDBr1bb/8NAZitcis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjciNQHBgTaujV2YgKuszJVG75vd0v5Sdj0qB0zOrrztJLsKd4G5u5Q96Yl3roHfW
         SvmYnxjYChGPOfHEw8tX94L1f32RIPY4Qgh1NeESzM/EaI7zWpjcLtF0VuaUH+HMYS
         R43V10VNExqNF1t/yyj8bEGz7imS6Zrneh1GCyhNn/GYZ+8kOkkmGcF+RPm+l+xAbs
         kZQmcQsobtP4GpVztNVu4AhO2PR2TKsifZT437968FExewObUmL46ptXbJTeFkcmAg
         0J90DyZYUEv8KqF7ozFswqhfVnFJJyValjwtY6+TW5NzBezmtQGjG4HwFsx/MpqQSP
         xJ/PUpIqBXAOw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 01/18] Revert "checkpatch: Error out if deprecated RCU API used"
Date:   Fri, 13 Oct 2023 13:58:45 +0200
Message-Id: <20231013115902.1059735-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The definition for single-argument kfree_rcu() has been removed,
so that any further attempt to use it will result in a build error.
Because of this build error, there is no longer any need for a special
check in checkpatch.pl.

Therefore, revert commit 1eacac3255495be7502d406e2ba5444fb5c3607c.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 scripts/checkpatch.pl | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1..25fdb7fda112 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6427,15 +6427,6 @@ sub process {
 			}
 		}
 
-# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
-		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
-			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
-				ERROR("DEPRECATED_API",
-				      "Single-argument k[v]free_rcu() API is deprecated, please pass rcu_head object or call k[v]free_rcu_mightsleep()." . $herecurr);
-			}
-		}
-
-
 # check for unnecessary "Out of Memory" messages
 		if ($line =~ /^\+.*\b$logFunctions\s*\(/ &&
 		    $prevline =~ /^[ \+]\s*if\s*\(\s*(\!\s*|NULL\s*==\s*)?($Lval)(\s*==\s*NULL\s*)?\s*\)/ &&
-- 
2.34.1

