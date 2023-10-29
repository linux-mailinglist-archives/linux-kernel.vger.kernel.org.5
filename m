Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906F57DAE0F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjJ2Txc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2Txb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 15:53:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECB7BD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 12:53:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46471C433C8;
        Sun, 29 Oct 2023 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698609208;
        bh=lmudrSFAHZUzHPWgKrth9d+IMU9R0eRDc3eGd1MXJC4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BYRXQ30H7zG0VuXvZAImgIlhy7I8o0cO6u74yfM2MHH0xc7shZ1zPeV2NrW/FjYxm
         i4M3G+IwBNXrgeZp3ir7RiYdAXCQ21w9+g2mLWKgb4yZLNGvf15tGfJJ8JL5yaPcEq
         qBB0vaSNa3IHDUzD7YZPYbnbbfWpmSVIikUNp0bt+QECZyY+Cvos8qOifeaL0DKm8V
         B8G6oz2+1L1rKMk4wfU5chSopqlaNhyqJQrmmQ6EM1kahfNdN2MaPEIqrYWIKZinDD
         UXmf+XJb9cuLyPTCuIg838uJhSmMdiQHs5+J8kT0pLfy4AXYne4Dm49zDSNV8mDFwo
         9nksLDpGRohlw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 09/14] irqchip/riscv-imsic: Add support for PCI MSI
 irqdomain
In-Reply-To: <87y1fmzja1.ffs@tglx>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-10-apatel@ventanamicro.com>
 <8734y0rwtw.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UVgTd-a0671Lab_ZeOPWP3=wHY+pydKHqaR-Yg65YhrA@mail.gmail.com>
 <87jzrbf5cw.fsf@all.your.base.are.belong.to.us> <87y1fmzja1.ffs@tglx>
Date:   Sun, 29 Oct 2023 20:53:25 +0100
Message-ID: <87bkchfbnu.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Oct 25 2023 at 10:55, Bj=C3=B6rn T=C3=B6pel wrote:
>>> Now for IMSIC-PCI domain, the PCI framework expects the
>>> pci_msi_mask/unmask_irq() functions to be called but if
>>> we directly point pci_msi_mask/unmask_irq() in the IMSIC-PCI
>>> irqchip then IMSIC-BASE (parent domain) irq_mask/umask
>>> won't be called hence the IRQ won't be masked/unmask.
>>> Due to this, we call both pci_msi_mask/unmask_irq() and
>>> irq_chip_mask/unmask_parent() for IMSIC-PCI domain.
>>
>> Ok. I wont dig more into it for now! If the interrupt is disabled at
>> PCI, it seems a bit overkill to *also* mask it at the IMSIC level...
>
> Only _if_ the device provides MSI masking, but that extra mask/unmask is
> not the end of the world.

Yikes -- so MSI masking is optional. Ick. :-( Thanks for the excellent
MSI vs MSI-X post in the other thread, BTW. Great stuff!
