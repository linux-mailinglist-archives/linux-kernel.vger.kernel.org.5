Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0007A83DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbjITNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjITNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:50:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34E6D6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:50:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B44C433C8;
        Wed, 20 Sep 2023 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217804;
        bh=6LBg8rWGE6wunIHc9/YosolnqJC3Zt1oTMggO9I04Dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMiYqqgpYqYGc1Jjs6rEQMdzmL7iB+V+aupac4b8lBBC4V0gMI4RuAtXJd0gyChfn
         X+8XLj+ZK0aDfrB80REhuwgjbCfQqezAm9BK2G+zNMdsQSVS0JZpGcyeOhaAk9W5zW
         Djy507/y969w7S76BcPubuwqCcK06//Amj/7wsKrNdK2wFIqu4dE/vUdwzQS4xtlUO
         Ea6EPNPyDkFRISXHgTdhoizH2SLeJKIdi7L4QEBW6kWvkv7zgT9h4LByjcaL0FYH15
         KqgwHPA2DcF5t4SI5sOmKyEfluZkr1/ialnre7ozIwdsdmSY+CXl7ftpE+AEPPFf/W
         5qJHjRSwBFW2w==
Date:   Wed, 20 Sep 2023 15:50:01 +0200
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        rdunlap@infradead.org
Subject: Re: [PATCH] soundwire: bus: Make IRQ handling conditionally built
Message-ID: <ZQr4iYRmDppFJS0w@matsya>
References: <20230918161026.472405-1-ckeepax@opensource.cirrus.com>
 <ZQqZqalGdqy86qdD@matsya>
 <20230920085133.GE103419@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920085133.GE103419@ediswmail.ad.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-23, 08:51, Charles Keepax wrote:
> On Wed, Sep 20, 2023 at 09:05:13AM +0200, Vinod Koul wrote:
> > On 18-09-23, 17:10, Charles Keepax wrote:
> > > SoundWire has provisions for a simple callback for the IRQ handling so
> > > has no hard dependency on IRQ_DOMAIN, but the recent addition of IRQ
> > > handling was causing builds without IRQ_DOMAIN to fail. Resolve this by
> > > moving the IRQ handling into its own file and only add it to the build
> > > when IRQ_DOMAIN is included in the kernel.
> > > 
> > > Fixes: 12a95123bfe1 ("soundwire: bus: Allow SoundWire peripherals to register IRQ handlers")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202309150522.MoKeF4jx-lkp@intel.com/
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >  drivers/soundwire/Makefile   |  4 +++
> > >  drivers/soundwire/bus.c      | 31 +++----------------
> > >  drivers/soundwire/bus_type.c | 11 +++----
> > >  drivers/soundwire/irq.c      | 59 ++++++++++++++++++++++++++++++++++++
> > >  drivers/soundwire/irq.h      | 43 ++++++++++++++++++++++++++
> > >  5 files changed, 115 insertions(+), 33 deletions(-)
> > >  create mode 100644 drivers/soundwire/irq.c
> > >  create mode 100644 drivers/soundwire/irq.h
> > > 
> > > diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> > > index c3d3ab3262d3a..657f5888a77b0 100644
> > > --- a/drivers/soundwire/Makefile
> > > +++ b/drivers/soundwire/Makefile
> > > @@ -15,6 +15,10 @@ ifdef CONFIG_DEBUG_FS
> > >  soundwire-bus-y += debugfs.o
> > >  endif
> > >  
> > > +ifdef CONFIG_IRQ_DOMAIN
> > > +soundwire-bus-y += irq.o
> > > +endif
> > 
> > Any reason why we cant use depends for this?
> > 
> 
> No reason we can't, but my thinking was really that SoundWire doesn't
> really have a dependency on IRQ_DOMAIN, as you can use the original
> callback mechanism. It seemed a shame to force it as a dependency,
> when the whole subsystem can function happily without it.
> 
> That said, I am happy to switch to a simple dependency if you prefer?
> It would certainly be a much simpler change.

That is very valid point, not every user needs it... I guess lets go
with this change now, can you fix the comment style and we can merge
this

-- 
~Vinod
