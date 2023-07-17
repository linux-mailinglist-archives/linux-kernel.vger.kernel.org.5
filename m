Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5194C756B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGQSFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjGQSFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08EF198E;
        Mon, 17 Jul 2023 11:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30508611D1;
        Mon, 17 Jul 2023 18:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96001C433C7;
        Mon, 17 Jul 2023 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617095;
        bh=MFE5zfhf0lge+PlNtey6NsBHeE7FU1t9598D+2WWazI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFVx6RCzlCHQeu5P4ovX7IXKbUO7PwJTzL6RqFD51A2XX1zzsYJAwgrg6Ih3gegDL
         a6gZF/SS3K0imID7jRZ/7ZwKAS0TEBX2hWaiJK7KASXoITkTqX7FkJtCdVUvBrI/Ly
         cNzT907+NO7KGkvgVy6xCO7hHG5dSN+RsMgGplqFT49QwA/ph3RAya0PyHCjvxiimh
         voaiCHocjeuX2JOEj4PlPx0JWiYAbEowqDZFUmtSWPHNEakVacF/4Qi3L122l01azp
         JB3/hjA8G2X3uUcR/9FXy4IGUl22E6tAHO1wZEe8RaySkURFihswkgf/w46c857rza
         GJ1njkKZUTYgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 575C5CE04CD; Mon, 17 Jul 2023 11:04:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/5] rcu-tasks: Remove redundant #ifdef CONFIG_TASKS_RCU
Date:   Mon, 17 Jul 2023 11:04:51 -0700
Message-Id: <20230717180454.1097714-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
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

The kernel/rcu/tasks.h file has a #endif immediately followed by an

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c88d7fe29d92..7eae67fbe47c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -146,9 +146,7 @@ static struct rcu_tasks rt_name =							\
 #ifdef CONFIG_TASKS_RCU
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
-#endif
 
-#ifdef CONFIG_TASKS_RCU
 /* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
 static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
 static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
-- 
2.40.1

