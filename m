Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E948B7735A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHHBDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHHBDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:03:42 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF7A9E;
        Mon,  7 Aug 2023 18:03:37 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qTB7X-0002x3-0M;
        Tue, 08 Aug 2023 01:02:47 +0000
Date:   Tue, 8 Aug 2023 02:02:36 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 2/6] mmc: block: set fwnode of disk devices
Message-ID: <ZNGULFxXpLT7zn35@makrotopia.org>
References: <cover.1689802933.git.daniel@makrotopia.org>
 <1ce5f56df546cec25ef741f381286f1d7c33d000.1689802933.git.daniel@makrotopia.org>
 <CAPDyKFqhZtCHVmCNnm_Qm7X+=GtJY8uNJOWOgZXuTTVEw0msNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqhZtCHVmCNnm_Qm7X+=GtJY8uNJOWOgZXuTTVEw0msNA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

thank you for reviewing and suggesting ways to improve this series!

On Mon, Aug 07, 2023 at 03:48:31PM +0200, Ulf Hansson wrote:
> On Thu, 20 Jul 2023 at 00:02, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > Set fwnode of disk devices to 'block', 'boot0' and 'boot1' subnodes of
> > the mmc-card. This is done in preparation for having the eMMC act as
> > NVMEM provider.
> 
> Sorry, but I don't quite understand what you are trying to do here.
> Maybe you should re-order the patches in the series so it becomes
> clear why this is needed?
> 
> Moreover, I don't see any DT docs being updated as a part of the
> series, which looks like it is needed too. That would also help to
> understand what you are proposing, I think.

I've prepared a tree on Github which now also includes commits adding
dt-bindings for block devices and partitions, so they can be referenced
as nvmem-cells provider.

The dt-schema addition supposedly explaining this specific patch:

https://github.com/dangowrt/linux/commit/b399a758f0e1c444ae9443dc80902a30de54af09

The whole tree:

https://github.com/dangowrt/linux/commits/for-nvmem-next

Most comments have been addressed, however, I still depend on using
either a class_interface *or* adding calls to add/remove the NVMEM
representation of a block device to block/genhd.c as well as
block/partitions/core.c, simply because afaik there isn't any better
way for in-kernel users of block devices to be notified about the
creation or removal of a block device.

Cheers


Daniel

> 
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/mmc/core/block.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index f701efb1fa785..fc1a9f31bd253 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -2413,6 +2413,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
> >                                               int area_type,
> >                                               unsigned int part_type)
> >  {
> > +       struct fwnode_handle *fwnode;
> > +       struct device *ddev;
> >         struct mmc_blk_data *md;
> >         int devidx, ret;
> >         char cap_str[10];
> > @@ -2509,6 +2511,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
> >
> >         blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
> >
> > +       ddev = disk_to_dev(md->disk);
> > +       fwnode = device_get_named_child_node(subname ? md->parent->parent :
> > +                                                      md->parent,
> > +                                            subname ? subname : "block");
> > +       ddev->fwnode = fwnode;
> > +
> >         string_get_size((u64)size, 512, STRING_UNITS_2,
> >                         cap_str, sizeof(cap_str));
> >         pr_info("%s: %s %s %s%s\n",
> 
> Kind regards
> Uffe
