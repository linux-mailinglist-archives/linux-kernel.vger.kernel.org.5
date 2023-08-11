Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41C7778C90
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjHKLAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjHKLAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA8910F5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E9F864A20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FA1C433C7;
        Fri, 11 Aug 2023 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691751641;
        bh=cEl3r7yAOwX5FZhvE8h8dANr7BWBZOnBqQkPPztJWWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7VIrpBJDV8YKFzsSTb1f7n2xn7z/xmYC64AOowEBRU556a/Nb+o2s8IUPWiUUKac
         wmr5yyTIOr6K4fWFlu7A7m7H8QuwjTElFtenW8itMf87UDgpqQeqBRuTmIJb4o4fn9
         8nWfEX0jLndE0t4RT2Vr8dZHXeeWqHE9pwSbQxU7wY1XWannD9i4PkB2lDOzI/b0+l
         a7S00IYScp3LBkpG0WEUZ0mBi9d5to96oArk4MsUYon1F6qidebn60n7Fe49nCd9LF
         kd2BgNpl9YRLT/faw/R+iITtAXHhF8LKRY3WNMQ7tKgXJxN4YX5lhayiKQhpfEMshU
         MGKhcNqz338Dw==
Date:   Fri, 11 Aug 2023 12:00:35 +0100
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
Message-ID: <20230811110035.GA6993@willie-the-truck>
References: <20230808082247.383405-1-anshuman.khandual@arm.com>
 <20230808082247.383405-2-anshuman.khandual@arm.com>
 <9d22520a-3450-0e75-59a2-035209f239e6@arm.com>
 <20230811101201.GA6827@willie-the-truck>
 <7920ce3b-15ee-c8d8-a7c0-59009620073c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7920ce3b-15ee-c8d8-a7c0-59009620073c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:55:43PM +0530, Anshuman Khandual wrote:
> 
> 
> On 8/11/23 15:42, Will Deacon wrote:
> > On Fri, Aug 11, 2023 at 02:13:42PM +0530, Anshuman Khandual wrote:
> >> On 8/8/23 13:52, Anshuman Khandual wrote:
> >>> +	/*
> >>> +	 * Sanity check all the GICC tables for the same interrupt
> >>> +	 * number. For now, only support homogeneous ACPI machines.
> >>> +	 */
> >>> +	for_each_possible_cpu(cpu) {
> >>> +		struct acpi_madt_generic_interrupt *gicc;
> >>> +
> >>> +		gicc = acpi_cpu_get_madt_gicc(cpu);
> >>> +		if (gicc->header.length < len)
> >>> +			return gsi ? -ENXIO : 0;
> >>> +
> >>> +		this_gsi = parse_gsi(gicc);
> >>> +		if (!this_gsi)
> >>> +			return gsi ? -ENXIO : 0;
> >>> +
> >>> +		this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
> >>> +		if (!gsi) {
> >>> +			hetid = this_hetid;
> >>> +			gsi = this_gsi;
> >>> +		} else if (hetid != this_hetid || gsi != this_gsi) {
> >>> +			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
> >>> +			return -ENXIO;
> >>> +		}
> >>> +	}
> >>
> >> As discussed on the previous version i.e V3 thread, will move the
> >> 'this_gsi' check after parse_gsi(), inside if (!gsi) conditional
> >> block. This will treat subsequent cpu parse_gsi()'s failure as a
> >> mismatch thus triggering the pr_warn() message.
> >>
> >> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> >> index 845683ca7c64..6eae772d6298 100644
> >> --- a/drivers/perf/arm_pmu_acpi.c
> >> +++ b/drivers/perf/arm_pmu_acpi.c
> >> @@ -98,11 +98,11 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
> >>                         return gsi ? -ENXIO : 0;
> >>  
> >>                 this_gsi = parse_gsi(gicc);
> >> -               if (!this_gsi)
> >> -                       return gsi ? -ENXIO : 0;
> >> -
> >>                 this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
> >>                 if (!gsi) {
> >> +                       if (!this_gsi)
> >> +                               return 0;
> > 
> > Why do you need this hunk?
> 
> Otherwise '0' gsi on all cpus would just clear the above homogeneity
> test, and end up in acpi_register_gsi() making it fail, but with the
> following warning before returning with -ENXIO.
> 
> irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
> if (irq < 0) {
> 	pr_warn("ACPI: %s Unable to register interrupt: %d\n", pdev->name, gsi);
> 	return -ENXIO;
> }

Ah gotcha, thanks.

> Is this behaviour better than returning 0 after detecting '0' gsi in
> the first cpu to avoid the above mentioned scenario ? Although 0 gsi
> followed by non-zero ones will still end up warning about a mismatch.

Can we move the check _after_ the loop, then? That way, we still detect
mismatches but we'll quietly return 0 if nobody has an interrupt.

Will
