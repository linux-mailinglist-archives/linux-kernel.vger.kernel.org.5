Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFB9803C22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjLDR6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjLDR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:58:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97803FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:58:50 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bed6c1716so103e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701712729; x=1702317529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M2dGUfstuu9hpA5P20OKWEe6aEE9pZqEiqGcMNxwt0Y=;
        b=N7a8lt2kM/YN9dmxStcic1qHKCmGYYSHPbgDaK3TQn76v3gG1JfQnsw63Nqp9eNRbs
         qhosLPAKMkxaZvGZ0zedlcb25nke8nHRcdhd/6M4M5oPeKBGBqkbKB0SDz/zIl/JGy3m
         tVpi3skSAAhNHzEJqooRURHyOeOhQTwmDq+QQpu2CvCjBC6hKEEm75TrIC7lRrEhrd/U
         CDWzvAC0t4CU58gjlaNT/u6P0AaO1vTF4/MroR5U1RIihOufmpoypxWxK41NuSkLjJpM
         c+aMQ1u76zfl8gtMX6Me/DbnGDz7JDNXeHaSFdPtF9skBd7KYkycPiWVDVzGfpYOtRdw
         vohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712729; x=1702317529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2dGUfstuu9hpA5P20OKWEe6aEE9pZqEiqGcMNxwt0Y=;
        b=l95ADpecwfygqny8sfV5rwQ64Niq9SrF14MoZlM7PnK6gF4yw36Av3nlIl7SI8BJoy
         kMzGCdbzWF/UU1+lY5WyP77VJZafBT0EtNVdkE7Vu9yPND0hIR8XYlZNH2HDFJKpFV9N
         48tgYmc54+UpPD4b4d1vx3SYeRbJ3h3WtNQiPCnPi206KH94YW5j6sJ/utr8tUd7NODj
         HDiKtVSjcNvMGSJEWNYGuhIEL6FNxArNpWoXVQZUKfVjclrmsztxtsevbK++EM8PhFsC
         UlvvlZtvCZPcr+WEr+5qtjCm3OIogg/QISAtzfpbVUcWU7N/Wwn7u151WcnG+KwiJDav
         vQ4A==
X-Gm-Message-State: AOJu0YysIP0jFmX/cLhO8l0EGwP20iftw4AsbPyD9OnaCd+cZcuZUpsB
        VsTvcRAzHFW5wNacYbJtEiaSr7Hw4kzI7WuQevnuXA==
X-Google-Smtp-Source: AGHT+IHspoH9apSWcUgPcEWJCkpeYvSoli8ODebiezNEvagGADeVfPIhvJmNnKaXWLk6htJi6ipiIFDIY61wlipGWh8=
X-Received: by 2002:ac2:4ac1:0:b0:50b:f115:7ffb with SMTP id
 m1-20020ac24ac1000000b0050bf1157ffbmr71731lfp.0.1701712728350; Mon, 04 Dec
 2023 09:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20231204171807.3313022-1-mark.rutland@arm.com>
In-Reply-To: <20231204171807.3313022-1-mark.rutland@arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Dec 2023 18:58:35 +0100
Message-ID: <CACT4Y+avSyKoW-i=GzDT0iAi7SnQg21BanNK1GjkQsKKBUCKNg@mail.gmail.com>
Subject: Re: [PATCH] kcov: remove stale RANDOMIZE_BASE text
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        alex.popov@linux.com, andreyknvl@gmail.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 at 18:18, Mark Rutland <mark.rutland@arm.com> wrote:
>
> The Kconfig help text for CONFIG_KCOV describes that recorded PC values
> will not be stable across machines or reboots when RANDOMIZE_BASE is
> selected. This was the case when KCOV was introduced in commit:
>
>   5c9a8750a6409c63 ("kernel: add kcov code coverage")
>
> However, this changed in commit:
>
>   4983f0ab7ffaad1e ("kcov: make kcov work properly with KASLR enabled")
>
> Since that commit KCOV always subtracts the KASLR offset from PC values,
> which ensures that these are stable across machines and across reboots
> even when RANDOMIZE_BASE is selected.
>
> Unfortunately, that commit failed to update the Kconfig help text, which
> still suggests disabling RANDOMIZE_BASE even though this is no longer
> necessary.
>
> Remove the stale Kconfig text.
>
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Popov <alex.popov@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks for fixing this.

> ---
>  lib/Kconfig.debug | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index cc7d53d9dc019..e77873cf85c78 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2103,10 +2103,6 @@ config KCOV
>           KCOV exposes kernel code coverage information in a form suitable
>           for coverage-guided fuzzing (randomized testing).
>
> -         If RANDOMIZE_BASE is enabled, PC values will not be stable across
> -         different machines and across reboots. If you need stable PC values,
> -         disable RANDOMIZE_BASE.
> -
>           For more details, see Documentation/dev-tools/kcov.rst.
>
>  config KCOV_ENABLE_COMPARISONS
> --
> 2.30.2
>
