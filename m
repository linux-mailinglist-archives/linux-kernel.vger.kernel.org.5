Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC4C7D5F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbjJYA1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbjJYA1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:27:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B092ED7F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:27:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso4151849b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698193664; x=1698798464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TH/bxJhzk4YBMuPvj5C/RXj2mSj5ZNHWKAEzVgv6LAI=;
        b=elW45zfKHiHj1TAULAWxgVgKeQv8BHQRj+pr3j0026rN6lz4+0DpEhpKyKnvC0eu8/
         de577vi3jiMu5qa0zKFPdyk7mBVQk02BCZv26IFxhvihrhiA7I1pB3C4RAXDZcW6zw82
         nFWL5L/7QyvvV9nxYxtAFXnRON+6aDbPvTmZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698193664; x=1698798464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH/bxJhzk4YBMuPvj5C/RXj2mSj5ZNHWKAEzVgv6LAI=;
        b=XSV7OUThUiSKozNqSNCYYvrViBGUbfUeyFq76poSj1c+R7nmXjQGJ59u0l8WilkKCw
         8/rL/WHGCprPEnWbAuDIR9FqtTCtQJ7jEnvEQfjI/jtOxtn3xpqTOyoXjAQSDOaMhvYy
         ndhuj7ivtrTouoUE50yoi27BYUGtzOW/qPRXnkPOq6liqRlWRU46qPtJRUr47HE/fFDU
         oUJ1XrgY+avOIulw1fRG/SyYC6WokeSitSzCNK8xaKI4vffQ1GSLcqO29RpFhr31p+66
         9IJr+Tdbo52ecSoEk3uy2vyoUf5td+MkYZjGMjF7q1at+mSIiLQbI58DJ/UTl1d0Q8eK
         s4GA==
X-Gm-Message-State: AOJu0Yzyx72c4XcjCE+TDEi3GlBQnQ1ZDTbmf4yKzHlHsgVW89/p3Jh/
        TkU9Rz8YdkiETiqoPj/EOHn9bjAPtIxxQXJKwo4=
X-Google-Smtp-Source: AGHT+IET7rqMR9OH/w3FWw9AK/oAQKufGhWIN9o/TsoD1Nk8vYc1Kzw4/JZETEyaQhasjAiYaaCKcw==
X-Received: by 2002:a05:6a21:a583:b0:155:5c28:ea67 with SMTP id gd3-20020a056a21a58300b001555c28ea67mr5196136pzc.38.1698193664123;
        Tue, 24 Oct 2023 17:27:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t22-20020aa79476000000b0068e49cb1692sm8139544pfq.1.2023.10.24.17.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:27:43 -0700 (PDT)
Date:   Tue, 24 Oct 2023 17:27:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: replace deprecated strncpy with strscpy
Message-ID: <202310241727.A4EB83D8@keescook>
References: <20231023-strncpy-drivers-scsi-3w-sas-c-v1-1-4c40a1e99dfc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-scsi-3w-sas-c-v1-1-4c40a1e99dfc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 07:50:57PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This pattern of strncpy(dest, src, strlen(src)) is extremely bug-prone.
> This pattern basically never results in NUL-terminated destination
> strings unless `dest` was zero-initialized. The current implementation
> may be accidentally correct as tw_dev is zero-allocated via:
> 
> 	host = scsi_host_alloc(&driver_template, sizeof(TW_Device_Extension));
>         ...
> 	tw_dev = shost_priv(host);
> 
> ... wherein scsi_host_alloc zero-allocates host:
> 
>         shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);
> 
> Also, further suggesting this change is worthwhile is another strscpy()
> usage in 32-9xxx.c:
> 
> 	strscpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION,
> 		sizeof(tw_dev->tw_compat_info.driver_version));
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's not be accidentally correct, let's be definitely correct.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks legit.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
