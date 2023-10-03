Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1288C7B70CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbjJCS13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjJCS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:27:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137BF95
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:27:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d20548adso1189142f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696357643; x=1696962443; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKEsyAv6XjAH8lDfghIcM7e9BN4zDNSRbHBKEya8cd8=;
        b=D4HpboJsYPOZH0bf75Te51EUSLV92q4xXzWFCeZHCbTj1qLAFER9Pd9HccRXqnd3pM
         YZU/3OoIrGdmiz488e/F8uHhIBKBvsgU81VFWQ2vSRt6zF1AbmDMvSBQ5sjLVpuDTB7v
         qVJqHFi+nUh+U9I5jPzTm3q0Jn9PMiu1vn+1c2w+o1K+XQhrg36ko0s+KP5/zi6MPDIN
         nDv6f4mt59pByDKp0PZMdLVdzreNMCClFk8DB9lMKyhxtVgjRhdshv2DlASx8caAqoNc
         nq4yUsCSPtxbceXNCdWCIiRyaQJAb3TR6yR8ddKLcXV4RzZQ8VrL/dRMXjBwt9kSGvZL
         oCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696357643; x=1696962443;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKEsyAv6XjAH8lDfghIcM7e9BN4zDNSRbHBKEya8cd8=;
        b=XncnCDjRP7vgXgTzG8wKmOYguIKkh1k55jkzwEHpQM4hTg3fN9vaJMAS6SdejaOMJf
         27wWjT9XTGtFYQpD5BYCXngvR984mwaSld9HuVRgcacjNCSOPRwjwhBNPrb5bGq6UF1Z
         b9ai6J/tCWziz6DwNTrNT95Pqpgf9ZE9eCS7okDf4B96DgyrwVAfcZSxULL/Shf4GLqV
         hxr3OPC6S06Sk/Xtwqj+usoyMnk/LJ1kw2Hq5mfgREL4lHHWIZB/EykDr29Cb67XI+1E
         1FAp+kFcMSVWa99Cyz2yBjurJmxAg4uDai9j3u/w/O94Vew0wgypeU5GYnUPtbZSz//S
         QJTQ==
X-Gm-Message-State: AOJu0Yyvedw9/OR4FJM2/44zMjFHGuDdDDtfMlRPrE/OIpWReOz0Gs1X
        DGcd9E6p0W64BECzPsQ+A/obVoZ040CMgXaqxLSepA==
X-Google-Smtp-Source: AGHT+IFFlWyGOt0b75dfwwM1K65K2zojxoftJASga5Hu+zgw0aqN5/Z8ze3Y/z9ubr5U1wQ1TY3F3woRwx2wqOVdm9U=
X-Received: by 2002:a5d:6909:0:b0:317:e542:80a8 with SMTP id
 t9-20020a5d6909000000b00317e54280a8mr39860wru.15.1696357643542; Tue, 03 Oct
 2023 11:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231003182407.32198-1-alexghiti@rivosinc.com>
In-Reply-To: <20231003182407.32198-1-alexghiti@rivosinc.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 3 Oct 2023 20:27:12 +0200
Message-ID: <CAHVXubgTkoWYEybsbXVbCMO4JaMAChaSq4BgqZZO9ih7OxwUyA@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix ftrace syscall handling which are now
 prefixed with __riscv_
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Conor Dooley This fails checkpatch but the documentation here states
that this is how to do:
https://elixir.bootlin.com/linux/latest/source/Documentation/trace/ftrace-d=
esign.rst#L246

On Tue, Oct 3, 2023 at 8:24=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
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
> +
>  struct dyn_arch_ftrace {
>  };
>  #endif
> --
> 2.39.2
>
