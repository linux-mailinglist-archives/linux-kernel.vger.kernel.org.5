Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9477CFB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345878AbjJSNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjJSNnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:43:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF99124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:43:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3421C433C7;
        Thu, 19 Oct 2023 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697723001;
        bh=fNfzoqPWnxpHpfpwgiuXewdIuM9DFInylMJTHvvmILo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gnP8+wBbAkOCOyn5Cg5KbPb8++KjWQ/7lQ8rMIHckwlmX3FAW8KMQ2GTkslW8Al6/
         mmftTT6QyTe6Mjvc6xY6mrGooWm7sMVOQPZZCY5kuoW2yCsPjlS7krk1kygXEyjaXb
         S8oBOu+WISWZ+MQqb8+9fvujWdfgAiKfFr11gGqK4cSCWF/u0pkuHVszXHiBfRqhHN
         AtTEl6DdBvJC5vJn8aV+CyLDKQIG7ZueP/60QBRmneObNlEjVhAECF8e3NOoTEWbCG
         AXHggYFB9W9q81QusyURho5DJ5I/l3MQcc+ItbdFzGERTmDLY2hH0tbzgG/B/YxVuo
         KFtHBZjP8X8Gw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v10 00/15] Linux RISC-V AIA Support
In-Reply-To: <20231003044403.1974628-1-apatel@ventanamicro.com>
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
Date:   Thu, 19 Oct 2023 15:43:18 +0200
Message-ID: <87o7gu7mo9.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

Anup Patel <apatel@ventanamicro.com> writes:

> The RISC-V AIA specification is ratified as-per the RISC-V international
> process. The latest ratified AIA specifcation can be found at:
> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts=
-1.0.pdf
>
> At a high-level, the AIA specification adds three things:
> 1) AIA CSRs
>    - Improved local interrupt support
> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>    - Per-HART MSI controller
>    - Support MSI virtualization
>    - Support IPI along with virtualization
> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>    - Wired interrupt controller
>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
>    - In Direct-mode, injects external interrupts directly into HARTs

Thanks for working on the AIA support! I had a look at the series, and
have some concerns about interrupt ID abstraction.

A bit of background, for readers not familiar with the AIA details.

IMSIC allows for 2047 unique MSI ("msi-irq") sources per hart, and
each MSI is dedicated to a certain hart. The series takes the approach
to say that there are, e.g., 2047 interrupts ("lnx-irq") globally.
Each lnx-irq consists of #harts * msi-irq -- a slice -- and in the
slice only *one* msi-irq is acutally used.

This scheme makes affinity changes more robust, because the interrupt
sources on "other" harts are pre-allocated. On the other hand it
requires to propagate irq masking to other harts via IPIs (this is
mostly done up setup/tear down). It's also wasteful, because msi-irqs
are hogged, and cannot be used.

Contemporary storage/networking drivers usually uses queues per core
(or a sub-set of cores). The current scheme wastes a lot of msi-irqs.
If we instead used a scheme where "msi-irq =3D=3D lnx-irq", instead of
"lnq-irq =3D {hart 0;msi-irq x , ... hart N;msi-irq x}", there would be
a lot MSIs for other users. 1-1 vs 1-N. E.g., if a storage device
would like to use 5 queues (5 cores) on a 128 core system, the current
scheme would consume 5 * 128 MSIs, instead of just 5.

On the plus side:
* Changing interrupts affinity will never fail, because the interrupts
  on each hart is pre-allocated.

On the negative side:
* Wasteful interrupt usage, and a system can potientially "run out" of
  interrupts. Especially for many core systems.
* Interrupt masking need to proagate to harts via IPIs (there's no
  broadcast csr in IMSIC), and a more complex locking scheme IMSIC

Summary:
The current series caps the number of global interrupts to maximum
2047 MSIs for all cores (whole system). A better scheme, IMO, would be
to expose 2047 * #harts unique MSIs.

I think this could simplify/remove(?) the locking as well.

I realize that the series in v10, and coming with a change like this
now might be a bit of a pain...

Finally, another question related to APLIC/IMSIC. AFAIU the memory map
of the IMSIC regions are constrained by the APLIC, which requires a
certain layout for MSI forwarding (group/hart/guest bits). Say that a
system doesn't have an APLIC, couldn't the layout requirement be
simplified?


Again, thanks for the hard work!
Bj=C3=B6rn
