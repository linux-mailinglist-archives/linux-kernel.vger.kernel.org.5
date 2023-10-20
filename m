Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E4A7D0A88
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376458AbjJTIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjJTIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:30:59 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A684112
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:30:56 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39K8UpJf015318;
        Fri, 20 Oct 2023 16:30:51 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Fri, 20 Oct 2023 16:30:49 +0800
Date:   Fri, 20 Oct 2023 16:30:46 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <will@kernel.org>, <mark.rutland@arm.com>,
        <atishp@atishpatra.org>, <anup@brainfault.org>,
        <conor.dooley@microchip.com>, <ajones@ventanamicro.com>,
        <heiko@sntech.de>, <jszhang@kernel.org>, <evan@rivosinc.com>,
        <sunilvl@ventanamicro.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <tim609@andestech.com>,
        <dylan@andestech.com>, <locus84@andestech.com>,
        <dminus@andestech.com>, "Leo Yu-Chi Liang" <ycliang@andestech.com>
Subject: Re: [RFC PATCH v2 08/10] perf: RISC-V: Introduce Andes PMU for perf
 event sampling
Message-ID: <ZTI6k00Z1la8EmtR@APC323>
References: <20231019140156.3660000-1-peterlin@andestech.com>
 <20231019-daybed-preschool-8663d5a86798@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231019-daybed-preschool-8663d5a86798@spud>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39K8UpJf015318
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Thu, Oct 19, 2023 at 05:02:18PM +0100, Conor Dooley wrote:
> On Thu, Oct 19, 2023 at 10:01:56PM +0800, Yu Chien Peter Lin wrote:
> > The Andes PMU extension provides the same mechanism as Sscofpmf,
> > allowing us to reuse the SBI PMU driver to support event sampling
> > and mode filtering.
> > 
> > To make use of this custom PMU extension, "xandespmu" needs
> > to be appended to the riscv,isa-extensions for each cpu node
> > in device-tree, and enable CONFIG_ANDES_CUSTOM_PMU.
> > 
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > Co-developed-by: Locus Wei-Han Chen <locus84@andestech.com>
> > Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>
> > ---
> > Changes v1 -> v2:
> >   - New patch
> > ---
> >  arch/riscv/include/asm/hwcap.h |  1 +
> >  arch/riscv/kernel/cpufeature.c |  1 +
> >  drivers/perf/Kconfig           | 14 ++++++++++++++
> >  drivers/perf/riscv_pmu_sbi.c   | 35 +++++++++++++++++++++++++++++-----
> >  4 files changed, 46 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index d3082391c901..eecfe95d5050 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -59,6 +59,7 @@
> >  #define RISCV_ISA_EXT_ZIFENCEI		41
> >  #define RISCV_ISA_EXT_ZIHPM		42
> >  #define RISCV_ISA_EXT_XTHEADPMU		43
> > +#define RISCV_ISA_EXT_XANDESPMU		44
> >  
> >  #define RISCV_ISA_EXT_MAX		64
> >  
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 4a3fb017026c..a8e71c6dfb3e 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -182,6 +182,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> >  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> >  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> >  	__RISCV_ISA_EXT_DATA(xtheadpmu, RISCV_ISA_EXT_XTHEADPMU),
> > +	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
> 
> This does not following the ordering convention (see the comment above
> this datastructure) and is not documented in the dt-binding AFAICT.

OK, will insert the xandespmu here.

Thanks,
Peter Lin

> Cheers,
> Conor.


