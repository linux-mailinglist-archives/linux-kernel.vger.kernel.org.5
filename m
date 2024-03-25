Return-Path: <linux-kernel+bounces-117021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A778788A63E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8ADA1C3C85A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62493158D97;
	Mon, 25 Mar 2024 12:38:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F534A1C;
	Mon, 25 Mar 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370292; cv=none; b=iyOV1RM4LTHazYGDA/4BpCuYOBJTR/5CvyDxCtEmsmTAZjzTw/mmSprZy5Fhogakp0MX+kkPaFP+Ah9llsUgK89HD6PIlx9/jsG75e2vNqsQ1IS7UA3VAUlrhpn5V+z6cFLYh0fCny0URYIeFNJm2asUWr7TTtMS6KUSSDbaHWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370292; c=relaxed/simple;
	bh=qeAcaT5CXsM7WiKAlDn7So/q00mu0KRykv/FEqyC1mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hozDNAn7KlGhWuXLPxh0pILW2tSoFMDvmcaR85TwSeqNEDRSqFVD3h0nCTUYz8rZUusm8a4NEJs5QtkB9gpfaR4a8OT/mSvDQj+RpGnNZN6wtjp+J/ACPhrEwxTaRIq3+h0MHTY8QU1btDo/OCrzyOl7/zWnKMhIG6n80sJlWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6550152"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6550152"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:38:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070365"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070365"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:38:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 89D4813F; Mon, 25 Mar 2024 14:38:05 +0200 (EET)
Date: Mon, 25 Mar 2024 14:38:05 +0200
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
	linux@roeck-us.net, robert.moore@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 2/2] hwmon: (acpi_power_meter) Ensure IPMI space
 handler is ready on Dell systems
Message-ID: <ZgFwLXzNG2aTL_BQ@black.fi.intel.com>
References: <20240320084317.366853-1-kai.heng.feng@canonical.com>
 <20240320084317.366853-2-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320084317.366853-2-kai.heng.feng@canonical.com>

On Wed, Mar 20, 2024 at 04:43:17PM +0800, Kai-Heng Feng wrote:
> The following error can be observed at boot:
> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c5) [IPMI] (20230628/evregion-130)
> [    3.717928] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)
> 
> [    3.717936] No Local Variables are initialized for Method [_GHL]
> 
> [    3.717938] No Arguments are initialized for method [_GHL]
> 
> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
> 
> On Dell systems several methods of acpi_power_meter access variables in
> IPMI region [0], so wait until IPMI space handler is installed by
> acpi_ipmi and also wait until SMI is selected to make the space handler
> fully functional.
> 
> Since the dependency is inside BIOS's ASL code and it's not
> discoverable, so use this fixup is a hack to workaround BIOS issue.

..

> +	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.")) {
> +		ipi_device = acpi_dev_get_first_match_dev("IPI0001", NULL, -1);
> +
> +		if (ipi_device) {
> +			if (acpi_wait_for_acpi_ipmi())
> +				dev_warn(&device->dev, "Waiting for ACPI IPMI timeout");
> +			acpi_dev_put(ipi_device);
> +		}

Can be written as

	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.")) {
		ipi_device = acpi_dev_get_first_match_dev("IPI0001", NULL, -1);
		if (ipi_device && acpi_wait_for_acpi_ipmi())
			dev_warn(&device->dev, "Waiting for ACPI IPMI timeout");
		acpi_dev_put(ipi_device);

> +	}

-- 
With Best Regards,
Andy Shevchenko



