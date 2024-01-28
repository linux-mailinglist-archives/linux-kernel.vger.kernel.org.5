Return-Path: <linux-kernel+bounces-41668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197B483F622
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D6C1C224D4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9432556D;
	Sun, 28 Jan 2024 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJHHwVZD"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408524B39;
	Sun, 28 Jan 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706455986; cv=none; b=Rfqe/0ru5mUvJqIEu8l6tdf6A+xqaO+33E5Wu+RvDSJSOqVQAV25MI9NkujwbEf3iHOyWPl7K63nL+fx+v2IBvRGXHvKT2TEB1yP/uGPem/ukihVaVekUcSAn1Mv6bo9J+hjB6JnnyFt2cQsx9AuFtkwotyPI+lLQQ84qqNfCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706455986; c=relaxed/simple;
	bh=v4IlAJTa40g79PNQvpu6vZR5qPIThE5gVQjHysgEezg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9vvpOiYBFvHFMGMWVLiRuDz5WeFHy1Ur1Db7CnsRMmLN7QtUH6dORUnfRanS3Lv8U4ULEZjHBxlWmDxQimzxWYrVJShEB0q9std2CCO67OthaFKnkZ8QpcHVaBSLbR4yQLFiqwgzibDSmQ/cFLM1V0R5O/jbRWmGiBWVMivv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJHHwVZD; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706455984; x=1737991984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v4IlAJTa40g79PNQvpu6vZR5qPIThE5gVQjHysgEezg=;
  b=PJHHwVZD8PzJ2tpC5Fu8VdoQsZCXL346oNAsmSe0Ri3Aw0j8E6tlpQcw
   /ptkHetOpD2b/HOpMrLMTcS76iHw6S0FKt1Ifc9GraM+iW/mMIIqj8EMS
   1smvffTyTjYWgeEl7apc8j3LLDkb2CeB9VChbk+nlYQ72tIiQgqb3/GEH
   tF3ClXLL1UuhTUq4M22i25jzrSH14LYWRO+x73RY4EUaPJceq4xgGgV79
   X1h6y1HRD16fpUUzOWNcXHQeP21x9qMsGsk5tBbZTsCVRjcs+n8Zk8k1S
   DfIYlz5ULGYwzLfPlWbXUFu1CWkZqKWL3FpzFB/HoWgwujqQEx/ScHI21
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="406506870"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="406506870"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:33:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="857865944"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="857865944"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:33:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU75b-0000000HUSl-0Xhx;
	Sun, 28 Jan 2024 17:28:55 +0200
Date: Sun, 28 Jan 2024 17:28:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: kumaravel.thiagarajan@microchip.com,
	tharunkumar.pasumarthi@microchip.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
	f.fainelli@gmail.com, john.ogness@linutronix.de, tony@atomide.com,
	tglx@linutronix.de, jiaqing.zhao@linux.intel.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 tty] 8250: microchip: Add 4 Mbps support in PCI1XXXX
 UART
Message-ID: <ZbZytn3N0R8XNiF5@smile.fi.intel.com>
References: <20240125100619.154873-1-rengarajan.s@microchip.com>
 <ZbZyW_g4OOkCqIxf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbZyW_g4OOkCqIxf@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jan 28, 2024 at 05:27:24PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 25, 2024 at 03:36:19PM +0530, Rengarajan S wrote:

..

> > +#define UART_BAUD_4MBPS				4000000
> 
> (4 * MEGA) ? (will need to include units.h, if not yet)

..and use proper namespace for the definition.
UART_ one is not owned by this driver.

-- 
With Best Regards,
Andy Shevchenko



