Return-Path: <linux-kernel+bounces-76578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C1585F974
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1B31F24880
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E15131E5C;
	Thu, 22 Feb 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVjktYGq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7012F381
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607872; cv=none; b=HsvvyXkV2Dd+q/TrY4MZnjZaLjr+YVBZjGb0I8XVWKWF8Haw9k3v70CWPuQJKxeR72ZohZfvpOfRkAOoqj2TWsUrx7JItx2g4L+LqEQ1HaW9YZP80tffsbupnmpi/QvBb7IwKfKJDYoijMfb0vAxHoD7jPWtxrzALXliQgvGLWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607872; c=relaxed/simple;
	bh=xBCbl14vD49pli8r5yv+02NnEeDwE1tbGIB9bKQyujE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFLBmxPkZu0hzcJrY05NP0pVhujQkYOIZOirzBLV2eJowFlh8T3kfbPDPK8b7EB0TCS2oq6QErLJFfJcUDt3QwOtvkj7QyXOy3Nrei/JdE/Y8BECv3s3/GSwRJMMVTog9uGq+DPyvknOPKcCoy0NCkccAjqxVbcs1t9KPQz2PNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVjktYGq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708607870; x=1740143870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xBCbl14vD49pli8r5yv+02NnEeDwE1tbGIB9bKQyujE=;
  b=IVjktYGqbQxlBBUqzS4herNnAXWd8kTKklGHHJCK6mabk9IdT7jK2ciX
   MCQDUUrcQkYMLcFtm8HNablumTVwJN+c4rnDEDTp/UkGanDZz9ek8jsJS
   0Y0nFC1cWj0U3str2drMIgpxFErzpcHkwaV3wBPxVb8trpLa9/jVU3WEe
   +YJcNnwe8rnwsjNduFHHjZMWotZvFyLQNGKhD3qQTH/q7fNRxZgridFrl
   aEvOTW1XqRAGNwa4ozpZYjHlVgy6EJQqzovtHwcbStat451AAOFmmB4xQ
   wNIN7jWa6dn8nsViU6X+8Mnc+zUaG0mRrnn0W4aHTbA8iPIsFTqhmutD+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14246295"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="14246295"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:17:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913522712"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913522712"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:17:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd8xN-00000006dSL-2Ptq;
	Thu, 22 Feb 2024 15:17:45 +0200
Date: Thu, 22 Feb 2024 15:17:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 1/1] extcon: intel-mrfld: Don't shadow error from
 devm_extcon_dev_allocate()
Message-ID: <ZddJeYhe8pCHup9a@smile.fi.intel.com>
References: <20231222161854.2955859-1-andriy.shevchenko@linux.intel.com>
 <ZcUqiaGI8N-FLijJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcUqiaGI8N-FLijJ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 09:24:58PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 22, 2023 at 06:18:54PM +0200, Andy Shevchenko wrote:
> > Don't shadow error from devm_extcon_dev_allocate() and return it as is.
> 
> Any comment on this?

Here is another one, can it be applied as well?

-- 
With Best Regards,
Andy Shevchenko



