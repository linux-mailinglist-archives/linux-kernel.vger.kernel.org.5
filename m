Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEEC782DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjHUQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjHUQM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:12:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24B5EA8;
        Mon, 21 Aug 2023 09:12:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC8CA2F4;
        Mon, 21 Aug 2023 09:13:36 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.4.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A43153F64C;
        Mon, 21 Aug 2023 09:12:54 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:12:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Subject: Re: [PATCH] samples: ftrace: replace bti assembly with hint for
 older compiler
Message-ID: <ZOONA8yHeszPwdEz@FVFF77S0Q05N>
References: <20230820111509.1470826-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820111509.1470826-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 07:15:09PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When cross-building the arm64 kernel with allmodconfig using GCC 9.4,
> the following error occurs on multiple files under samples/ftrace/:
> 
> /tmp/ccPC1ODs.s: Assembler messages:
> /tmp/ccPC1ODs.s:8: Error: selected processor does not support `bti c'
> 
> Fix this issue by replacing `bti c` with `hint 34`, which is compatible
> for the older compiler.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Sorry about this; I'd forgotten about earlier compilers when reviewing the
original patch. It's a bit unfortunate to have to hand-code this each time, but
I'm not sure that it'd actually be cleaner to have a macro.

For the moment, I reckon this is worth taking as-is.

Steve, are you happy to add:

  Fixes: 8c3526fb86060cb5 ("arm64: ftrace: Add direct call trampoline samples support")
  Acked-by: Mark Rutland <mark.rutland@arm.com>

... ?

Thanks,
Mark.

> ---
>  samples/ftrace/ftrace-direct-modify.c       | 4 ++--
>  samples/ftrace/ftrace-direct-multi-modify.c | 4 ++--
>  samples/ftrace/ftrace-direct-multi.c        | 2 +-
>  samples/ftrace/ftrace-direct-too.c          | 2 +-
>  samples/ftrace/ftrace-direct.c              | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> index e5ed08098ff3..e2a6a69352df 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -105,7 +105,7 @@ asm (
>  "	.type		my_tramp1, @function\n"
>  "	.globl		my_tramp1\n"
>  "   my_tramp1:"
> -"	bti	c\n"
> +"	hint	34\n" // bti	c
>  "	sub	sp, sp, #16\n"
>  "	stp	x9, x30, [sp]\n"
>  "	bl	my_direct_func1\n"
> @@ -117,7 +117,7 @@ asm (
>  "	.type		my_tramp2, @function\n"
>  "	.globl		my_tramp2\n"
>  "   my_tramp2:"
> -"	bti	c\n"
> +"	hint	34\n" // bti	c
>  "	sub	sp, sp, #16\n"
>  "	stp	x9, x30, [sp]\n"
>  "	bl	my_direct_func2\n"
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> index 292cff2b3f5d..2e349834d63c 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -112,7 +112,7 @@ asm (
>  "	.type		my_tramp1, @function\n"
>  "	.globl		my_tramp1\n"
>  "   my_tramp1:"
> -"	bti	c\n"
> +"	hint	34\n" // bti	c
>  "	sub	sp, sp, #32\n"
>  "	stp	x9, x30, [sp]\n"
>  "	str	x0, [sp, #16]\n"
> @@ -127,7 +127,7 @@ asm (
>  "	.type		my_tramp2, @function\n"
>  "	.globl		my_tramp2\n"
>  "   my_tramp2:"
> -"	bti	c\n"
> +"	hint	34\n" // bti	c
>  "	sub	sp, sp, #32\n"
>  "	stp	x9, x30, [sp]\n"
>  "	str	x0, [sp, #16]\n"
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> index b4391e08c913..9243dbfe4d0c 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -75,7 +75,7 @@ asm (
>  "	.type		my_tramp, @function\n"
>  "	.globl		my_tramp\n"
>  "   my_tramp:"
> -"	bti	c\n"
> +"	hint	34\n" // bti	c
>  "	sub	sp, sp, #32\n"
>  "	stp	x9, x30, [sp]\n"
>  "	str	x0, [sp, #16]\n"
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> index e9804c5307c0..e39c3563ae4e 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -81,7 +81,7 @@ asm (
>  "	.type		my_tramp, @function\n"
>  "	.globl		my_tramp\n"
>  "   my_tramp:"
> -"	bti	c\n"
> +"	hint	34\n" // bti	c
>  "	sub	sp, sp, #48\n"
>  "	stp	x9, x30, [sp]\n"
>  "	stp	x0, x1, [sp, #16]\n"
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
> index 20f4a7caa810..32c477da1e9a 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -72,7 +72,7 @@ asm (
>  "	.type		my_tramp, @function\n"
>  "	.globl		my_tramp\n"
>  "   my_tramp:"
> -"	bti	c\n"
> +"	hint	34\n" // bti	c
>  "	sub	sp, sp, #32\n"
>  "	stp	x9, x30, [sp]\n"
>  "	str	x0, [sp, #16]\n"
> -- 
> 2.25.1
> 
