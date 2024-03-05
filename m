Return-Path: <linux-kernel+bounces-91813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B24F78716F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E05B24779
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5877EEF0;
	Tue,  5 Mar 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9DOaTim"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C57E564;
	Tue,  5 Mar 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623973; cv=none; b=LAUKHtzRLCAkVu3GpIBPyfhYD7Nmx5yTNktxUit7PF6RDRVVs9RrWxCpAoKs11/FV6sYYqpAtpxTZfRz1K5DC1TdX4pXW225rLtz0hn2+cZyGYpoPhAi4WGCsaQdYLj0VumUtC+pa/iT6VURt/CoEdv+oabh9eNwgRf6XHWr3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623973; c=relaxed/simple;
	bh=YjfH/4uaFuWJtJMASjOecQcGKJu/nURAXgrynQrpwt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpRY+1zEs/tz+7zzZaDKuoY+S4/0H1vGqh0a4fDLxaed+PhSX6YxM4Jth8xFrXBqRamM2+aDWHGOS3JjcrM5Zgvi6P7evuy+K798vAoTYmig76YoKuCDW5G//s/NotcQMzzdfqThvGHVGvbWbSZhQoTpBOx4SNV+MCffeZsC/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9DOaTim; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709623972; x=1741159972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YjfH/4uaFuWJtJMASjOecQcGKJu/nURAXgrynQrpwt8=;
  b=O9DOaTimStvlbVtGp2xW6XQeU/RJwEAZouQQL4eDZMKRQf4JQwu7w66L
   V2Z+vZq6S7iJGl+Nbda8aIuDtRYEk518eHXafmdTThC9/yWOkYbCW6Wyi
   5ebkJNV9A6+EpekSfPLqcPW644l1awWQVYKyKxzzO+ongBqHJO0mmeLwK
   eyRjQuXoKvKY39dKwJKov+h76VdpLkh9YPA42DM/V/IRi5f9gsIcXAmmI
   5EuE7K6tjLZxnnrwaIn5XkLRmb6VP/4OixSG9NDdoahNbprCCGISCzrj+
   C3ai9/zZa/7uQrfNMXMwFFLxj+CE7Oa6PySWpwooGwzXCFjIZG3QQ6nTe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4317376"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4317376"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:32:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40160744"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:32:49 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 14A1211F871;
	Tue,  5 Mar 2024 09:32:46 +0200 (EET)
Date: Tue, 5 Mar 2024 07:32:46 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: tomas.winkler@intel.com, mchehab@kernel.org, wentong.wu@intel.com,
	hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Message-ID: <ZebKnqynAiWBEkE6@kekkonen.localdomain>
References: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
 <Zd-BVmoFOiCxA632@kekkonen.localdomain>
 <ZeAwhhW7DSEazs0F@shine.dominikbrodowski.net>
 <ZeAymVVsI-CNj6Pc@kekkonen.localdomain>
 <ZeC2jss4IAM4aPWy@shine.dominikbrodowski.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeC2jss4IAM4aPWy@shine.dominikbrodowski.net>

Hi Dominik,

On Thu, Feb 29, 2024 at 05:53:34PM +0100, Dominik Brodowski wrote:
> Hi Sakari,
> 
> Am Thu, Feb 29, 2024 at 07:30:33AM +0000 schrieb Sakari Ailus:
> > On Thu, Feb 29, 2024 at 08:21:42AM +0100, Dominik Brodowski wrote:
> > > Hi Sakari,
> > > 
> > > many thanks, this patch helps. Another issue persists, though:
> > > 
> > > 
> > > $ dmesg | cut -c16- | grep -E "(mei|vsc)"
> > > mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> > > mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops)
> > > mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops)
> > > intel_vsc intel_vsc: silicon stepping version is 0:2
> > > mei intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: deferred probe pending: (reason unknown)
> > > mei intel_vsc-5db76cf6-0a68-4ed6-9b78-0361635e2447: deferred probe pending: (reason unknown)
> > 
> > You'll probably need the IPU bridge patches from that branch, too. Or you
> > can try removing the intel-ipu6 driver and modprobing it again.
> 
> Everything is built into the kernel here - and the kernel I run is pure
> upstream (plus your patch), therefore no intel-ipu6 driver is available
> (yet) or active.
> 
> > > During suspend entry (s2idle), the following messages are emitted:
> > > 
> > > ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> > > intel_vsc intel_vsc: silicon stepping version is 0:2
> > > PM: Some devices failed to suspend, or early wake event detected
> > > ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> > > intel_vsc intel_vsc: silicon stepping version is 0:2
> > > vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> > > vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> > > intel_vsc intel_vsc: wait fw ready failed: -110
> > > intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
> > > intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status = 
> > > ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> > > intel_vsc intel_vsc: silicon stepping version is 0:2
> > 
> > I haven't tried suspending. Is this while streaming or not?
> 
> No streaming - in fact, without intel-ipu6 available (upstream + your patch,
> see above).
> 
> 
> I have now tried upstream plus the ipu6 branch; there I get one message
> indicating that something is amiss:
> 
> 	vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> 
> And if I try to do a suspend&resume cycle, the machine hangs. A longer
> snippet from dmesg from upstream+ipu6 branch:
> 
> mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops)
> mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops)
> intel-ipu6 0000:00:05.0: enabling device (0000 -> 0002)
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel_vsc intel_vsc: silicon stepping version is 0:2
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: IPU6 in non-secure mode touch 0x0 mask 0xff
> intel-ipu6 0000:00:05.0: FW version: 20230925
> intel-ipu6 0000:00:05.0: Found supported sensor OVTI01A0:00
> intel-ipu6 0000:00:05.0: Connected 1 cameras
> intel-ipu6 0000:00:05.0: IPU6-v3[465d] hardware version 5

I haven't tried suspending but I know Wentong has. So this is odd.

Which system do you have? Could you provide your .config?

-- 
Regards,

Sakari Ailus

