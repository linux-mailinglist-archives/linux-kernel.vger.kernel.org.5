Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C242A80A7F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574424AbjLHPyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574415AbjLHPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:54:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB261734;
        Fri,  8 Dec 2023 07:54:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702050874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6O/DmHCMHLUH4FV1veAF/8wiZY0/z4QkGmnuD54M7ss=;
        b=dUAYIEG5jE088Ag2fa2Z1rmOHZzMqN8lggzcGrdUF+qteYYY6+KScF/UWzOmEkwppSIzMg
        drYMKkylIh4/jkIuNwWg2RwRfCbgTFEy27hCcz9Gk15i9dRSW78M5DpeqR2QWEKRIKLyHx
        wDyd9rDgT2FHf75QyRs2uIi2l6vjA1qxtgW30iVOhJiK/nDRv0wwaN3/yoM2ixz4AokyV3
        zQJjh3UFGsZP+qwKuCSP1Jjc0k3T3iczFPHGvrAcOe0PUf5+TVU2oFxwJl21okm2QGqOr9
        HP3DNdUlp9E4kYFKpOiZ0aDPB40Qzxtb++qm4dqzsK4Vk2qKeTKYrhvStKL7/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702050874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6O/DmHCMHLUH4FV1veAF/8wiZY0/z4QkGmnuD54M7ss=;
        b=4b3Ipi5s1e37x7+vS4YcQAh1vTCM28hhl4temVUWU7Lfo1Vr/kigWJ41YHwTye0jWEYeM3
        fXhNrHzTehUYsbBA==
To:     Yu Chien Peter Lin <peterlin@andestech.com>, acme@kernel.org,
        adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterlin@andestech.com,
        peterz@infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        sunilvl@ventanamicro.com, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com,
        inochiama@outlook.com
Subject: Re: [PATCH v4 02/13] irqchip/riscv-intc: Allow large non-standard
 interrupt number
In-Reply-To: <20231122121235.827122-3-peterlin@andestech.com>
References: <20231122121235.827122-1-peterlin@andestech.com>
 <20231122121235.827122-3-peterlin@andestech.com>
Date:   Fri, 08 Dec 2023 16:54:34 +0100
Message-ID: <871qbwsn9h.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22 2023 at 20:12, Yu Chien Peter Lin wrote:
> Currently, the implementation of the RISC-V INTC driver uses the
> interrupt cause as hwirq and has a limitation of supporting a

s/hwirq/hardware interrupt/

Please spell things out. We are not on Xitter here.

> maximum of 64 hwirqs. However, according to the privileged spec,
> interrupt causes >= 16 are defined for platform use.
>
> This limitation prevents us from fully utilizing the available

This limitation prevents to fully utilize the ... 

> local interrupt sources. Additionally, the hwirqs used on RISC-V
> are sparse, with only interrupt numbers 1, 5 and 9 (plus Sscofpmf
> or T-Head's PMU irq) being currently used for supervisor mode.
>
> Switch to using irq_domain_create_tree() to create the radix tree
> map, so a larger number of hardware interrupts can be handled.
