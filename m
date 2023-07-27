Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0212765702
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjG0PIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjG0PIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B493A9B;
        Thu, 27 Jul 2023 08:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8253161EB4;
        Thu, 27 Jul 2023 15:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1BBC433C9;
        Thu, 27 Jul 2023 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690470505;
        bh=K2GcWqcSjYTfOkV2WI65gqtpuyMcHLeQlsbh9kooW5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GApGL/agaLDFgR3uFnVPlCEXmWpSvHrtRRYgCyM7lVTpP4wRhNJGcaSSPecd+F7fs
         XxtxC8rXhPnnx1Hj5FPXFK6JbvipJ3HgQcyzQNMuSVceeOUTi8XvX372mnXTMvzpXe
         6V8Ev1CeOQCovfCPFaVY5cGIWqpV99vPOS6q2uqxrERm9GivzYil6zH03Mw0bvCsJC
         Xta4Q+UCGy7sYnICUBpsSIScwPrwfJSn5ZveEugRxmWqh17KXPFvdYkZpuufSaMwqK
         3oJ0ds1NEuVMr3xDs+AsXHCpQqZGlqVx9D6f7dygPuWKOKfXuKdiGTf7lK3RgXdcQN
         xrTk5q2dMp7Aw==
Date:   Thu, 27 Jul 2023 17:08:20 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
Message-ID: <ZMKIZMfmBMHG0IOz@lpieralisi>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <ZMJzj2oe0B2Qp8vp@lpieralisi>
 <ZMJ4JnlVlqkO3E0P@arm.com>
 <ZMJ8jeLs69env0pL@lpieralisi>
 <20230727150042.GC19940@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727150042.GC19940@willie-the-truck>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 04:00:43PM +0100, Will Deacon wrote:
> On Thu, Jul 27, 2023 at 04:17:49PM +0200, Lorenzo Pieralisi wrote:
> > On Thu, Jul 27, 2023 at 02:59:02PM +0100, Catalin Marinas wrote:
> > > On Thu, Jul 27, 2023 at 03:39:27PM +0200, Lorenzo Pieralisi wrote:
> > > > On Mon, Jul 17, 2023 at 07:33:45PM +0800, Guanghui Feng wrote:
> > > > > According to the ARM IORT specifications DEN 0049 issue E,
> > > > > the "Number of IDs" field in the ID mapping format reports
> > > > > the number of IDs in the mapping range minus one.
> > > > > 
> > > > > In iort_node_get_rmr_info(), we erroneously skip ID mappings
> > > > > whose "Number of IDs" equal to 0, resulting in valid mapping
> > > > > nodes with a single ID to map being skipped, which is wrong.
> > > > > 
> > > > > Fix iort_node_get_rmr_info() by removing the bogus id_count
> > > > > check.
> > > > > 
> > > > > Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
> > > > > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/acpi/arm64/iort.c | 3 ---
> > > > >  1 file changed, 3 deletions(-)
> > > > 
> > > > Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > > 
> > > > Catalin/Will,
> > > > 
> > > > can you pick this up please ?
> > > 
> > > Would you like it merged in 6.5 or 6.6 is fine?
> > 
> > It is definitely a fix - I don't think that's super urgent
> > though, bug has been there since v6.0 so the fix can probably
> > wait to trickle back from v6.6.
> 
> On the flip side, it's a fix, Hanjun has tested it and we have a few
> weeks in case we need to revert it.
> 
> So I'd be inclined to say Catalin should pick it up for 6.5, unless
> there's a good reason to wait?

No reason to wait - I just wanted to make clear it is not urgent,
if it is possible it makes sense for it to get into v6.5.

Thanks,
Lorenzo
