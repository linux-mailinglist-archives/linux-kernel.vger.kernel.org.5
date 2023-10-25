Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63B7D74FE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjJYT7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYT7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:59:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C705F93;
        Wed, 25 Oct 2023 12:59:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698263956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sT6BK5Z8FPdXb0R3Y4NYE9GeqC6Wv7eahDU+D60e1Ps=;
        b=UfFMIM7eQiozcUjqpRZh5qaxkLEq8/25fz8PmjlZuV6PIoFovao2Bbs1sW3O6KSyMaSrGK
        YZGvmLN3vsXfmUYzVQ6BV1J674CzA1EDPI1HwadW711XopPlJD2r2UmR0G3a313p3h9l19
        IZYw4JC/qYr0vkr0mwcrKY+gW5ZmopG2f1htxgsLdH/O5PadMrsoCiT4c7SXFw79gqTios
        YV9lR8jbxXDjU3KhWoNYZy0dj5Es19ds0W3hoOHQMb8ll/4qLnZyKrJTzggDTqG83UARCI
        MjbvIPxf3DCmqYONVcFQFnJUM6wSAKq8p+Gx83HGq/ybjtRGujc4q3EeQ3aKqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698263956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sT6BK5Z8FPdXb0R3Y4NYE9GeqC6Wv7eahDU+D60e1Ps=;
        b=UAS7JqC/0l/WnQ7ztOlbqaFHo826mHKYl/aPVpUn6S9Ppdw/RBzfQ1kws4/1EYbO9PUovO
        rJ/FsqYvfBY4irBQ==
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH v11 09/14] irqchip/riscv-imsic: Add support for PCI MSI
 irqdomain
In-Reply-To: <20231023172800.315343-10-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-10-apatel@ventanamicro.com>
Date:   Wed, 25 Oct 2023 21:59:15 +0200
Message-ID: <87bkcm5v8s.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23 2023 at 22:57, Anup Patel wrote:
> The Linux PCI framework requires it's own dedicated MSI irqdomain so
> let us create PCI MSI irqdomain as child of the IMSIC base irqdomain.

Same here. Please don't add new incarnations of that and switch over to
per device MSI domains which is the most future proof mechanism.

Thanks,

        tglx

