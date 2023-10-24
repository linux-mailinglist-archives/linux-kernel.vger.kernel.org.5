Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF88C7D49ED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjJXIZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjJXIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:25:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245D99;
        Tue, 24 Oct 2023 01:25:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022F3C433CB;
        Tue, 24 Oct 2023 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698135918;
        bh=C59B0paKctZmmkp2VOX6y7BbpXKe0RQc3L0GlQ5MORA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lUHxY4dcQwVjg5SUU5gs/je41M3qZ4LMPlg1s493IHaOO2/mZWmP1bMKoDO5pdTtH
         GqYrjvk53EzJ9EaquO/DZrQDKNWFoe4lDR0x4Qbd9ccZJgVdnheFdCrHQAzEu7cIrK
         QalJd+FW0IhUFrxsdgG5NYDQzoZMHiL2PfQ/1QO6CFX3dAoTpZkOdwlaKVF3Cs8gVC
         G5L/4tOyphbQQ3QSPDf5x7KowouqwsaFHMYJWJKUkgWEucYxBZV3NjgjX6qmfNG/NF
         CtRWVjDiy+HbirSgWYkbZo6EIdG6dGK7M7mhygh0jem6tfIWNXeFkJfkzY4LgHF0Im
         0GRg+wfyy/bWw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c3e23a818bso48303191fa.0;
        Tue, 24 Oct 2023 01:25:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YyrbbTVRXZ8lehm+X67KpSDdr8RANfLBAzBWEaLxrI17snl7bos
        ONwUB5QoPmqpFaO8htLrRcjJQwTcyX8SH0m7T2o=
X-Google-Smtp-Source: AGHT+IHAvdGuy4z7waKPOPuMEoCAwF5zHzeSD0m5NoFjVS0hMs2GT0fmx+h+xqhKzRRO0C4u2ghvcFuqtqiZxILlkqA=
X-Received: by 2002:a05:651c:1308:b0:2c4:fdaf:1d62 with SMTP id
 u8-20020a05651c130800b002c4fdaf1d62mr4901833lja.11.1698135916116; Tue, 24 Oct
 2023 01:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231024010954.6768-1-quic_aiquny@quicinc.com>
In-Reply-To: <20231024010954.6768-1-quic_aiquny@quicinc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 Oct 2023 10:25:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXENRh6mvxc1QD67G7_t_H+WWhbyHFkfof5KOHT=MM2DJQ@mail.gmail.com>
Message-ID: <CAMj1kXENRh6mvxc1QD67G7_t_H+WWhbyHFkfof5KOHT=MM2DJQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: module: PLT allowed even !RANDOM_BASE
To:     Maria Yu <quic_aiquny@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 03:10, Maria Yu <quic_aiquny@quicinc.com> wrote:
>
> Module PLT feature can be enabled even when RANDOM_BASE is disabled.
> Break BLT entry counts of relocation types will make module plt entry
> allocation fail and finally exec format error for even correct and plt
> allocation available modules.
>
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/kernel/module-plts.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index bd69a4e7cd60..79200f21e123 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -167,9 +167,6 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
>                 switch (ELF64_R_TYPE(rela[i].r_info)) {
>                 case R_AARCH64_JUMP26:
>                 case R_AARCH64_CALL26:
> -                       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> -                               break;
> -
>                         /*
>                          * We only have to consider branch targets that resolve
>                          * to symbols that are defined in a different section.
> @@ -269,9 +266,6 @@ static int partition_branch_plt_relas(Elf64_Sym *syms, Elf64_Rela *rela,
>  {
>         int i = 0, j = numrels - 1;
>
> -       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> -               return 0;
> -
>         while (i < j) {
>                 if (branch_rela_needs_plt(syms, &rela[i], dstidx))
>                         i++;
>
> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
> --
> 2.17.1
>
