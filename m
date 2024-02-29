Return-Path: <linux-kernel+bounces-87105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0826286CFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C247B24972
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6A64AEF0;
	Thu, 29 Feb 2024 16:53:47 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60016065D;
	Thu, 29 Feb 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225627; cv=none; b=RB+U1eq+QDPQdB1gbAumqXheV3X6SCXbFpxL3PIN22rcIXzlJlgEE3dPdKotuI7g72zJ/3ynzQ6zpAlEQ3agpc9xoiwjUXZN3ewearuZqRtSn4QcNAVoZAkVdDnR3fZDWzElPgxrIaCNUY/K6YCFVO0Iru5Qp2yUKKdijbXHtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225627; c=relaxed/simple;
	bh=nSf+UyIsvbI5cnEYLyQ0GPOZ4UECM4vWEu3AEyZSTpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZLFGGOui1gRK1dDZgL+Da7W59bKCr7wP2W1EvSqY2DJYqnXK3xj5G4kioR1WBgymYpVZLyXfQeY2G8ZOJDCFalSyZbtITLiebXzMW/TJMpAyPIJyGdAb7JU0KB+ffssIuAnYmeS74U9Q4ubLYEvd0YsP1HOEwV5JrjqttXZepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 688482000CD;
	Thu, 29 Feb 2024 16:53:40 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id DB256A0083; Thu, 29 Feb 2024 17:53:34 +0100 (CET)
Date: Thu, 29 Feb 2024 17:53:34 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: tomas.winkler@intel.com, mchehab@kernel.org, wentong.wu@intel.com,
	hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Message-ID: <ZeC2jss4IAM4aPWy@shine.dominikbrodowski.net>
References: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
 <Zd-BVmoFOiCxA632@kekkonen.localdomain>
 <ZeAwhhW7DSEazs0F@shine.dominikbrodowski.net>
 <ZeAymVVsI-CNj6Pc@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeAymVVsI-CNj6Pc@kekkonen.localdomain>

Hi Sakari,

Am Thu, Feb 29, 2024 at 07:30:33AM +0000 schrieb Sakari Ailus:
> On Thu, Feb 29, 2024 at 08:21:42AM +0100, Dominik Brodowski wrote:
> > Hi Sakari,
> > 
> > many thanks, this patch helps. Another issue persists, though:
> > 
> > 
> > $ dmesg | cut -c16- | grep -E "(mei|vsc)"
> > mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> > mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops)
> > mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops)
> > intel_vsc intel_vsc: silicon stepping version is 0:2
> > mei intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: deferred probe pending: (reason unknown)
> > mei intel_vsc-5db76cf6-0a68-4ed6-9b78-0361635e2447: deferred probe pending: (reason unknown)
> 
> You'll probably need the IPU bridge patches from that branch, too. Or you
> can try removing the intel-ipu6 driver and modprobing it again.

Everything is built into the kernel here - and the kernel I run is pure
upstream (plus your patch), therefore no intel-ipu6 driver is available
(yet) or active.

> > During suspend entry (s2idle), the following messages are emitted:
> > 
> > ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> > intel_vsc intel_vsc: silicon stepping version is 0:2
> > PM: Some devices failed to suspend, or early wake event detected
> > ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> > intel_vsc intel_vsc: silicon stepping version is 0:2
> > vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> > vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> > intel_vsc intel_vsc: wait fw ready failed: -110
> > intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
> > intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status = 
> > ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> > intel_vsc intel_vsc: silicon stepping version is 0:2
> 
> I haven't tried suspending. Is this while streaming or not?

No streaming - in fact, without intel-ipu6 available (upstream + your patch,
see above).


I have now tried upstream plus the ipu6 branch; there I get one message
indicating that something is amiss:

	vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110

And if I try to do a suspend&resume cycle, the machine hangs. A longer
snippet from dmesg from upstream+ipu6 branch:

mei_me 0000:00:16.0: enabling device (0000 -> 0002)
mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops)
mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops)
intel-ipu6 0000:00:05.0: enabling device (0000 -> 0002)
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel_vsc intel_vsc: silicon stepping version is 0:2
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
intel-ipu6 0000:00:05.0: FW version: 20230925
intel-ipu6 0000:00:05.0: Found supported sensor OVTI01A0:00
intel-ipu6 0000:00:05.0: Connected 1 cameras
intel-ipu6 0000:00:05.0: IPU6-v3[465d] hardware version 5


Best,
	Dominik

