Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30D8799293
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbjIHW7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjIHW7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:59:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D39B1FEB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 15:59:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf7a6509deso19718255ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 15:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694213982; x=1694818782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETim7bqC4c0aI+Gj1+8OKYYdNlAwl+LsLJgDB3GOPU0=;
        b=yMUZ6/HC++uW3+txnrYeAqIlInlYuHN1ddTYx5Vx2H0AyviviajNsnl4mm4IMezYKL
         ekoGtEVMFzMDJFzs7oz8ABwofyFIEDOhoLJFDObBpIJi+0kOv1jCJ9GMxb6h4FTz/8UA
         1Q9YhcJ6LvsOxaFpNRQjWeeNYB3k94Q/MV9QB2+ZXTQoVPreONz+kglhKKQnGKvYUtUa
         wypAMALy/GkhufD8CScgguIpyHoHjskAbQm5QH9nYcOJtn6b1w/3RyuGhFG3kzcyGRVG
         zC7h83w4bVgMjlfaDCbbF58BOokb1e/5HA8YXDexatI+L9EduA46ZCqCdB+FEe2kCpF9
         rm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694213982; x=1694818782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETim7bqC4c0aI+Gj1+8OKYYdNlAwl+LsLJgDB3GOPU0=;
        b=U05h/BypTDsn1PE2EDd7vVOXJK2YBoWN4QC82PjZKg4GxeUhjw98v9IhWdJrIiXrrn
         anJX/bpQ//cEhEYzBB52y4OZDXxOCmGIBrh2EsqUFMeic6KJf2l+VWQy2khDDnUOrmnb
         4bZU5pF7DX5e8mX1Oe895RxARXtgAz8ceHRUJWcEsmlwa3+2B2Wh1UxFwaVuO1EdETPv
         QtQQWNuWCLTP9Wi0RDNOtFmLxOfhtqd4tJ37y+/YZQHe589Gtihj1JoCoAfCrW7jqa+0
         qy0nFjqsBEiKmG1B5Km1+HdBOxX6QXQWXDePiL3aOfCm+H4sxT1DqYinuUxpUJTems93
         sXrQ==
X-Gm-Message-State: AOJu0YyA7ViLApjQx+nsh0OW+p7oLZSGui8l50TVqlPwkIJJI9wlRga+
        E62xebkyXSMJWCrPR4z/g25LpQ==
X-Google-Smtp-Source: AGHT+IHrseoLZKz9f+X23SUo9lh+9srjRT/B0C9SNO5Kl8Ketugg/YTE6oE1r1EnvshvFys7O6MlqQ==
X-Received: by 2002:a17:902:834c:b0:1c0:a417:ccb2 with SMTP id z12-20020a170902834c00b001c0a417ccb2mr3011165pln.35.1694213982229;
        Fri, 08 Sep 2023 15:59:42 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:d39f:a985:2060:eedd])
        by smtp.gmail.com with ESMTPSA id y12-20020a1709027c8c00b001ba066c589dsm2060747pll.137.2023.09.08.15.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 15:59:41 -0700 (PDT)
Date:   Fri, 8 Sep 2023 15:59:36 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, songliubraving@fb.com,
        Ricardo Ribalda <ribalda@chromium.org>,
        kexec@lists.infradead.org, x86@kernel.org, samitolvanen@google.com,
        llvm@lists.linux.dev
Subject: Re: [PATCH] x86/purgatory: Remove LTO flags
Message-ID: <ZPunWKU/TlrN9xiH@google.com>
References: <20230908225353.984169-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908225353.984169-1-song@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 03:53:53PM -0700, Song Liu wrote:
> With LTO enabled, ld.lld generates multiple .text sections for
> purgatory.ro:
> 
> $ readelf -S purgatory.ro  | grep " .text"
>   [ 1] .text             PROGBITS         0000000000000000  00000040
>   [ 7] .text.purgatory   PROGBITS         0000000000000000  000020e0
>   [ 9] .text.warn        PROGBITS         0000000000000000  000021c0
>   [13] .text.sha256_upda PROGBITS         0000000000000000  000022f0
>   [15] .text.sha224_upda PROGBITS         0000000000000000  00002be0
>   [17] .text.sha256_fina PROGBITS         0000000000000000  00002bf0
>   [19] .text.sha224_fina PROGBITS         0000000000000000  00002cc0
> 
> This cause WARNING from kexec_purgatory_setup_sechdrs():
> 
> WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
> kexec_load_purgatory+0x37f/0x390
> 
> Fix this by disabling LTO for purgatory.
> 
> Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections")
> Cc: Ricardo Ribalda <ribalda@chromium.org>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> AFAICT, x86 is the only arch that supports LTO and purgatory.
> ---
>  arch/x86/purgatory/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index c2a29be35c01..9c0bff4992ea 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -19,6 +19,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
>  # optimization flags.
>  KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
>  
> +# When LTO is enabled, llvm emits many text sections, which is not supported
> +# by kexec. Remove -flto=* flags.
> +KBUILD_CFLAGS := $(filter-out -flto=%,$(KBUILD_CFLAGS))

Thanks for the patch!

Please prefer something akin to:
commit 6e20f18579c5 ("efi/libstub: disable LTO")

Please also CC Sami and llvm@lists.linux.dev for v2.

Pretty sure we use a linker script to rejoin .text.* elsewhere in the
kernel, but it doesn't look like x86 purgatory has one.

> +
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved symbols.
>  PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
> -- 
> 2.34.1
> 
