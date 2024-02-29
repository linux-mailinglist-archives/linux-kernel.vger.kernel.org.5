Return-Path: <linux-kernel+bounces-86236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B9186C289
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DBB1C20B99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D66481AE;
	Thu, 29 Feb 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FV6Uwt1m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4345BE9;
	Thu, 29 Feb 2024 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191840; cv=none; b=dMq5P8muadjEcErSNnEYOqTTdEXnwL4Cp6KK41sww5j6W41UuQkf98TVfCjMyuW24ApSMuzU9XfXzDovNqzPwAEr/day9u3tqRDt8BC6SQe5Q7m4W662Hy2zlPPij3c2378baoZxPPaL20SAa59MCJsIDnDH0gfv0KbLsYzOaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191840; c=relaxed/simple;
	bh=YOkyCXSsZrl39Y+e6CCJ8gMJHF00r/SHWHtb0duN4To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYI/aapXIw2JJ+wejh7OGSECHcxOSKZSt8YhQC1lPBHUFSIF6T+XKeAzsOgBnpV+z7gl382OWr7OV/w9u/V/yR/DuTu0kYLYK5AwQfW1Hv3NNpeYIAtUveGhdCPCGtJjevuekRb+Fkm5EBRU0dlwekj6CfyNJT5oHM40Tl6f98Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FV6Uwt1m; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709191839; x=1740727839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOkyCXSsZrl39Y+e6CCJ8gMJHF00r/SHWHtb0duN4To=;
  b=FV6Uwt1mpLc4amtsNdNu6T4FMQFN9FpiS6y8beL/TS440gZuWJJXwQvO
   ZSbPI6zgsGCIwu7OkTNrwNdxcFWcLUrwJD0C/6rztD9yPyp2nsrsieqxL
   M2BUWj2vYWvoNAPRuWAbWAqViXojzr5uheAr54V2hVWhZprvl6G3jwra0
   +7146A6sm6j3LoxMoTli9a/ef9J/bhkc5BPEiJ9RzOU56zuapRm3KXeX3
   +ogYRk3SgtKLEnewNMz/N2ZhEm5/0BBpl6mnLNAV2DPDqQgg9OoI3dScU
   +EFKsZjvKE+3iaty/bfVS3D2xDFv9M5865l0bZqPcGj0IhPnRHrMhnpdg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="4225272"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="4225272"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="45242986"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:30:36 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5003E11F853;
	Thu, 29 Feb 2024 09:30:33 +0200 (EET)
Date: Thu, 29 Feb 2024 07:30:33 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: tomas.winkler@intel.com, mchehab@kernel.org, wentong.wu@intel.com,
	hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Message-ID: <ZeAymVVsI-CNj6Pc@kekkonen.localdomain>
References: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
 <Zd-BVmoFOiCxA632@kekkonen.localdomain>
 <ZeAwhhW7DSEazs0F@shine.dominikbrodowski.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeAwhhW7DSEazs0F@shine.dominikbrodowski.net>

On Thu, Feb 29, 2024 at 08:21:42AM +0100, Dominik Brodowski wrote:
> Hi Sakari,
> 
> many thanks, this patch helps. Another issue persists, though:
> 
> 
> $ dmesg | cut -c16- | grep -E "(mei|vsc)"
> mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops)
> mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops)
> intel_vsc intel_vsc: silicon stepping version is 0:2
> mei intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: deferred probe pending: (reason unknown)
> mei intel_vsc-5db76cf6-0a68-4ed6-9b78-0361635e2447: deferred probe pending: (reason unknown)

You'll probably need the IPU bridge patches from that branch, too. Or you
can try removing the intel-ipu6 driver and modprobing it again.

> 
> 
> During suspend entry (s2idle), the following messages are emitted:
> 
> ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> intel_vsc intel_vsc: silicon stepping version is 0:2
> PM: Some devices failed to suspend, or early wake event detected
> ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> intel_vsc intel_vsc: silicon stepping version is 0:2
> vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> intel_vsc intel_vsc: wait fw ready failed: -110
> intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
> intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status = 
> ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> intel_vsc intel_vsc: silicon stepping version is 0:2

I haven't tried suspending. Is this while streaming or not?

-- 
Sakari Ailus

