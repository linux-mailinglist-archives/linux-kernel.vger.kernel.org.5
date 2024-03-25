Return-Path: <linux-kernel+bounces-117478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FAD88ABD6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0029F2E4DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C31422AF;
	Mon, 25 Mar 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoUSLqoV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A412C551;
	Mon, 25 Mar 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384460; cv=none; b=tK57pIMPP8Pdj2U7uFVY7G8geRB20Kvqot+yssEY9bh293A4pquFrwkcA3FzqhOFwC/BAxPII2ad4LYkmP1fcDu28bX6cQH0mcA9UpU6n/BkhTWeX1pl6yDNvME7tNRP8bnzqsQ1sbojD318weMLlLds40DEsIvN25dKKoPXmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384460; c=relaxed/simple;
	bh=UAS46IJcG3uBdN1lZzwUuv04mLPkLsl6ZrWX5laSLr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2kphqHuizNY3xN+W9oavBShV+riV1OG7lvdoOUf8udPFy3THQZfC+BFjJ9yL97CgT5NsWKSZrKO/PGWglwbXU0nytsBwBxz47VEA+23CvVxUzuzDm6d6B28oC1PNo/dfgmyPQSSWD0glUJeI4HcTWFAHEobeOB6c/8PIV0F1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoUSLqoV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711384459; x=1742920459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UAS46IJcG3uBdN1lZzwUuv04mLPkLsl6ZrWX5laSLr4=;
  b=IoUSLqoVil51f+VxNGhTyfe/oQJLv64aQ2V1DdpfD8JtFdyg7yPXxXnD
   iiMlEETUvq5bHw4LXpPijGb7PsUc9LKeOOh4QPoI8Pa0euc99tB8zQA6B
   gXwz3M8so/UUUf7kUXpiLaz98owp61S3YVys7kxZDwatEiMpQ3WVHIlqz
   Z7OVQs8tkfqI2o7XzDyrELA36vjTfzR9fxJDyPPTLkPkbp//58bK9R85a
   FYDuUH67yaOW8V5eKP4G43Ept/ahrmFBFRpQfFZfL8Byk+T4oxZKAKK5w
   uBItdOsMTcXSE3b6p4jx8VUuFA1oPgXW2b1IyX57CTyFjK0RqmKXK9a91
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17028825"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17028825"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914848583"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914848583"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:34:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ronH4-0000000G31d-0sTY;
	Mon, 25 Mar 2024 18:34:14 +0200
Date: Mon, 25 Mar 2024 18:34:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/3] hwmon: (pmbus/mp2975) Replace home made version
 of __assign_bit()
Message-ID: <ZgGnhTITTPpKr4rf@smile.fi.intel.com>
References: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
 <20240325120952.3019767-2-andriy.shevchenko@linux.intel.com>
 <e04c9300-b9e8-4ea9-8d4a-464f82cbdb0c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e04c9300-b9e8-4ea9-8d4a-464f82cbdb0c@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 09:29:11AM -0700, Guenter Roeck wrote:
> On Mon, Mar 25, 2024 at 02:07:42PM +0200, Andy Shevchenko wrote:
> > The newly introduced SWAP() macro is quite generic by naming, but
> > moreover it's a repetition of the existing __assign_bit().
> > With this applied, add a missing bits.h (via now required bitops.h).
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Not sure if I like __assign_bit() more than SWAP(),

To add to the mess, we have swap() already defined globally.
This one steps on our toes.

> but at least it is "standard". Applied.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



