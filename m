Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA55773E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjHHQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjHHQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0311F66
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 171ED62513
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2F9C433C7;
        Tue,  8 Aug 2023 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691500923;
        bh=NF5G/R0NqeQHYbKyCLsFwN904Kw6X0MLSj8fCMzbh/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePBIfcRi49VfeipofeouYVyEl0jnR3i6+3DlVYQJBGrzqdfkftJoXoUQEYx60e+KC
         xtvQE3P8fS8ZDhvRL3+IIlA56I4P2pKWBKY209TFAUFwLKFsgjU5edqPOg4tI92/hj
         tojQ5/H3sKxUYEbkxiVzCchvcaDgBInIozEC1FWVajBOQwQXstV99UYKbQcZDoYwdo
         HstWS30mqU60qO8QhDxrrMC6CI72+99JOC/YPnstBNw3oX+XcG+X+HHovX8Fupyx2G
         VsgaNYbR+3OeRCP010Oxn1wdDXrHv1slKnMXXQLOUL2P9DCf7GCIzPLFm2sGVL4ssw
         r9SqbgCDGIdPA==
Date:   Tue, 8 Aug 2023 14:21:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/4] arm_pmu: acpi: Refactor
 arm_spe_acpi_register_device()
Message-ID: <20230808132157.GB2369@willie-the-truck>
References: <20230803055652.1322801-1-anshuman.khandual@arm.com>
 <20230803055652.1322801-2-anshuman.khandual@arm.com>
 <89058c7c-1fed-60ea-7233-04187772a931@arm.com>
 <20230804163921.GE30679@willie-the-truck>
 <9b630f76-2f9e-fc42-012e-403f4b8c1dee@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b630f76-2f9e-fc42-012e-403f4b8c1dee@arm.com>
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

On Mon, Aug 07, 2023 at 11:03:40AM +0530, Anshuman Khandual wrote:
> On 8/4/23 22:09, Will Deacon wrote:
> > On Thu, Aug 03, 2023 at 11:43:27AM +0530, Anshuman Khandual wrote:
> >> On 8/3/23 11:26, Anshuman Khandual wrote:
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
> >>
> >> Moved parse_gsi() return code checking to its original place just to
> >> make it similar in semantics to existing 'gicc->header.length check'.
> >> If 'gsi' is valid i.e atleast a single cpu has been probed, return
> >> -ENXIO indicating mismatch, otherwise just return 0.
> > 
> > Wouldn't that still be the case without the check in this hunk? We'd run
> > into the homogeneous check and return -ENXIO from there, no?
> Although the return code will be the same i.e -ENXIO, but not for the same reason.
> 
> 		this_gsi = parse_gsi(gicc);
> 		if (!this_gsi)
> 			return gsi ? -ENXIO : 0;
> 
> This returns 0 when IRQ could not be parsed for the first cpu, but returns -ENXIO
> for subsequent cpus. Although return code -ENXIO here still indicates IRQ parsing
> to have failed.
> 
> 		} else if (hetid != this_hetid || gsi != this_gsi) {
> 			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
> 			return -ENXIO;
> 		} 
> 
> This returns -ENXIO when there is a IRQ mismatch. But if the above check is not
> there, -ENXIO return code here could not be classified into IRQ parse problem or
> mismatch without looking into the IRQ value.

Sorry, but I don't understand your point here. If any of this fails, there's
going to be some debugging needed to look at the ACPI tables; the only
difference with my suggestion is that you'll get a message indicating that
the devices aren't homogeneous, which I think is helpful.

Will
