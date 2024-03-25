Return-Path: <linux-kernel+bounces-117159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05C88A810
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB0B1C6056C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C118405B;
	Mon, 25 Mar 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLAOkfIb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D659B7F;
	Mon, 25 Mar 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374088; cv=none; b=mj6xNoUUneCA3SVSbe73scE+qgno7TKnoKb9ti+I7HaPckNGIP8DMiqu1VXfaQP0MkyhO3wXV61t1+fcBpe7xk9XYR3UCeuua2prfEbTnAe3SyXNiG3I14gEX4J0cui7Rk4dm1Onq2Z55Flrfq+eZGDhGKDtyi6BZk5/F6qKe10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374088; c=relaxed/simple;
	bh=rXc6zCv7Edh3plk8DVy9yN3hG/WFZbqbbOYMv5uOJvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jdccam2h53UmRqH0kk7y03Jhx2yMkgZo016Y2U3c+/NzUVBFWr+u/0rjEUXAncd+Qa2qEq16YI3w4cYuouyXAIqdt6kqSqKkmCwsnU6Ffr+KsdL8Y6V3ORjQaLVqbGyocf9WjQw+LSv0E6/eKxRLc3dvtUOhKYjWXgnLNC30Tck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLAOkfIb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711374086; x=1742910086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rXc6zCv7Edh3plk8DVy9yN3hG/WFZbqbbOYMv5uOJvU=;
  b=RLAOkfIb07MNuopAmgBi4t2Re5lg7Y23z8tPb8WbVGF/83XQbD6+4J6l
   Z4RYX0XjfbCpwcpCUUMau+lV8FTvmwQjFdQGz++8cKUSYBic/shlYR8n4
   fUMFVUUBBxvcvxPop9as8FQKtqlVFleU/zvVFjsK5Svv2Sw3MPpM1y+l9
   xZsLINq+JQ6WjzqEI/iJ1t5sFZfCyQ6w7rLexOz3xkSG8U+I0JzDGyGhS
   U9mZ+JngxPB8Tvn+qVv984uQ9J7Y2H1A0yJUciw5gc0Ista8QC4TpHHg6
   ETn8IrT0LH2+ZAQmtwarKC2ltfwzUGwKtgKzEHVg8cz3OYfVQ4ayEgK2G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="23860642"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="23860642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914843820"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914843820"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:41:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rokZj-0000000Fzr9-3BeR;
	Mon, 25 Mar 2024 15:41:19 +0200
Date: Mon, 25 Mar 2024 15:41:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Herve Codina <herve.codina@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <ZgF-_ww5k3h9pvEm@smile.fi.intel.com>
References: <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
 <20230227234411.jqmwshzkeyx6iqyo@skbuf>
 <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
 <20230301143625.7kdnzujlv4psbhla@skbuf>
 <Y/9qtT0vckSikOKJ@smile.fi.intel.com>
 <20230301152527.khyzifds4w3rkebt@skbuf>
 <Y/9wlDkuh39auAgF@smile.fi.intel.com>
 <20230301171845.oliqbso7v2vmyqr3@skbuf>
 <Y/+MaRO4vrCRFXE8@smile.fi.intel.com>
 <20230301174309.5nqul7vg5uygwtpy@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301174309.5nqul7vg5uygwtpy@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: people who might be also interested in this topic.

On Wed, Mar 01, 2023 at 07:43:09PM +0200, Vladimir Oltean wrote:
> On Wed, Mar 01, 2023 at 07:33:29PM +0200, Andy Shevchenko wrote:

Sorry for really late reply. I somehow forgot to answer.

> > Yes, that's why I remember overlays approach and FPGA case.
> > 
> > I guess you have very similar requirements to get this done: your case is a
> > particular one for FPGA, i.e. (re-)loading the same HW layout over and over.
> > 
> > I believe it should be discussed with them being involved. We don't want to
> > have two approaches of similar things in the kernel.
> 
> I don't think comparisons with the denatured case are helpful.
> Is "ax + b = 0" a quadratic equation? Well, yes, if you consider it to
> be a particular case where the coefficient of x^2 is 0. Do you use
> quadratic equation techniques to solve it? No.
> 
> I agree we don't want to have multiple approaches of doing the same thing,
> but I debate whether I am really doing the same thing?
> 
> If software nodes are not designed to be a good fit for my kind of use
> case, then what are they designed for?

I think the hardware should be described in the respective format. Yet, you
have a point that it's too verbose to the cases when we know the layout of
the attached (not-hotpluggable) devices.

There are discussions [1,2] on how to enable DT for the cases when
non-discoverable HW needs to be detected and enumerated.

I don't know which solution will eventually be accepted, but my personal
opinion here that we would like to distantiate from board files as much
as possible.

Btw, for the internal (board files) code we may also use property to
go with (see how spi-pxa2xx uses that) to distinguish configurations.
But it might be not that straight as with driver data.

So far, I haven't seen the code (am I mistaken?) which makes use of driver data
for software nodes.

[1]: https://lore.kernel.org/lkml/20231128084236.157152-1-wenst@chromium.org/
[2]: https://lore.kernel.org/lkml/1692120000-46900-1-git-send-email-lizhi.hou@amd.com/

Aux topics which might not directly be related (in order of declining relevance
from my p.o.v.):
https://lore.kernel.org/lkml/20231130165700.685764-1-herve.codina@bootlin.com/
https://lore.kernel.org/lkml/DM6PR12MB3993D5ECA50B27682AEBE19FCD67A@DM6PR12MB3993.namprd12.prod.outlook.com/
https://lore.kernel.org/lkml/20240217010557.2381548-1-sboyd@kernel.org/

-- 
With Best Regards,
Andy Shevchenko



