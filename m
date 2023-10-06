Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209607BB58B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjJFKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjJFKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:43:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7789F;
        Fri,  6 Oct 2023 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rErJBB9kXP4hssemwy/Dg/yVUF2CtnPzRZ/3Lx9KggE=; b=FoeB60JP0MaoiPQhzbTyS5i8ks
        Nm215GOOd3Ao6yM7TGNkkjuexkCUfabGbByt72OSMWJNMOg941re1/zOJ7I7y87lzGWmpF2xZ9vhd
        ZRsyK52coEVJrDG7a9ad1kfd5vsw66DQrhw1BzRtwvHmEKcWMpCpES/+xMw4I1l6U/hdc0/DEKJ3I
        R3jxQKJSq3WRb9/UmTVncBxek1m4c9hJGCocAOiodyXblfGHx+/AWI/45gPHJbYnUamVZuSThrk1L
        Yrt8c9rZFYr5uEvMpwvmy7UFEypzVLFiCQaksdqpUgm3N/bRuDiJydsUAyaekK4f7s7M4CYOiBBUF
        yZOCvZVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qoiIo-00ErWX-5C; Fri, 06 Oct 2023 10:43:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDC4E300392; Fri,  6 Oct 2023 12:43:25 +0200 (CEST)
Date:   Fri, 6 Oct 2023 12:43:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: locking/core] locking/futex/selftests: Remove duplicate
 ABI defines
Message-ID: <20231006104325.GC36277@noisy.programming.kicks-ass.net>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
 <169658834039.3135.4395839213523782496.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169658834039.3135.4395839213523782496.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:32:20AM -0000, tip-bot2 for Muhammad Usama Anjum wrote:
> The following commit has been merged into the locking/core branch of tip:
> 
> Commit-ID:     d351a9e56cc90a9ff694550e4b3bcaf51a391525
> Gitweb:        https://git.kernel.org/tip/d351a9e56cc90a9ff694550e4b3bcaf51a391525
> Author:        Muhammad Usama Anjum <usama.anjum@collabora.com>
> AuthorDate:    Fri, 06 Oct 2023 14:55:37 +05:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 06 Oct 2023 12:29:45 +02:00
> 
> locking/futex/selftests: Remove duplicate ABI defines
> 
> Kselftests are kernel tests that are built with kernel headers
> from the same source version. The kernel headers, which includes
> current ABI definitions, are already being included correctly
> in the futex selftest Makefile with the help of KHDR_INCLUDE,
> no need to define them again.
> 
> Remove duplicate ABI definitions, which is effectively dead code.
> 
> No functional changes intended.

so.. as it happens I recently built these things as stand-alone, and
then you ver much end up using the system headers.

Also see 20230922205449.808782861@infradead.org where I add more of
this.

Specifically, if one does:

cd tools/testing/selftests/futex/functional; make

You don't get kernel headers and stuff does not build.

So no, I don't think this is superfluous.

> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/20231006095539.1601385-1-usama.anjum@collabora.com
> ---
>  tools/testing/selftests/futex/include/futextest.h | 22 +--------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
> index ddbcfc9..59f66af 100644
> --- a/tools/testing/selftests/futex/include/futextest.h
> +++ b/tools/testing/selftests/futex/include/futextest.h
> @@ -25,28 +25,6 @@
>  typedef volatile u_int32_t futex_t;
>  #define FUTEX_INITIALIZER 0
>  
> -/* Define the newer op codes if the system header file is not up to date. */
> -#ifndef FUTEX_WAIT_BITSET
> -#define FUTEX_WAIT_BITSET		9
> -#endif
> -#ifndef FUTEX_WAKE_BITSET
> -#define FUTEX_WAKE_BITSET		10
> -#endif
> -#ifndef FUTEX_WAIT_REQUEUE_PI
> -#define FUTEX_WAIT_REQUEUE_PI		11
> -#endif
> -#ifndef FUTEX_CMP_REQUEUE_PI
> -#define FUTEX_CMP_REQUEUE_PI		12
> -#endif
> -#ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
> -#define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
> -					 FUTEX_PRIVATE_FLAG)
> -#endif
> -#ifndef FUTEX_REQUEUE_PI_PRIVATE
> -#define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
> -					 FUTEX_PRIVATE_FLAG)
> -#endif
> -
>  /**
>   * futex() - SYS_futex syscall wrapper
>   * @uaddr:	address of first futex
