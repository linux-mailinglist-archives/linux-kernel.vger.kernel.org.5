Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C369E797DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbjIGVX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjIGVX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:23:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F9A1BD2;
        Thu,  7 Sep 2023 14:23:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF02C433C7;
        Thu,  7 Sep 2023 21:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694121832;
        bh=rCuPsdLQufVpLwMAqTh9+q8pTfYjnuRBRZ8mkaCuqTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMQSV40VEDZPZFdNzkvj7TREKfIyuN/vANgoRRDi3kify60cuG2oUUZCqrKXpHyLg
         syQiuZIx5OvFHRtARkSLAFYuztV6uXP8k20FZ8N0cD4+l19C/q7epzKssrz5Fv7XLe
         e2QsvLIxkjg6BLTnConCHO8s+ii8MZhOjtCai9dGLHGw9RNX0jN2Di9OwC4vVir2J2
         MoZ0XlT06PR6q/g33kR3lG9uFoV1WMpZmByGHUZYcHYGFk+XjXLsK54wYXXfunYHLy
         yMP0ACKGNd2aJEqJN4oXb8U63oIsOrRjuRQ2VoYpIvE5M/qJLVIeMdaVeXjDhA6Vrs
         KaDUf18n0zhiA==
Date:   Thu, 7 Sep 2023 14:28:05 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Justin Stitt <justinstitt@google.com>,
        Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2] arm64/sysreg: refactor deprecated strncpy
Message-ID: <amh6pp2mkmn22jcvz5tva7c4aaqxaq7zaz6v5u6rb7emsqp6p2@nxd7ynj524sx>
References: <20230811-strncpy-arch-arm64-v2-1-ba84eabffadb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-strncpy-arch-arm64-v2-1-ba84eabffadb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 04:33:51PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1]. Which seems to be the case here due to the forceful setting of `buf`'s
> tail to 0.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> In this case, we can simplify the logic and also check for any silent
> truncation by using `strscpy`'s return value.
> 
> This should have no functional change and yet uses a more robust and
> less ambiguous interface whilst reducing code complexity.
> 

I'm sorry, but this patch is wrong.

__parse_cmdline() is supposed to match the command line against a set of
keywords, one word at a time. The new implementation ignores the
word-boundaries and matches the whole command line once and then breaks
the loop, typically without having found a match. (See below)

Can we please have this patch dropped, Will?



Also, the commit message is a blanket statement about why strscpy is
better than stncpy, but I don't see how this is applicable to the code
it attempts to "fix". Afaict the code already handled these cases.

> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Suggested-by: Kees Cook <keescook@chromium.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - Utilize return value from strscpy and check for truncation (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com
> ---
> For reference, see a part of `strscpy`'s implementation here:
> 
> |	/* Hit buffer length without finding a NUL; force NUL-termination. */
> |	if (res)
> |		dest[res-1] = '\0';
> 
> Note: compile tested
> ---
>  arch/arm64/kernel/idreg-override.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index 2fe2491b692c..aee12c75b738 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -262,9 +262,9 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
>  		if (!len)
>  			return;
>  
> -		len = min(len, ARRAY_SIZE(buf) - 1);

Here "len" was either the number of bytes to the first space, the end of
the string, or the last byte in "buf".

> -		strncpy(buf, cmdline, len);

So this will copy one word, or the rest of the string.

> -		buf[len] = 0;

And it will NUL-terminate the word, which is then matched upon below.

> +		len = strscpy(buf, cmdline, ARRAY_SIZE(buf));

In this new implementation, the code copies the rest of the command line
to "buf", makes an attempt to match with with the keywords, and then
breaks the loop (as cmdline + len is the end of the string).

Regards,
Bjorn
