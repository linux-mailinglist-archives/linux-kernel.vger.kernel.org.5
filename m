Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC09978E25D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbjH3WfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbjH3WfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:35:19 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82255E46
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:34:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-564cd28d48dso240665a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693434893; x=1694039693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H349t5BLDzZGdOT/qIW4Y0MnkdkIeEkiYwVrHohy3Oo=;
        b=YGlkBxBmQrBjgH5SWS80zq2M8Bn2Nit6eKDvy9Ps4gw8HIxKHFiio1ezxn+ZleZD2L
         cGIaGblazYlvbFOd5z5kELgBT5sBggZ4ulo5XbqWUh6ncamQWeN4106vvbym4ygsklCm
         jg4mLvghoixQmHxEdXKiF5ZYUDQbIOhkajqog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693434893; x=1694039693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H349t5BLDzZGdOT/qIW4Y0MnkdkIeEkiYwVrHohy3Oo=;
        b=F34ID/hgQJl4Ok6pNCPMkjS4bSJA2+TcXBs+CMWQxL3FRCa5JO6KAshFB6Hb63n+ju
         NrJnY8i01XNCE2MnjwGJ2YANkn0UWOHq6Wa2qOxNcV6G3ay45F3uDwqjyFHU4Jf6lPYr
         er2HpVKYXSVEQbpH50NaB4l/WxKUX2rFiAhvXhViLtzsVPF8D5vqgx9FljObNVHS0zCk
         LZFBU9/7QxI4wFjyrPUUTfMdUWF+UG/sjJRcbv1fVi+SWbJp0tsz/mT+4W30sHBW8Jlh
         knt/yDiWpOJ2j7Ai93yXFeqhU0F1h01P+z5RGSVZtgl3GPAeyM99vZ2HxHWJzd4ruBn8
         qfFA==
X-Gm-Message-State: AOJu0YxCIO09jpC8b1RFJS4iwUEwF7F5UwAaLVafDB+N6eR+BN+j/H6Z
        +VSAxCbC4eHO+fefSPfLFLsVcw==
X-Google-Smtp-Source: AGHT+IHFl7iM6EXsgM8MgKuI4oOXAeizDRCFkDsV4FulHrVc0r/znpAO1pO4mZiU4kBmEFzxgLRLow==
X-Received: by 2002:a05:6a20:12d2:b0:14c:5dc2:659c with SMTP id v18-20020a056a2012d200b0014c5dc2659cmr4170802pzg.22.1693434893130;
        Wed, 30 Aug 2023 15:34:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q19-20020a62ae13000000b006871fdde2c7sm74459pff.110.2023.08.30.15.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 15:34:52 -0700 (PDT)
Date:   Wed, 30 Aug 2023 15:34:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        linux-hardening@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kobject: Replace strlcpy with strscpy
Message-ID: <202308301533.D6E65EF5C@keescook>
References: <20230830202021.4134348-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830202021.4134348-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:20:21PM +0000, Azeem Shaikh wrote:
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
> v3:
>  * Fixed weird indentation.
> 
> v2:
>  * Updated error message to remove @len which is errno now.
>  * https://lore.kernel.org/all/20230830150136.3798414-1-azeemshaikh38@gmail.com/
> 
> v1:
>  * https://lore.kernel.org/all/20230703180528.3709258-1-azeemshaikh38@gmail.com/
> 
>  lib/kobject_uevent.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7c44b7ae4c5c..032d81b959f0 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -254,10 +254,10 @@ static int init_uevent_argv(struct kobj_uevent_env *env, const char *subsystem)
>  	int buffer_size = sizeof(env->buf) - env->buflen;
>  	int len;
> 
> -	len = strlcpy(&env->buf[env->buflen], subsystem, buffer_size);
> -	if (len >= buffer_size) {
> -		pr_warn("init_uevent_argv: buffer size of %d too small, needed %d\n",
> -			buffer_size, len);
> +	len = strscpy(&env->buf[env->buflen], subsystem, buffer_size);
> +	if (len < 0) {
> +		pr_warn("init_uevent_argv: insufficient buffer space "
> +			"(%u left) for %s\n", buffer_size, subsystem);
>  		return -ENOMEM;
>  	}

I thought scripts/checkpatch.pl would warn about this, but kernel
coding-style (as it is) says to not split strings. I'd expect this to
be:

+		pr_warn("init_uevent_argv: insufficient buffer space (%u left) for %s\n",
+			buffer_size, subsystem);


-- 
Kees Cook
