Return-Path: <linux-kernel+bounces-76579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7756C85F975
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C570AB23CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101313172C;
	Thu, 22 Feb 2024 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nz+D3Usb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529DC3F9ED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607897; cv=none; b=rrYBT8UJHRKHYxIy/T0olVOc3Fu3G4zg6B2LEH4XobFQupMxdqydiB/0dtJ7RiEQcHTfKCvI/eSr4QjJq9EMDV/eFmSkJYIFtDPB2GN5oPDmGjxv9eBNrZkkNXTX7hP9oPd6gJ/FNb8cPysBuHM8y5syIi86WVlSJ7tNFoSO63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607897; c=relaxed/simple;
	bh=hUBVl/lSvf+STyEZrx5DjJNHowgjyI3x+RDu23Q5g6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFhXjXN7dUYMuT9cYR5NFP8eblw9NZgwVkRlmWwy7i5fdqsLzbBlz3Bj7onG6ld42UHxIodgGIhxEmh5mcJ6CRdNrJjeV/U+lm75R93F+XlGkkSf5U0XblqLPvYnKfK18YaUzX12mjJBKeCf4xde4ElPK+yTNt92zrj0/euJCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nz+D3Usb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708607896; x=1740143896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hUBVl/lSvf+STyEZrx5DjJNHowgjyI3x+RDu23Q5g6s=;
  b=nz+D3Usb7kmOe9RUco85F1+1uDytTDwP3IzWslg/tjIH/IPAJAIAdlBH
   v10oFDgXyyp6979Ct4kFCcSHzTCZ/lc+90RDnJ7zkuM5QjljEC/M5ni/k
   xAchNAN7S1RtiY3hqFx/mq5FH/jhyPMckp7e0CooP9R/iiTNvj+Cyt4mT
   PyUnIsUru0FHmXXniHfMt4W+ZCw3AVcoS1DgYc/knTzhQN5IdeJI4bGqs
   2RmFo65Ub7IOn9ObIcWqdw2NN1gdXH5cPn2qs3GU377As0hdEyIAgzksb
   u0CrZ5qANHNAY1jdK/CfSe/cbULPEDv5ov7yTeLhDbKUST4+5fQRZb3du
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14246335"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="14246335"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913522761"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913522761"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:18:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd8xo-00000006dSs-1euh;
	Thu, 22 Feb 2024 15:18:12 +0200
Date: Thu, 22 Feb 2024 15:18:12 +0200
From: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org, 'MyungJoo Ham' <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v1 1/1] extcon: intel-mrfld: Switch to use dev_err_probe()
Message-ID: <ZddJlKoxp8AbyKSK@smile.fi.intel.com>
References: <20231222161954.2955905-1-andriy.shevchenko@linux.intel.com>
 <ZbuJ8zCEfU-ORmk_@smile.fi.intel.com>
 <CGME20240221145253epcas1p181803bdcfac50532a85ae191fe2e85f0@epcas1p1.samsung.com>
 <ZdYOPISUzbjid9l8@smile.fi.intel.com>
 <001001da6552$64c02a90$2e407fb0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001da6552$64c02a90$2e407fb0$@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 02:45:51PM +0900, Chanwoo Choi wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday, February 21, 2024 11:53 PM
> > On Thu, Feb 01, 2024 at 02:09:23PM +0200, Andy Shevchenko wrote:
> > > On Fri, Dec 22, 2023 at 06:19:54PM +0200, Andy Shevchenko wrote:
> > > > Switch to use dev_err_probe() to simplify the error path and unify a
> > > > message template.
> > >
> > > Any comments? Can these two patches (with
> > > 20231222161854.2955859-1-andriy.shevchenko@linux.intel.com) be applied?
> > 
> > Ping?
> > 
> > It's more than two months passed...
> 
> I'm sorry for late reply. I applied it. Thanks.

Thank you, there is the other one. Can it be applied too?

-- 
With Best Regards,
Andy Shevchenko



