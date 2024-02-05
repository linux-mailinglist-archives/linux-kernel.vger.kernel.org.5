Return-Path: <linux-kernel+bounces-52410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860C08497C1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5FC1C21CEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49D2171AD;
	Mon,  5 Feb 2024 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5kmz8qL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05319171B0;
	Mon,  5 Feb 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128860; cv=none; b=jZqCaEDeFZ7nFPv2flVYv27uPmegsYqux00loSkf0mfixW8apkv8wO7VtLehum6h/8KveaqL3ZCAmenn6lTVqd43oGtECiTub5ORAD+WO6C69IVZ8POt6NcFHYciMGV3qqbUIiUS7r8ilODw7fU9gbEvXN6xlzkNe2t5A1Ox738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128860; c=relaxed/simple;
	bh=VAS2Lu0xN6uR6DVUY/x61U7rqCFObsbM4IPQJXIRAOI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o3qsJupePjBT5NrNNFai5B5q52k83gcEod593h8N8/2GD8yotTCn1OFYrMMwXaEYS5umptrr3YtxFFUtQokmtVSZZMoBfC7Ae1MIV9LgeUPBSMsp0QvHBy/erFiNPcMn0XqCnlI8j3n1Vqx1QIfpFDhLI3/t70aOPpMnctqfW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5kmz8qL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707128858; x=1738664858;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VAS2Lu0xN6uR6DVUY/x61U7rqCFObsbM4IPQJXIRAOI=;
  b=D5kmz8qLJi8hKNJJ+AmcT1hNRqKooRZRP12ebc1YKmoctOVTCAzlwqdw
   1fZN2OKk34wV92eichLQMtEAl3u7kx/0y8oKkVuqlqOcGgJw7ZFrSomyE
   Fn0A141fP/LTcHnuoyBcYJ6/pwSoYGAEC0HQD7cuqh0gG05h5J2Tw2ikt
   BcIaJFO4ePTnyLMYcdyF3B/hHg9yrV3U0Lnx37knqYopLrV8x/EbE1LY+
   6NfzAEwLRtGffGODDs5QMV7PDfNMO7wf0QcCE9KGuEaUcbQlp8FlOXO0s
   QOr31/dsDghveGXD/DnrguGQCuh8RRbaRn8/wu07ajz2d4SCMlBt26wJ6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="3452950"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="3452950"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 02:27:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5424972"
Received: from papaga-mobl.ger.corp.intel.com (HELO localhost) ([10.246.35.237])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 02:27:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Feb 2024 12:27:24 +0200 (EET)
To: Hans de Goede <hdegoede@redhat.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: naveenkrishna.chatradhi@amd.com, LKML <linux-kernel@vger.kernel.org>, 
    Carlos Bilbao <carlos.bilbao@amd.com>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/amd/hsmp: switch to use
 device_add_groups()
In-Reply-To: <06e92b87-4d48-4519-b1db-6d7605bf3962@redhat.com>
Message-ID: <e8605fd7-1ffc-00ff-ec3b-e125085d4e92@linux.intel.com>
References: <2024020145-junior-outnumber-3e76@gregkh> <07010c54-2e44-463b-9a9b-95697fd30ffd@redhat.com> <2024020243-blinks-pantomime-c51e@gregkh> <06e92b87-4d48-4519-b1db-6d7605bf3962@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 Feb 2024, Hans de Goede wrote:
> On 2/2/24 16:32, Greg Kroah-Hartman wrote:
> > On Fri, Feb 02, 2024 at 08:49:39AM +0100, Hans de Goede wrote:
> >> Hi Greg,
> >>
> >> On 2/2/24 03:44, Greg Kroah-Hartman wrote:
> >>> The use of devm_*() functions works properly for when the device
> >>> structure itself is dynamic, but the hsmp driver is attempting to have a
> >>> local, static, struct device and then calls devm_() functions attaching
> >>> memory to the device that will never be freed.
> >>
> >> As I mentioned in my reply to v1, this is not correct.
> >>
> >> There is a global data struct, but that holds a struct device
> >> pointer, not the device struct.
> > 
> > Ooops, I misread that:
> > 	static struct hsmp_plat_device plat_dev;
> > was not the actual device struct anymore.
> > 
> >> The device itself is created with platform_device_alloc() +
> >> platform_device_add() from module-init and it is removed
> >> on module-exit by calling platform_device_unregister()
> > 
> > Ok, much better.
> > 
> >> So AFAICT this should keep using the devm_ variant to properly
> >> cleanup the sysfs attributes.
> > 
> > This devm_ variant is odd, and should never have been created as the
> > sysfs core always cleans up the sysfs attributes when a device is
> > removed, there is no need for it (i.e. they do the same thing.)
> > 
> > That's why I want to get rid of it, it's pointless :)
> > 
> >> But what this really needs is to be converted to using
> >> amd_hsmp_driver.driver.dev_groups rather then manually
> >> calling devm_device_add_groups() I have already asked
> >> Suma Hegde (AMD) to take a look at this.
> > 
> > The initial issue I saw with this is that these attributes are being
> > created dynamically, so using dev_groups can be a bit harder.  The code
> > paths here are twisty and not obvious as it seems to want to support
> > devices of multiple types in the same codebase at the same time.
> > 
> > But yes, using dev_groups is ideal, and if that happens, I'm happy.
> > It's just that there are now only 2 in-kernel users of
> > devm_device_add_groups() and I have a patch series to get rid of the
> > other one, and so this would be the last, hence my attention to this.
> > 
> > Again, moving from devm_device_add_groups() to device_add_groups() is a
> > no-op from a functional standpoint, so this should be fine.
> 
> Ok, I was not aware that the core automatically cleans up
> all the attributes anyways.
> 
> In that case this fine with me and I agree with merging this
> so that you can entirely remove the  devm_ variant:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Greg,

Does this same stuff apply to devm_device_add_group() which was added 
along the ACPI changes?

And the changelog is quite misleading as is, it should be changed to 
match the real motivation.

-- 
 i.


