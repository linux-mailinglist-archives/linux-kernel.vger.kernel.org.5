Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B607DBE48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjJ3QxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3QxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:53:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ADCF1;
        Mon, 30 Oct 2023 09:53:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 57AED377;
        Mon, 30 Oct 2023 16:53:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 57AED377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698684793; bh=QRgAQrH62j72CYNaUq0Va4PHddd9yeJq/c0nZSGCl18=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VlIQ4m6GMC9A9wm4x6Q4yiBb10yt7WmKGqvrkrY1o4P2bNUPfhCGd73CEBEuJd6+j
         ObpQyw5M9JoNTKJ2hxSqf3QVFCFq4RpPwVMJH4D7yAkFChgZyCcwB52/JqexxsND4r
         K+Mp6tpToHsOpq61JtByWWHxEWbt7u/d9IpMV7M+Iw20H9LYzhh15dJljifbpmXRvw
         2fGUo+fSPNqwwG1LN5bjmaSGIYRJbswJzND4XFqTezBzXuJpyfHYEnhy/AzfPqL4tV
         BrO//5IZl6SG/B9VVtgVn8oH6GV32Hma/ay/js1HCN6OgawbWEMcgbz7gKjEvjWJL8
         X4FT/P5MR5QXA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yujie Liu <yujie.liu@intel.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] scripts/kernel-doc: Fix the regex for matching -Werror
 flag
In-Reply-To: <20231030085404.3343403-1-yujie.liu@intel.com>
References: <20231030085404.3343403-1-yujie.liu@intel.com>
Date:   Mon, 30 Oct 2023 10:53:12 -0600
Message-ID: <87il6o3vd3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yujie Liu <yujie.liu@intel.com> writes:

> Swarup reported a "make htmldocs" warning:
>
>   Variable length lookbehind is experimental in regex;
>   marked by <-- HERE in m/(?<=^|\s)-Werror(?=$|\s)
>   <-- HERE / at ./scripts/kernel-doc line 188.
>
> Akira managed to reproduce it by perl v5.34.0.
>
> On second thought, it is not necessary to have the complicated
> "lookahead and lookbehind" things, and the regex can be simplified.
>
> Generally, the kernel-doc warnings should be considered as errors only
> when "-Werror" flag is set in KCFLAGS, but not when
> "-Werror=<diagnostic-type>" is set, which means there needs to be a
> space or start of string before "-Werror", and a space or end of string
> after "-Werror".
>
> The following cases have been tested to work as expected:
>
> * kernel-doc warnings are considered as errors:
>
>   $ KCFLAGS="-Werror" make W=1
>   $ KCFLAGS="-Wcomment -Werror" make W=1
>   $ KCFLAGS="-Werror -Wundef" make W=1
>   $ KCFLAGS="-Wcomment -Werror -Wundef" make W=1
>
> * kernel-doc warnings remain as warnings:
>
>   $ KCFLAGS="-Werror=return-type" make W=1
>   $ KCFLAGS="-Wcomment -Werror=return-type" make W=1
>   $ KCFLAGS="-Werror=return-type -Wundef" make W=1
>   $ KCFLAGS="-Wcomment -Werror=return-type -Wundef" make W=1
>
> The "Variable length lookbehind is experimental in regex" warning is
> also resolved by this patch.
>
> Fixes: 91f950e8b9d8 ("scripts/kernel-doc: match -Werror flag strictly")
> Reported-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index d660e1f4b483..08a3e603db19 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -185,7 +185,7 @@ if (defined($ENV{'KBUILD_VERBOSE'}) && $ENV{'KBUILD_VERBOSE'} =~ '1') {
>  if (defined($ENV{'KCFLAGS'})) {
>  	my $kcflags = "$ENV{'KCFLAGS'}";
>  
> -	if ($kcflags =~ /(?<=^|\s)-Werror(?=$|\s)/) {
> +	if ($kcflags =~ /(\s|^)-Werror(\s|$)/) {
>  		$Werror = 1;

OK, I've applied this one and will sneak it into the 6.7 pull request,
thanks.

jon
