Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D177DA8A9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjJ1Sg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Sg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:36:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D68ED;
        Sat, 28 Oct 2023 11:36:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698518182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+JcIxwCXoDSqf+artDzmxw4NchEsdASLJbThyKqdKo=;
        b=XPD1tQNetxvEMQ5Fs4mzhtA/G5HWxqiD9ADxCIt7lYfraNqzOMel6WUxppBbqdi0bgI8aZ
        3rPQzNZs9PUl2jp/jDJY2L4QntS1kpl91bgcoQ8MwxMNYCKU40QO7P9NsDtqVkoHPAClvL
        l9Ypj6JGrlL6oh82hFpbPRFKtkzuzehhR65XTPO0nAGcN9vge7E/sYR1ZlCZlBdTUGXvum
        fYXhCUPu6U1EscBv3oubTAhyVMdv3h8CHa+y5E4EtnPUo0zDFZy+A0MI5NJV9UW1cJ1lan
        V7JKOjHUv+9AL7BsjcQiBzM9/OdO3TClZ5ZNgh66xWjZ4stz3rc6q78CJ+tyyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698518182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+JcIxwCXoDSqf+artDzmxw4NchEsdASLJbThyKqdKo=;
        b=M3mwqGYRAOI6KGdDqVCILcqh8Ql5h8OW+P1CEwmVfh4n9f9Nn8Lo5wD7FszZtGyZKCGF0j
        WXB1fuwq/1Jxa9Bw==
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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
In-Reply-To: <87jzrbf5cw.fsf@all.your.base.are.belong.to.us>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-10-apatel@ventanamicro.com>
 <8734y0rwtw.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UVgTd-a0671Lab_ZeOPWP3=wHY+pydKHqaR-Yg65YhrA@mail.gmail.com>
 <87jzrbf5cw.fsf@all.your.base.are.belong.to.us>
Date:   Sat, 28 Oct 2023 20:36:22 +0200
Message-ID: <87y1fmzja1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25 2023 at 10:55, Bj=C3=B6rn T=C3=B6pel wrote:
>> Now for IMSIC-PCI domain, the PCI framework expects the
>> pci_msi_mask/unmask_irq() functions to be called but if
>> we directly point pci_msi_mask/unmask_irq() in the IMSIC-PCI
>> irqchip then IMSIC-BASE (parent domain) irq_mask/umask
>> won't be called hence the IRQ won't be masked/unmask.
>> Due to this, we call both pci_msi_mask/unmask_irq() and
>> irq_chip_mask/unmask_parent() for IMSIC-PCI domain.
>
> Ok. I wont dig more into it for now! If the interrupt is disabled at
> PCI, it seems a bit overkill to *also* mask it at the IMSIC level...

Only _if_ the device provides MSI masking, but that extra mask/unmask is
not the end of the world.

Thanks,

        tglx
