Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326D6760B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjGYHMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGYHMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D82E0;
        Tue, 25 Jul 2023 00:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C22AF611F1;
        Tue, 25 Jul 2023 07:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B490C433CA;
        Tue, 25 Jul 2023 07:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690269164;
        bh=aI7ZxYAZWlJJwjCBT+ee6LoTaj892FuVBC7Fojf9VzI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hW7g3w5Kw0pS/hSdNwEre8jz9hbCE0eq3Kl32QphLESsVFtWgQKDSDFoFT/nzfV/n
         m4WHOWapcyYVx1IlKAk9/Ux3pXV50OF/s0j36pltbH1j7LUaLgr83pa4rj0SxeoE/H
         UqgtPbWREZBOXWUSNG5sbdj3Q2OV2VZiIS5+qHFhDbEeopuRJRN7IB7jACs4pDf7YT
         m9KEdQfxoMgpCWtFO8Kq+9g3oFBAnXRVWd47iZmgR0Yi3dQiyBnE1ylwTQuePFGD0t
         Ww+u4dnnjQlidonfcykAARagZjjkb9df9zCcG+RyNWkWk/7Sft8A3tkQbVLCDe7Xg/
         oWExfwr2c3k0Q==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so177342a12.1;
        Tue, 25 Jul 2023 00:12:44 -0700 (PDT)
X-Gm-Message-State: ABy/qLZQv38xLk3Kdu2tdQinU3GHUkkLIdU+6UkR/upBizutazIZGuRM
        fJqu1k5fg2B1jlOOV8raHcEW3b9nmR5X9AB+zfo=
X-Google-Smtp-Source: APBJJlHQPOq5U9UiunyY1ciPlHNXhaZTj9WL96PQqOavAh1qrAHgwh701yOcTY56SwThmVOTkw7K25bIWNxzspX06+4=
X-Received: by 2002:a05:6402:2802:b0:51e:588b:20ca with SMTP id
 h2-20020a056402280200b0051e588b20camr1618231ede.8.1690269162359; Tue, 25 Jul
 2023 00:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <1690268708-5899-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1690268708-5899-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 25 Jul 2023 15:12:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H65jzk+PpuXBH79Q2XwYVzFdL55vFUhXTD1R4iUQ3zd-g@mail.gmail.com>
Message-ID: <CAAhV-H65jzk+PpuXBH79Q2XwYVzFdL55vFUhXTD1R4iUQ3zd-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] LoongArch: BPF: Fix check condition to call
 lu32id in move_imm()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org,
        #@web.codeaurora.org, 6.1@web.codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Tue, Jul 25, 2023 at 3:05=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> As the code comment says, the initial aim is to reduce one instruction
> in some corner cases, if bit[51:31] is all 0 or all 1, no need to call
> lu32id, that is to say, it should call lu32id only if bit[51:31] is not
> all 0 and not all 1. The current code always call lu32id, the result is
> right but the logic is unexpected and wrong, fix it.
>
> Cc: stable@vger.kernel.org # 6.1
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Reported-by: Colin King (gmail) <colin.i.king@gmail.com>
> Closes: https://lore.kernel.org/all/bcf97046-e336-712a-ac68-7fd194f2953e@=
gmail.com/
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> index c335dc4..6858633 100644
> --- a/arch/loongarch/net/bpf_jit.h
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -150,7 +150,7 @@ static inline void move_imm(struct jit_ctx *ctx, enum=
 loongarch_gpr rd, long imm
>                          * no need to call lu32id to do a new filled oper=
ation.
>                          */
>                         imm_51_31 =3D (imm >> 31) & 0x1fffff;
> -                       if (imm_51_31 !=3D 0 || imm_51_31 !=3D 0x1fffff) =
{
> +                       if (imm_51_31 !=3D 0 && imm_51_31 !=3D 0x1fffff) =
{
>                                 /* lu32id rd, imm_51_32 */
>                                 imm_51_32 =3D (imm >> 32) & 0xfffff;
>                                 emit_insn(ctx, lu32id, rd, imm_51_32);
> --
> 2.1.0
>
>
