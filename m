Return-Path: <linux-kernel+bounces-140642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8560C8A172D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FDFB2C5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680814EC49;
	Thu, 11 Apr 2024 14:26:59 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DB22096;
	Thu, 11 Apr 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845618; cv=none; b=BiZ+4oFO8baQxnNIyif7JOv4LwX7MbEHmdEC8PuZCpCXk3zqgFsWd7eFM14XUgyohnsevYOgcp60Go4AwEyTSmBlJLClEz9A0ABakdfF0Lot3ySXefvPJtiABCWA0yYpAmsWOTPkn8TodXIVi9bzob8Q26aHKZFd+ERACcFieGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845618; c=relaxed/simple;
	bh=SJssxiRpIa7EWmwqifhF1CvwSu8SPB3L7xZjE3ZKre8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIK8aG1Vct84Qebd/x+eSy6UdShiEMq0XAqcimAkwu1ITvrQG+zzRW2T6zy3QxFTFpAurcs5PMaEIVtGQCRYdRMETEby/WgtLyuIMmLdInNdE+JPhbzOph8ASebZWY7ZalyC2jO8uwQCCXPS14bYhoxVJQwAjkFmMhPKJHupb5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id DE3CB520347;
	Thu, 11 Apr 2024 16:26:45 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Thu, 11 Apr
 2024 16:26:45 +0200
Date: Thu, 11 Apr 2024 16:26:37 +0200
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Ferry Toth <fntoth@gmail.com>, Hardik Gajjar <hgajjar@de.adit-jv.com>,
	<gregkh@linuxfoundation.org>, <s.hauer@pengutronix.de>,
	<jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <quic_linyyuan@quicinc.com>,
	<paul@crapouillou.net>, <quic_eserrao@quicinc.com>, <erosca@de.adit-jv.com>
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
Message-ID: <20240411142637.GA110162@vmlxhi-118.adit-jv.com>
References: <20231006153808.9758-1-hgajjar@de.adit-jv.com>
 <20231006155646.12938-1-hgajjar@de.adit-jv.com>
 <ZaQS5x-XK08Jre6I@smile.fi.intel.com>
 <20240115132720.GA98840@vmlxhi-118.adit-jv.com>
 <f25283fc-4550-4725-960b-2ea783fd62e1@gmail.com>
 <aeee83d8-dee3-42ed-b705-988b17800721@gmail.com>
 <20240405113855.GA121923@vmlxhi-118.adit-jv.com>
 <321e908e-0d10-4e36-8dc4-6997c73fe2eb@gmail.com>
 <ZhbOZsp-XHemVhQz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhbOZsp-XHemVhQz@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko wrote:
> On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
> > Op 05-04-2024 om 13:38 schreef Hardik Gajjar:
> > > On Wed, Apr 03, 2024 at 11:01:58PM +0200, Ferry Toth wrote:
> > > > Op 15-01-2024 om 21:10 schreef Ferry Toth:
> > > > > Op 15-01-2024 om 14:27 schreef Hardik Gajjar:
> > > > > > On Sun, Jan 14, 2024 at 06:59:19PM +0200, Andy Shevchenko wrote:
> > > > > > > On Fri, Oct 06, 2023 at 05:56:46PM +0200, Hardik Gajjar wrote:
> > > > > > > > This patch replaces the usage of netif_stop_queue with
> > > > > > > > netif_device_detach
> > > > > > > > in the u_ether driver. The netif_device_detach function not
> > > > > > > > only stops all
> > > > > > > > tx queues by calling netif_tx_stop_all_queues but also marks
> > > > > > > > the device as
> > > > > > > > removed by clearing the __LINK_STATE_PRESENT bit.
> > > > > > > > 
> > > > > > > > This change helps notify user space about the disconnection
> > > > > > > > of the device
> > > > > > > > more effectively, compared to netif_stop_queue, which only
> > > > > > > > stops a single
> > > > > > > > transmit queue.
> > > > > > > This change effectively broke my USB ether setup.
> > > > > > > 
> > > > > > > git bisect start
> > > > > > > # status: waiting for both good and bad commits
> > > > > > > # good: [1f24458a1071f006e3f7449c08ae0f12af493923] Merge tag
> > > > > > > 'tty-6.7-rc1' of
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> > > > > > > git bisect good 1f24458a1071f006e3f7449c08ae0f12af493923
> > > > > > > # status: waiting for bad commit, 1 good commit known
> > > > > > > # bad: [2c40c1c6adab90ee4660caf03722b3a3ec67767b] Merge tag
> > > > > > > 'usb-6.7-rc1' of
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> > > > > > > git bisect bad 2c40c1c6adab90ee4660caf03722b3a3ec67767b
> > > > > > > # bad: [17d6b82d2d6d467149874b883cdba844844b996d] usb/usbip: fix
> > > > > > > wrong data added to platform device
> > > > > > > git bisect bad 17d6b82d2d6d467149874b883cdba844844b996d
> > > > > > > # good: [ba6b83a910b6d8a9379bda55cbf06cb945473a96] usb:
> > > > > > > xhci-mtk: add a bandwidth budget table
> > > > > > > git bisect good ba6b83a910b6d8a9379bda55cbf06cb945473a96
> > > > > > > # good: [dddc00f255415b826190cfbaa5d6dbc87cd9ded1] Revert "usb:
> > > > > > > gadget: uvc: cleanup request when not in correct state"
> > > > > > > git bisect good dddc00f255415b826190cfbaa5d6dbc87cd9ded1
> > > > > > > # bad: [8f999ce60ea3d47886b042ef1f22bb184b6e9c59] USB: typec:
> > > > > > > tps6598x: Refactor tps6598x port registration
> > > > > > > git bisect bad 8f999ce60ea3d47886b042ef1f22bb184b6e9c59
> > > > > > > # bad: [f49449fbc21e7e9550a5203902d69c8ae7dfd918] usb: gadget:
> > > > > > > u_ether: Replace netif_stop_queue with netif_device_detach
> > > > > > > git bisect bad f49449fbc21e7e9550a5203902d69c8ae7dfd918
> > > > > > > # good: [97475763484245916735a1aa9a3310a01d46b008] USB: usbip:
> > > > > > > fix stub_dev hub disconnect
> > > > > > > git bisect good 97475763484245916735a1aa9a3310a01d46b008
> > > > > > > # good: [0f5aa1b01263b8b621bc4f031a1f2983ef8517b7] usb: usbtest:
> > > > > > > fix a type promotion bug
> > > > > > > git bisect good 0f5aa1b01263b8b621bc4f031a1f2983ef8517b7
> > > > > > > # first bad commit: [f49449fbc21e7e9550a5203902d69c8ae7dfd918]
> > > > > > > usb: gadget: u_ether: Replace netif_stop_queue with
> > > > > > > netif_device_detach
> > > > > > > 
> > > > > > > Note, revert indeed helps. Should I send a revert?
> > > > > > > 
> > > > > > > I use configfs to setup USB EEM function and it worked till this
> > > > > > > commit.
> > > > > > > If needed, I can share my scripts, but I believe it's not needed
> > > > > > > as here
> > > > > > > we see a clear regression.
> > > > > > > 
> > > > > > Without this patch, there may be a potential crash in a race
> > > > > > condition, as __LINK_STATE_PRESENT is monitored at many places in
> > > > > > the Network stack to determine the status of the link.
> > > > > > 
> > > > > > Could you please provide details on how this patch affects your
> > > > > > functionality? Are you experiencing connection problems or data
> > > > > > transfer interruptions?
> > > > > In my case on mrfld (Intel Edison Arduino) using configfs with this
> > > > > patch no config from host through dhcp is received. Manual setting
> > > > > correct ipv4 addr / mask / gw still no connection.
> > > > > 
> > > > > > Instead of reverting this patch, consider trying the upcoming patch
> > > > > > (soon to be available in the mainline) to see if it resolves your
> > > > > > issue.
> > > > > > 
> > > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_lkml_2023122900-2Dcommence-2Dagenda-2Ddb2c-40gregkh_T_-23m36a812d3f1e5d744ee32381f6ae4185940b376de&d=DwICaQ&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=4g6EtvkKKfp8YYHpU196b2HzQxCMgsAhuo8pFng3X4TCWdcOVEUCug2-l2hRfLyV&s=t82wZAFwm2FTSaacgsmSpZWvWEa89jN8GX-okIJrwFw&e=
> > > > > > 
> > > > > This patch works for me with v6.7.0.
> > > > I need to revisit this. The patch in this topic landed in v6.7.0-rc1
> > > > (f49449fbc21e) and breaks the gadget mrfld (Intel Edison Arduino) and other
> > > > platforms as well.
> > > > 
> > > > The mentioned fix "usb: gadget: u_ether: Re-attach netif device to mirror
> > > > detachment*" * has landed in v6.8.0-rc1 (76c945730). What it does fix: I am
> > > > able to make a USB EEM function again.
> > > > 
> > > > However, now a hidden issue appears. With mrfld there is an external switch
> > > > to easily switch between host and device mode.
> > > > 
> > > > What is not fixed:
> > > > 
> > > > - when in device mode and unplugging/plugging the cable when using `ifconfig
> > > > usb0` the line "usb0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>" changes to
> > > > "usb0: flags=4099<UP,BROADCAST,MULTICAST>" as is supposed to, the route
> > > > table is updated and the dir `/sys/class/net/usb0` exists and in the dir
> > > > `cat carrier*` shows the carrier up and down counts. This is the expected
> > > > behavior.
> > > > 
> > > > - when in device mode and switching to host mode `ifconfig usb0` continues
> > > > to show "RUNNING", the route table is not modified and the dir
> > > > `/sys/class/net/usb0` no longer exists.
> > > > 
> > > > - switching to device mode again, USB EEM works fine, no changes to RUNNING
> > > > or the route table happen and the dir `/sys/class/net/usb0` still is non-
> > > > existing.
> > > > 
> > > > - unplugging/plugging the cable in device mode after this does not restore
> > > > the original situation.
> > > > 
> > > > This behavior I tested on v6.9.0-rc2 (with a few unrelated but essential
> > > > patches on top) and bisected back to this patch in v6.70-rc1.
> > > > 
> > > > It seems `netif_device_detach` does not completely clean up as expected and
> > > > `netif_device_attach` does not completely rebuild.
> > > > 
> > > > I am wondering if on other platforms this can be reproduced? If so, inho it
> > > > would be best to revert the both patches until the issue is resolved.
> > > > 
> > > > Thanks,
> > > > 
> > > > Ferry
> > > I'm wondering why the /sys/class/net/usb0 directory is being removed when the network interface is still available.
> > > This behavior seems not correct.
> > 
> > Exactly. And this didn't happen before the 2 patches.
> > 
> > To be precise: /sys/class/net/usb0 is not removed and it is a link, the link
> > target /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0 no
> > longer exists

So, it means that the /sys/class/net/usb0 is present, but the symlink is broken. In that case, the dwc3 driver should recreate the device, and the symlink should become active again
I have the dwc3 IP base usb controller, Let me check with this patch and share result here.
May be we need some fix in dwc3

> > 
> > > The gether_cleanup function should remove the interface along with the associated kobject,
> > > and this function should only be called during the unloading of the driver or deleting the gadget.
> > > Could you please confirm whether any of your custom modifications are removing the net interface kobject?
> > 
> > As far as know not. I have one tusb1210 (usb phy) and 2 dwc3 patches,
> > nothing related to gadgets or net.
> > 
> > For reference, patches are here: https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_htot_meta-2Dintel-2Dedison_tree_nanbield_meta-2Dintel-2Dedison-2Dbsp_recipes-2Dkernel_linux_files&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=b4sDyiL5E5Uvzote95pWzkQE_qFYYrvfF766keBAL41H9ZrXG_fF_I7mAnRnI32b&s=1t88BV-wyxvDFZcsmuO0wtanAnpRPP9TSw3ysu6ZUgs&e=
> > 
> > 0001-phy-ti-tusb1210-write-to-scratch-on-power-on.patch
> > 
> > 0001a-usb-dwc3-core-Fix-dwc3_core_soft_reset-before-anythi.patch
> > 
> > 044-REVERTME-usb-dwc3-gadget-skip-endpoints-ep-18-in-out.patch
> > 
> > Seems (just guessing) gether_cleanup is being called due to the switch to
> > host mode, but cleanup only partly succeeds. Now I'm finding I can make the
> > net interface disappear with `ip link set dev usb0 down` and the broken link
> > goes away by destroying the gadget in configfs.
> > 
> > Is that intentional? Do I need to tear down the gadgets in reverse order as
> > on create when switching to host mode? That would be new.
> > 
> > What happens when you trigger a switch to host mode without actually
> > unplugging your cable?
> 
> Since there is no response, should we actually prepare revert next week?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>


