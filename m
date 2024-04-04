Return-Path: <linux-kernel+bounces-131349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53CD898694
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5872728B8BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC2385C69;
	Thu,  4 Apr 2024 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGIPWXvv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03785276;
	Thu,  4 Apr 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231867; cv=none; b=MPQKuQQjoLTa9ZlP/HNL2ZC7D7ecYrimqzE5JP5YMBXcOA8LnI3mmqOd8dfukxXIsRWQhUtK/xdmC8qBHomIBFJTVQzcBsH449m/IkTjU4sCx2ASMSdbRh7JP5j5hkA4BW24L5Q5CfGqZia0qoL5zVY77Kpno1gQpay5Nuu9z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231867; c=relaxed/simple;
	bh=vfjVnDcA4y40C1ptsdkzs8++Rd0MHm7wYp7KYKcJhZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ortODAXbvv+CO8GcK4ysKj+O3ZFZciDOFaMCsv0yVXn1DeEk4hT31BeJn5VKNUQ2ZRT3bQtWlaCDULPtWos/5LPnuo91CxV57WDjknx+dBX0sfTl2idXoYOE95kocPfPEskTB1R7E/IgOoUIVWNWfkThbVJQmUZo4D1ClJR+cjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGIPWXvv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712231862; x=1743767862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vfjVnDcA4y40C1ptsdkzs8++Rd0MHm7wYp7KYKcJhZA=;
  b=bGIPWXvvYI9w38+N4HOIwsBTuDB9Bx8g0hRE6/CwnkiyEqJIMiOUQ0Lh
   6nFecPGgSa/x//O/3ePxupuR/w/lJMxqjkh9an1uo/rFy1IpEX/kkK8ow
   QX1o16mYuUwamwvYQ/W0KNuL95iX49XCgLdJ6LNu4oj5HIMNWaUP75I/w
   hOuhU9BFS5ZNwox75bYCxYt1mn9FUWR0QBRF6XgH+5xkCYILogz8BSyyH
   pz4tqbuVyfytRJb33LYYAWSO6sIPdDMqBFzvjcDl6vXl+52yRQxQu+XJi
   wUyYpuzmJbO/gczIRE6jSnUZr3BgBkUz/hYpbrnh6KFl3oAG1wpoA5HC5
   A==;
X-CSE-ConnectionGUID: IbiyF15MQtyWOHRKlXUWZw==
X-CSE-MsgGUID: +PiQYXwDTB6RKHJ1RyZcYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7349576"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7349576"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 04:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915216165"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915216165"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 04:57:38 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsLir-00000001PyV-2E4J;
	Thu, 04 Apr 2024 14:57:37 +0300
Date: Thu, 4 Apr 2024 14:57:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 2/2] ACPI: LPSS: Advertise number of chip selects via
 property
Message-ID: <Zg6Vsc-Uh-iUX8XB@smile.fi.intel.com>
References: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com>
 <20240402152952.3578659-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iQZXbFQFsZ+gL3==LV7UsqfOr-FZuWdoPSv0veUkuCrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iQZXbFQFsZ+gL3==LV7UsqfOr-FZuWdoPSv0veUkuCrQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 12:58:29PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 2, 2024 at 5:30 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Advertise number of chip selects via property for Intel Braswell.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> A Fixes: tag, please?

Sure.

> Also, IIUC this should be applied before
> https://lore.kernel.org/linux-acpi/20240403170302.1073841-1-andriy.shevchenko@linux.intel.com/
> ?

I believe yes for the sake of simplicity in maintaining / backporting
(if needed).

-- 
With Best Regards,
Andy Shevchenko



