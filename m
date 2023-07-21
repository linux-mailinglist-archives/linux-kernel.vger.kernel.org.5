Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC90775C5E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGULbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGULbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:31:02 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B92E0;
        Fri, 21 Jul 2023 04:31:01 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qMoKx-0001XQ-0A;
        Fri, 21 Jul 2023 11:30:19 +0000
Date:   Fri, 21 Jul 2023 12:30:10 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] block: implement NVMEM provider
Message-ID: <ZLpsQg3tDj2gEelv@makrotopia.org>
References: <cover.1689802933.git.daniel@makrotopia.org>
 <e5b709e15739dc0563e9497a2dbbe63050381db0.1689802933.git.daniel@makrotopia.org>
 <ZLjci5bHzTI+/Kxs@infradead.org>
 <ZLlaOB1sb8wSd7Aq@makrotopia.org>
 <ZLomKmNe+EhpjI1K@infradead.org>
 <ZLpgs-aZVHCQooi0@makrotopia.org>
 <2023072128-shadow-system-1903@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072128-shadow-system-1903@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 01:11:40PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 21, 2023 at 11:40:51AM +0100, Daniel Golle wrote:
> > On Thu, Jul 20, 2023 at 11:31:06PM -0700, Christoph Hellwig wrote:
> > > On Thu, Jul 20, 2023 at 05:02:32PM +0100, Daniel Golle wrote:
> > > > On Thu, Jul 20, 2023 at 12:04:43AM -0700, Christoph Hellwig wrote:
> > > > > The layering here is exactly the wrong way around.  This block device
> > > > > as nvmem provide has not business sitting in the block layer and being
> > > > > keyed ff the gendisk registration.  Instead you should create a new
> > > > > nvmem backed that opens the block device as needed if it fits your
> > > > > OF description without any changes to the core block layer.
> > > > > 
> > > > 
> > > > Ok. I will use a class_interface instead.
> > > 
> > > I'm not sure a class_interface makes much sense here.  Why does the
> > > block layer even need to know about you using a device a nvmem provider?
> > 
> > It doesn't. But it has to notify the nvmem providing driver about the
> > addition of new block devices. This is what I'm using class_interface
> > for, simply to hook into .add_dev of the block_class.
> 
> Why is this single type of block device special to require this, yet all
> others do not?  Encoding this into the block layer feels like a huge
> layering violation to me, why not do it how all other block drivers do
> it instead?

I was thinkng of this as a generic solution in no way tied to one specific
type of block device. *Any* internal block device which can be used to
boot from should also be usable as NVMEM provider imho.
Just like all MTD devices also act as NVMEM providers (just in case of
block devices I'd make that opt-in via device tree).

> 
> > > As far as I can tell your provider should layer entirely above the
> > > block layer and not have to be integrated with it.
> > 
> > My approach using class_interface doesn't require any changes to be
> > made to existing block code. However, it does use block_class. If
> > you see any other good option to implement matching off and usage of
> > block devices by in-kernel users, please let me know.
> 
> Do not use block_class, again, that should only be for the block core to
> touch.  Individual block drivers should never be poking around in it.

Do I have any other options to coldplug and be notified about newly
added block devices, so the block-device-consuming driver can know
about them?
This is not a rhetoric question, I've been looking for other ways
and haven't found anything better than class_find_device or
class_interface. Using those also prevents blk-nvmem to be built as
a module, so I'd really like to find alternatives.
E.g. for MTD we got struct mtd_notifier and register_mtd_user().
