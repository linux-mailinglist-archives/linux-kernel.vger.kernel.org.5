Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D516C7581E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjGRQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjGRQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:17:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358FF132
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4A8561632
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21CBC433C7;
        Tue, 18 Jul 2023 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689697018;
        bh=gjPI6IYvNwE6IlPyT0VcSbZTdDCqABRF1V0+Aiy19nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtLZsrvG3V844S0NtHi5bZj4DXmZL2FnVVLvVnvuc2Nav8IjzSaTUgCI0cGNN2wtC
         XCnySBLwGOXuaO1LIEIQ94oqLdLrd7Vi1b8YgCI6fvbbl/h4PouklTaw+gmCxum575
         6VSF2uO5PeFYPtCAbtz/ayqh+itGf5aSh8bKDZe2pF7URzFvaHdF3zlgb41vGjTzda
         /6eFbObFX6Xdz4V6GcMUDf1+WJkq7POaQhr+ykdLw1YWkzWHzL91IePR9Yqd7OIEFG
         8gmY2mrb9CjKjb3Iq2I9ctgyQk9ogGYY1CqFp/1G5f/ke3QQwUHbRQ5SlW59/idIbN
         hG90uZw5NNIxA==
From:   SeongJae Park <sj@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core-test: Initialise context before test in damon_test_set_attrs()
Date:   Tue, 18 Jul 2023 16:16:56 +0000
Message-Id: <20230718161656.78877-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718052811.1065173-1-feng.tang@intel.com>
References: 
MIME-Version: 1.0
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

Hi Feng Tang,

On Tue, 18 Jul 2023 13:28:11 +0800 Feng Tang <feng.tang@intel.com> wrote:

> Running kunit test for 6.5-rc1 hits one bug:
> 
>         ok 10 damon_test_update_monitoring_result
>     general protection fault, probably for non-canonical address 0x1bffa5c419cfb81: 0000 [#1] PREEMPT SMP NOPTI
>     CPU: 1 PID: 110 Comm: kunit_try_catch Tainted: G                 N 6.5.0-rc2 #15
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>     RIP: 0010:damon_set_attrs+0xb9/0x120
>     Code: f8 00 00 00 4c 8d 58 e0 48 39 c3 74 ba 41 ba 59 17 b7 d1 49 8b 43 10 4d
>     8d 4b 10 48 8d 70 e0 49 39 c1 74 50 49 8b 40 08 31 d2 <69> 4e 18 10 27 00 00
>     49 f7 30 31 d2 48 89 c5 89 c8 f7 f5 31 d2 89
>     RSP: 0000:ffffc900005bfd40 EFLAGS: 00010246
>     RAX: ffffffff81159fc0 RBX: ffffc900005bfeb8 RCX: 0000000000000000
>     RDX: 0000000000000000 RSI: 01bffa5c419cfb69 RDI: ffffc900005bfd70
>     RBP: ffffc90000013c10 R08: ffffc900005bfdc0 R09: ffffffff81ff10ed
>     R10: 00000000d1b71759 R11: ffffffff81ff10dd R12: ffffc90000013a78
>     R13: ffff88810eb78180 R14: ffffffff818297c0 R15: ffffc90000013c28
>     FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000000000000000 CR3: 0000000002a1c001 CR4: 0000000000370ee0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>      <TASK>
>      damon_test_set_attrs+0x63/0x1f0
>      kunit_generic_run_threadfn_adapter+0x17/0x30
>      kthread+0xfd/0x130

Great.  But it would be even greater if you could this kind of output after
decoding the addreses using 'scripts/decode_stacktrace.sh` or
'scripts/faddr2line' from next time if possible.

> 
> The problem seems to be related with the damon_ctx was used without
> being initialized. Fix it by adding the initialization.

Somehow the test always passed on my test machine, but maybe that's due to some
different behavior of my compiler.  I agree that could be the root cause
because 'damon_set_attrs()' calls 'damon_update_monitoring_results()', which
accesses the context's fields including the targets list.  Since the list is
not initialized in this test code, it would cause such error.

> 
> Fixes: aa13779be6b7 ("mm/damon/core-test: add a test for damon_set_attrs()")
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/core-test.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index c11210124344..bb07721909e1 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -320,25 +320,25 @@ static void damon_test_update_monitoring_result(struct kunit *test)
>  
>  static void damon_test_set_attrs(struct kunit *test)
>  {
> -	struct damon_ctx ctx;
> +	struct damon_ctx *c = damon_new_ctx();
>  	struct damon_attrs valid_attrs = {
>  		.min_nr_regions = 10, .max_nr_regions = 1000,
>  		.sample_interval = 5000, .aggr_interval = 100000,};
>  	struct damon_attrs invalid_attrs;
>  
> -	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &valid_attrs), 0);
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &valid_attrs), 0);
>  
>  	invalid_attrs = valid_attrs;
>  	invalid_attrs.min_nr_regions = 1;
> -	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
>  
>  	invalid_attrs = valid_attrs;
>  	invalid_attrs.max_nr_regions = 9;
> -	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
>  
>  	invalid_attrs = valid_attrs;
>  	invalid_attrs.aggr_interval = 4999;
> -	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
>  }
>  
>  static struct kunit_case damon_test_cases[] = {
> -- 
> 2.34.1
> 
> 
> 
