Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFAA803F61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345792AbjLDUdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345544AbjLDUdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:33:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE02D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:33:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD3EC433CC;
        Mon,  4 Dec 2023 20:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722005;
        bh=VQ1kDw6UcR7JbTEq2lMQAZ17c1wIZV3ufze0fEvndbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvNFnpFz/PSWcSxylNhLAdk53Csf6TjBDMF40Vc8+lPruq8HRef9dS+GGfYv9Vy5i
         sK6zR5EJMxk1is3BB0nukj19AyM/racWMAMBy2hP7UvFAouTokKK+UddrM3NahmXzt
         Zr7AKMX4+ThlUzQFL3C7IHGLOE9/448KzY5tzi4GngaqivDk5zdUhylzw89dYR69re
         8p2314zXghypQ2iLBXhg3PYLPGbdBoeaeVNPQ9AHMGF/oAQLif09D6iiq1lA6lPB0O
         XjEjVU86FG9DKMNUfW5a0V7daA1CTD5M0ZrQNDWUkdvm7QuC1WrNmfg9FC7pmA6I8H
         ia2c7wTEgn8pg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH AUTOSEL 6.6 03/32] kunit: Reset suite counter right before running tests
Date:   Mon,  4 Dec 2023 15:32:23 -0500
Message-ID: <20231204203317.2092321-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 2e3c94aed51eabbe9c1c0ee515371ea5441c2fa7 ]

Today we reset the suite counter as part of the suite cleanup,
called from the module exit callback, but it might not work that
well as one can try to collect results without unloading a previous
test (either unintentionally or due to dependencies).

For easy reproduction try to load the kunit-test.ko and then
collect and parse results from the kunit-example-test.ko load.
Parser will complain about mismatch of expected test number:

[ ] KTAP version 1
[ ] 1..1
[ ]     # example: initializing suite
[ ]     KTAP version 1
[ ]     # Subtest: example
..
[ ] # example: pass:5 fail:0 skip:4 total:9
[ ] # Totals: pass:6 fail:0 skip:6 total:12
[ ] ok 7 example

[ ] [ERROR] Test: example: Expected test number 1 but found 7
[ ] ===================== [PASSED] example =====================
[ ] ============================================================
[ ] Testing complete. Ran 12 tests: passed: 6, skipped: 6, errors: 1

Since we are now printing suite test plan on every module load,
right before running suite tests, we should make sure that suite
counter will also start from 1. Easiest solution seems to be move
counter reset to the __kunit_test_suites_init() function.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e451cfe6143ec..7452d1a2acd98 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -740,6 +740,8 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 		return 0;
 	}
 
+	kunit_suite_counter = 1;
+
 	static_branch_inc(&kunit_running);
 
 	for (i = 0; i < num_suites; i++) {
@@ -766,8 +768,6 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
 
 	for (i = 0; i < num_suites; i++)
 		kunit_exit_suite(suites[i]);
-
-	kunit_suite_counter = 1;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
-- 
2.42.0

