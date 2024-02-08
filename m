Return-Path: <linux-kernel+bounces-57702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265AD84DC8A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599F11C24DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55EA6BB47;
	Thu,  8 Feb 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4KF6dyu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D4535DC;
	Thu,  8 Feb 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383588; cv=none; b=BlLLLg2HUbur/+8pDhma5fLvQGW/hFhHVZA+U97pWO1lNqkkdDihlXTjmDY24Z5iBHEoAdeSidHhQuOosasMDlBXiFhi0ui32r2LIu04uPD8fdHFcKz7YtCoym5XaIt/zQIzlb21wkLyo41tP0Iv7vg+wYPcn80CGgu99eyZcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383588; c=relaxed/simple;
	bh=Cmqaj8sgs7iWeMHaQKt5n5zPWvccQgeBanow+ePMb3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXvy99I2z1QIpn/8DHDvDaPlOC+cemSjPcwgCvL97pel8/Rl1xw0sM3suvqqIkNsRKq/TWl7z27plZKRXalJyWMPutDqIZ1TSrpiRIW2cE3Ic9pE1+vMZXYMu1VV6BImGG5fy7raxExzCtC24MeKeS/CII7gynZER4PfNIDbTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4KF6dyu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707383586; x=1738919586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cmqaj8sgs7iWeMHaQKt5n5zPWvccQgeBanow+ePMb3Y=;
  b=F4KF6dyuNauh0LweZ+0DfDPDsgalwXU1HdCHOVxkh9KkQ5l5bE7YzKem
   NRZ4cjtQzVhhMW/XvRFtXts3+yt9dCft4z2u+JilLvWBOLksnPH1jOTW3
   QjGhk6kw1aaIHaW7V0V+FSr2cxI/bz9ay5Dp2X+RzxDM6rGmXoD+SnzS+
   ChDK3zg1upIglslv2h2ePGohBt3+3JEzPJ46M2YrT6gswK7Licdv2eBZW
   O/PEFpHDhY0hBmhRSeCJBh76jl0YoiER10FF/3CsHtvAluyQwH0JYaV7e
   YJAaMWu+nUKrkBWoQcAdt32Vdg7j58iZr1KDj67t38+QN4thCXFt5j6zW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1324250"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1324250"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 01:13:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="934072190"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="934072190"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Feb 2024 01:12:57 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Feb 2024 11:12:56 +0200
Date: Thu, 8 Feb 2024 11:12:56 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prashant Malani <pmalani@chromium.org>,
	Uday Bhat <uday.m.bhat@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	oe-kbuild-all@lists.linux.dev, Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Emilie Roberts <hadrosaur@google.com>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
	"Radjacoumar, Shyam Sundar" <ssradjacoumar@google.com>,
	Samuel Jacob <samjaco@google.com>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Make sure the USB
 role switch has PLD
Message-ID: <ZcSbGIBt1BtFQd36@kuha.fi.intel.com>
References: <20240207145851.1603237-3-heikki.krogerus@linux.intel.com>
 <202402081136.sve0cViZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402081136.sve0cViZ-lkp@intel.com>

On Thu, Feb 08, 2024 at 12:07:40PM +0800, kernel test robot wrote:
> Hi Heikki,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on usb/usb-testing]
> [also build test ERROR on usb/usb-next usb/usb-linus chrome-platform/for-next chrome-platform/for-firmware-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.8-rc3 next-20240207]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Heikki-Krogerus/usb-roles-Link-the-switch-to-its-connector/20240207-230017
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> patch link:    https://lore.kernel.org/r/20240207145851.1603237-3-heikki.krogerus%40linux.intel.com
> patch subject: [PATCH 2/2] platform/chrome: cros_ec_typec: Make sure the USB role switch has PLD
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240208/202402081136.sve0cViZ-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402081136.sve0cViZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402081136.sve0cViZ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/platform/chrome/cros_ec_typec.c: In function 'cros_typec_parse_port_props':
> >> drivers/platform/chrome/cros_ec_typec.c:75:34: error: invalid use of undefined type 'struct acpi_device'
>       75 |                 if (adev && !adev->pld_crc)
>          |                                  ^~
>    drivers/platform/chrome/cros_ec_typec.c:76:29: error: invalid use of undefined type 'struct acpi_device'
>       76 |                         adev->pld_crc = to_acpi_device_node(fwnode)->pld_crc;
>          |                             ^~
>    drivers/platform/chrome/cros_ec_typec.c:76:68: error: invalid use of undefined type 'struct acpi_device'
>       76 |                         adev->pld_crc = to_acpi_device_node(fwnode)->pld_crc;
>          |                                                                    ^~

Oh, so this has to be wrapped in ifdef CONFIG_ACPI :(

-- 
heikki

