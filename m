Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908DA7D4F42
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjJXLzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjJXLzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:55:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC4BD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:55:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BB9C433C7;
        Tue, 24 Oct 2023 11:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698148529;
        bh=ozsPNKeRYz2u0iELn3HbnuXXLgIDYAVxNBxhsn13OoU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gp/kARWkeQCvZcJG51906PXhGlm2ymUqGxZ0YpevWlinAhdCJ8ccWWJ7UI4/r3z8E
         OT35Ycq8hze2eR21Dv7CifcmXJLQc9h4N6Sq0e4Zw0ZMVpVaIepz36MdvFlEOLwlq+
         DELIVmHBREeVxPD7McDdYBrugbGj0anqLa5spDHY+qD6QF4kT6RLBWgH36psqrk3YV
         NdWiQY5wlw126R6bLEx8scnNL4MiJHILywR1lCcJYKWG0+I33zpgAD5OrNu4MXEkHI
         4+Gho6kZkaMG7wsX6BgCqV/mBP/OwPToli+7r+LluAlsSOtTc0olHSUos3ayccLada
         LvtEhPyprQBTg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v11 01/14] RISC-V: Don't fail in
 riscv_of_parent_hartid() for disabled HARTs
In-Reply-To: <20231023172800.315343-2-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-2-apatel@ventanamicro.com>
Date:   Tue, 24 Oct 2023 13:55:24 +0200
Message-ID: <87h6mgs09f.fsf@all.your.base.are.belong.to.us>
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

Anup Patel <apatel@ventanamicro.com> writes:

> The riscv_of_processor_hartid() used by riscv_of_parent_hartid() fails
> for HARTs disabled in the DT. This results in the following warning
> thrown by the RISC-V INTC driver for the E-core on SiFive boards:
>
> [    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interru=
pt-controller
>
> The riscv_of_parent_hartid() is only expected to read the hartid from
> the DT so we should directly call of_get_cpu_hwid() instead of calling
> riscv_of_processor_hartid().
>
> Fixes: ad635e723e17 ("riscv: cpu: Add 64bit hartid support on RV64")

Patch 1 and 3: These fixes are stand alone, and doesn't have to be part
of the series.

Wouldn't it be better to pull these out of the long-going series, and
try to get in the fixes ASAP?


Bj=C3=B6rn
