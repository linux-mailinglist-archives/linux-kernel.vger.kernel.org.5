Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB7C78D1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 03:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbjH3Bhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 21:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbjH3BhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A2FCD6;
        Tue, 29 Aug 2023 18:37:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D745460CEC;
        Wed, 30 Aug 2023 01:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485D4C433C7;
        Wed, 30 Aug 2023 01:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693359440;
        bh=dPf4kldHLwVQWKVmZVGZxcUp8BjRiStmfkC4GhSqQOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kD2kdSw92+xzFguoEUs/NfjRaQv9uCx0X1ruiPMjbHf1i924ECnvo6SlQyeuBDiMM
         3IUO5jQ4VraWCBcLlU5QUZVzxQKWNTCVrA4ifEzVoLADNntPMZEk+6VInCZls3gqzO
         nTzuT14B1VBhFmC+8WEZV0HWeQPZ8x8JVyiqcM3opP4BJC7dwqTwYBNyE0u9DznVRO
         1A01N0Ixa7i0Hi28Ig8aaAbRUXrBfNl5Tu0QB8l3mIbXbIN5aFnZHvjVvqDO7EzGAq
         kLTPrYrlhe6ZhBRJre5iCVhb80eDAAknCCpDWNJpZu4Xf+tBu2TFREc9nxMV/4vQ9g
         kCNy5IeZJttNQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52bca2e8563so2471508a12.2;
        Tue, 29 Aug 2023 18:37:20 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyp998l/ZvXnQ+/tNKGdi5yxoPn9VYvX9xD+ShEQRFxYdTxYgOI
        SbbZUDyagB/BaGpoYXEysZdUX3pOMiVdpdAwRwM=
X-Google-Smtp-Source: AGHT+IFxM/pc+mlJmDqVNMXxYu6T33APpKzC6JZXNd2v6LFSpNeeV1Tzov2tS3Gr5aayD63mcZuwkyYwBi0GNRphdAo=
X-Received: by 2002:a05:6402:1287:b0:528:90d7:a1f with SMTP id
 w7-20020a056402128700b0052890d70a1fmr695346edv.10.1693359438604; Tue, 29 Aug
 2023 18:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230829182500.61875-1-namcaov@gmail.com>
In-Reply-To: <20230829182500.61875-1-namcaov@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 30 Aug 2023 09:37:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR2vZLFo=cfg+KD_LY8z=_D4sLROGgx4GiwTYKXt=8k4w@mail.gmail.com>
Message-ID: <CAJF2gTR2vZLFo=cfg+KD_LY8z=_D4sLROGgx4GiwTYKXt=8k4w@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobes: allow writing to x0
To:     Nam Cao <namcaov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 2:25=E2=80=AFAM Nam Cao <namcaov@gmail.com> wrote:
>
> Instructions can write to x0, so we should simulate these instructions
> normally.
>
> Currently, the kernel hangs if an instruction who writes to x0 is
> simulated.
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  arch/riscv/kernel/probes/simulate-insn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel=
/probes/simulate-insn.c
> index d3099d67816d..6c166029079c 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.c
> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> @@ -24,7 +24,7 @@ static inline bool rv_insn_reg_set_val(struct pt_regs *=
regs, u32 index,
>                                        unsigned long val)
>  {
>         if (index =3D=3D 0)
> -               return false;
> +               return true;
Acked-by: Guo Ren <guoren@kernel.org>

>         else if (index <=3D 31)
>                 *((unsigned long *)regs + index) =3D val;
>         else
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
