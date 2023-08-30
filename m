Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE51978E15B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbjH3VYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbjH3VYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:24:14 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194491A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:23:38 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68bec3a9bdbso76253b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693430234; x=1694035034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGe4Pd8w1XrhVdlP17guvu7l/IZfeNQ7rJWtm4eORLw=;
        b=J683F7Y+MNn61wydBMMz9tQRIvqoLVnywNW2hhlOpKahl9qw5biPuQb7N+gwngc8OV
         RWopjtRtnLmbP8QSGlfKqA+iaAn4mHKecyXCbU0IO+SodJ1H3+TmojsDrQ8D5xd/1AbS
         hlRieI2Ww1zoejwIvg3RIK9tLpy3Ii0vdcqag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430234; x=1694035034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGe4Pd8w1XrhVdlP17guvu7l/IZfeNQ7rJWtm4eORLw=;
        b=Ax91z8AGeUtUTzR+XGqiMc39vwiXSJ0dST1uvrZdksuqzw5SV0fdn14fhggJSWYB2G
         Gj13qyMmHz/ZU/BFEKTfC2OZD7Anu+nGcp5yr5xZsg+1ySgqNosd1APx7zjfNGu5Uy5E
         CkvkKGjUGCyFdwIFtxWivhbMWnQWm+BMrPYv21srRcILgXpIBoGY0X5cBi8HPLD8KsLd
         uBTUHE6enOGsdKjTOr2l0YXniXqTKFugYYrBYtaYiQL4mk1S6ZbHwxHyy0H6cMPlliJd
         YSdd7VmI6X/ursy8OfnoKF1+V9zfYdjNlDY0kHNXkp8HqWIxZbN/3d5NN6aEBCuc6w1Z
         3unw==
X-Gm-Message-State: AOJu0YyzDyR0JYmcsiEwgWlPmGLP5CIJOpFm91pDJSpXXqS0+ga0kto/
        /fXHdeqsJ241gZzEwKYZCL4LtA==
X-Google-Smtp-Source: AGHT+IEhDIeNkXGeOol6NmD2a6/aKXuUj39+GPQFW3PVFsAxlOBUs8czLJdOIDe37aRlRtNO1kTfiQ==
X-Received: by 2002:a05:6a00:1799:b0:68c:3f2:6007 with SMTP id s25-20020a056a00179900b0068c03f26007mr3677865pfg.8.1693430233873;
        Wed, 30 Aug 2023 14:17:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78086000000b006889511ab14sm22956pff.37.2023.08.30.14.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:17:13 -0700 (PDT)
Date:   Wed, 30 Aug 2023 14:17:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] init/version.c: Replace strlcpy with strscpy
Message-ID: <202308301415.42CAF1C13B@keescook>
References: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 04:08:06PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  init/version.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/init/version.c b/init/version.c
> index f117921811b4..94c96f6fbfe6 100644
> --- a/init/version.c
> +++ b/init/version.c
> @@ -21,10 +21,10 @@ static int __init early_hostname(char *arg)
>  {
>  	size_t bufsize = sizeof(init_uts_ns.name.nodename);
>  	size_t maxlen  = bufsize - 1;
> -	size_t arglen;
> +	ssize_t arglen;
> 
> -	arglen = strlcpy(init_uts_ns.name.nodename, arg, bufsize);
> -	if (arglen > maxlen) {
> +	arglen = strscpy(init_uts_ns.name.nodename, arg, bufsize);
> +	if (arglen < 0) {

nitpick: this is no longer "length of arg", it's the length of the
destination string. Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

>  		pr_warn("hostname parameter exceeds %zd characters and will be truncated",
>  			maxlen);
>  	}
> --
> 2.41.0.255.g8b1d071c50-goog
> 
> 

-- 
Kees Cook
