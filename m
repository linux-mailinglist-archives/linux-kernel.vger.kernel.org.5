Return-Path: <linux-kernel+bounces-50058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985778473CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE0B2A317
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522E21474A6;
	Fri,  2 Feb 2024 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+TpP/av"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915A146916;
	Fri,  2 Feb 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889507; cv=none; b=NKUzqk1AuckNx17ZzHlGVwJSbj26kIwVJEO7cM3AWqB7jYLroTzWZ/YmgDCSwFazJPS2AqE6puYB+MjGQDljvNbkgTeOYzEWyQ7/eZ4IQvHVnb4fbzX0zKO2iENewFqu2KU21nmWEOZyVxrLdyEEUNcu2JtHb8zCunvfcJ1Bb/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889507; c=relaxed/simple;
	bh=wUwZPwNqrEK75tnxfRq10rV4lQ31r9uKs2N3OkJYfbY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UMFe76NyoS+pMTJCLSb/vpD96TXM9QVkcaXwHaf4EVdPBgQM1LHNL61r3qrUBHX9PkEfC6664p4sGBU84Ya7CL1ykK1FAyj5ItDm72Dz57c7uIS43DbUxAEeDLe+L9Qm4plJLipQaYbH86jbjskWf9IOGJ//imQCmMgk/VLEZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+TpP/av; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706889506; x=1738425506;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wUwZPwNqrEK75tnxfRq10rV4lQ31r9uKs2N3OkJYfbY=;
  b=b+TpP/av+x2k7VPTuHVf5oGeSEtJ32gNNziWEhiSaKO4RVMBmSYq0WRS
   G4QlY7CHdjFkAxJDoSRPqfJd6H0ycv4uY2t72PU0p4Iaq1j94G8BRgFMX
   rj3MYdrradms1YIYeqOArmGv5rIKd1T9VZT3DNdT8rCEbENa1DmnTxspz
   G09NV2NSHWiCirIYsk0ueTNXM15WdMa34MsyMzgzNh56V2+uWg5TVB8vD
   /FoVwyr6moc3aUtcn4DbL4LGObB01KdvPiufBbBp7m0MFAKtb84dHZ7gW
   DnAPV9MWvsHPD7q0TQRJjznk5Y5ZgCgDoJ7t5H1Epkvfb94DMUNBgAjtQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="89240"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="89240"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:58:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="425162"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.66])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:58:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 2 Feb 2024 17:58:17 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Hans de Goede <hdegoede@redhat.com>, naveenkrishna.chatradhi@amd.com, 
    LKML <linux-kernel@vger.kernel.org>, Carlos Bilbao <carlos.bilbao@amd.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/amd/hsmp: switch to use
 device_add_groups()
In-Reply-To: <2024020243-blinks-pantomime-c51e@gregkh>
Message-ID: <14131097-3f19-70f1-0a9c-41dd26c6be0d@linux.intel.com>
References: <2024020145-junior-outnumber-3e76@gregkh> <07010c54-2e44-463b-9a9b-95697fd30ffd@redhat.com> <2024020243-blinks-pantomime-c51e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 Feb 2024, Greg Kroah-Hartman wrote:

> On Fri, Feb 02, 2024 at 08:49:39AM +0100, Hans de Goede wrote:
> > Hi Greg,
> > 
> > On 2/2/24 03:44, Greg Kroah-Hartman wrote:
> > > The use of devm_*() functions works properly for when the device
> > > structure itself is dynamic, but the hsmp driver is attempting to have a
> > > local, static, struct device and then calls devm_() functions attaching
> > > memory to the device that will never be freed.
> > 
> > As I mentioned in my reply to v1, this is not correct.
> > 
> > There is a global data struct, but that holds a struct device
> > pointer, not the device struct.
> 
> Ooops, I misread that:
> 	static struct hsmp_plat_device plat_dev;
> was not the actual device struct anymore.
> 
> > The device itself is created with platform_device_alloc() +
> > platform_device_add() from module-init and it is removed
> > on module-exit by calling platform_device_unregister()
> 
> Ok, much better.
> 
> > So AFAICT this should keep using the devm_ variant to properly
> > cleanup the sysfs attributes.
> 
> This devm_ variant is odd, and should never have been created as the
> sysfs core always cleans up the sysfs attributes when a device is
> removed, there is no need for it (i.e. they do the same thing.)
> 
> That's why I want to get rid of it, it's pointless :)
>
> > But what this really needs is to be converted to using
> > amd_hsmp_driver.driver.dev_groups rather then manually
> > calling devm_device_add_groups() I have already asked
> > Suma Hegde (AMD) to take a look at this.
> 
> The initial issue I saw with this is that these attributes are being
> created dynamically, so using dev_groups can be a bit harder.  The code
> paths here are twisty and not obvious as it seems to want to support
> devices of multiple types in the same codebase at the same time.

It wants to provide metrics for each socket. The ACPI part was a recent 
addition (as you've now probably discovered) and works slighty differently 
because the discovered structure is different but it's not really that 
different otherwise.

-- 
 i.

> But yes, using dev_groups is ideal, and if that happens, I'm happy.
> It's just that there are now only 2 in-kernel users of
> devm_device_add_groups() and I have a patch series to get rid of the
> other one, and so this would be the last, hence my attention to this.
> 
> Again, moving from devm_device_add_groups() to device_add_groups() is a
> no-op from a functional standpoint, so this should be fine.


