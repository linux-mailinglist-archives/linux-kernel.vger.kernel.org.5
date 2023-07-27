Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F367656A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjG0PBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjG0PBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A683590;
        Thu, 27 Jul 2023 08:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2792761EAF;
        Thu, 27 Jul 2023 15:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F260C433C7;
        Thu, 27 Jul 2023 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690470048;
        bh=xK7Ub5uts6ZqW0uNEPNO/65yJ7tQxvMALn4ycps0P1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISc2eBWEQIMT8jOdH/6ZNpiSIOp5EnIavPwuLBKP3PkSZ5bgHgCpmbMGNwFRjmFZN
         57lu8UIh27zwDX3CXMcEzpcoNo8ht3rEo0iaN0MuI76UnnC6WW5+RbIRnaXAKGhrT0
         xjQa4kx1MEEb5EycLHUgeZCmIoH2IL94f88TDatk28UKpU0Zx2S23r4C5zJ8f3kQAn
         SWE30j34fpO7k8T32ICBuMyZTk0hq1mL2pYMecR+vkQEe6T/gNP623CDbnGj27HQFx
         56+GpOS8rX11jG6/cMwKYjIK1ar+21Nw3KleZwqw4BgVRx1Qf3/rmtnmnNLqfoxrQG
         hImyC+hq/MOWQ==
Date:   Thu, 27 Jul 2023 16:00:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
Message-ID: <20230727150042.GC19940@willie-the-truck>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <ZMJzj2oe0B2Qp8vp@lpieralisi>
 <ZMJ4JnlVlqkO3E0P@arm.com>
 <ZMJ8jeLs69env0pL@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMJ8jeLs69env0pL@lpieralisi>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 04:17:49PM +0200, Lorenzo Pieralisi wrote:
> On Thu, Jul 27, 2023 at 02:59:02PM +0100, Catalin Marinas wrote:
> > On Thu, Jul 27, 2023 at 03:39:27PM +0200, Lorenzo Pieralisi wrote:
> > > On Mon, Jul 17, 2023 at 07:33:45PM +0800, Guanghui Feng wrote:
> > > > According to the ARM IORT specifications DEN 0049 issue E,
> > > > the "Number of IDs" field in the ID mapping format reports
> > > > the number of IDs in the mapping range minus one.
> > > > 
> > > > In iort_node_get_rmr_info(), we erroneously skip ID mappings
> > > > whose "Number of IDs" equal to 0, resulting in valid mapping
> > > > nodes with a single ID to map being skipped, which is wrong.
> > > > 
> > > > Fix iort_node_get_rmr_info() by removing the bogus id_count
> > > > check.
> > > > 
> > > > Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
> > > > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > > > ---
> > > >  drivers/acpi/arm64/iort.c | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > 
> > > Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > 
> > > Catalin/Will,
> > > 
> > > can you pick this up please ?
> > 
> > Would you like it merged in 6.5 or 6.6 is fine?
> 
> It is definitely a fix - I don't think that's super urgent
> though, bug has been there since v6.0 so the fix can probably
> wait to trickle back from v6.6.

On the flip side, it's a fix, Hanjun has tested it and we have a few
weeks in case we need to revert it.

So I'd be inclined to say Catalin should pick it up for 6.5, unless
there's a good reason to wait?

Will
