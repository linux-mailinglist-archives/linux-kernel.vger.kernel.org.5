Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D477D9317
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjJ0JIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0JIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:08:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C393
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:08:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698397712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Mik8A9xbm7B9NaPlH1OFdo3giewagd8ozyvOVETdeM=;
        b=xEGfJtTXcMzSiccUwqeK/tNw8/5AtkrWY7H7wCbleDmqjUbjUyWSm37sDkBDPnuujLAXg6
        1xR24zmkvIgwnyykSd/LENC/6QDTGVJMH2OUssdRYgJqgLWVhXRaEpBPTKJvLYYryFcWLM
        UMfF2ha+Hooh7wjvM7AFGbxhqQgIeVjprhG5+ErRqE+3n8P7sgSNXVzjzXsPeJMlGh1DuH
        9z11mifRop85mU0AWUix2a9+UUqz6wyiRrohOe/w4i77a2chv1IlKms9eLQR1EwVwsDH2n
        9pEsk1IVvVXNV0ugaIrAeaYZfih8Eb1Zz20bkD2GSYHXZFFyuNHrlMuUzSK65w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698397712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Mik8A9xbm7B9NaPlH1OFdo3giewagd8ozyvOVETdeM=;
        b=JX0juIhhEDJ22N56IbsoZOOAgusFUAxt9RwDw1vEfT7BD9S5G0X4wTe4PBwPy/gsjsMrP6
        cb3zmhobY/M62HDQ==
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH] genirq/matrix: Dynamic bitmap allocation
In-Reply-To: <CAK9=C2Xou_sZKX96c8Z7RXPCnmdf-_DPHZ8rfPmNdBqx8s_30Q@mail.gmail.com>
References: <20231026101957.320572-1-bjorn@kernel.org>
 <CAK9=C2Vcbq_ReGcK51uOYp+M2hakz=9=RNHaHFMbfxhth_4cnA@mail.gmail.com>
 <87a5s5z44x.fsf@all.your.base.are.belong.to.us> <87fs1x3re9.ffs@tglx>
 <CAK9=C2Xou_sZKX96c8Z7RXPCnmdf-_DPHZ8rfPmNdBqx8s_30Q@mail.gmail.com>
Date:   Fri, 27 Oct 2023 11:08:32 +0200
Message-ID: <87sf5w301b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27 2023 at 10:01, Anup Patel wrote:
> On Fri, Oct 27, 2023 at 4:47=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> We have three types of MSIs on RISC-V platforms:
> 1) PCI MSIs (handled by the IMSIC driver of the RISC-V AIA series)
> 2) Platform MSIs (handled by the IMSIC driver of the RISC-V AIA series)
> 3) Wired IRQs converted to platform MSIs (aka wired-to-MSI bridge, which
>     is handled by APLIC driver of the RISC-V AIA series)
>
> The RISC-V AIA series needs the generic IRQ framework changes
> related to #2 and #3 (above) from your series hence my suggestion
> to rebase on your series.
> (https://lore.kernel.org/all/20221121135653.208611233@linutronix.de/)
>
> Is there a way to have your genirq changes merged before all ARM
> drivers have been moved to the new programming model ?
> OR
> Any other way to deal with this dependency ?

I'll have a look at this maze again and see how that can be separated
from the ARM pile, unless you beat me to it :)
