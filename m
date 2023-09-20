Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A4D7A784D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjITJ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjITJ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:58:35 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F2F1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:58:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-5308430052fso6644385a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695203900; x=1695808700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JuLstdULL+9O12ksEVrhOrE8xohHCriozL2R7kr9wsU=;
        b=MWPgFZOKpyi90rllEY2JHAETeGoUbT9EwaY1cgFARFZacloXrQMpgwBm6+D+8P0tOa
         vucBv3fFrC2G9irFnNxCPYuoHbaCBBWzEseAbhY/5kodqVNFNR+xH5KFnE8OKY5nP5mB
         QRFQZ8VG4F6d+Yc761JnYH1qEgKyv19uaQs84WIrOfuUVDehhqEJTyQoGMTPGmUpWb3R
         VxjHBoL5USKoscbmICDZTxhBCbYRWfVckbiAv9trlglIAVxI/V8kRFSm4S22x3Uf2Wgl
         bgCYpVpMivzxE8j80fGlLZ+P5oJDCN8bG5BuxFbLLnMMQS/XZoTWig+0+5/H0B4Fze2h
         XwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695203900; x=1695808700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuLstdULL+9O12ksEVrhOrE8xohHCriozL2R7kr9wsU=;
        b=XJlMu+vtrG2iPR1m/ExIcrznvkCqPsLd8HVz5Xs+nfrrh8dzyg9ikQIw2EwoJaMwvA
         JPOGyAtNqXo5DCtpFeIb11SBjTb0S3FP3Ka+xDg6LQ8kry2fsrBFcjjw0iaqVq+jlzzP
         u1dcE80BvKd3TmvJ12rXgluE2pR4tLr9LAVM3Pb/mX0JskOUIYgYIwfaJNaJ/koD0ypD
         lcrmnOOPZZ+jNPcCxqj5wWdnX6Ja74r+2S2zaoZL29nEHYoJ89wJx5bM6JnNObxk18tw
         a8n4eUYTj4j3EEaiTufwxptjRZzTW2u/0Xa26FSR5m8Z6Jja9WrP75ysCJlWxp2maWMa
         n8cg==
X-Gm-Message-State: AOJu0Yw4PgGtU0jyCvBjqf8vHGrHW7U8LP1d+I3eytjEP9hYQutudSlR
        KFSh2j0grETkSIDrawq62ZijyOo8LOc9nKPOud8=
X-Google-Smtp-Source: AGHT+IHxb41VlvhZmfdMDaH9WPByQBzvrpvRMO9a59WOypr5/4Kw13TOhdfJKUi0HA5By1OVpoHbv+q6NFBs/Rd5468=
X-Received: by 2002:aa7:dace:0:b0:52d:212d:78ee with SMTP id
 x14-20020aa7dace000000b0052d212d78eemr1591973eds.25.1695203900414; Wed, 20
 Sep 2023 02:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230920041446.300415-1-koba.ko@canonical.com>
In-Reply-To: <20230920041446.300415-1-koba.ko@canonical.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 20 Sep 2023 11:57:44 +0200
Message-ID: <CAP01T77uPmAmCiqNUJ=NwJ3c=1uTM9Qb92-yQTRc4NVUuK5y6g@mail.gmail.com>
Subject: Re: [PATCH] x86/arch: Fix access invalid member when disable CONFIG_UNWINDER_ORC
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 06:14, Koba Ko <koba.ko@canonical.com> wrote:
>
> CONFIG_UNWINDER_DRAME_POINTER doesn't have bp and sp members.
> this leads the compilation error when only enable CONFIG_UNWINDER_DRAME_POINTER.
>
> arch/x86/net/bpf_jit_comp.c:3022:72: error: 'struct unwind_state' has no member named
> 'sp'; did you mean 'bp'?
> 3022 | if (!addr || !consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp))
>
> Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---

Hi Koba,
Sincere apologies for the build breakage. This is fixed now in
bpf-next, and I believe it will soon make its way into net-next and
linux-next.
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=5bfdb4fbf348f9e1935a6e9c64e7f60cb913fb21

>  arch/x86/net/bpf_jit_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 84005f2114e09..db2b09949d407 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3012,7 +3012,7 @@ bool bpf_jit_supports_exceptions(void)
>
>  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
>  {
> -#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_FRAME_POINTER)
> +#if defined(CONFIG_UNWINDER_ORC)
>         struct unwind_state state;
>         unsigned long addr;
>
> --
> 2.34.1
>
