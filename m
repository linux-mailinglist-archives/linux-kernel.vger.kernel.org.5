Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB85775B616
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjGTSEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGTSEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:04:45 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3152709;
        Thu, 20 Jul 2023 11:04:43 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qMY0H-0005Hr-29;
        Thu, 20 Jul 2023 18:03:53 +0000
Date:   Thu, 20 Jul 2023 19:03:37 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: Re: [RFC PATCH 0/6] nvmem: add block device NVMEM provider
Message-ID: <ZLl2-TW982oKXMnN@makrotopia.org>
References: <cover.1689802933.git.daniel@makrotopia.org>
 <352167df-34fc-ddff-def9-902873796536@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <352167df-34fc-ddff-def9-902873796536@acm.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 08:30:39AM -0700, Bart Van Assche wrote:
> On 7/19/23 15:01, Daniel Golle wrote:
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
> Is my understanding correct that these devices boot from eMMC and not over
> Wi-Fi?

Yes, that's right.

> If so, why does this calibration data have to be stored on a raw
> block device?

It's just how many vendors decided to implement it in their firmware.

I reckon this happened mostly out of habbit and in order to avoid any
potential complexities in their manufacturing and QA processes -- most
of those processes have been created in a time when NOR flash was the
most common way to store firmware on embedded devices with Wi-Fi.

The occurance of raw NAND and SPI-NAND didn't change much about that,
most vendors still just use a raw MTD partition to store all that
per-device 'factory' data. Very few have have started to use raw data
inside UBI volumes (and I've been working on a UBI NVMEM driver as
well).

Also when it comes to eMMC they just keep doing things how they were
always doing them, just that instead of a raw NOR flash, some devices
nowadays come with an eMMC. Some vendors use the 'boot1' hardware
partition to store things like MAC addresses at raw offsets there
(GL.iNet for example [1]), others use small GPT or MBR partitions on
the main hardware partition of the eMMC to store MAC addresses and
calibration blobs (for example Adtran [2]).

> Why can't this information be loaded from a file on a
> filesystem?

Having this information stored in a file on a filesystem is also an
option, of course, but out in the wild you will hardly find it being
done like that, for the reason stated above and also because having
the OS pull the Ethernet MAC addresses somewhere from a filesystem
while in early user-space will require the OS to even know about the
individual hardware and how this should be done, so it's not exactly
beautiful, may need fsck, mounting, ... all before the machine can
become available with it's assigned MAC address on Ethernet.

The RaspberryPi and other brcmfmac-based systems are the exception to
the rule, here a simple text file stored on the root filesystem serves
the Wi-Fi calibration. This file hence needs to be shipped with the OS
instead of being stored on the device, and e.g. Raspbian does so. I
suppose this is mostly because there just isn't any permanent on-board
storage large enough and being a low-barrier DYI system they wanted to
make it easy for users designing systems besed on that (as in: not
having to mess with raw offsets or partitions, but rather just use
tools like Etcher on Windows and edit CR-LF terminated text files on a
FAT filesystem inside notepad...).

However, practically all Qualcomm and MediaTek Wi-Fi AP/Routers which
come with an eMMC come with their MAC addresses and Wi-Fi EEPROM data
stored as raw data inside a hardware or software partition.

[1]: https://github.com/dangowrt/linux/commit/8a24f03efb6b1dd7d8fdf68558146bacc71c2c1b
[2]: https://github.com/dangowrt/linux/commit/b14c0215641047d0447956b40bd344049a11becb
