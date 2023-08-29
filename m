Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC578BD74
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 06:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjH2EMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 00:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjH2EMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FA2BD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2492660277
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D511C433C9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693282316;
        bh=UE0fiU8lFv4dJudFnVMoBNTPI7KqE1uy1T28k5iHb4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n0nsJEXFXvVbV4XCAcoylKgp8EdAvbi45Sf3MMemgHXm+PSrUUR99TobOIB/U11N3
         4tJqsX16l+oFGq0hGbp47Gn+kh6soR4JvFxfkrIvHIf8gUyFKUygo0guJDIhm8pbXy
         ELC0SwQz2g2Ig6XfpM7E/HOsnnhEkdXSbiRuRjN1T0GvY22k5K7lPFYIU5mCOGTB01
         9IE1qAVkqzUmKCA1Y8f3InZFWE5kf5DeqVwlPvo6DrQ+8FEDVuc0w2sPFch4R7Sx+9
         X0OeSmW3Bg92E92xEFzrNufBChBo+Wtl8FdPIH6Vnzm75S08xXl2TgadQEvnMMD6GJ
         7KNkY71mKJbcA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so817369466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:11:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy70vZH5HC0X8ix7U9SXfKfpY1k3eGXTzasib8fe1T5y3SfViC1
        OvUsBvlUcS1l9wbVGhvH7SdNxgmM4da4BajE0T8=
X-Google-Smtp-Source: AGHT+IGBvfYoh1PFxGP/kniMUDcEPyq8i2LMVb8Vo8d8EdIgKhtuZOFQRYCX4xLp/Spw4FEe4q61imfQx/Sk4P4bTAk=
X-Received: by 2002:a17:907:868d:b0:9a5:7d34:e68a with SMTP id
 qa13-20020a170907868d00b009a57d34e68amr1497886ejc.28.1693282314885; Mon, 28
 Aug 2023 21:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230829002323.28303-1-rdunlap@infradead.org>
In-Reply-To: <20230829002323.28303-1-rdunlap@infradead.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 29 Aug 2023 12:11:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ORNqMYh0maxkyZFjEn5HgC7vZHUZD8GicOn7pkN8C4g@mail.gmail.com>
Message-ID: <CAAhV-H4ORNqMYh0maxkyZFjEn5HgC7vZHUZD8GicOn7pkN8C4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] Loongarch: KGDB: fix build when CPU_HAS_LBT not set
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Qing Zhang <zhangqing@loongson.cn>,
        Hui Li <lihui@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
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

Hi, Randy,

On Tue, Aug 29, 2023 at 8:23=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix build errors when CONFIG_CPU_HAS_LBT is not set:
>
> loongarch64-linux-ld: arch/loongarch/kernel/kgdb.o: in function `dbg_get_=
reg':
> arch/loongarch/kernel/kgdb.c:154:(.text+0xc7c): undefined reference to `_=
save_lbt'
> loongarch64-linux-ld: arch/loongarch/kernel/kgdb.o: in function `dbg_set_=
reg':
> arch/loongarch/kernel/kgdb.c:229:(.text+0x13a4): undefined reference to `=
_restore_lbt'
Thank you for your patch, this has been fixed in today's linux-next.

Huacai
>
> Fixes: 8968eb010689 ("LoongArch: Add basic KGDB & KDB support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Qing Zhang <zhangqing@loongson.cn>
> Cc: Hui Li <lihui@loongson.cn>
> Cc: Binbin Zhou <zhoubinbin@loongson.cn>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: loongarch@lists.linux.dev
> ---
>  arch/loongarch/kernel/kgdb.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff -- a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
> --- a/arch/loongarch/kernel/kgdb.c
> +++ b/arch/loongarch/kernel/kgdb.c
> @@ -150,7 +150,8 @@ char *dbg_get_reg(int regno, void *mem,
>         }
>
>         /* Handle LBT registers */
> -       if ((regs->csr_euen & CSR_EUEN_LBTEN)) {
> +       if (IS_ENABLED(CONFIG_CPU_HAS_LBT) &&
> +           (regs->csr_euen & CSR_EUEN_LBTEN)) {
>                 _save_lbt(&current->thread.lbt);
>
>                 switch (regno) {
> @@ -211,7 +212,8 @@ int dbg_set_reg(int regno, void *mem, st
>         }
>
>         /* Handle LBT registers */
> -       if ((regs->csr_euen & CSR_EUEN_LBTEN)) {
> +       if (IS_ENABLED(CONFIG_CPU_HAS_LBT) &&
> +           (regs->csr_euen & CSR_EUEN_LBTEN)) {
>                 switch (regno) {
>                 case DBG_FTOP:                          /* Process the ft=
op */
>                         memcpy((char *)&current->thread.fpu.ftop, mem, re=
g_size);
