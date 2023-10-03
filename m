Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6527B7131
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjJCSku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjJCSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:40:48 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3B695
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:40:40 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4527d7f7305so645751137.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696358439; x=1696963239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4EHhQcGy2VS2JlcOPiKLjlIFfrg/psFf5RMRLEP3YE=;
        b=NVtywLp8/m1kTVnO0jYxdh9jx11prD5iwZL/YqB/oMwyO4tFVZxoQP2h2ZE0JbpHT0
         Wy1M/eGPM9IViLC/2ECIxhMjJYoQ2JjZIcsGqqLAM255BX/DYocKVflc2Z8YkIPT/Eac
         w/DIfDT4+EmgDlReX/GfMNolUro/9r3LB+3SwUCKegITK8iMoOP9iBtGBmJrxLYv0H4K
         EY/G7dLU4xEqEF+SbxDVlihDtikfidTk4kJTpZNGzpWCiyKD7XohoGEfGZokkv8oMbN8
         Hv2Do20wBlQUS60xofEdFGWUxurLRfeAu4AO/F4K7YTZE8LuZYMjj6zgbQiqS0FI/7Wb
         2x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358439; x=1696963239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4EHhQcGy2VS2JlcOPiKLjlIFfrg/psFf5RMRLEP3YE=;
        b=ehXURBVeFCXHpVWBBwF9zcAn6zA8HHEWn4B5SG4YxQhkDBEujiU3rbSsGhkDMvEuTg
         MPz+BKGQOEypuZonxmAAFyHPKdSjITRH16x+bNwPhPKDecdJbjZW1id1dAQncX3EkqKm
         /ac/3j59UWnFH1nRcG1d7vaMWHcfdDpkwYY8uQ2PyUzwzE1s7tjhj3p/2esvmeANaoDR
         E3xgiwfxp8taezloJzFxa5fR+0VXCgB2aNmwT5dDECOsM8f1OF3jy03gSVGsKxdvPI42
         H34Vx7rDKuPG7up09Dy6WajT+D0BCzURgpUMvnBu8WE5oAW2blpE+A3uch9nrKpHbjN0
         y92g==
X-Gm-Message-State: AOJu0YyDxTJRnSNqvnRR24gDuAyknjk/dEtt82CQNxqigb8tKs09KVpb
        vwb6zoQLBZwjMLZ2QwS8dbjVoSvy76IFRDGiW4d6Pg==
X-Google-Smtp-Source: AGHT+IEXyXPbfnJlsOBki7NVmiAFCgLoSOf3hPuUmd5KFCUolgJZY900HDpzR6daqk+k9LaODgXmolUHPsjA5BASddI=
X-Received: by 2002:a67:b40b:0:b0:452:74b1:63d7 with SMTP id
 x11-20020a67b40b000000b0045274b163d7mr210462vsl.6.1696358439487; Tue, 03 Oct
 2023 11:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231003182407.32198-1-alexghiti@rivosinc.com>
In-Reply-To: <20231003182407.32198-1-alexghiti@rivosinc.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 3 Oct 2023 11:40:03 -0700
Message-ID: <CABCJKud=VqYNuQmw1y7JUSBDuPXpPGDv-WwPOeSmBZtf0RUM=w@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix ftrace syscall handling which are now
 prefixed with __riscv_
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 11:24=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> ftrace creates entries for each syscall in the tracefs but has failed
> since commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") which
> prefixes all riscv syscalls with __riscv_.
>
> So fix this by implementing arch_syscall_match_sym_name() which allows us
> to ignore this prefix.
>
> And also ignore compat syscalls like x86/arm64 by implementing
> arch_trace_is_compat_syscall().
>
> Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/ftrace.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftr=
ace.h
> index 740a979171e5..2b2f5df7ef2c 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -31,6 +31,27 @@ static inline unsigned long ftrace_call_adjust(unsigne=
d long addr)
>         return addr;
>  }
>
> +/*
> + * Let's do like x86/arm64 and ignore the compat syscalls.
> + */
> +#define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
> +static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
> +{
> +       return is_compat_task();
> +}
> +
> +#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> +static inline bool arch_syscall_match_sym_name(const char *sym,
> +                                              const char *name)
> +{
> +       /*
> +        * Since all syscall functions have __riscv_ prefix, we must skip=
 it.
> +        * However, as we described above, we decided to ignore compat
> +        * syscalls, so we don't care about __riscv_compat_ prefix here.
> +        */
> +       return !strcmp(sym + 8, name);
> +}

Good catch, thanks for fixing this!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
