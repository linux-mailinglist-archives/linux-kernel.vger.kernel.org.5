Return-Path: <linux-kernel+bounces-88878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A24086E7DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0591C25515
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF7818624;
	Fri,  1 Mar 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzY11SU8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA711C88;
	Fri,  1 Mar 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315871; cv=none; b=Lk0WgXgz0ZO9VblXO3IfUqRW8WLRHavNg/ZTs2vqNGRMldIo741VB2+fc6bBt2MyRPlfb4bSD9X3ebuVZRc3hei9d4m1996hG4AkFUkrMCyQ0B+elBdRt4yA1Rx9lDm8mWrnbSqe0VRpN8onzb5AYcn1XFYLqhDMJdUvCn8APtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315871; c=relaxed/simple;
	bh=9U32FfVz5GFyN0u7mqtk0ZDcyLH33VVSuTSZTCpEwG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDZ2oaVZBSP76gb0qi0210vpKgYeL6OmW08Fb0VVuVMeOXRm/KjPEs6EhJ5P5TF3gy/MHWMiMjnVUaKP70sA5RLlNLYWodAwenwPLoyyAE7ObKZw8EGnflOgEVu6m+mJgSfkPlg2r7V32xjVKIAw/p6m+D8OIgyc+RFDViJSqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzY11SU8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709315870; x=1740851870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9U32FfVz5GFyN0u7mqtk0ZDcyLH33VVSuTSZTCpEwG0=;
  b=TzY11SU8jKfyxbWzv+qDxzu1HF1P4MX6vbA++8fIsPTqBexi2KqaRzZA
   PEfeJMdT0thuzV3zfaryicinmpxrP2zizOpf2ee9imDcJGWflJo+sLMwq
   bGpgK9ceT3BJfhONErJqrieWBa+vGUBeTOTI7bynnrRL8JgQANlJIduX0
   liIkHOWiZm708TxeOKADaNVav1/Sge9fe7KCyA2WHJMv+HWQXbXfcirKn
   2Yg/JfBnRTX7qaHwCnB+v0qe1/LE+EVuQjdtqjCfUrnBjG5FOxzhPmD1D
   +fmAFVSqpmu6bRx+GYDDt8Kfrip1eY1exmdgOd7iPQqwEwX2qvdKZbrTm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3727023"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3727023"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914021689"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914021689"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:57:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rg78h-000000091Mk-0p4G;
	Fri, 01 Mar 2024 19:57:43 +0200
Date: Fri, 1 Mar 2024 19:57:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 0/4] driver core & device property: clean up APIs
Message-ID: <ZeIXFqwe_bcUmRCY@smile.fi.intel.com>
References: <20240229162741.3854912-1-andriy.shevchenko@linux.intel.com>
 <2024022958-motocross-abdominal-e709@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022958-motocross-abdominal-e709@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 07:46:15PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 29, 2024 at 06:23:42PM +0200, Andy Shevchenko wrote:
> > There are two, but dependent pair of patches that:
> > - makes some of devlink APIs static
> > - removes 'proxy' header use
> > 
> > This is rebased on top of latest patches from Jonathan as it has a minor
> > conflict in property.h. The series can be applied directly to driver
> > core tree with reduced context, but it may be better just to route it
> > via IIO. Greg, which way do you prefer?
> 
> Why would IIO mess with driver core stuff?
> 
> I can just take it in my driver core tree, thanks.

Let me base on your driver-core-testing then.
Thank you!

-- 
With Best Regards,
Andy Shevchenko



