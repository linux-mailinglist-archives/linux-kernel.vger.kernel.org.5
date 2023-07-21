Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DCF75C74C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjGUNEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjGUNED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:04:03 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C91186;
        Fri, 21 Jul 2023 06:04:00 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qMpmy-0001ws-1J;
        Fri, 21 Jul 2023 13:03:20 +0000
Date:   Fri, 21 Jul 2023 14:03:08 +0100
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
Message-ID: <ZLqCDCTTx9GcLqDd@makrotopia.org>
References: <cover.1689802933.git.daniel@makrotopia.org>
 <e5b709e15739dc0563e9497a2dbbe63050381db0.1689802933.git.daniel@makrotopia.org>
 <ZLjci5bHzTI+/Kxs@infradead.org>
 <ZLlaOB1sb8wSd7Aq@makrotopia.org>
 <ZLomKmNe+EhpjI1K@infradead.org>
 <ZLpgs-aZVHCQooi0@makrotopia.org>
 <2023072128-shadow-system-1903@gregkh>
 <ZLpsQg3tDj2gEelv@makrotopia.org>
 <2023072106-partly-thank-8657@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072106-partly-thank-8657@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 01:39:18PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 21, 2023 at 12:30:10PM +0100, Daniel Golle wrote:
> > On Fri, Jul 21, 2023 at 01:11:40PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 21, 2023 at 11:40:51AM +0100, Daniel Golle wrote:
> > > > On Thu, Jul 20, 2023 at 11:31:06PM -0700, Christoph Hellwig wrote:
> > > > > On Thu, Jul 20, 2023 at 05:02:32PM +0100, Daniel Golle wrote:
> > > > > > On Thu, Jul 20, 2023 at 12:04:43AM -0700, Christoph Hellwig wrote:
> > > > > > > The layering here is exactly the wrong way around.  This block device
> > > > > > > as nvmem provide has not business sitting in the block layer and being
> > > > > > > keyed ff the gendisk registration.  Instead you should create a new
> > > > > > > nvmem backed that opens the block device as needed if it fits your
> > > > > > > OF description without any changes to the core block layer.
> > > > > > > 
> > > > > > 
> > > > > > Ok. I will use a class_interface instead.
> > > > > 
> > > > > I'm not sure a class_interface makes much sense here.  Why does the
> > > > > block layer even need to know about you using a device a nvmem provider?
> > > > 
> > > > It doesn't. But it has to notify the nvmem providing driver about the
> > > > addition of new block devices. This is what I'm using class_interface
> > > > for, simply to hook into .add_dev of the block_class.
> > > 
> > > Why is this single type of block device special to require this, yet all
> > > others do not?  Encoding this into the block layer feels like a huge
> > > layering violation to me, why not do it how all other block drivers do
> > > it instead?
> > 
> > I was thinkng of this as a generic solution in no way tied to one specific
> > type of block device. *Any* internal block device which can be used to
> > boot from should also be usable as NVMEM provider imho.
> 
> Define "internal" :)

Exactly, it could be anything, MMC, SATA, even USB. As long as there is
a device tree node associated with the device, it could be referenced
as an NVMEM provider. And that's what this series tries to implement.

> 
> And that's all up to the boot process in userspace, the kernel doesn't
> care about this.

So lets look at any random embedded Linux router or Wi-Fi AP:

Typically we got some kind of NAND or NOR flash memory with a
hard-coded partitioning dedicating different areas in the flash to be
used for the bootloader, bootloader environment, factory data (such as
MAC addresses and Wi-Fi EEPROMs), a linux kernel, a root filesystem and
some way to store user data.

And things are not that different when using an eMMC instead of NOR
flash, from the perspective of the OS the main difference is just that
the eMMC is larger and represented as a block device and typically
MBR or GPT partitioning is used.

> 
> > > > > As far as I can tell your provider should layer entirely above the
> > > > > block layer and not have to be integrated with it.
> > > > 
> > > > My approach using class_interface doesn't require any changes to be
> > > > made to existing block code. However, it does use block_class. If
> > > > you see any other good option to implement matching off and usage of
> > > > block devices by in-kernel users, please let me know.
> > > 
> > > Do not use block_class, again, that should only be for the block core to
> > > touch.  Individual block drivers should never be poking around in it.
> > 
> > Do I have any other options to coldplug and be notified about newly
> > added block devices, so the block-device-consuming driver can know
> > about them?
> 
> What other options do you need?

Either calls for adding/removing the NVMEM devices need to be added to
block/genhd.c and block/partitions/core.c, and if that's not acceptable
(see below), then we'd need something like register_mtd_user() would be
for MTD:
A way for a driver to cold-plug existing block devices and be notified
about newly added ones.

> 
> > This is not a rhetoric question, I've been looking for other ways
> > and haven't found anything better than class_find_device or
> > class_interface.
> 
> Never use that, sorry, that's not for a driver to touch.
> 
> > Using those also prevents blk-nvmem to be built as
> > a module, so I'd really like to find alternatives.
> > E.g. for MTD we got struct mtd_notifier and register_mtd_user().
> 
> Your storage/hardware driver should be the thing that "finds block
> devices" and registers them with the block class core, right?  After
> that, what matters?

Well, I'd say: Make the device available as NVMEM provider, as it could
be needed for e.g. the Ethernet driver to know the MAC address to be
used.

This is how it is done for MTD devices here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mtd/mtdcore.c#n723
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mtd/mtdcore.c#n804

... and then used for example here:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts#n227

The idea to use a class_interface at all is a result of the criticism
by Christoph Hellwig that the series requires changes to be made to the
block subsystem, ie. calls to register and unregister the NVMEM
provider.

Yet another way would obviously be to let the block-device-providing
driver (eg. drivers/mmc/core/block.c) register the NVMEM provider, but
that would then have to be re-implemented for every relevant block
driver which also seems wrong.
