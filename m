Return-Path: <linux-kernel+bounces-133234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDB389A0FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1AB24F39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9607E16F8FE;
	Fri,  5 Apr 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l13UVQis"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5B16F8E7;
	Fri,  5 Apr 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330695; cv=none; b=qYMmtMCRgelW85vhBodfBVCE6JlSiKZ3z8Bq3haQ90T9PUIgOsOH9FlQ1EhwAmGb07t0NLLovZVRymwAyhb4L9DdEZd7DLW5IzdE0NdWCD4ecPeRt/VIWnr9cL+CxZo4reKhsN/keoP0xUTv4cPGwCeZLyKU0oPuDIKEvYuzYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330695; c=relaxed/simple;
	bh=GyDxE2CA81kKBR9d6tCMtIF9rih/K6NKJd4/EhB1CNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzXBjZiQZ329PtHIZq60QxbKVxih2JWe7cSXc+sAAhl1GTu69U3gsChd4+0NnSrzeTFhklL+K02qGGgBxnlQtLe1DK8xnruh/SR2npo1wHcX4zztkQLLhVwjPYD+JrpY1QOcjhUN4egJitahNp30EnaKchbExK+hHd3kIknk5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l13UVQis; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712330695; x=1743866695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GyDxE2CA81kKBR9d6tCMtIF9rih/K6NKJd4/EhB1CNE=;
  b=l13UVQiszEgnkWzs3Ya7fRqvxN3lSXRae1nLPW6bwXs2c1Mz6REegBKJ
   1Qm5UE5K6ZZx08lH02uCoVhsAa1jWgZK5E34OvU8EP2Y12TLm+xcYJ89J
   XEt9P83CEt17CMorjS1LI6JCrll5s6baRl/sUgEi1cR4VNhrnZLb4NKWm
   fWmKyNGImMBWc1npHyuO9A6rcXhjm8l5DfaskO7towSzA9kHSSVV98gfY
   5oJNFzIhoAZqGde3enacuGZPVak/8YPeYQffcL07nKqF9erGJKnicWqL9
   uer73xilQnIniNGzw5qsygl2Gt3fAMG5QXTOZSJ/Yf/yn6+2MVrM68zd7
   g==;
X-CSE-ConnectionGUID: gn7YmV2nR3apEaGvWLms7w==
X-CSE-MsgGUID: uGW8Z3lCQmO72K89ReDolw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18274770"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18274770"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915256912"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915256912"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:24:51 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rslQv-00000001ma2-21xQ;
	Fri, 05 Apr 2024 18:24:49 +0300
Date: Fri, 5 Apr 2024 18:24:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v1 1/1] ata: libata: Move inclusion to where it belongs
Message-ID: <ZhAXwWtA8ASDG89x@smile.fi.intel.com>
References: <20240404192111.3580578-1-andriy.shevchenko@linux.intel.com>
 <8e37f392-1ddd-4c8e-87df-acb3bb5bdf0b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e37f392-1ddd-4c8e-87df-acb3bb5bdf0b@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 08:16:29AM +0900, Damien Le Moal wrote:
> On 4/5/24 04:21, Andy Shevchenko wrote:

..

> >  /* libata-acpi.c */
> > +
> > +#include <linux/acpi.h>
> 
> I am really not a big fan of including files in the middle of a header file.

I'm fine to place it at the top.

..

> > -#include <linux/acpi.h>
> 
> Why not:
> 
> #ifdef CONFIG_ATA_ACPI
> #include <linux/acpi.h>
> #endif
> 
> Which avoids the union forward declaration below.

The point is to reduce dependency hell. The header does NOT dependent on
ACPI guts, that's why I really prefer forward declaration over including
a monstrous acpi.h.

-- 
With Best Regards,
Andy Shevchenko



