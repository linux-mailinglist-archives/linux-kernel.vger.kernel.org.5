Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDD27D520D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjJXNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjJXNmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:42:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B293;
        Tue, 24 Oct 2023 06:42:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD88BC433C9;
        Tue, 24 Oct 2023 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698154953;
        bh=oLUw4HUETYTag/q+WgmsddbpnNeeKsiPxomQx+RAhQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RnVNYQASnBUCi7hrFCOBYE/zVGD6T5aLyP0YOtluyOSHUDBMjO2GQu/0+y1MIfN0K
         n9VVgaDU9jzdbNbLpfX7HnKPBdXM5rG8SdSWUUpYWHCqIWGYtZ7pUH1D8HveLn1GT2
         YG94zDB63VHZiWgZiDxBKcMzX1muHDi1uhAKZY28iWx2WJ7IqNrliPV7rxjmSgFm5A
         iLCkvGGUKLb3YjgvSQqiKD+jTKIxFMJDdx4ZeMurfFBRUzOiFfSCWoYmlgtK0rkJTP
         tN/jgZCG5uzzA8wPz4Y+HXk4vuNGBjXVS4UARSn1QKZ7niibfBgPI7E8KV9DXTop5l
         KCQxKWcsmOHkg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-507bd644a96so6624926e87.3;
        Tue, 24 Oct 2023 06:42:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YwGPyNVrjj5iwVeR/RTFIlBujVuqNSNukX/CN/qI1e+ieB6DxGE
        OT2kVgDPZ/1BNhMZtJPVoXkF39U5VXDjUm3P4F8=
X-Google-Smtp-Source: AGHT+IEeBOhs0t8y/Hr0aF+QuXEThQOJnUMJRir36Ob9NXaBD+VMPSvQjk2UmmPL7QSj7rkMV8lNLpTXKIwn6NTX9jg=
X-Received: by 2002:ac2:5333:0:b0:502:d743:9fc4 with SMTP id
 f19-20020ac25333000000b00502d7439fc4mr8948350lfh.37.1698154951976; Tue, 24
 Oct 2023 06:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231024172409.7b519868@canb.auug.org.au> <ZTeUhsf1xWmkJcRh@arm.com>
In-Reply-To: <ZTeUhsf1xWmkJcRh@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 Oct 2023 15:42:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGSG0KLa0NNnMM-_zh+wEJm94b2zpHtkSeUi1hdxMYa_Q@mail.gmail.com>
Message-ID: <CAMj1kXGSG0KLa0NNnMM-_zh+wEJm94b2zpHtkSeUi1hdxMYa_Q@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm64 tree
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 11:55, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> + Ard
>
> On Tue, Oct 24, 2023 at 05:24:09PM +1100, Stephen Rothwell wrote:
> > After merging the arm64 tree, today's linux-next build (arm64 defconfig)
> > produced this warning:
> >
> > WARNING: modpost: vmlinux: section mismatch in reference: __pi_$x+0x38 (section: .text) -> __pi_map_range (section: .init.text)
> >
> > I don't know what caused this.
>
> For some reason, building linux-next doesn't inline all the functions in
> the map_range.c file and we end up with some of them in different
> sections. I didn't get this when building the arm64 for-next/core
> separately.
>

Strange, I never ran into this before.

I guess commit 24cc769d70d8bda055a028aa6a is implicated in this, if we
run into more trouble like this i'll look whether we can bring that
logic back in some way.

The fix looks fine to me.


> My fix (I'll push it to the arm64 branch):
>
> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
> index be7caf07bfa7..e07f3ece5430 100644
> --- a/arch/arm64/kernel/pi/map_kernel.c
> +++ b/arch/arm64/kernel/pi/map_kernel.c
> @@ -20,17 +20,17 @@ extern const u8 __eh_frame_start[], __eh_frame_end[];
>
>  extern void idmap_cpu_replace_ttbr1(void *pgdir);
>
> -static void map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
> -                       void *start, void *end, pgprot_t prot,
> -                       bool may_use_cont, int root_level)
> +static void __init map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
> +                              void *start, void *end, pgprot_t prot,
> +                              bool may_use_cont, int root_level)
>  {
>         map_range(pgd, ((u64)start + va_offset) & ~PAGE_OFFSET,
>                   ((u64)end + va_offset) & ~PAGE_OFFSET, (u64)start,
>                   prot, root_level, (pte_t *)pg_dir, may_use_cont, 0);
>  }
>
> -static void unmap_segment(pgd_t *pg_dir, u64 va_offset, void *start,
> -                         void *end, int root_level)
> +static void __init unmap_segment(pgd_t *pg_dir, u64 va_offset, void *start,
> +                                void *end, int root_level)
>  {
>         map_segment(pg_dir, NULL, va_offset, start, end, __pgprot(0),
>                     false, root_level);
> @@ -205,7 +205,7 @@ static void __init remap_idmap_for_lpa2(void)
>         memset(init_pg_dir, 0, (u64)init_pg_end - (u64)init_pg_dir);
>  }
>
> -static void map_fdt(u64 fdt)
> +static void __init map_fdt(u64 fdt)
>  {
>         static u8 ptes[INIT_IDMAP_FDT_SIZE] __initdata __aligned(PAGE_SIZE);
>         u64 efdt = fdt + MAX_FDT_SIZE;
>
