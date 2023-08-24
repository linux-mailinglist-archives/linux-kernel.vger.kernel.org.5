Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED94787B32
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbjHXWGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbjHXWGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0AC1BE9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:06:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F14D565166
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64445C433CC;
        Thu, 24 Aug 2023 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692914767;
        bh=wokMPVNGYw0bXxAHx+gbY2Rre1rA2yUIZNWpn8SDz0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jyUXaUaxJtZV7CYOk2XL+Zyg2f4RZPI22r4LPPqKKdjy32b+hTft9aRxzS/4P+2da
         PN1vk5nAcbHZwlOIfXEfFFkGSP0OmUVpQXTOOCk7GK9nwxknPK7fSrOfOAaezFDAJR
         qCE8Njk77g7JsK1do2ZVbCU9ipTZ42pOpn0luBnxg5ayImyQUnUEyLagHycmdgNnys
         /wA0eb+ayL6lpfMWgMkdRNHFHS/B4IUdwcNnU9tayDj5pEbFFbKlk1APFHAyxzrk9b
         Sav4OVLLleGO4L879987zDovjmeQEtacJq7eLL2VsJpafwnrhW10nEvfUORf35rUk5
         xwAqdf7Lqo9UQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5009d4a4897so428727e87.0;
        Thu, 24 Aug 2023 15:06:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YynXFYU1dTMiuC5K3heu7rMRLX7h85TDZr0VLTE07prY04PkIWx
        FSqvIu3flqU7MNJN+Bc61r7EliBM8Sic5DCBdis=
X-Google-Smtp-Source: AGHT+IE7zxauTjqBL+3SpA3KVBh8UWS/WrLsqL0PTc+cCRH+7F9/m4FCw4SAU8RPuh5hsVsfOy/8ggpSJsWfddEbnQw=
X-Received: by 2002:a05:6512:a8f:b0:4fe:8c01:32ac with SMTP id
 m15-20020a0565120a8f00b004fe8c0132acmr16342249lfu.41.1692914765396; Thu, 24
 Aug 2023 15:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230824133135.1176709-1-puranjay12@gmail.com> <20230824133135.1176709-3-puranjay12@gmail.com>
In-Reply-To: <20230824133135.1176709-3-puranjay12@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 24 Aug 2023 15:05:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6jLLt7gu1RbZTAjLeFKzu=PoumaohRsN538BW2gH97sA@mail.gmail.com>
Message-ID: <CAPhsuW6jLLt7gu1RbZTAjLeFKzu=PoumaohRsN538BW2gH97sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] riscv: implement a memset like function
 for text
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, pulehui@huawei.com,
        conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, yhs@fb.com,
        kpsingh@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 6:31=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> The BPF JIT needs to write invalid instructions to RX regions of memory
> to invalidate removed BPF programs. This needs a function like memset()
> that can work with RX memory.
>
> Implement patch_text_set_nosync() which is similar to text_poke_set() of
> x86.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/riscv/include/asm/patch.h |  1 +
>  arch/riscv/kernel/patch.c      | 74 ++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patc=
h.h
> index 63c98833d510..aa5c1830ea43 100644
> --- a/arch/riscv/include/asm/patch.h
> +++ b/arch/riscv/include/asm/patch.h
> @@ -7,6 +7,7 @@
>  #define _ASM_RISCV_PATCH_H
>
>  int patch_text_nosync(void *addr, const void *insns, size_t len);
> +int patch_text_set_nosync(void *addr, const int c, size_t len);
>  int patch_text(void *addr, u32 *insns, int ninsns);
>
>  extern int riscv_patch_in_stop_machine;
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 465b2eebbc37..24d49999ac1a 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -13,6 +13,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/ftrace.h>
>  #include <asm/patch.h>
> +#include <asm/string.h>
>
>  struct patch_insn {
>         void *addr;
> @@ -53,6 +54,34 @@ static void patch_unmap(int fixmap)
>  }
>  NOKPROBE_SYMBOL(patch_unmap);
>
> +static int __patch_insn_set(void *addr, const int c, size_t len)
> +{
> +       void *waddr =3D addr;
> +       bool across_pages =3D (((uintptr_t) addr & ~PAGE_MASK) + len) > P=
AGE_SIZE;
> +       int ret;
> +
> +       /*
> +        * Only two pages can be mapped at a time for writing.
> +        */
> +       if (len > 2 * PAGE_SIZE)
> +               return -EINVAL;

Same for this one.

[...]
