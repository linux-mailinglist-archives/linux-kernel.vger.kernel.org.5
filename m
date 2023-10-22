Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD37D2205
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 11:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjJVJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVJJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 05:09:28 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3C498
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 02:09:25 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39M99FBx063388;
        Sun, 22 Oct 2023 17:09:15 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Sun, 22 Oct 2023 17:09:12 +0800
Date:   Sun, 22 Oct 2023 17:09:09 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <will@kernel.org>, <mark.rutland@arm.com>,
        <atishp@atishpatra.org>, <anup@brainfault.org>,
        <conor.dooley@microchip.com>, <evan@rivosinc.com>,
        <jszhang@kernel.org>, <ajones@ventanamicro.com>,
        <rdunlap@infradead.org>, <heiko@sntech.de>, <samuel@sholland.org>,
        <guoren@kernel.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <uwu@icenowy.me>, <sunilvl@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <tim609@andestech.com>,
        <dylan@andestech.com>, <locus84@andestech.com>,
        <dminus@andestech.com>
Subject: Re: [RFC PATCH v2 07/10] perf: RISC-V: Move T-Head PMU to CPU
 feature alternative framework
Message-ID: <ZTTmtVnZrioRWpJx@APC323>
References: <20231019140119.3659651-1-peterlin@andestech.com>
 <20231019-predator-quartet-e56f43d5aa8d@spud>
 <ZTJAYqk_DnrR9-Sc@APC323>
 <20231020-snippet-diffusive-1a6052d52aae@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231020-snippet-diffusive-1a6052d52aae@spud>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39M99FBx063388
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Fri, Oct 20, 2023 at 10:05:20AM +0100, Conor Dooley wrote:
> On Fri, Oct 20, 2023 at 04:54:58PM +0800, Yu-Chien Peter Lin wrote:
> > On Thu, Oct 19, 2023 at 05:13:00PM +0100, Conor Dooley wrote:
> > > On Thu, Oct 19, 2023 at 10:01:19PM +0800, Yu Chien Peter Lin wrote:
> > > 
> > > $subject: perf: RISC-V: Move T-Head PMU to CPU feature alternative framework
> > > 
> > > IMO, this should be "RISC-V, perf:" or just "RISC-V" as the changes
> > > being made to the arch code are far more meaningful than those
> > > elsewhere.
> > 
> > OK will update the subject to "RISC-V:"
> > 
> > > > The custom PMU extension was developed to support perf event sampling
> > > > prior to the ratification of Sscofpmf. Instead of utilizing the standard
> > > > bits and CSR of Sscofpmf, a set of custom CSRs is added. So we may
> > > > consider it as a CPU feature rather than an erratum.
> > > > 
> > > > T-Head cores need to append "xtheadpmu" to the riscv,isa-extensions
> > > > for each cpu node in device tree, and enable CONFIG_THEAD_CUSTOM_PMU
> > > > for proper functioning as of this commit.
> > > 
> > > And in doing so, you regress break perf for existing DTs :(
> > > You didn't add the property to existing DTS in-kernel either, so if this
> > > series was applied, perf would just entirely stop working, no?
> > 
> > Only `perf record/top` stop working I think.
> > 
> > There are too many users out there, and don't have the boards to
> > test, so leave those DTS unchanged, it would be great if T-Head
> > community could help to check/update their DTS.
> 
> So, there are too many users to add xtheadpmu to the devicetrees, but
> not too many users to make changes that will cause a regression?
> I'm not following the logic here, sorry.

humm, I'll try. I assume that the sun20i-d1s.dtsi is all I need
to update for T-Head PMU.

> > > > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > > > ---
> > > > Hi All,
> > > > 
> > > > This is in preparation for introducing other PMU alternative.
> > > > We follow Conor's suggestion [1] to use cpu feature alternative
> > > > framework rather than errta, if you want to stick with errata
> > > > alternative or have other issues, please let me know. Thanks.
> > > 
> > > Personally, I like this conversion, but it is going to regress support
> > > for perf on any T-Head cores which may be a bitter pill to get people to
> > > actually accept...
> > > Perhaps we could add this "improved" detection in parallel, and
> > > eventually remove the m*id based stuff in the future.
> > > 
> > > > [1] https://patchwork.kernel.org/project/linux-riscv/patch/20230907021635.1002738-4-peterlin@andestech.com/#25503860
> > > > 
> > > > Changes v1 -> v2:
> > > >   - New patch
> > > > ---
> 
> > > > @@ -805,7 +816,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
> > > >  	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> > > >  		riscv_pmu_irq_num = RV_IRQ_PMU;
> > > >  		riscv_pmu_use_irq = true;
> > > > -	} else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
> > > > +	} else if (riscv_isa_extension_available(NULL, XTHEADPMU) &&
> > > > +		   IS_ENABLED(CONFIG_THEAD_CUSTOM_PMU) &&
> > > >  		   riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
> > > >  		   riscv_cached_marchid(0) == 0 &&
> > > >  		   riscv_cached_mimpid(0) == 0) {
> > > 
> > > Can all of the m*id checks be removed, since the firmware is now
> > > explicitly telling us that the T-Head PMU is supported?
> > 
> > I can only comfirm that boards with "allwinner,sun20i-d1" compatible
> > string uses the T-Head PMU device callbacks.
> 
> I'm not sure how that is an answer to my question.

Sorry for that unclear answer.
Yes, I agree we no longer need to check the m*id here.

In OpenSBI, it appears that allwinner D1 is the only platform that
has T-Head PMU support, the other T-Head platforms need to ensure
that the callbacks [1] are registered in order to work with SBI
PMU driver in kernel.

Regards,
Peter Lin

[1] https://github.com/riscv-software-src/opensbi/blob/v1.3.1/platform/generic/allwinner/sun20i-d1.c#L263-L272

> Thanks,
> Conor.


