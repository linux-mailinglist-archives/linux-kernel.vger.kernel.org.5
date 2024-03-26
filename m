Return-Path: <linux-kernel+bounces-119905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C457D88CEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46094B24E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD9143871;
	Tue, 26 Mar 2024 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4JFORtz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7A13D884;
	Tue, 26 Mar 2024 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484692; cv=none; b=ioiA0Pn5qYjYAatDa3k8rBebKMZGkEPNQh4Kx3AA3RYyzhFVuh55xRMjReRFY7sg5u5sIdW2ZqoQGC1Q8xV6wcU1eLq+lAFS9KhSpPDQBwJ839q120r/fIu6xGW4HvzX5V4b9KShZsOiqptu0pSAtWzMux6IIm3JQq6tpgTCfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484692; c=relaxed/simple;
	bh=XBx/8R7L2B6+rjNGoBxN/n8BedOCOXaomAypWF28x3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2dkW+Kw7ZYE2ENoBF9hLiKgtSlwlzY4NHm3GSLAdbvDQjmO3MFqa/3bhoegPyCKZWFt1XcYO5J9vvd/CvG6SPj9bcZ7FlDjlDGy1K0QKUWto6yBtfWXMpfwyqMP3nI1Pcy4/8OA0dRhsQ49FDb+gmDigDOx8D+PohNm/SIJVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4JFORtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B36FC433C7;
	Tue, 26 Mar 2024 20:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711484691;
	bh=XBx/8R7L2B6+rjNGoBxN/n8BedOCOXaomAypWF28x3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4JFORtzTY4+T0i9CTpyZ5n9Kzv7uBoHhdb2MFuQIi5GSJEHbCgPlIkln4YnP7rLt
	 DlplLsXo68oHda4f3DZgkPNp3kcXZeuS7zaxvF6nDthF3XESUYT6OmpOxXiiTq4oFz
	 8jyGdnq9XjjFNxONhHd8h701YNRDQnUCE21xRg0IE+77G0Gsk0SNrCYFpqW9UjswZh
	 1SNIF805YDoPnHCJsDAlRCEgRYeYageUpcultqZ566QjXKZkMCzAuO7ifkQ5AsXcBv
	 IW8rcj5oq2HGy0PNo4uK8ehBPPanY74TYpuZql52Rnx9C/rf/EqcOsSw9L8BleGEgg
	 qaP/o40frckkA==
Date: Tue, 26 Mar 2024 15:24:49 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/8] block: implement NVMEM provider
Message-ID: <20240326202449.GA3255378-robh@kernel.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
 <20240325151046.GA3591150-robh@kernel.org>
 <ZgGaay6bLFAcCo2E@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgGaay6bLFAcCo2E@makrotopia.org>

+boot-architecture list

On Mon, Mar 25, 2024 at 03:38:19PM +0000, Daniel Golle wrote:
> On Mon, Mar 25, 2024 at 10:10:46AM -0500, Rob Herring wrote:
> > On Thu, Mar 21, 2024 at 07:31:48PM +0000, Daniel Golle wrote:
> > > On embedded devices using an eMMC it is common that one or more (hw/sw)
> > > partitions on the eMMC are used to store MAC addresses and Wi-Fi
> > > calibration EEPROM data.
> > > 
> > > Implement an NVMEM provider backed by a block device as typically the
> > > NVMEM framework is used to have kernel drivers read and use binary data
> > > from EEPROMs, efuses, flash memory (MTD), ...
> > > 
> > > In order to be able to reference hardware partitions on an eMMC, add code
> > > to bind each hardware partition to a specific firmware subnode.
> > > 
> > > Overall, this enables uniform handling across practially all flash
> > > storage types used for this purpose (MTD, UBI, and now also MMC).
> > > 
> > > As part of this series it was necessary to define a device tree schema
> > > for block devices and partitions on them, which (similar to how it now
> > > works also for UBI volumes) can be matched by one or more properties.
> > > 
> > > ---
> > > This series has previously been submitted as RFC on July 19th 2023[1]
> > > and most of the basic idea did not change since. Another round of RFC
> > > was submitted on March 5th 2024[2] which has received overall positive
> > > feedback and only minor corrections have been done since (see
> > > changelog below).
> > 
> > I don't recall giving positive feedback.
> > 
> > I still think this should use offsets rather than partition specific 
> > information. Not wanting to have to update the offsets if they change is 
> > not reason enough to not use them.
> 
> Using raw offsets on the block device (rather than the partition)
> won't work for most existing devices and boot firmware out there. They
> always reference the partition, usually by the name of a GPT
> partition (but sometimes also PARTUUID or even PARTNO) which is then
> used in the exact same way as an MTD partition or UBI volume would be
> on devices with NOR or NAND flash.

MTD normally uses offsets hence why I'd like some alignment. UBI is 
special because raw NAND is, well, special.

> Just on eMMC we usually use a GPT
> or MBR partition table rather than defining partitions in DT or cmdline,
> which is rather rare (for historic reasons, I suppose, but it is what it
> is now).

Yes, I understand how eMMC works. I don't understand why if you have 
part #, uuid, or name you can't get to the offset or vice-versa. You 
need only 1 piece of identification to map partition table entries to DT 
nodes. Sure, offsets can change, but surely the firmware can handle 
adjusting the DT? 

An offset would also work for the case of random firmware data on the 
disk that may or may not have a partition associated with it. There are 
certainly cases of that. I don't think we have much of a solution for 
that other than trying to educate vendors to not do that or OS 
installers only supporting installing to something other than eMMC. This 
is something EBBR[1] is trying to address.

> Depending on the eMMC chip used, that partition may not even be at the
> same offset for different batches of the same device and hence I'd
> like to just do it in the same way vendor firmware does it as well.

Often vendor firmware is not a model to follow...

> Chad of Adtran has previously confirmed that [1], which was the
> positive feedback I was refering to. Other vendors like GL-iNet or
> Netgear are doing the exact same thing.
> 
> As of now, we support this in OpenWrt by adding a lot of
> board-specific knowledge to userland, which is ugly and also prevents
> using things like PXE-initiated nfsroot on those devices.
> 
> The purpose of this series is to be able to properly support such devices
> (ie. practially all consumer-grade routers out there using an eMMC for
> storing firmware).
> 
> Also, those devices have enough resources to run a general purpose
> distribution like Debian instead of OpenWrt, and all the userland
> hacks to set MAC addresses and extract WiFi-EEPROM-data in a
> board-specific ways will most certainly never find their way into
> Debian. It's just not how embedded Linux works, unless you are looking
> only at the RaspberryPi which got that data stored in a textfile
> which is shipped by the distribution -- something very weird and very
> different from literally all of-the-shelf routers, access-points or
> switches I have ever seen (and I've seen many). Maybe Felix who has
> seen even more of them can tell us more about that.

General purpose distros want to partition the disk themselves. Adding 
anything to the DT for disk partitions would require the installer to be 
aware of it. There's various distro folks on the boot-arch list, so 
maybe one of them can comment.

Rob

[1] https://arm-software.github.io/ebbr/index.html#document-chapter4-firmware-media

