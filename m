Return-Path: <linux-kernel+bounces-131372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D172F8986DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B782287BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA085624;
	Thu,  4 Apr 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YULxGPOY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A758526B;
	Thu,  4 Apr 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232696; cv=none; b=LNdyMpeW+M3+bs1VHBPpQdlw6ppgkI20/RWybMuE/HDQdYAOgStoFeI9risSx2VCBAUutz5KDiDqBHBCK6gx8x+pgKP7P2uykoPRUZJjaqdFUCkT1AUr/Zak41qp5xXGEXCf8BM6yhR+2ILTUaIgnSjHHsnJ6LsbjvCU5dBuI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232696; c=relaxed/simple;
	bh=252nTC/vhBKxpMQxxrSnCOB5cIOsD0sOThNf85Lyd+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt3R63pjZ2s3rKymwqZl46XWlwIF+AGcJAzuyIoCf9+vmH+vJQlnV+OwSLfu/EOCzZuLtPZON4SU3MSKq8RKR33ndZI7FDip6xfHM/wJGkreGO463joasZyI1+9mgE48OWMUAUtf+ljFbLc96lLL9HQXm+Phe7WU9jFSeNxtwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YULxGPOY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712232694; x=1743768694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=252nTC/vhBKxpMQxxrSnCOB5cIOsD0sOThNf85Lyd+4=;
  b=YULxGPOY598mkO055nluGox9L6Ogn2QR06ps0Rm+i2Fl97jPsiyWE2iM
   NakUqqlOW6oqYi3I5ygRYmD+bHiAjWO6UXcUlLyCt5n0B720qJgD+t56u
   ThpbM3lL3sqKSk5n6BxO9BdbxXWpQ6FdtRgjU5gd8YrFdPgCzIJ3wzJPG
   esDZjxpYf36KDrjvRicwcdKDP8MmtMlkPN0bX6zCv/Gk52JhGvukOGyeG
   NYem4tcTwpUk5vRH5ivQr0I30aaQU+eMQkSoHh3k+icoKmWQkAGBK8zDW
   qTqQRocpPzqknIdSDNvGEb0RwPLGMyh0yRyh1T/+mGGOiJ+Yn3o163XPz
   w==;
X-CSE-ConnectionGUID: 81W6Ei3dTJKBL+ouklEIlw==
X-CSE-MsgGUID: KfacjiFwQJuQ/I1nM035Qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7351512"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7351512"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915216427"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915216427"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:11:29 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsLwH-00000001QBP-0UJm;
	Thu, 04 Apr 2024 15:11:29 +0300
Date: Thu, 4 Apr 2024 15:11:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 0/2] ACPI: LPSS: Prepare for SPI code cleanup
Message-ID: <Zg6Y8AVId_R83yMI@smile.fi.intel.com>
References: <20240404120856.4109303-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404120856.4109303-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 03:06:57PM +0300, Andy Shevchenko wrote:
> An ad-hoc cleanup followed by preparation for SPI code cleaning.
> The latter will be done in the next kernel cycle to avoid conflicts.
> 
> This patch series should go before
> https://lore.kernel.org/linux-acpi/20240403170302.1073841-1-andriy.shevchenko@linux.intel.com/

Indeliberately forgot
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

(Code hasn't been changed, commit messages also stays the same, hence I added
 it from v1)

> In v2:
> - added Fixes tag to the first patch (Rafael)
> - reordered to get Fixes first in the series
> - v1: 20240402152952.3578659-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



