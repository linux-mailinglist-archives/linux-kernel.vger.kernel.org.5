Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2AE806011
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbjLEVEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEVEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:04:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C41188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:04:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C92C433C8;
        Tue,  5 Dec 2023 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701810290;
        bh=oBo9P7E2H1qo/8P7D4Gn1bqot50xulgDivPddX3B360=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Umm13VIfsxObQ8ml3mnlVj2Ggug4q74F5giIj1ChM2SJpMGqfOoIJm/I/zwxWurWb
         UO3nMTeKUpysC/bdJyiBA/s/ehpIBbSeHj6P+xggFewzgSUQw6z1xt+5uNePlJR/MN
         WX7rq/HoUa6w6xG42vWWspTCu+TsBaCrNZzf6wT0=
Date:   Tue, 5 Dec 2023 13:04:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     tanzirh@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-Id: <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
In-Reply-To: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 20:58:53 +0000 tanzirh@google.com wrote:

> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list changing indirect includes to direct includes.
> IWYU is implemented using the IWYUScripts github repository which is a tool that is
> currently undergoing development. These changes seek to improve build times.
> 
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5232 lines (-80%).
> 
> If there are any problems with the output of the tool please raise an
> issue on the github.
> 
> Link: https://github.com/ClangBuiltLinux/IWYUScripts

Issue:

> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -16,16 +16,16 @@
>  
>  #define __NO_FORTIFY
>  #include <linux/types.h>
> +#include <asm/bitsperlong.h>

The preferred way to import bit-fiddling stuff is to include
<linux/bits.h>.  Under the hood this may include asm/bitsperlong.h.  Or
it may not, depending on Kconfig settings (particularly architecture).

