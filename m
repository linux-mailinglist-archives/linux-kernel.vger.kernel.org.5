Return-Path: <linux-kernel+bounces-48385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB2845B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4968B2C38E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858A81649B4;
	Thu,  1 Feb 2024 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K59Cf+Z2"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2E163A9E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800718; cv=none; b=bBldxnWUxHU3KstdXoyn7Q9XQ4sJbcvQM4+0B3ysSTN41n2xszdIvhAEmhDritB4q0noJWd/ULDTTfveB3bqbcej1nlMSK1wanMGTk9zJBqKltsH/QEz+eoNu+ZM+MrM/4Qo6RtRCl6hL+z2dcvQ1b0t/lNWSAIIyBwPGVGWirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800718; c=relaxed/simple;
	bh=7Y044RfAyAnYPPxwov64yn9PAAetech3yST1uGWNe68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0RwX5prLkH05tm8sxTv7gFgOAWQv1FhJ5zwUudL3DsX4wLPJjmcZQm598PIDTGcAUfpGMTX6z+51Vu1ROqZ1HROx1b/psqBEnLFR0IGwvFBPKm15MovtXPsIOHioWUdgvu7bCa6dQk5aijSjKV+HISHc/MQmhq36IK2cdaOqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K59Cf+Z2; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800717; x=1738336717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Y044RfAyAnYPPxwov64yn9PAAetech3yST1uGWNe68=;
  b=K59Cf+Z2fruHKw9XRvziR4RF0biLp0u05UBEJX/z1NC1NHabCBL5sod+
   MPojxtJT1vBRQNdgIGiexVsnpD3l4qEHZ5gQg5UozCCgZvU0clvf91G7v
   8v9nhe20gLdWLnAsn3DoeKe7yNw3FR0MRidcpl8SyC1MU4JD9TXaVZeoS
   Du1nm1lhQpfAtGGpXlsLXjKtvSWXwRURXHpjuYDB4REeekeKhuvxTOBLS
   xcb5mIwivMOVS58QbK2scUgF/fIQk8TZtv7vBXJIFXJspno9fLhcYNCEM
   a75QJDMV+MjPjkeuGuMFJuRZ35GAUUBp8YgMXZAssi0pRearGjtg3VYya
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="394367707"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="394367707"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:18:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822940925"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="822940925"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:18:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVYoR-00000000rso-2mm6;
	Thu, 01 Feb 2024 17:17:11 +0200
Date: Thu, 1 Feb 2024 17:17:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v1 1/1] pcmcia: Convert to use less arguments in
 pci_bus_for_each_resource()
Message-ID: <Zbu19xfahgI_dKLt@smile.fi.intel.com>
References: <20231030115053.2752588-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030115053.2752588-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 30, 2023 at 01:50:53PM +0200, Andy Shevchenko wrote:
> The pci_bus_for_each_resource() can hide the iterator loop since
> it may be not used otherwise. With this, we may drop that iterator
> variable definition.

Can it be now applied?

-- 
With Best Regards,
Andy Shevchenko



