Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5302E7897C4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjHZPgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjHZPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD3C19A5;
        Sat, 26 Aug 2023 08:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56092621E9;
        Sat, 26 Aug 2023 15:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8898C433CC;
        Sat, 26 Aug 2023 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693064143;
        bh=O8wuYZcLhoKWZlUxZr6PD029Q3evNHJgtU708Lj2E/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=escgIZtyTERtOC8fj7wb6PYBDeRibot9e4doZFlVr8F8tJb8ztxzGkdOBAonsHg7R
         6D+JUAa6V0ym62EOBjgih2j7e6As70nKSPvqE0wtfgW7bzRPre/qBQjNz51W42+IFw
         5DZ1hmhFG72SKE1BBKFSiyq7Ga3OQ9bseYHkJ6RSkTPwSoNZaTh/MDW6Pi5Mye9wwh
         tpRWR8FYgaNXYjO4EXYxOdTVpfmXYXNY0lXf9wROn+DtIbuI9gf9ZbmNSzJTiETOhk
         TzrJZGeu3u38U39P4d6QG7vyqM0a4/HTlK+uM5AZx/8WXF+YomkKVG6A9L9Gn6J5Mx
         kNTsLXz4dEjMA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-98377c5d53eso229536966b.0;
        Sat, 26 Aug 2023 08:35:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YzW896PRQaKB7IA1fMkEckfQoWXYuq5i8OCQeSmah7qg7o68yOp
        YC3mCCBpGcKm4FVqfLm5m+rjz+EG9mRJNHfGZDo=
X-Google-Smtp-Source: AGHT+IFD0703EUECek5Q3jvqqGNWP2GfJxngt6MNtz+IYmcmPNf4JCFEuW5JC/pLs8zTUjeuOU1um+EsmDCbOxn0f3o=
X-Received: by 2002:a17:906:8a74:b0:9a1:b8fc:624a with SMTP id
 hy20-20020a1709068a7400b009a1b8fc624amr10001270ejc.1.1693064141925; Sat, 26
 Aug 2023 08:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230826142341.4107728-1-chenhuacai@loongson.cn> <2023082618-mocha-reactor-1dbe@gregkh>
In-Reply-To: <2023082618-mocha-reactor-1dbe@gregkh>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 26 Aug 2023 23:35:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4aKT=O1Ly7Zw+oSuVDP73kcXf+boAJK5W=6n76Ftz=WA@mail.gmail.com>
Message-ID: <CAAhV-H4aKT=O1Ly7Zw+oSuVDP73kcXf+boAJK5W=6n76Ftz=WA@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Ensure FP/SIMD registers in the core dump
 file is up to date
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:22=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Sat, Aug 26, 2023 at 10:23:41PM +0800, Huacai Chen wrote:
> > This is a port of commit 379eb01c21795edb4c ("riscv: Ensure the value
> > of FP registers in the core dump file is up to date").
> >
> > The values of FP/SIMD registers in the core dump file come from the
> > thread.fpu. However, kernel saves the FP/SIMD registers only before
> > scheduling out the process. If no process switch happens during the
> > exception handling, kernel will not have a chance to save the latest
> > values of FP/SIMD registers. So it may cause their values in the core
> > dump file incorrect. To solve this problem, force fpr_get()/simd_get()
> > to save the FP/SIMD registers into the thread.fpu if the target task
> > equals the current task.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V2: Rename get_fpu_regs() to save_fpu_regs().
>
> What stable tree(s) is this for?
For 5.19+, but before 6.4 we should remove the call site in simd_get()
because that function doesn't exist.

Huacai

>
> thanks,
>
> greg k-h
