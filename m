Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E078770628
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjHDQjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjHDQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E0195
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 786B262046
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10847C433C7;
        Fri,  4 Aug 2023 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691167166;
        bh=dTYy+wslgCnW7iAMpRTLXyQJ6KWPx/kiIfpKfLbgNdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhfIyNLeaDElxuK0kO+ZzQqFnA2BFl0yRMf7axtfhHJgzNGlZ1n5RgXEyIDeTg0U+
         dJ9aHM5/hLz+qwl7K8dUHTMYE8bDLOoHgrkPY3mX7o3jzIny0eARnqRXTaRDoTI3ui
         /NCsjQ6svpSf0GIXZsIgxLmzC9+HQDsc75k7yr5jqsJVNXiiWYNg1+KKC3kVZI4ivp
         gJeGrPkKL+IuJ4FDzfQX3mxCskl9eS1Ngz2ldsxzc2qxUOHCoyaOQgDmFMpzo45vm0
         yCEIQ86ihN3yicPTZhXycMfitJsUBE8ud11HyvKGmfd51Cs/ZAIgNM0997pqcUDMVh
         zEFh3o+aiP8QQ==
Date:   Fri, 4 Aug 2023 17:39:21 +0100
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
Message-ID: <20230804163921.GE30679@willie-the-truck>
References: <20230803055652.1322801-1-anshuman.khandual@arm.com>
 <20230803055652.1322801-2-anshuman.khandual@arm.com>
 <89058c7c-1fed-60ea-7233-04187772a931@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89058c7c-1fed-60ea-7233-04187772a931@arm.com>
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

On Thu, Aug 03, 2023 at 11:43:27AM +0530, Anshuman Khandual wrote:
> 
> 
> On 8/3/23 11:26, Anshuman Khandual wrote:
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
> 
> Hello Will,
> 
> Moved parse_gsi() return code checking to its original place just to
> make it similar in semantics to existing 'gicc->header.length check'.
> If 'gsi' is valid i.e atleast a single cpu has been probed, return
> -ENXIO indicating mismatch, otherwise just return 0.

Wouldn't that still be the case without the check in this hunk? We'd run
into the homogeneous check and return -ENXIO from there, no?

Will
