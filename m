Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9707BFA93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjJJMBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjJJMA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:00:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151071B4;
        Tue, 10 Oct 2023 05:00:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E30CC433CC;
        Tue, 10 Oct 2023 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939210;
        bh=/Z5ZKEkqeX88LkvGvhKdpELWee2yXXovMScGD9Eqo9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOjjiJxH+QRs1qhHXeGnAKLSQq4UPKjSxBp/Nea681WLA2DKgUJbjwI5i1okReCW2
         ulaK5X5oxxUjNNlqbQOkRNLr5wyIsiC4mt8SCJO40UGroE7gLTNxb+m0vwe1mbQM7G
         TuQLD8CKudBSRUW+6zQ7yWnUrKLEcrH2YdaowKBxQT00AIETb8MYwbKwHf3mz2LK69
         Tp8LImOYc8+EgIaFyo7LUOzGlLzsj0aAvFhFBrwiQcHH45hAyL/zRzytmzsL/LBm9l
         ar9iwX3bTxCKY+4nD58Aae/YX0EO7+AisoljosRmQjowt//AyOccZLz8eux+EoNL0w
         12mpHqN5KvbmA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 13/23] torture: Print out torture module parameters
Date:   Tue, 10 Oct 2023 13:59:11 +0200
Message-Id: <20231010115921.988766-14-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

The kernel/torture.c module now has several module parameters, so this
commit causes them to be printed out.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/torture.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/torture.c b/kernel/torture.c
index fd353f98162f..c72ab2d251f4 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -791,6 +791,13 @@ static void torture_stutter_cleanup(void)
 	stutter_task = NULL;
 }
 
+static void
+torture_print_module_parms(void)
+{
+	pr_alert("torture module --- %s:  disable_onoff_at_boot=%d ftrace_dump_at_shutdown=%d verbose_sleep_frequency=%d verbose_sleep_duration=%d random_shuffle=%d\n",
+		 torture_type, disable_onoff_at_boot, ftrace_dump_at_shutdown, verbose_sleep_frequency, verbose_sleep_duration, random_shuffle);
+}
+
 /*
  * Initialize torture module.  Please note that this is -not- invoked via
  * the usual module_init() mechanism, but rather by an explicit call from
@@ -813,6 +820,7 @@ bool torture_init_begin(char *ttype, int v)
 	torture_type = ttype;
 	verbose = v;
 	fullstop = FULLSTOP_DONTSTOP;
+	torture_print_module_parms();
 	return true;
 }
 EXPORT_SYMBOL_GPL(torture_init_begin);
-- 
2.34.1

