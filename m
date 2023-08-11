Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB25778BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjHKKXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjHKKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664423C33
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0769B66E5C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AFCC433C7;
        Fri, 11 Aug 2023 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691748727;
        bh=ZvfU6kB3bN1t91HtVqT/9MuA+hqqmc52GVwIlq9B6fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYd168SJ7D6Nk/EbsRr41eqUY+WEH7t0HP4e7DkTjB1fPNO+5ER1eOW8UczLVgErO
         IS0aKMEqZZLXYbwDYCvSCHJ6sKSMHwUzZL6FzF5JMTMI6rLTkjDRLidAJiIyFPkEk2
         opl4v9tXy/hE93B/e6D0O3x+CqqhX6u+qyufpGpz6y7UCZBjCVnBGUyHQ4eEV481fD
         Lkw8FtR6YX8rXkXkEX2hChruilPawGmshXOeDKVfWdNnuxy846GFAnH42Msc2U8SD1
         f+3JzJP2c7srGSXsV5ShKc7o69Cub2pvAA3zrpujyuyzhmn9dsvN+D/SsYPMVotlcV
         FLZPYlOpjthJw==
Date:   Fri, 11 Aug 2023 11:12:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        yangyicong@huawei.com, Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/4] arm_pmu: acpi: Refactor
 arm_spe_acpi_register_device()
Message-ID: <20230811101201.GA6827@willie-the-truck>
References: <20230808082247.383405-1-anshuman.khandual@arm.com>
 <20230808082247.383405-2-anshuman.khandual@arm.com>
 <9d22520a-3450-0e75-59a2-035209f239e6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d22520a-3450-0e75-59a2-035209f239e6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 02:13:42PM +0530, Anshuman Khandual wrote:
> On 8/8/23 13:52, Anshuman Khandual wrote:
> > +	/*
> > +	 * Sanity check all the GICC tables for the same interrupt
> > +	 * number. For now, only support homogeneous ACPI machines.
> > +	 */
> > +	for_each_possible_cpu(cpu) {
> > +		struct acpi_madt_generic_interrupt *gicc;
> > +
> > +		gicc = acpi_cpu_get_madt_gicc(cpu);
> > +		if (gicc->header.length < len)
> > +			return gsi ? -ENXIO : 0;
> > +
> > +		this_gsi = parse_gsi(gicc);
> > +		if (!this_gsi)
> > +			return gsi ? -ENXIO : 0;
> > +
> > +		this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
> > +		if (!gsi) {
> > +			hetid = this_hetid;
> > +			gsi = this_gsi;
> > +		} else if (hetid != this_hetid || gsi != this_gsi) {
> > +			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
> > +			return -ENXIO;
> > +		}
> > +	}
> 
> As discussed on the previous version i.e V3 thread, will move the
> 'this_gsi' check after parse_gsi(), inside if (!gsi) conditional
> block. This will treat subsequent cpu parse_gsi()'s failure as a
> mismatch thus triggering the pr_warn() message.
> 
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 845683ca7c64..6eae772d6298 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -98,11 +98,11 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
>                         return gsi ? -ENXIO : 0;
>  
>                 this_gsi = parse_gsi(gicc);
> -               if (!this_gsi)
> -                       return gsi ? -ENXIO : 0;
> -
>                 this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
>                 if (!gsi) {
> +                       if (!this_gsi)
> +                               return 0;

Why do you need this hunk?

Will
