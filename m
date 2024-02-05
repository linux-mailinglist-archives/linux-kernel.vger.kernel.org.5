Return-Path: <linux-kernel+bounces-52747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129ED849C34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C338B284CC1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041A210F4;
	Mon,  5 Feb 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwjTn0Vc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9B22EF8;
	Mon,  5 Feb 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141008; cv=none; b=M2Kx7duQupggliXeACDP/rNkb6d/wzX3FAWxq+8bGZNbfUhVlnqsus56hYXVANlVurAzUs7ZKvEwwGRgL9HTkUZz3qKAjPCigioxT3moxKO2wjEQmuWS3lW8rAA3+a5tGKzRAxrmj/PMvkiLo7tt2yfxu/RsIgtkDKc+tuCJppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141008; c=relaxed/simple;
	bh=OhhX8ldNOaOSmWoLaFHyAg1ttzE1fLMG49T8A9iVixo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=px2B1rBOCphi+T+2EM9p7YWilT3xB4D/NuhN5dAFSlNU9e0tTFhqg4Vc4neTM5xDsSXT+yASfTu0XPL8BkX8hpeY2v9V+IPBaf+vOu08v97+z2SKEMScccaJdG6vIktTz5d0rvImEd0zlq2zogphJF73i7ZcEJVutFsq2g+Oo7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwjTn0Vc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707141007; x=1738677007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OhhX8ldNOaOSmWoLaFHyAg1ttzE1fLMG49T8A9iVixo=;
  b=ZwjTn0VcxdUo+9GMsoOnyDvlSwhHa8du3EqyAX98ETEF6kW78fdWkrXk
   Q9xlpVQnG5oJNUvyqV//wOLZnaXU7az1Nl6/153afIqWStGkEheDKTRr6
   mR8ZmMeq9pJrUcIgyCyxyVpUyOgcpCQHOuByyXO5j1xMiBiMXsQUB2JbX
   I78UOtf0MLpyR3RIGCdL8il67vwjS+A4exPsxnGdp+31pidB3hQ7qd4s3
   YX7W1c3yxchCYvPJ2HVPkLx1B2Gp2wqlVRT29QaGp7VZdAQYhl6876SJx
   2OvDd9IW0jk+miyrzbYusWuUvJTu/NWPS9QOjCQDdiJUiAYlEH2xqvqra
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="431102"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="431102"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:50:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909300593"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909300593"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:50:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWzMI-000000025qj-3UNJ;
	Mon, 05 Feb 2024 15:50:02 +0200
Date: Mon, 5 Feb 2024 15:50:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jesus Gonzalez <jesusmgh@gmail.com>, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding
 on some devices
Message-ID: <ZcDnikkiwSIDGzT0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo


On Sun, Feb 04, 2024 at 02:00:10PM +0000, Jonathan Cameron wrote:
> On Fri,  2 Feb 2024 18:30:41 +0100
> Jesus Gonzalez <jesusmgh@gmail.com> wrote:

..

> >  static const struct acpi_device_id bmi160_acpi_match[] = {
> >  	{"BMI0160", 0},
> > +	{"10EC5280", 0},
> >  	{ },
> >  };

Keep it ordered (digits are going before letters).


-- 
With Best Regards,
Andy Shevchenko



