Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDFA7D74F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjJYT4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjJYT4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:56:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B0D185;
        Wed, 25 Oct 2023 12:56:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698263808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Y76BTvDL8fMtXIIKTEWVYaf4r3Jy1wak2WgowyW9Fw=;
        b=esCpCbSf/cGVbPuyJtSR/0shnIZx4AEsHhsuEwZxlDbnnT0pQnNCb03npVRR/WhzSfjUhx
        Xpt9WvqkcG2JGqu1Seh1gjDkPBHQ7OWDw4/TuryeGH6Vg4d8JlVwLLJh0jehwL10F1M1MO
        JvNMBIwld2eUpyFwYp4wLTYBqnr1C6d6ShrtrPMiDzwuBR71FSxDey1udLojgTOxynWYqb
        uQK2pY/kDLAoripSvgpJ/Hq72zxU4svuQijQMK79oXtPPi6Y30GoKPzagA/4VOSVJ8cHRE
        aXWHTUO79O38JrTYJ8ZJxZCcHDKpZE+elp4ZGtKMU0c1RHf2ja0YVtFOyN8mqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698263808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Y76BTvDL8fMtXIIKTEWVYaf4r3Jy1wak2WgowyW9Fw=;
        b=f3nWV8Kv0BmZV5MMqx2/zHJSBaiOlu6tmCwUSQPXD2tXDy2idlMko8ZhhVUvoLvflaC8KH
        RAURu2cNz+Woq5Bg==
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
Subject: Re: [PATCH v11 08/14] irqchip/riscv-imsic: Add support for platform
 MSI irqdomain
In-Reply-To: <20231023172800.315343-9-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-9-apatel@ventanamicro.com>
Date:   Wed, 25 Oct 2023 21:56:47 +0200
Message-ID: <87edhi5vcw.ffs@tglx>
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
> The Linux platform MSI support requires a platform MSI irqdomain so
> let us add a platform irqchip driver for RISC-V IMSIC which provides
> a base IRQ domain and platform MSI domain. This driver assumes that
> the IMSIC state is already initialized by the IMSIC early driver.

Please no. The platform MSI cruft is really a horrible concept and there
is ongoing work (sadly mightily delayed) to convert the main (ab)user
ARM over to per device MSI domains.

  https://lore.kernel.org/r/20221121135653.208611233@linutronix.de
