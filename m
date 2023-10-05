Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28F27BA280
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjJEPjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjJEPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:38:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197FB59ACE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:54:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E463C433CB;
        Thu,  5 Oct 2023 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696517655;
        bh=BgEP5es9zeO064dvwEF9wU58m/4e+xe7DsWjQLlWi6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jt9GE9e/mtkG2Et8vx1/UjPdeJzi+syUGOOPaV+kooEL54cZQcxA44vHAtz3igd5h
         /VUOdJOzc5rWduV//h9Rn0ELG6rxwsFQOosGcnqEeLOBa1y0vp4oafnPtlLGK8Vl0B
         jmQNsEVXDsIZjhVs6b7GmWgd5/Wn7BeY6tchonJA=
Date:   Thu, 5 Oct 2023 16:54:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gupta, Nipun" <nipun.gupta@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, maz@kernel.org, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
Message-ID: <2023100531-stick-cupped-78f6@gregkh>
References: <20230911135259.14046-1-nipun.gupta@amd.com>
 <2023100531-matron-oversold-4a73@gregkh>
 <87wmw1p4g5.ffs@tglx>
 <2023100547-retool-chamomile-d581@gregkh>
 <51b6606a-fdc1-de11-2260-863ac08071fd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b6606a-fdc1-de11-2260-863ac08071fd@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 08:07:35PM +0530, Gupta, Nipun wrote:
> Hi Greg,
> 
> On 10/5/2023 7:30 PM, Greg KH wrote:
> > On Thu, Oct 05, 2023 at 03:46:34PM +0200, Thomas Gleixner wrote:
> > > On Thu, Oct 05 2023 at 12:24, Greg KH wrote:
> > > > > diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> > > > > index a08958485e31..86df7ccb76bb 100644
> > > > > --- a/drivers/cdx/Kconfig
> > > > > +++ b/drivers/cdx/Kconfig
> > > > > @@ -8,6 +8,7 @@
> > > > >   config CDX_BUS
> > > > >   	bool "CDX Bus driver"
> > > > >   	depends on OF && ARM64
> > > > > +	select GENERIC_MSI_IRQ_DOMAIN
> > > > 
> > > > This config option isn't in my tree anywhere, where did it come from?
> > > > What is it supposed to do?
> > > 
> > > 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN") :)
> > 
> > Ok, so this hasn't been tested since the 6.2 release?  Wow, I think
> > someone from AMD needs to take a deep look at this and verify that it
> > actually is doing what it is supposed to be doing...
> 
> The patch Thomas mentioned renames "GENERIC_MSI_IRQ_DOMAIN" to
> "GENERIC_MSI_IRQ"; and in our testing "GENERIC_MSI_IRQ" is also selected as
> 'ARM64' is enabled which enables 'ARM_GIC_V3_ITS' which in-turn selects
> 'GENERIC_MSI_IRQ'.

Ok, but that's not what this patch "selects" at all :(

> The patch is tested for MSI functionality on 6.6-rc1. We will re-look into
> the config dependencies to avoid such issues, but please be assured that the
> patch has been validated.

How has the dependancy been validated as correct if there is no such
thing in this kernel?

confused,

greg k-h
