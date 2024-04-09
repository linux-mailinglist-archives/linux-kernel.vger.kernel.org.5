Return-Path: <linux-kernel+bounces-137033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5389DB60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4B61F21E20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6CA130ADE;
	Tue,  9 Apr 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZVJLYTq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7957F7CF;
	Tue,  9 Apr 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670966; cv=none; b=SjXtmXyIB5TL2k5qIdE5HZS1pcZIJ7gyoPM18pxlJLvw1dtYxNbI/N8LTb+s8uxhbeF+EjL0X52j+CEYx/gQZoLIZ/xptiWn+RKqJeKYEJYHcC4eU1eBaE+7Gv7s3K9jZK/WeKzRbT9qlUUucDYOjg3QNrB/bk7cZyHXar54GqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670966; c=relaxed/simple;
	bh=RBSpeFzUgk1uKxLJIr7tftZLTft+Bs7jG9rcib8MkYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnF+504zDll/iUVmRxasBNjNKG0OqJc/PSGki14Y5UtLa3qAv9XYH5odI24oD4CKRUnvlN+tAwC6WaBLxZICFE7quIzJRS6X4TVcsh10zLYRR0b1bl78GDzr9MLtaKp1v4Dy4/uSmc5wFmswZxuf1ezXcfcrIab2xFgeyDzDNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZVJLYTq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712670964; x=1744206964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RBSpeFzUgk1uKxLJIr7tftZLTft+Bs7jG9rcib8MkYk=;
  b=AZVJLYTqr4kwuqTxA8wgsG8JSwHKOUzKWRe1bwM0aXi+iRqdrivg09HZ
   y8KPaliVUUNlu4NHPsSgWN35jdY0bG9A94WwLmh8E4k5rnKl/b1Jb2j8e
   2gR43P8ZjsxSDoR7KDuH5W8A6ON/k2IGf9T4XC7EakRLJ6jnh0whVl4GR
   BEGECxcvlgaqV/3PTl2HM0BuPCxnytHo+mPHqHXDzNzcI+yvsPRs6uRvS
   QLNjagfugdtf6qw+OiKg9m6CcsWEio6TMed9vJXee/Ab9sXB6VMEzNbOR
   k+WPrweblTVafdQIeJ4Ex3mZBE3iWvqVTxArhqAQlITuHlx8lJsTaVgsd
   w==;
X-CSE-ConnectionGUID: ZhEx+SRQRIWS1Yqp9QpUAA==
X-CSE-MsgGUID: rev2I3tiTn+P/G7MsJTphA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25426973"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="25426973"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915400508"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915400508"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:56:02 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruBx9-00000002oxV-2byg;
	Tue, 09 Apr 2024 16:55:59 +0300
Date: Tue, 9 Apr 2024 16:55:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH v2 00/16] serial: max3100: Put into shape
Message-ID: <ZhVI7wzYKrutk1LA@smile.fi.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
 <2024040903-handcuff-lanky-cc13@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040903-handcuff-lanky-cc13@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 03:52:19PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 02, 2024 at 10:50:27PM +0300, Andy Shevchenko wrote:
> > Put the driver into the shape with all new bells and whistles
> > from the kernel.
> > 
> > The first three patches marked as fixes, but there is no hurry (as it
> > was for ages like this in the kernel) to pipe them to stable. That's
> > why I sent all in one series and it's good for tty-next.
> > 
> > Tested on Intel Merrifield with MAX3111e connected.
> > 
> > In v2:
> > - fixed a few typos in the commit messages (Hugo)
> > - added an additional fix to patch 2 (Hugo)
> > - appended tag to patch 13 (Hugo)
> > - v1 (20240402154219.3583679-1-andriy.shevchenko@linux.intel.com)
> 
> Only a portion of this series applied to my tree.  Can you please rebase
> and resend the remaining bits?

Sure, thanks!

-- 
With Best Regards,
Andy Shevchenko



