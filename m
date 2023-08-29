Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4270378BD75
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 06:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjH2ENg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 00:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjH2ENb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7834E10E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C1C1601BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D68C433C9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693282408;
        bh=zjEphFgb/yvAPz6k3BMSEsKTy6F40wxOWJDC85TABLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GvhHN38EfEXV32XdObboMjVfgkbR/QR4r6ZPFjQZ5/3b6rLZLKMpdqszWnslItpGw
         vh/deo4HU0m6uzubSplmR/jHCcpPhFthNyHgqQJNolL6HR+SZRjeIB9jb/RGQ5zYhX
         ny7SoSjveaBIoHm/Orops9EsQbzwaWWYUvk4Z5F/iCyYHD8EkccN/f5N+/ehAVWhL5
         Sw6bujLQLLjaJGPYMogSA41Fp5EEUahVsWOtH1ZzOZswcznM/b9FSPjVy1+Tw8I+Jq
         ysP0ooRRM4OT8CfnwUVkBAoz4nsubox/Rb5l2PJ8WYhPXaOKoe1PAyxTSbws7TTvol
         6ngDXI28oahpw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so59265471fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:13:28 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz3wGiv8zmFhSR4PZRWlRjYziVgC98pV8yRBrFOk/o7+VN03W8s
        TNts2hQ2pUlsf36HjRuG5ECbgiBfn4kbi6dF61o=
X-Google-Smtp-Source: AGHT+IFO+HbHT17lxSo5vGP6w0EAuHQOZfH+cc4ak7hfS+RTZenB+gURXHXSuMhJ6iPZOXVQC0oVSXaElnzzGLtq18g=
X-Received: by 2002:a2e:9d96:0:b0:2bc:ce85:2de2 with SMTP id
 c22-20020a2e9d96000000b002bcce852de2mr15434052ljj.37.1693282406490; Mon, 28
 Aug 2023 21:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230829002316.28287-1-rdunlap@infradead.org>
In-Reply-To: <20230829002316.28287-1-rdunlap@infradead.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 29 Aug 2023 12:13:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4xxSeoF9Nu65jwMjV5dbywyue6rJvkW9yoVHVEjL93Fg@mail.gmail.com>
Message-ID: <CAAhV-H4xxSeoF9Nu65jwMjV5dbywyue6rJvkW9yoVHVEjL93Fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Loongarch: KGDB: fix implicit declaration of flush_icache_range()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Qing Zhang <zhangqing@loongson.cn>,
        Hui Li <lihui@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
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

Hi, Randy,

On Tue, Aug 29, 2023 at 8:23=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Add <asm/cacheflush.h> to prevent a build error:
>
> arch/loongarch/kernel/kgdb.c: In function 'do_single_step':
> arch/loongarch/kernel/kgdb.c:440:9: error: implicit declaration of functi=
on 'flush_icache_range' [-Werror=3Dimplicit-function-declaration]
>   440 |         flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
Thank you for your fixing, this will be included in linux-next.

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
>  arch/loongarch/kernel/kgdb.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
> --- a/arch/loongarch/kernel/kgdb.c
> +++ b/arch/loongarch/kernel/kgdb.c
> @@ -13,6 +13,7 @@
>  #include <linux/sched.h>
>  #include <linux/smp.h>
>
> +#include <asm/cacheflush.h>
>  #include <asm/fpu.h>
>  #include <asm/lbt.h>
>  #include <asm/hw_breakpoint.h>
