Return-Path: <linux-kernel+bounces-59940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9675084FD9E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D077287F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B73953A9;
	Fri,  9 Feb 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+oJ/k47"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B65A23;
	Fri,  9 Feb 2024 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510788; cv=none; b=GqGK7IXCRQWEPS4YeTJEtZm3Q9arnT6KYnfrgjT9VJK0GKsUYSgDq0lTyeHPanHQfA3BcuX/UseX0ssyPo7Za3ey1JSiX0zy7yr+fQ8bKR7MAUAYuFsW534n+2aWg8mMn4Nzbmss3v0l2I/eSTTXVGZdz4lOMSX8OvZGLC8hl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510788; c=relaxed/simple;
	bh=mofdcpGy1V81U1c8x+WzJOFneD0awWhMdn35ige/Lh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyicK+Azxt/0Zm11Yk8IN51GCTxF8uZCeVXHoakoEbPlfdT0l8wzEQgL+WKDnQN3UBHhkQdMM0zePegSk8WNbOIVqniF9seNqlYXalEgKflMFkK9A/KcrYBvabq5IwCKPu1LqiOlwewyMhpuAibShKr7Ou07hHXi/J0z6DGoJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+oJ/k47; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707510787; x=1739046787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mofdcpGy1V81U1c8x+WzJOFneD0awWhMdn35ige/Lh4=;
  b=m+oJ/k47WMWMsyfUTPk1J8Xl/5mvntuUuEx4GwsxPolMgHsx7tOnrX5R
   GBkSed/GhSbffCwCQZuZQIC9NkF1a5eKai/998LyXcdZ86jPBRxkplS06
   vjhHnq3cVB0/l7DfitMfrcVcSV5OXozA6gn13gO27fiyPdpPseFd24zNp
   73PzQP+Gu284jPf6zpuatcPLz1bOPubWftiaRIQNZlpqrmde0hEpX11vH
   +yz1PYGaUqsbqiJ0GK/Qt+iAbNegzLIyssc1R4Y1Ril8qw9FE5anE7iko
   W1a2kzo/QVJXo5XBldUF6r8WGPJaW7ODAwcYbngOA95A0CK6RRI0L6wy6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="4475813"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="4475813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:33:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934520600"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934520600"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:33:04 -0800
Date: Fri, 9 Feb 2024 22:33:01 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] pwm: dwc: simplify error handling
Message-ID: <ZcaL_VH2l5t9cx6m@black.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-4-raag.jadav@intel.com>
 <ZcUNxT4lxFYhZNBB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcUNxT4lxFYhZNBB@smile.fi.intel.com>

On Thu, Feb 08, 2024 at 07:22:13PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 08, 2024 at 12:35:27PM +0530, Raag Jadav wrote:
> > Simplify error handling in ->probe() function using dev_err_probe() helper.
> 
> ...
> 
> > +		return dev_err_probe(dev, ret, "Failed to enable device (%pe)\n", ERR_PTR(ret));
> 
> Have you checked the output?
> Note, it will duplicate error codes which we don't want.

True. Does it make sense to remove it?

Raag

