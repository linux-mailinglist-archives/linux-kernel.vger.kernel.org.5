Return-Path: <linux-kernel+bounces-68983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A808582F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FF62849A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD47043687;
	Fri, 16 Feb 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJtmy1S7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB8130ADF;
	Fri, 16 Feb 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102219; cv=none; b=DwW+u2GDUu2OtnKetMB8mFpns4/cjK5f5hvKNPBu8ij8HUwQGmHV1OrpkMd9fizH9W8oKmTZoBZwKDbRU7lQmkM/feOE+fIotmMJyfs1F0A0tWh+CRlOOHUbDQeIcw2Na1ZVxgGLOAlN9YUNBY34dUXCb7BORUaZ7YxMxaqbjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102219; c=relaxed/simple;
	bh=9x0VAcgRR5iydeprnwWx5rGSU/WwGPjsi6M/40rCSuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/VqzVHGVtu+wE7RGXWTMZbNoocMpZYcvsKafCIHhFFFJgIdCdwK8IngsGfEcCh87jaEUu8AzXi5sdUnhdgiV3OhzwS86LumtyJve3FAh1Oo3klMwJE2aoafp/TvvshSTmnHoGT7qI8fbyJ/wRhrPSawjwcubi5SgVlgJkVW02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJtmy1S7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708102217; x=1739638217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9x0VAcgRR5iydeprnwWx5rGSU/WwGPjsi6M/40rCSuw=;
  b=OJtmy1S7kexNi1D4GYl3chgJvnjFjn56PK2EhvLZ/KGQQX7hxNLC4Pm+
   9TbXOJhkudOqH4cAkZVa5KNzDlGiO679A30adT9cWLZyBGdRFgmf9QF9/
   uAmNiCJNOy/HrHvd7jvxzPxjjl0xK5Hjri7vp5E7FXAzdpFVoEDxr53jT
   qApJwN31669KNbcOnPw6B782F8uLY98lo+2KeGLjg7Nth8a7WI6ofJLb7
   WYjRzIHMYHSTWjVdjUOvUt2/NzD6I16xt42di60oM/JWBVtD7UNNjUCtn
   AXxHSuMfZQMf3p9iN3qAyYTAhjUku1w4j3J2gcVfWFZ+uCEbiom+vGpxP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2367363"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2367363"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 08:50:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="912387756"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="912387756"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 08:50:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rb1Pf-000000056Gt-2LJH;
	Fri, 16 Feb 2024 18:50:11 +0200
Date: Fri, 16 Feb 2024 18:50:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Kees Cook <kees@kernel.org>,
	"shiqiang.deng" <shiqiang.deng213@gmail.com>,
	Sebastian Grzywna <swiftgeek@gmail.com>,
	Hang Zhang <zh.nvgt@gmail.com>
Subject: Re: [PATCH v3] ACPI: Drop the custom_method debugfs interface
Message-ID: <Zc-SQ1SM6i6RCsRo@smile.fi.intel.com>
References: <6029478.lOV4Wx5bFT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6029478.lOV4Wx5bFT@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 16, 2024 at 05:38:55PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI custom_method debugfs interface is security-sensitive and
> concurrent access to it is broken [1].
> 
> Moreover, the recipe for preparing a customized version of a given
> control method has changed at one point due to ACPICA changes, which
> has not been reflected in its documentation, so whoever used it before
> has had to adapt and it had gone unnoticed for a long time.
> 
> This interface was a bad idea to start with and its implementation is
> fragile at the design level.  It's been always conceptually questionable,
> problematic from the security standpoint and implemented poorly.
> 
> Patches fixing its most apparent functional issues (for example, [2]) don't
> actually address much of the above.
> 
> Granted, at the time it was introduced, there was no alternative, but
> there is the AML debugger in the kernel now and there is the configfs
> interface allowing custom ACPI tables to be loaded.  The former can be
> used for extensive AML debugging and the latter can be use for testing
> new AML. [3]
> 
> Accordingly, drop custom_method along with its (outdated anyway)
> documentation.
> 
> Link: https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/ # [1]
> https://lore.kernel.org/linux-acpi/20231111132402.4142-1-shiqiang.deng213@gmail.com/ [2]
> https://stackoverflow.com/questions/62849113/how-to-unload-an-overlay-loaded-using-acpi-config-sysfs # [3]

I believe you missed Link: tags for 2 and 3.

> Reported-by: Hang Zhang <zh.nvgt@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>

-- 
With Best Regards,
Andy Shevchenko



