Return-Path: <linux-kernel+bounces-78637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E963B861642
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87545B21A05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A132A82D76;
	Fri, 23 Feb 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAaEvw/0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527E82C88
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703304; cv=none; b=WlOUO6dfGmE16Vl1Sty9ksb40hcxmO+I8fPucWCRaIRmWvIj6hDQhgK30kcS3gbinfisj+ZJb4rEai1WS1nMfjhQhxLMTZd1p+EaIXeWwXzAKuHgAaQfl7SayOKwM1TGD+66vjVWoE06Ks2m9CerhVr8eqTLBhONUQjS0li1hL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703304; c=relaxed/simple;
	bh=Aj0e6KT0fe8LWRbvLT+F2AYFx2lVUhFtTgoPY3Su+lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quF57EKLNHTov3uNOiU1jMHoEPHYi2Gn5NMK9iItblnQrNsCUbPZb1P4VJNBLK5VaA0yaG9roe4b6XY577xBjysN5gpZYAJua3BNMSsKhKMcXEceBt0o61GtNUdhVG8mSiAq+6LWVfd/MKBcX3LtlzGovOH4o0tVG1YYj4ufYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAaEvw/0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703303; x=1740239303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aj0e6KT0fe8LWRbvLT+F2AYFx2lVUhFtTgoPY3Su+lA=;
  b=gAaEvw/051D0/Xc1vsLcUlQvFVStvmkeRI97xuRI8xTSO0NFv0wcBVj2
   bGoFDDa7gTDtUkUXMLshjeJrb650FR/wT7N1u/jhXyg5A35nwrNAZvCeC
   DySLidUCEO+XD3A/kWDsAoFWLR12Vb/hqo74a8ZG+JgEOMqN+2AgjQtqa
   1AdvPu1VJZ+eW79GwoSpyGYcesoEYx85N4TbWPb5LHD01362Ea3t7CjX/
   sBVcaFANQNBcUOaZ4pKb7AxUDCe8PYDDZdUvrhMhjUdzb/d5mtfUK1Agr
   2D1boG330BeAicy5+bsGVl2LZpjrpQEfi6MppywbueliQCDlUc2M8M0+s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="20563856"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="20563856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913749500"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913749500"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:48:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdXmd-00000006wI1-0SEz;
	Fri, 23 Feb 2024 17:48:19 +0200
Date: Fri, 23 Feb 2024 17:48:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clkdev: Update clkdev id usage to allow for longer names
Message-ID: <Zdi-QnkPYUFWLJIe@smile.fi.intel.com>
References: <20240223141857.3794855-1-michael.j.ruhl@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223141857.3794855-1-michael.j.ruhl@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 09:18:14AM -0500, Michael J. Ruhl wrote:
> clkdev ID information is limited to arrays of 20 and 16 bytes
> (MAX_DEV_ID/MAX_CON_ID).  It is possible that the IDs could be
> longer that.  If so, the lookup will fail because the "real ID"
> will not match the copied value.

Perhaps you need to add a real example.

> Increase the size of the IDs to allow for longer names.

..

> -#define MAX_DEV_ID	20
> -#define MAX_CON_ID	16
> +#define MAX_DEV_ID	32
> +#define MAX_CON_ID	32

Do we need to alter both?

-- 
With Best Regards,
Andy Shevchenko



