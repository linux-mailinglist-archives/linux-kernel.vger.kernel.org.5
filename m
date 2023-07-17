Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAEC756B69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGQSMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGQSLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E5FE7F;
        Mon, 17 Jul 2023 11:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46473611F5;
        Mon, 17 Jul 2023 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829E6C433BF;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=1idW3qeMxeR/pQhpNzqDLOrZBK/BHCj+UCLTJY852f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoJLg8xuXNwGHpVNV1qzauZ71fIsFOh0jKQChIYHxZSM1WVf6Xk8tngWps4HXo9wl
         z5P51FfAZ+uBQMShS7/hMnooBscEB0s/vAlBvQ26yWhTPlr0Ax49opu+8WNcDLuEA0
         nQFO8T8J8clIdadcRqCfdsAyJ+DPsh/DN+l6W9PfcBCgVa9CDBmPs05xD9orHk2OfZ
         i8eTwk7kJrePNe0BIQhYysCWFV+2y+kUSeD9QC8P1zPXWAHu1EaxPx2CS6cNX/LDJ8
         pLFxADrYHZZTd3JNYVuHxl/iR0yQkpjVUxCk2waPrmBu/a6x5VUL0t4zDSOZRK593J
         G4/+x6FwPSj/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C8EC7CE0A11; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/13] rcuscale: Add CONFIG_PREEMPT_DYNAMIC=n to TRACE01 scenario
Date:   Mon, 17 Jul 2023 11:11:38 -0700
Message-Id: <20230717181138.1098063-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
References: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
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

It is no longer possible to build a kernel with a preemption-disabled
RCU without use of CONFIG_PREEMPT_DYNAMIC=n.  This commit therefore
adds CONFIG_PREEMPT_DYNAMIC=n to the rcuscale torture type's TRACE01
scenario file.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
index 227aba7783af..0059592c7408 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
@@ -2,6 +2,8 @@ CONFIG_SMP=y
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
+#CHECK#CONFIG_TREE_RCU=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-- 
2.40.1

