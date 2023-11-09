Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337E87E73C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbjKIVkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjKIVkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:40:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C763C39
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 13:40:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C3CC433C7;
        Thu,  9 Nov 2023 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699566032;
        bh=cMpWJuvtZ89awIwTnITkBTxvpjxR/aX314zlqcUFJ8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s46zQjAOtQrrn+vv+w0lUxz2pt479xpfvq9Nehk4o9q0nJx1gApdZUPuMWpR30VQ7
         9JlGb+T7VXJVl73lr++ggTMgX+1+YaBDKFP0KMfaHr54AeEyI2X7NutUXwo93jedmj
         Zcj6amPAUMIFqJF2lAxe3hfeZgE0EY56xx7lmoVCrOEAkJvOOEZsZoBarkQVtdfuYD
         BZ6JFEwfRXOEt7hr1Z2PMpoDNwnalN0kxx19WUQvCSMuwF7hMnL1poOw3d040+GV1H
         DeEpba8h1lx+ngFawEcu+xtF3dXyFgeQhLQSqwiQw1JB2puETBurtmmDO6fg6T6osB
         kvycrqSJQZBkQ==
Date:   Thu, 9 Nov 2023 13:40:30 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Sam James <sam@gentoo.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix calloc call for new -Walloc-size
Message-ID: <20231109214030.jxx44y3q4rxrltkw@treble>
References: <20231107205504.1470006-1-sam@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231107205504.1470006-1-sam@gentoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 08:55:00PM +0000, Sam James wrote:
> GCC 14 introduces a new -Walloc-size included in -Wextra which errors out
> like:
> ```
> check.c: In function ‘cfi_alloc’:
> check.c:294:33: error: allocation of insufficient size ‘1’ for type ‘struct cfi_state’ with size ‘320’ [-Werror=alloc-size]
>   294 |         struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
>       |                                 ^~~~~~
> ```
> 
> The calloc prototype is:
> ```
> void *calloc(size_t nmemb, size_t size);
> ```
> 
> So, just swap the number of members and size arguments to match the prototype, as
> we're initialising 1 struct of size `sizeof(struct ...)`. GCC then sees we're not
> doing anything wrong.
> 
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
>  tools/objtool/check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e94756e09ca9..548ec3cd7c00 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -291,7 +291,7 @@ static void init_insn_state(struct objtool_file *file, struct insn_state *state,
>  
>  static struct cfi_state *cfi_alloc(void)
>  {
> -	struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
> +	struct cfi_state *cfi = calloc(1, sizeof(struct cfi_state));
>  	if (!cfi) {
>  		WARN("calloc failed");
>  		exit(1);

Thanks!

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

Peter are you able to grab this or should I put it in my tree first?

-- 
Josh
