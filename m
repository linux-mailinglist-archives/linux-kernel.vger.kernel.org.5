Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D677897C9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjHZPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHZPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:43:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA3319AE;
        Sat, 26 Aug 2023 08:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA3F4621EF;
        Sat, 26 Aug 2023 15:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E1BC433C8;
        Sat, 26 Aug 2023 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693064618;
        bh=weZ7hM26hSmhQknF+fslvxqkPMpUEXb3Hf1xgLFvSeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcGlyV9hyIKwMfU/My+NiiuEK9Vxphlgd3+GDTIaPAypfszMEMjPjfQ8CeBs+AYov
         AXyp0wJdWhGcbQaektl381Vb1grjWncmcc2rB7g1BYdZGtkHNPRoLwZku+4UWQBQT2
         RNQm3GsaW4duQfNrXna7j7Hxy1n+Qij+Sda0Kcsk=
Date:   Sat, 26 Aug 2023 17:43:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        stable@vger.kernel.org
Subject: Re: [PATCH V2] LoongArch: Ensure FP/SIMD registers in the core dump
 file is up to date
Message-ID: <2023082609-coerce-capricorn-a69f@gregkh>
References: <20230826142341.4107728-1-chenhuacai@loongson.cn>
 <2023082618-mocha-reactor-1dbe@gregkh>
 <CAAhV-H4aKT=O1Ly7Zw+oSuVDP73kcXf+boAJK5W=6n76Ftz=WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4aKT=O1Ly7Zw+oSuVDP73kcXf+boAJK5W=6n76Ftz=WA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:35:31PM +0800, Huacai Chen wrote:
> On Sat, Aug 26, 2023 at 11:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Aug 26, 2023 at 10:23:41PM +0800, Huacai Chen wrote:
> > > This is a port of commit 379eb01c21795edb4c ("riscv: Ensure the value
> > > of FP registers in the core dump file is up to date").
> > >
> > > The values of FP/SIMD registers in the core dump file come from the
> > > thread.fpu. However, kernel saves the FP/SIMD registers only before
> > > scheduling out the process. If no process switch happens during the
> > > exception handling, kernel will not have a chance to save the latest
> > > values of FP/SIMD registers. So it may cause their values in the core
> > > dump file incorrect. To solve this problem, force fpr_get()/simd_get()
> > > to save the FP/SIMD registers into the thread.fpu if the target task
> > > equals the current task.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > > V2: Rename get_fpu_regs() to save_fpu_regs().
> >
> > What stable tree(s) is this for?
> For 5.19+, but before 6.4 we should remove the call site in simd_get()
> because that function doesn't exist.

But this commit is already in the following released kernels:
	5.10.62 5.13.14 5.14
so how can it be backported?

totally confused,

greg k-h
