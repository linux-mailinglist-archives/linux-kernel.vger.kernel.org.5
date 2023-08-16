Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1D677DFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244368AbjHPLEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbjHPLDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:03:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BE02D68;
        Wed, 16 Aug 2023 04:03:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 14D381F855;
        Wed, 16 Aug 2023 11:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692183708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kh9gn+MAlUKG30rkz4N7QMgrJ4Mle0VRLZ/2rPI+KVo=;
        b=egKSjtKnCQg+lMexVn55ytb/W4boIZ5k4LDJbUVLAvcUsG0FegBE+cGE9rEpWaa2p+RXRR
        ugudL9KdCPop984AOz0HlXKYvEAr0oNDqrsaBGCbwOdsv616QifhhL14FwUYdaXpCS5nFd
        B56BqMjsycFUa1XkDMzkkXfUx6UUaKg=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D5612C143;
        Wed, 16 Aug 2023 11:01:47 +0000 (UTC)
Date:   Wed, 16 Aug 2023 13:01:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] lib: test_scanf: Add explicit type cast to result
 initialization in test_number_prefix()
Message-ID: <ZNysmicYHHQ3f1Ck@alley>
References: <20230807-test_scanf-wconstant-conversion-v2-1-839ca39083e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-test_scanf-wconstant-conversion-v2-1-839ca39083e1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-08-07 08:36:28, Nathan Chancellor wrote:
> A recent change in clang allows it to consider more expressions as
> compile time constants, which causes it to point out an implicit
> conversion in the scanf tests:
> 
>   lib/test_scanf.c:661:2: warning: implicit conversion from 'int' to 'unsigned char' changes value from -168 to 88 [-Wconstant-conversion]
>     661 |         test_number_prefix(unsigned char,       "0xA7", "%2hhx%hhx", 0, 0xa7, 2, check_uchar);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   lib/test_scanf.c:609:29: note: expanded from macro 'test_number_prefix'
>     609 |         T result[2] = {~expect[0], ~expect[1]};                                 \
>         |                       ~            ^~~~~~~~~~
>   1 warning generated.
> 
> The result of the bitwise negation is the type of the operand after
> going through the integer promotion rules, so this truncation is
> expected but harmless, as the initial values in the result array get
> overwritten by _test() anyways. Add an explicit cast to the expected
> type in test_number_prefix() to silence the warning. There is no
> functional change, as all the tests still pass with GCC 13.1.0 and clang
> 18.0.0.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1899

"Closes:" is not a valid tag. It was proposed and rejected in the end.
I replaced it with "Link:" as suggested by ./scripts/checkpatch.pl/

> Link: https://github.com/llvm/llvm-project/commit/610ec954e1f81c0e8fcadedcd25afe643f5a094e
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

The patch has been pushed into printk/linux.git, branch for-6.6.

Best Regards,
Petr
