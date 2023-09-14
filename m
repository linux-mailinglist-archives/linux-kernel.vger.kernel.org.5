Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411347A0ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjINQbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbjINQbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:31:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B111FD7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:31:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71DDC433CC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694709072;
        bh=yK9wOyly7qXn00unB+iWDobdGAfW+ysMR294jVlJehY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YnPF73tA4FJIt1zHgix/GbKseAd2p1qSvJtvFEtLKU3tglVfdtSVXz45R90EkROQz
         4DpirqdSNTq64df/D8anke/yvRlxoNEUDu6aYxjnyf/Z4JUO9LnCsZyYHmiNwgiMcl
         5IHyGhGtTIOsXVfp3AD3GwKvno+ZwQOi+qR6VWpQzoWEZVywa6c35nRqcoNhN4VWYA
         /D479EcO6+Df3QjJVMxfSgNkUz4ldk4Dp1pbDkeAG5mCGwgVWRYgOavhfoCQE6MtkC
         2uV3mPcZf7JO5x//6SjPYIaphF1Hg5cdZ+WD+0lZMajeZUHbBOuVZHsm1/woQ9/MyH
         wCdJ6RKgfup4Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so18688561fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:31:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YxkiOIpDFE8UUF4m57EhVXWNA00HKXpvSZ7B42y0QVeawR7yIs/
        +iloLjoVImh91pel/QWuvs6iHg4Gi5WEgIilW60=
X-Google-Smtp-Source: AGHT+IEyDvQTasFSMTuQOc1lTVEzqzqm8NEorFEDvZRS+lGp6oHxPgR0Z57DdvNG5dUkvLYrxKYK4WrAwjGHajHGftg=
X-Received: by 2002:a2e:3012:0:b0:2b9:aa4d:3719 with SMTP id
 w18-20020a2e3012000000b002b9aa4d3719mr5166010ljw.12.1694709070929; Thu, 14
 Sep 2023 09:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230908231244.1092614-1-song@kernel.org>
In-Reply-To: <20230908231244.1092614-1-song@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 14 Sep 2023 09:30:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Xy_K=6u4s=pNAZ8+eGBtX8v16Fr+9quL-FftEu+DWOA@mail.gmail.com>
Message-ID: <CAPhsuW5Xy_K=6u4s=pNAZ8+eGBtX8v16Fr+9quL-FftEu+DWOA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/purgatory: Remove LTO flags
To:     linux-kernel@vger.kernel.org
Cc:     ndesaulniers@google.com, Ricardo Ribalda <ribalda@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        kexec@lists.infradead.org, x86@kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Fri, Sep 8, 2023 at 4:13=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
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
> Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections"=
)
> Cc: Ricardo Ribalda <ribalda@chromium.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Song Liu <song@kernel.org>

What would be the next step for this work? We hope to back port it
to our production kernel soon.

Thanks,
Song

>
> ---
> AFAICT, x86 is the only arch that supports LTO and purgatory.
>
> Changes in v2:
> 1. Use CC_FLAGS_LTO instead of hardcode -flto. (Nick Desaulniers)
> ---
>  arch/x86/purgatory/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index c2a29be35c01..08aa0f25f12a 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -19,6 +19,10 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS -D__NO_FORTIF=
Y
>  # optimization flags.
>  KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-use=
=3D%,$(KBUILD_CFLAGS))
>
> +# When LTO is enabled, llvm emits many text sections, which is not suppo=
rted
> +# by kexec. Remove -flto=3D* flags.
> +KBUILD_CFLAGS :=3D $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
> +
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved sy=
mbols.
>  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
> --
> 2.34.1
>
