Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75537CC04C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbjJQKOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjJQKOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:14:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 343A78E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:14:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42ABC2F4;
        Tue, 17 Oct 2023 03:15:31 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.68.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F933F762;
        Tue, 17 Oct 2023 03:14:49 -0700 (PDT)
Date:   Tue, 17 Oct 2023 11:14:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Li zeming <zeming@nfschina.com>
Cc:     gor@linux.ibm.com, hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] stackleak: =?us-ascii?Q?Remove?=
 =?us-ascii?Q?_unnecessary_'0'?= values from ret
Message-ID: <ZS5ek5RrW3XaBph9@FVFF77S0Q05N>
References: <20231017060824.10434-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017060824.10434-1-zeming@nfschina.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:08:24PM +0800, Li zeming wrote:
> ret is assigned first, so it does not need to initialize the assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Does this actually need to change? It's not harmful, and deleting the
assignment doesn't save any lines of code.

That said, I don't have strong feelings either way, and Kees is the
de-facto-yet-undocumented maintainer for this code, so I will leave it to him
to decide whether to apply.

Mark.

> ---
>  kernel/stackleak.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index 34c9d81eea940..3faf863593846 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -24,7 +24,7 @@ static DEFINE_STATIC_KEY_FALSE(stack_erasing_bypass);
>  static int stack_erasing_sysctl(struct ctl_table *table, int write,
>  			void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	int ret = 0;
> +	int ret;
>  	int state = !static_branch_unlikely(&stack_erasing_bypass);
>  	int prev_state = state;
>  
> -- 
> 2.18.2
> 
