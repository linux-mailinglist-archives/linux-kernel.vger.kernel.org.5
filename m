Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7A379A17E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjIKCtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjIKCty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:49:54 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC598B0;
        Sun, 10 Sep 2023 19:49:47 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 38B2mndQ062834;
        Mon, 11 Sep 2023 10:48:49 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Mon, 11 Sep 2023 10:48:48 +0800
Date:   Mon, 11 Sep 2023 10:48:44 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <conor.dooley@microchip.com>,
        <atishp@atishpatra.org>, <anup@brainfault.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <ajones@ventanamicro.com>, <heiko@sntech.de>,
        <samuel@sholland.org>, <geert+renesas@glider.be>,
        <n.shubin@yadro.com>, <dminus@andestech.com>,
        <ycliang@andestech.com>, <tim609@andestech.com>,
        <locus84@andestech.com>, <dylan@andestech.com>
Subject: Re: [PATCH 3/4] riscv: errata: Add Andes PMU errata
Message-ID: <ZP6ADIAqZn0kkxwB@APC323>
References: <20230907021635.1002738-1-peterlin@andestech.com>
 <20230907021635.1002738-4-peterlin@andestech.com>
 <20230907-158e1f7e1e866d8c02726c9c@fedora>
 <20230907-7bc08398d2f95c14e1c0bc76@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230907-7bc08398d2f95c14e1c0bc76@fedora>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 38B2mndQ062834
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:02:46PM +0100, Conor Dooley wrote:
> On Thu, Sep 07, 2023 at 10:27:03AM +0100, Conor Dooley wrote:
> > Hey,
> > 
> > On Thu, Sep 07, 2023 at 10:16:34AM +0800, Yu Chien Peter Lin wrote:
> > > Before the ratification of Sscofpmf, the Andes PMU extension
> > > implements the same mechanism and is compatible with existing
> > > SBI PMU driver of perf to support event sampling and mode
> > > filtering with programmable hardware performance counters.
> > 
> > If it actually was, you'd not need to modify the driver ;)
> > 
> > > This patch adds PMU support for Andes 45-series CPUs by
> > > introducing a CPU errata.
> > 
> > I don't really understand this in all honesty. You don't have Sscofpmf
> > support with a bug, you have something that is Sscofpmf-adjactent that
> > predates it. Why claim to support an extension that you do not, only to
> > have to come along and try to clean things up afterwards, instead of
> > accurately declaring what you do support from the outset?
> 
> Reading this again, I don't think that I have been particularly clear,
> sorry. My point is that this is not a fix for a bug in your
> implementation of Sscofpmf, but rather adding probing for what is
> effectively a custom ISA extension that happens to be very similar to
> the standard one. As it is not an implementation bug, errata should
> not be abused to support vendor extensions, and either DT or ACPI should
> be used to inform the operating system about its presence.
> 
> Cheers,
> Conor.
> 
> > 
> > (and just because someone already got away with it, doesn't mean that
> > you get a free pass on it, sorry)

Apologize for any confusion caused by the name. I thought it would make it
easier to find the related functions and files in OpenSBI, didn't expect
that it may have misled people to abuse the use of errata, you are right,
I should have chosen my words more carefully.

In my opinion, this is simply a pre-sepc solution to enable missing perf
features before the standard is finalized. The underlying logic remains the
same, so we can still use the errata to patch a few lines of CSR accesses
and align with other vendors. This way, we can make minimal changes and
avoid performance overhead to the driver.

> > Thanks,
> > Conor.
> > 
> > > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > > Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>
> > 
> > btw, what did Locus Wei-Han Chen do here? Are you missing
> > a Co-developed-by: tag?

Yes I missed the CD-tag, will fix it.
Thanks for the review.

> > > Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> > > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > > ---
> > >  arch/riscv/Kconfig.errata            | 13 ++++++++
> > >  arch/riscv/errata/andes/errata.c     | 45 +++++++++++++++++++++++++++-
> > >  arch/riscv/include/asm/errata_list.h | 43 ++++++++++++++++++++++++--
> > >  drivers/perf/riscv_pmu_sbi.c         | 20 +++++++++----
> > >  4 files changed, 111 insertions(+), 10 deletions(-)

Best regards,
Peter Lin
