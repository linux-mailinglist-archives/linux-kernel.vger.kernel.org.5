Return-Path: <linux-kernel+bounces-131394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A489870E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305C2295049
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04BA12837F;
	Thu,  4 Apr 2024 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKjKxSi6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEEB86244;
	Thu,  4 Apr 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232946; cv=none; b=SaEuwH4LN5enqxdx1j9svExM3zUfkdKMHIWiky50WdHDxrIv6vozQx8EOjRUk9m+TlzlZQfsy4vsirq4mVYj9mt9iHFwGdqiGw9Jcx5qv8LrjUsB12KDEu64zAAOhPtLFC4GOiIW+xjNtSbXaDvvVr2cBY0YNDkY0g/X/9MtgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232946; c=relaxed/simple;
	bh=ExeJC1M+3bZl05QwBaKfCI9mym+Fc6VBmZBjMFs3yM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RArrUv7xJIhFZeZ+UqLwD/R5sG+1ESJiJ/afJbNtUSacIIGLlE2QbELJ8Slx8W8COLm+OVaP0NTJAT/7F5T1cNuITyaaNouroEIp154pR2oSwjM+ngunprGO1vgWouE6eYZShjtmHrWBtZNeNnCdT7/u2lszGo7fR8xA5ehv/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKjKxSi6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712232943; x=1743768943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ExeJC1M+3bZl05QwBaKfCI9mym+Fc6VBmZBjMFs3yM8=;
  b=KKjKxSi6qY+UA9lPHkkfz7bE+HAf8MJhK7dl0qc16nmxKocqHrlcJzVG
   d55VAkTId2I53uKgT2STFD8PcUJUXMNJ12qmMFbqeWO0bwnCHfFc/R+FN
   PCHrIzcNBqjDAfgZzrcKwo+4KJZcHvc0PY8xyTHIRRi1bq+DVwiry9glV
   WFZdy8lxaelzehgvsZxP2nhJYn0W7yEYGraBs57kuBl2Qb2DZd0FxFsCn
   XBtpb8yk5G6gFWVfJbht4RPHqg0yUvmNU7FNxQvLXDhQv2Y8JMO107fuw
   yOOL568q5nnKL0O9Rd5+73sB6pgqqWIkwqhJKnqFk+fbjntuTeuu1pBKb
   A==;
X-CSE-ConnectionGUID: eGOvBaEkRhGGklZqBU/e8Q==
X-CSE-MsgGUID: b0jMuyTPTs6ZkWU9QcJmAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7352015"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7352015"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915216493"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915216493"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:15:38 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsM0F-00000001QEr-26v6;
	Thu, 04 Apr 2024 15:15:35 +0300
Date: Thu, 4 Apr 2024 15:15:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno Sa <nuno.sa@analog.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jyoti Bhayana <jbhayana@google.com>,
	Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/4] dev_printk: add dev_errp_probe() helper
Message-ID: <Zg6Z51uebr2dWLq2@smile.fi.intel.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Andi

On Thu, Apr 04, 2024 at 01:06:22PM +0200, Nuno Sa wrote:
> This series adds a dev_errp_probe() helper. This is similar to
> dev_err_probe() but for cases where an ERR_PTR() is to be returned
> simplifying patterns like:
> 
> 	dev_err_probe(dev, ret, ...);
> 	return ERR_PTR(ret)

What about ERR_CAST() cases?

> The other three patches are adding users for it. The main motivator for
> this were the changes in the commit ("iio: temperature: ltc2983: convert
> to dev_err_probe()"). Initially I just had a local helper [1] but then
> it was suggested to try a new, common helper. As a result, I looked for
> a couple more users.
> 
> I then move into dev_errp_probe() [2] but it was then suggested to separare
> the patch series so we have onde dedicated for the printk helper.
> 
> [1]: https://lore.kernel.org/all/20240301-ltc2983-misc-improv-v3-1-c09516ac0efc@analog.com/
> [2]: https://lore.kernel.org/all/20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com/

Have you seen mine?

20220214143248.502-1-andriy.shevchenko@linux.intel.com

(Note, I'm pretty much fine and thankful that you take care of this)

-- 
With Best Regards,
Andy Shevchenko



