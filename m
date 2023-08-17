Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1048B7800BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355540AbjHQWCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355635AbjHQWCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502C2698;
        Thu, 17 Aug 2023 15:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79C9D63B7A;
        Thu, 17 Aug 2023 22:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E08C433C7;
        Thu, 17 Aug 2023 22:02:43 +0000 (UTC)
Date:   Fri, 18 Aug 2023 00:02:40 +0200
From:   Helge Deller <deller@gmx.de>
To:     bpf@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf/tests: Enhance output on error and fix typos
Message-ID: <ZN6ZAAVoWZpsD1Jf@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a testcase returns a wrong (unexpected) value, print the expected and
returned value in hex notation in addition to the decimal notation. This is
very useful in tests which bit-shift hex values left or right and helped me
a lot while developing the JIT compiler for the hppa architecture.

Additionally fix two typos: dowrd -> dword, tall calls -> tail calls.

Signed-off-by: Helge Deller <deller@gmx.de>

---

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index fa0833410ac1..2c01932524b3 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -596,8 +596,8 @@ static int __bpf_fill_alu_shift(struct bpf_test *self, u8 op,
 {
 	static const s64 regs[] = {
 		0x0123456789abcdefLL, /* dword > 0, word < 0 */
-		0xfedcba9876543210LL, /* dowrd < 0, word > 0 */
-		0xfedcba0198765432LL, /* dowrd < 0, word < 0 */
+		0xfedcba9876543210LL, /* dword < 0, word > 0 */
+		0xfedcba0198765432LL, /* dword < 0, word < 0 */
 		0x0123458967abcdefLL, /* dword > 0, word > 0 */
 	};
 	int bits = alu32 ? 32 : 64;
@@ -14577,8 +14577,9 @@ static int run_one(const struct bpf_prog *fp, struct bpf_test *test)
 		if (ret == test->test[i].result) {
 			pr_cont("%lld ", duration);
 		} else {
-			pr_cont("ret %d != %d ", ret,
-				test->test[i].result);
+			s32 res = test->test[i].result;
+			pr_cont("ret %d != %d (%#x != %#x)",
+				ret, res, ret, res);
 			err_cnt++;
 		}
 	}
@@ -15055,7 +15056,7 @@ static __init int prepare_tail_call_tests(struct bpf_array **pprogs)
 	struct bpf_array *progs;
 	int which, err;
 
-	/* Allocate the table of programs to be used for tall calls */
+	/* Allocate the table of programs to be used for tail calls */
 	progs = kzalloc(struct_size(progs, ptrs, ntests + 1), GFP_KERNEL);
 	if (!progs)
 		goto out_nomem;
