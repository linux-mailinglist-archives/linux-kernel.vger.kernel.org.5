Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61314778BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbjHKKUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjHKKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A654C1E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D69F566F17
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3817C433C7;
        Fri, 11 Aug 2023 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691749171;
        bh=uLzOe07u2mc5CQdgcJqCfLD+BPdp+FAFUsDEr9hSL7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmzBoLX0tqhg+bqiJpj/BpbDfOI7f4tge07r0ir+XCi9n9p6N590mBZ4XSQvATCeE
         belyCKPq+cvh1Yy0h0jwnKuOoz8mU8obHq7SAXhvLCreXr5H8bPWs8bBUueTXU6csF
         giJaiJii9mmU47sV/wRiygpQJLN6vw1x3+sWD5lJ3uy81yVkdWo8YZkupGuDVYJtge
         MBVCCE52s7978VyhkEsVdbqRW3gxe/0S8efQQtFt+6K6gaaAgXbBNNTFfNdW2cuVso
         +xIAAUpyJAogMt/Bg+9UWYyVwUbNS5AKc1gWCa6TieeFgKCv/nltclGrX92CYAiVSw
         zETfu0evfVFnw==
Date:   Fri, 11 Aug 2023 11:19:25 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, yangyicong@huawei.com,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/4] arm_pmu: acpi: Refactor
 arm_spe_acpi_register_device()
Message-ID: <20230811101925.GB6827@willie-the-truck>
References: <20230808082247.383405-1-anshuman.khandual@arm.com>
 <20230808082247.383405-2-anshuman.khandual@arm.com>
 <8bef9c5a-eede-f78f-4418-da10c99a5bef@arm.com>
 <20230808131634.GA2369@willie-the-truck>
 <c2448e06-b46f-8a6d-163d-32364954fc23@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2448e06-b46f-8a6d-163d-32364954fc23@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 01:54:55PM +0100, Suzuki K Poulose wrote:
> On 08/08/2023 14:16, Will Deacon wrote:
> > On Tue, Aug 08, 2023 at 09:48:16AM +0100, Suzuki K Poulose wrote:
> > > On 08/08/2023 09:22, Anshuman Khandual wrote:
> > > > Sanity checking all the GICC tables for same interrupt number, and ensuring
> > > > a homogeneous ACPI based machine, could be used for other platform devices
> > > > as well. Hence this refactors arm_spe_acpi_register_device() into a common
> > > > helper arm_acpi_register_pmu_device().
> > > > 
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Co-developed-by: Will Deacon <will@kernel.org>
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > ---
> > > >    drivers/perf/arm_pmu_acpi.c | 105 ++++++++++++++++++++++--------------
> > > >    1 file changed, 65 insertions(+), 40 deletions(-)
> > > > 
> > > > diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> > > > index 90815ad762eb..72454bef2a70 100644
> > > > --- a/drivers/perf/arm_pmu_acpi.c
> > > > +++ b/drivers/perf/arm_pmu_acpi.c
> > > > +	pdev->resource[0].start = irq;
> > > > +	ret = platform_device_register(pdev);
> > > > +	if (ret < 0) {
> > > > +		pr_warn("ACPI: %s: Unable to register device\n", pdev->name);
> > > > +		acpi_unregister_gsi(gsi);
> > > > +	}
> > > > +	return ret;
> > > 
> > > A postivie return value here could confuse the caller. Also, with my comment
> > > below, we don't really need to return something from here.
> > 
> > How does this return a positive value?
> 
> Right now, there aren't. My point is this function returns a "return value"
> of another function. And the caller of this function doesn't
> really follow the "check" it needs.  e.g.:
> 
> ret = foo();
> if (ret < 0)
> 	error;
> return ret;
> 
> 
> 
> And the caller only checks for
> 
> if (ret)
> 	error;
> 
> This seems fragile.

Yeah, the '< 0' check is weird. I'd be inclined to drop that entirely
from the helper function tbh...

> > > > +	int ret = arm_acpi_register_pmu_device(&spe_dev, ACPI_MADT_GICC_SPE,
> > > > +					       arm_spe_parse_gsi);
> > > > +	if (ret)
> > > >    		pr_warn("ACPI: SPE: Unable to register device\n");
> > > 
> > > With this change, a system without SPE interrupt description always
> > > generates the above message. Is this intended ?
> > 
> > If there are no irqs, why doesn't this return 0?
> 
> Apologies, I missed that.
> 
> > arm_acpi_register_pmu_device() should only fail if either:
> > 
> >    - The static resources passed in are broken
> >    - The tables are not homogeneous
> >    - We fail to register the interrupt
> > 
> > so something is amiss.
> 
> Agreed. We don't need duplicate messages about an error ?
> i.e., one in arm_acpi_register_pmu_device() and another
> one in the caller ? (Of course adding any missing error msgs).

... and then just print the registration failure message in the caller.

Will
