Return-Path: <linux-kernel+bounces-98164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BF68775E8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 09:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92092B214BA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 08:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937A1DFEA;
	Sun, 10 Mar 2024 08:58:51 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31919BDC;
	Sun, 10 Mar 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710061130; cv=none; b=HwwP7bU3AfF2jRRr2Cm3oBuSlEUgjyJUF+8r59QDVX2Fm5WEbcFgKHWTQ+UFcwUz3CmON70MCb0yptejSBzC2NgV2aIPIsL/CpH5e++R7u4fLhnYCEneOaQejpHqkZwxAuk6YOSjgT1+k0yptN4VmJk+dvixSy5zGmhcW1BEP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710061130; c=relaxed/simple;
	bh=1lEICfmDw9BWW1Fhiw0XsMRlJ4xj+het4LVXTFyaegM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFltu0vMKLdKcZPuexlCIx+mNpi3tJL5wsjBaUvlDvS6yl2Js3vzGG7oP17P68qkO+36gp+P2kHwY0XfgDZQDy/RmD6Ty1FJgZ9pBRx52TkMmFECrTdB8k559Iatzdh9e5chwsPpSiGw8P89I38CKTvsor6p1cqpHX6Fx+9GR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 8FD1E2000D3;
	Sun, 10 Mar 2024 08:58:44 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 84517A006A; Sun, 10 Mar 2024 09:58:28 +0100 (CET)
Date: Sun, 10 Mar 2024 09:58:28 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Wu, Wentong" <wentong.wu@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Message-ID: <Ze12NB4XQaIydr0t@shine.dominikbrodowski.net>
References: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
 <Zd-BVmoFOiCxA632@kekkonen.localdomain>
 <ZeAwhhW7DSEazs0F@shine.dominikbrodowski.net>
 <ZeAymVVsI-CNj6Pc@kekkonen.localdomain>
 <ZeC2jss4IAM4aPWy@shine.dominikbrodowski.net>
 <MW5PR11MB5787E3A96C8EFF3C9F8BC8908D272@MW5PR11MB5787.namprd11.prod.outlook.com>
 <ZewpyJ3d7gx3dSvA@shine.dominikbrodowski.net>
 <PH0PR11MB580859671B2F9EFAD471F76C8D252@PH0PR11MB5808.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB580859671B2F9EFAD471F76C8D252@PH0PR11MB5808.namprd11.prod.outlook.com>

Am Sun, Mar 10, 2024 at 01:33:49AM +0000 schrieb Wu, Wentong:
> > From: Dominik Brodowski <linux@dominikbrodowski.net>
> > 
> > Hi Wetong,
> > 
> > Am Fri, Mar 08, 2024 at 11:45:44PM +0000 schrieb Wu, Wentong:
> > > Did you try master branch (v6.8) without IPU6 driver? There should be
> > > problems with the IPU6 driver you use as below:
> > >
> > > > intel-ipu6 0000:00:05.0: Found supported sensor OVTI01A0:00
> > > > intel-ipu6 0000:00:05.0: Connected 1 cameras
> > >
> > > If not, could you please help try it on your side?
> > 
> > Branch master from https://git.linuxtv.org/sailus/media_tree.git/ causes a
> > WARNING during boot; some extracts from dmesg:
> 
> Thanks for your help, I think this has been fix by below patch:
> <URL: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/misc/mei/vsc-tp.c?id=b8b19acfafdeacbedd4e2795cb18c81c4d8bb6cc>

.. which isn't in the master branch of git.linuxtv.org/sailus/media_tree.git
 I've now taken Linus' tree of today, merged in char-misc-next, merged in
the media_tree, and applied a fixup patch (see bottom of the message).

Booting this kernel, there is no WARNING during boot, and I can suspend and
resume. However, please note the warnings/failures and the long delays
between suspend entry and exit during the first (two) suspend/resume cycles:

[  107.696067] PM: suspend entry (s2idle)
[  107.701258] Filesystems sync: 0.005 seconds
[  107.818367] Freezing user space processes
[  107.822954] Freezing user space processes completed (elapsed 0.004 seconds)
[  107.822979] OOM killer disabled.
[  107.822980] Freezing remaining freezable tasks
[  107.825672] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
[  107.825834] printk: Suspending console(s) (use no_console_suspend to debug)
[  108.186987] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
[  108.192890] intel_vsc intel_vsc: silicon stepping version is 0:2
[  119.661371] PM: Some devices failed to suspend, or early wake event detected
[  119.696726] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
[  119.702358] intel_vsc intel_vsc: silicon stepping version is 0:2
[  133.493790] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  135.541436] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  135.541823] intel_vsc intel_vsc: wait fw ready failed: -110
[  135.541832] intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
[  135.543616] intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status = 
[  135.580522] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
[  135.584170] intel_vsc intel_vsc: silicon stepping version is 0:2
[  135.635935] OOM killer enabled.
[  135.635940] Restarting tasks ... done.
[  135.863803] PM: suspend exit

I seem to have pressed the power butten often enough to initiate a second suspend/resume cycle immediately:

[  135.864196] PM: suspend entry (s2idle)
[  135.875238] Filesystems sync: 0.011 seconds
[  135.879306] Freezing user space processes
[  135.883869] Freezing user space processes completed (elapsed 0.004 seconds)
[  135.883881] OOM killer disabled.
[  135.883884] Freezing remaining freezable tasks
[  135.886107] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
[  135.886112] printk: Suspending console(s) (use no_console_suspend to debug)
[  149.173274] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  151.221491] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  151.221784] intel_vsc intel_vsc: wait fw ready failed: -110
[  151.221793] intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
[  151.222752] intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status = 
[  151.256758] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
[  151.262174] intel_vsc intel_vsc: silicon stepping version is 0:2
[  164.853425] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  166.901441] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  166.901772] intel_vsc intel_vsc: wait fw ready failed: -110
[  166.901779] intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
[  166.904282] intel_vsc intel_vsc: reset: reached maximal consecutive resets: disabling the device
[  166.904290] intel_vsc intel_vsc: device disabled = -19
[  166.904665] intel_vsc intel_vsc: reset: reached maximal consecutive resets: disabling the device
[  166.904712] PM: Some devices failed to suspend, or early wake event detected
[  166.940695] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
[  166.946175] intel_vsc intel_vsc: silicon stepping version is 0:2
[  181.045504] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  183.093514] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  183.093898] intel_vsc intel_vsc: wait fw ready failed: -110
[  183.093912] intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
[  183.094507] intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status = 
[  183.129467] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
[  183.132830] intel_vsc intel_vsc: silicon stepping version is 0:2
[  183.135905] OOM killer enabled.
[  183.135909] Restarting tasks ... done.
[  183.372915] PM: suspend exit

Subsequent suspend/resume operations continue to emit warnings/failures related to intel_vsc:

[  341.554095] PM: suspend entry (s2idle)
[  341.559387] Filesystems sync: 0.005 seconds
[  341.673175] Freezing user space processes
[  341.679061] Freezing user space processes completed (elapsed 0.005 seconds)
[  341.679069] OOM killer disabled.
[  341.679071] Freezing remaining freezable tasks
[  341.680652] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  341.680656] printk: Suspending console(s) (use no_console_suspend to debug)
[  341.861251] intel_vsc intel_vsc: reset: reached maximal consecutive resets: disabling the device
[  342.065565] ACPI: EC: interrupt blocked
[  342.855083] ACPI: EC: interrupt unblocked
[  343.039446] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.bin version 70.20.0
[  343.039458] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
[  343.064550] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
[  343.065807] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[  343.065811] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[  343.066305] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[  343.124628] nvme nvme0: 8/0/0 default/read/poll queues
[  343.385084] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
[  343.389309] intel_vsc intel_vsc: silicon stepping version is 0:2
[  356.946491] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  358.996072] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  358.996432] intel_vsc intel_vsc: wait fw ready failed: -110
[  358.996446] intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
[  358.997008] intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status = 
[  359.031049] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
[  359.035795] intel_vsc intel_vsc: silicon stepping version is 0:2
[  359.051336] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops)
[  359.051432] OOM killer enabled.
[  359.051435] Restarting tasks ... 
[  359.052195] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops)
[  359.056184] done.
[  359.309627] PM: suspend exit
[  372.188053] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  374.364551] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  374.364749] intel_vsc intel_vsc: wait fw ready failed: -110
[  374.364755] intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
[  374.364778] intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status = 
[  374.399149] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
[  374.406099] intel_vsc intel_vsc: silicon stepping version is 0:2
[  387.747776] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  389.924474] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
[  390.045250] intel_vsc intel_vsc: wait fw ready failed: -110
[  390.045260] intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
[  390.045294] intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status = 
[  390.045297] intel_vsc intel_vsc: reset: reached maximal consecutive resets: disabling the device
[  390.045324] intel_vsc intel_vsc: device disabled = -19

Best,
	Dominik

--- 

Subject: [PATCH] media: v4l: async: remove unused variable

ret is unused in v4l2_async_nf_register()

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index a722c5eb3230..3b43d6285dfe 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -620,8 +620,6 @@ static int __v4l2_async_nf_register(struct v4l2_async_notifier *notifier)
 
 int v4l2_async_nf_register(struct v4l2_async_notifier *notifier)
 {
-	int ret;
-
 	if (WARN_ON(!notifier->v4l2_dev == !notifier->sd))
 		return -EINVAL;
 

