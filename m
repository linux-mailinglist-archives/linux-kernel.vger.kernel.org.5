Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C60D7FA6BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjK0Qqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjK0Qqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:46:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BDF1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:46:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E395C433C9;
        Mon, 27 Nov 2023 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701103605;
        bh=n0YJy9MtG9wS5bcesamH5c9LR2unSin2xWzNq/0Yo4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BEMiwoqnqPHfKIey/prxi1QaKY8T63v3GV4yMmaOKw6+Ow9Fp5n4NcB89LKyYsZiO
         RS7uZjnGEngBxUWC9Lknj0vzG6clJFRSuiMj5R73QjJpDUqboTUCZtTjTORPDveakD
         YIP7Jy7HjqCjysVz80BBbrg74/JnBEJMMV/KjAeFyX3BbT3NClyXtZh0iaDeo0QUFs
         mJcuVnVvXgzY+EAx05oT9hppzbF/yD+igPNvt/eGYP9bxjRDnUboB6aR4YE3IgVSEJ
         DAZlYzPHtxizr5CwGr01yCY3hPMJeoH8AQGGmx3AmKkmidck9gMV7CvzMh0jCrm3H7
         0p2jueQpkajxQ==
Date:   Mon, 27 Nov 2023 09:46:43 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
 <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
 <20231127155649.GA1403@lst.de>
 <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
 <20231127163333.GA2273@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127163333.GA2273@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 05:33:33PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 09:30:14AM -0700, Keith Busch wrote:
> > > > Should this even be an nvme specific attribute? I thought we should have
> > > > blk-integrity.c report its 'tuple_size' attribute instead. That should
> > > > work as long as we're not dealing with extended metadata at least, but
> > > > that's kind of a special format that doesn't have block layer support.
> > > 
> > > Reporting the tuple size is a good idea.  But is that enough for
> > > the existing nvme-cli use case?
> > 
> > nvme-cli currently queries with admin passthrough identify command, so
> > adding a new attribute won't break that. I assume Daniel would have it
> > fallback to that same command for backward compatibilty if a desired
> > sysfs attribute doesn't exist.
> 
> Yes.  But does it care about the tuple size, or the actual size of the
> metadata field even if is bigger than the PI tuple?

tuple_size is the same value as metadata size regardless of PI usage.
See nvme_init_integrity() for how this driver sets it:

	integrity.tuple_size = ns->ms;
