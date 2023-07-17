Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564D0756BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjGQSYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGQSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D3210E4;
        Mon, 17 Jul 2023 11:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D11AF6120F;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034B4C433BC;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618220;
        bh=P4nZm0GdBnAUsfoExek52rW/j2/tlQw3/AFSywEb7CU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mw0bjKH5O95bUQnfutikTew55M6HivyZiao3YDAyLIJb6Y35rtwRJmDI42mjHYeSt
         M3nbi2fMjrYlL5YMAelyqfWx9Yy45S1RAwEOkEZBN57gyAlBMiMgwlEp4juyHgw+hT
         9Cn/lm1Ol6vC5XOLtCz3y+9nGkuuKgho+CVqecsZyaIkr0AQLrZFxuICHAqtkLffAJ
         WS+D43+O8OgcDKDKACmbcZiaHulbfVCMUh1d2FJxkd0i3tasFiLj+rqOvL2TdYOycA
         fW/FGa+7W0yg9ICCtc7XpHoE6Gl0ub27e9Zwzu3YTztiew+nJ4filXKg+d+acmtO2A
         BrooQC0jpDMYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 38D6ACE0A10; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/18] torture: Loosen .config checks for KCSAN kernels
Date:   Mon, 17 Jul 2023 11:23:31 -0700
Message-Id: <20230717182337.1098991-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
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

KCSAN enables some Kconfig options unilaterally and unconditionally,
including CONFIG_PROVE_LOCKING.  This in turn enables CONFIG_PROVE_RCU
and CONFIG_PREEMPT_COUNT, which conflicts with constraints in SRCU-T,
TRACE01, and TREE10, which in turn causes rcutorture to emit spurious
configuration complaints.  This commit therefore forgives configuration
complaints involving CONFIG_PROVE_RCU and CONFIG_PREEMPT_COUNT.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 97bdacc3fc55..5be670dd4009 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -52,6 +52,13 @@ do
 				echo QEMU killed
 			fi
 			configcheck.sh $i/.config $i/ConfigFragment > $i/ConfigFragment.diags 2>&1
+			if grep -q '^CONFIG_KCSAN=y$' $i/ConfigFragment.input
+			then
+				# KCSAN forces a number of Kconfig options, so remove
+				# complaints about those Kconfig options in KCSAN runs.
+				mv $i/ConfigFragment.diags $i/ConfigFragment.diags.kcsan
+				grep -v -E 'CONFIG_PROVE_RCU|CONFIG_PREEMPT_COUNT' $i/ConfigFragment.diags.kcsan > $i/ConfigFragment.diags
+			fi
 			if test -s $i/ConfigFragment.diags
 			then
 				cat $i/ConfigFragment.diags
-- 
2.40.1

