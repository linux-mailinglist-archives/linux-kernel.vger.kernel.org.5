Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A03675C58B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGULL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGULLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:11:08 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F673586;
        Fri, 21 Jul 2023 04:10:28 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qMo0O-0001P2-1P;
        Fri, 21 Jul 2023 11:09:04 +0000
Date:   Fri, 21 Jul 2023 12:08:56 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Min Li <min15.li@samsung.com>,
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
Subject: Re: [RFC PATCH 0/6] nvmem: add block device NVMEM provider
Message-ID: <ZLpnSK8sfZnEkcgj@makrotopia.org>
References: <cover.1689802933.git.daniel@makrotopia.org>
 <ZLpCscTMc8h16Tyd@ovpn-8-26.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLpCscTMc8h16Tyd@ovpn-8-26.pek2.redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:32:49PM +0800, Ming Lei wrote:
> On Wed, Jul 19, 2023 at 11:01:14PM +0100, Daniel Golle wrote:
> > On embedded devices using an eMMC it is common that one or more (hw/sw)
> > partitions on the eMMC are used to store MAC addresses and Wi-Fi
> > calibration EEPROM data.
> > 
> > Implement an NVMEM provider backed by block devices as typically the
> > NVMEM framework is used to have kernel drivers read and use binary data
> > from EEPROMs, efuses, flash memory (MTD), ...
> > 
> > In order to be able to reference hardware partitions on an eMMC, add code
> > to bind each hardware partition to a specific firmware subnode.
> > 
> > This series is meant to open the discussion on how exactly the device tree
> > schema for block devices and partitions may look like, and even if using
> > the block layer to back the NVMEM device is at all the way to go -- to me
> > it seemed to be a good solution because it will be reuable e.g. for NVMe.
> 
> Just wondering why you don't use request_firmware() in drivers which consume
> the data, then the logic can be moved out of kernel, and you needn't to deal
> with device tree & block device.

The thing is: Why should the OS need to know about how to read
calibration to be fed into a wireless driver on a specific
hardware/firmware?

Or even worse: The MAC address of the main Ethernet interface? What if
for one of many possible reasons the extraction script in userland gets
broken and you would need to recover the system via SSH (because it's a
router or switch and doesn't even have any local console)?

Having information about the location of firmware artifacts be supplied
by the firmware (via device tree) seems to be the natural choice, and
also how it is done for devices booting off NOR or NAND flash by using
the NVMEM framework. Why should eMMC be the exception?

> 
> Or Android doesn't support udev and initrd?

Yes, sure, but then the OS ROM needs to know about and handle a lot of
very device-specific details in userland and if (unlike Android) the
same OS ROM should run on many devices that would mean it will have to
ship all of them in a huge initrd or root filesystem.

Also using userspace mechanics to acquire things as basic as a MAC
address seems overly complex and much more fragile than having the
firmware instruct the kernel via device tree to do so.

Hence, within the OpenWrt project, we've been working for years now to
push for Device Tree and lately for use of the NVMEM framework, exactly
to **reduce** the amount of hardware-specific knowledge in userland and
get rid of shell scripts acting as hotplug handlers for firmware
requests and such.
