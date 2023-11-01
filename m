Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5617DE921
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjKAXva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjKAXv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:51:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A29126;
        Wed,  1 Nov 2023 16:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KRgbwZSg+I8F4GIWxZtVNCJODdPzeC1pCi/Dya698bY=; b=jRTV0RXOOtdPIBwTv30bAO9kVO
        eG7/s4QyT4OltzFZZ/ZFrZpucTGfEwluKPNcSgw0wErQqeG3pcS0NKJSg2yvrFOrMDRv3BCxstay7
        24aCUC9B8ow6ha+pnJnNitqSDC4w0ZIQn0d1XWbiiwgJmke7qnsXwqmMvcZcAholaSRUT2zkzPwZm
        p0w/ebAS9BUM8YTPsPviPUxRQAMaELqTcp3TenRwXinrB+dHusyIlI5VjUIHNPA9esobcXjBBmgLe
        knyZjy8lQlvU5ed/lkSZPQP8gVT3Osavf142MA5P8BMGFqKRjTHFYRjmXJaeKLODpo0lK2vDtqcU3
        1wwYzrpQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyKzD-008MgL-1I;
        Wed, 01 Nov 2023 23:50:59 +0000
Message-ID: <4db3c258-a7c8-4e92-83db-797da32dd336@infradead.org>
Date:   Wed, 1 Nov 2023 16:50:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/lib: Fix overflow of variable m when val >=
 1410065408
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231101153237.2214698-1-colin.i.king@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231101153237.2214698-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/23 08:32, Colin Ian King wrote:
> There is an overflow in variable m in function num_digits when val
> is >= 1410065408 which leads to the digit calculation loop to
> iterate more times than required. This results in either more
> digits being counted or in some cases (for example where val is
> 1932683193) the value of m eventually overflows to zero and the
> while loop spins forever).
> 
> Currently the function num_digits is currently only being used for
> small values of val in the SMP boot stage for digit counting on the
> number of cpus and NUMA nodes, so the overflow is never encounterd.

                                                          encountered.

> However it is useful to fix the overflow issue in case the function
> is used for other purposes in the future. (The issue was discovered
> while investigating the digit counting performance in various
> kernel helper functions rather than any real-world use-case).
> 
> The simplest fix is to make m a long int, the overhead in
> multiplication speed for a long is very minor for small values
> of val less than 10000 on modern processors. The alternative
> fix is to replace the multiplication with a constant division
> by 10 loop (this compiles down to an multiplication and shift)
> without needing to make m a long int, but this is slightly slower
> than the fix in this commit when measured on a range of x86
> processors).
> 
> Fixes: 646e29a1789a ("x86: Improve the printout of the SMP bootup CPU table")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

num_digits() now works for all int values.
Thanks.

> ---
>  arch/x86/lib/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/lib/misc.c b/arch/x86/lib/misc.c
> index 92cd8ecc3a2c..41e26e246d8f 100644
> --- a/arch/x86/lib/misc.c
> +++ b/arch/x86/lib/misc.c
> @@ -8,7 +8,7 @@
>   */
>  int num_digits(int val)
>  {
> -	int m = 10;
> +	long m = 10;
>  	int d = 1;
>  
>  	if (val < 0) {

-- 
~Randy
