Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7385F7897D0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjHZPsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjHZPrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43FADA;
        Sat, 26 Aug 2023 08:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7224F628CE;
        Sat, 26 Aug 2023 15:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9A4C433C7;
        Sat, 26 Aug 2023 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693064856;
        bh=prnLNT3I+k4oP/QefVNsJFO9u+zW4R6P92NhyR9liDE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p8rjRPFlZ68joURB328Ee5k51+wdstvOzqh/Rnpj/rHUqwljHBfvC9xl1CvrtdjzZ
         w4xBZ1eal6tikCU3repiTA+w2+e7zw4U6AJSRV95yj5ggWY84UVfKnJqdSOmS8Nyvv
         tYuHpLvzcxQCWcddmnaNec87s/fbhin0nRikAWU4nLkB1jN1kzUr4jYfGfxwMNX6Xw
         tXyf1vqvv5maN040JeWFI6brkWyL+Ck2qKlKYHe+9DpiM4oXH0XamUbLQk3f2FrKNi
         9fYVbli8LXW/7hNzIKEADXQw/zgXR+LswkORmvi6KYdEm2Om5WRvRCejGdciL2Mm/1
         rFkEqb82cuEVA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso27026941fa.2;
        Sat, 26 Aug 2023 08:47:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YzI0DHKaAlhPGLH/lRTAaoNau3v79Gr1jz2fATuP1vdYViHyL2U
        d8EqbNX54EMlO3SSkWaBaNvZCIdnDLRI5sL/OcA=
X-Google-Smtp-Source: AGHT+IEvH4loVJkDWB0dZHlXqnIGXJwJ7wqKksCJ9FB3Onm4RJzNRqzk7a2z6nwLobAU7GzgGZZ++yvDQ8UTspKSptg=
X-Received: by 2002:a05:651c:237:b0:2bc:f39b:d1a8 with SMTP id
 z23-20020a05651c023700b002bcf39bd1a8mr3607693ljn.46.1693064854861; Sat, 26
 Aug 2023 08:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230826142341.4107728-1-chenhuacai@loongson.cn>
 <2023082618-mocha-reactor-1dbe@gregkh> <CAAhV-H4aKT=O1Ly7Zw+oSuVDP73kcXf+boAJK5W=6n76Ftz=WA@mail.gmail.com>
 <2023082609-coerce-capricorn-a69f@gregkh>
In-Reply-To: <2023082609-coerce-capricorn-a69f@gregkh>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 26 Aug 2023 23:47:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H532djpsYDPGZxG9g8eiaq2UMGYX_+ADb4kaPpQmgTXYg@mail.gmail.com>
Message-ID: <CAAhV-H532djpsYDPGZxG9g8eiaq2UMGYX_+ADb4kaPpQmgTXYg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:43=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Sat, Aug 26, 2023 at 11:35:31PM +0800, Huacai Chen wrote:
> > On Sat, Aug 26, 2023 at 11:22=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Sat, Aug 26, 2023 at 10:23:41PM +0800, Huacai Chen wrote:
> > > > This is a port of commit 379eb01c21795edb4c ("riscv: Ensure the val=
ue
> > > > of FP registers in the core dump file is up to date").
> > > >
> > > > The values of FP/SIMD registers in the core dump file come from the
> > > > thread.fpu. However, kernel saves the FP/SIMD registers only before
> > > > scheduling out the process. If no process switch happens during the
> > > > exception handling, kernel will not have a chance to save the lates=
t
> > > > values of FP/SIMD registers. So it may cause their values in the co=
re
> > > > dump file incorrect. To solve this problem, force fpr_get()/simd_ge=
t()
> > > > to save the FP/SIMD registers into the thread.fpu if the target tas=
k
> > > > equals the current task.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > > V2: Rename get_fpu_regs() to save_fpu_regs().
> > >
> > > What stable tree(s) is this for?
> > For 5.19+, but before 6.4 we should remove the call site in simd_get()
> > because that function doesn't exist.
>
> But this commit is already in the following released kernels:
>         5.10.62 5.13.14 5.14
Do you means commit 379eb01c21795edb4c ("riscv: Ensure the value of FP
registers in the core dump file is up to date")? That is a reference
commit, not a Fixes tag. This patch is for LoongArch and LoongArch
only exists after 5.19.

> so how can it be backported?
>
> totally confused,
>
> greg k-h
