Return-Path: <linux-kernel+bounces-74724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE4A85D840
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64A5283AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7269949;
	Wed, 21 Feb 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLrlpocA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214F41A94;
	Wed, 21 Feb 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519786; cv=none; b=K5MVtH2ue8IgJn9maZ3MHUmqrlmciciGhAJ453nJmBOQkTAQIH5kJ23C2mJVwUo1tBt2iZN1Lp7q7d3WZv3Gm9a34zdLxnVVPaL9Hp1kh5m9hCw2PjhzGLF4hvZJgfjh1fH5fB0eIxSb3bBqIcw+AIf3IIFf0CUEHuYmmnmI0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519786; c=relaxed/simple;
	bh=kWnrtTAN3Rb1GfnjS08rLEwgCHrSE1rI8HMZQnhqvU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzsjBuf1TzIi6/jaGVz8dCUSFP+0gUYNbvmLvjK0lruJmJitP62D6dbjEUMRCE/PJhMYCyUXIpMRH7EKGr2eH8UYs1z8/vReFZ7eQjoY1jgpLGla1VH4wFUjgaoamVJ1XBq5aeQ+rekDZRvPZySBs6GpdjBzliVeLepDFeOeDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLrlpocA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708519784; x=1740055784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kWnrtTAN3Rb1GfnjS08rLEwgCHrSE1rI8HMZQnhqvU0=;
  b=bLrlpocAM7wdIPNxdwf0xItzVk3bioz/Y+/TUqxNbhOfAq4dNox5ahpr
   Mb1UZrN8IjpOBpdNvdnSC1ZxyGDqiG98s+CTPBWPsQzkQKR4x6j1xjbKP
   3AzreaEBp4TiqlaMq47Uh/FHRPs/iznDpFM+KrXP4Hu1YqcpKmFp5vuRn
   YgoCtjacpJR+1v4S0F8gygmjKGDOoM0xK3o6dAfTkBhQSrj9ARIeCy1xA
   DkKlYQzG+/lAGPUqiGtFVKM7BfSz1IRRCwW/6llw8H2+sUpJO1bB5pK0f
   6w6/Cv4IRUSyXdLCnlWInEFNhbTa1+dFrmgTFI/hsAHsm5a8cbYPHUQ9x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2825203"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2825203"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 04:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913299363"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="913299363"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 04:49:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcm2d-00000006Lki-1MfL;
	Wed, 21 Feb 2024 14:49:39 +0200
Date: Wed, 21 Feb 2024 14:49:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] driver core: Move fw_devlink stuff to where it
 belongs
Message-ID: <ZdXxYjYsBQybbilQ@smile.fi.intel.com>
References: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
 <CAGETcx8hzYzjKWPz4ACgS=XrVXqg46QHB4hTpP5bDTY9=WFK+Q@mail.gmail.com>
 <ZdXxNFB8bMMFPoki@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdXxNFB8bMMFPoki@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 02:48:52PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 20, 2024 at 06:08:56PM -0800, Saravana Kannan wrote:
> > On Tue, Feb 20, 2024 at 8:10 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > A few APIs that belong specifically to the fw_devlink APIs
> > > - are exposed to others without need
> > > - prevents device property code to be cleaned up in the future
> > >
> > > Resolve this mess by moving fw_devlink code to where it belongs
> > > and hide from others.

..

> > The rest of the functions here are related to parents and children of
> > a fwnode. So, why is this function considered to be in the wrong
> > place?
> 
> When devlink was added it made a few fields in struct fwnode_handle.
> These fields have no common grounds with device properties. In particular
> struct device pointer is solely for devlinks and shouldn't be used with
> them. Hence this patch. TL;DR: they semantically do _not_ belong to
> the device property APIs.

On top of that for the 4+ years no new users appeared, so exporting them was
a clear mistake. Hence Fixes tags.

-- 
With Best Regards,
Andy Shevchenko



