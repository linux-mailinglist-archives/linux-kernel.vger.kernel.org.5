Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D170B7D276D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjJWAPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJWAPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:15:40 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A32DA;
        Sun, 22 Oct 2023 17:15:37 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39N0DIsq070639;
        Mon, 23 Oct 2023 08:13:18 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Mon, 23 Oct 2023 08:13:17 +0800
Date:   Mon, 23 Oct 2023 08:13:10 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <ajones@ventanamicro.com>, <alexander.shishkin@linux.intel.com>,
        <andre.przywara@arm.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <conor+dt@kernel.org>, <conor.dooley@microchip.com>,
        <devicetree@vger.kernel.org>, <dminus@andestech.com>,
        <evan@rivosinc.com>, <geert+renesas@glider.be>,
        <guoren@kernel.org>, <heiko@sntech.de>, <irogers@google.com>,
        <jernej.skrabec@gmail.com>, <jolsa@kernel.org>,
        <jszhang@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <locus84@andestech.com>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <n.shubin@yadro.com>,
        <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterz@infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tglx@linutronix.de>,
        <tim609@andestech.com>, <uwu@icenowy.me>, <wens@csie.org>,
        <will@kernel.org>, <ycliang@andestech.com>
Subject: Re: [PATCH v3 00/13] Support Andes PMU extension
Message-ID: <ZTW6lgK1oifvtqyH@APC323>
References: <20231022151858.2479969-1-peterlin@andestech.com>
 <20231022-cabana-crate-503b6e8d0481@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231022-cabana-crate-503b6e8d0481@spud>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39N0DIsq070639
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 07:00:28PM +0100, Conor Dooley wrote:
> Hey,
> 
> On Sun, Oct 22, 2023 at 11:18:45PM +0800, Yu Chien Peter Lin wrote:
> > Hi All,
> > 
> > This patch series introduces the Andes PMU extension, which serves
> > the same purpose as Sscofpmf. In this version we use FDT-based
> > probing and the CONFIG_ANDES_CUSTOM_PMU to enable perf sampling
> > and filtering support.
> > 
> > Its non-standard local interrupt is assigned to bit 18 in the
> > custom S-mode local interrupt enable/pending registers (slie/slip),
> > while the interrupt cause is (256 + 18).
> > 
> > The feature needs the PMU device registered in OpenSBI.
> > The OpenSBI and Linux patches can be found on Andes Technology GitHub
> > - https://github.com/andestech/opensbi/commits/andes-pmu-support-v2
> > - https://github.com/andestech/linux/commits/andes-pmu-support-v3
> > 
> > The PMU device tree node used on AX45MP:
> > - https://github.com/andestech/opensbi/blob/andes-pmu-support-v2/docs/pmu_support.md#example-3
> > 
> > Tested hardware:
> > - ASUS  Tinker-V (RZ/Five, AX45MP single core)
> > - Andes AE350    (AX45MP quad core)
> > 
> > Locus Wei-Han Chen (1):
> >   riscv: andes: Support symbolic FW and HW raw events
> > 
> > Yu Chien Peter Lin (12):
> >   riscv: errata: Rename defines for Andes
> >   irqchip/riscv-intc: Allow large non-standard hwirq number
> >   irqchip/riscv-intc: Introduce Andes IRQ chip
> >   dt-bindings: riscv: Add Andes interrupt controller compatible string
> >   riscv: dts: renesas: r9a07g043f: Update compatible string to use Andes
> >     INTC
> >   perf: RISC-V: Eliminate redundant IRQ enable/disable operations
> >   RISC-V: Move T-Head PMU to CPU feature alternative framework
> >   perf: RISC-V: Introduce Andes PMU for perf event sampling
> >   dt-bindings: riscv: Add T-Head PMU extension description
> >   dt-bindings: riscv: Add Andes PMU extension description
> >   riscv: dts: allwinner: Add T-Head PMU extension
> >   riscv: dts: renesas: Add Andes PMU extension
> 
> You only sent 5 of these patches FYI.

Hi Conor,

Yeah... I know. The following emails were intercepted automatically
due to our data traffic policy. I will resend the whole series soon.

Best regards,
Peter Lin

