Return-Path: <linux-kernel+bounces-74944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B248C85E059
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F7DB28B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557A7FBCD;
	Wed, 21 Feb 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVZ2mB8h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB07FBB7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527170; cv=none; b=aU9PGLQkGjJBUCt26Ve5xTF4/XQhn9SDtvE6L8GbeGzhrxCk6BAoHwewcrVwjzO0ggHvSuEMeMySgvK/ZY0B+4AV9dEuO45Gt4xbeUy6eJGH4WRCbcjRR7RfefoX8PRrUw7uuhTTEqh8NL8aXjL4KeGJQnTkLkYUlECBET1IyBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527170; c=relaxed/simple;
	bh=zXfcecKK7a0Wq45pUBJhy0+SLFreUTI3cAZpFt+oZHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPgGLKTTy9/MH12OR/EqcS9/Qmnq3MRqapjI5KfKXzRhr/GAWD1fbNS+lnhrUEvLh94PlsD0XJsBU8OG+MguEYpllqbkplJ+kD0hudRBn8xTfzvadcrD0+IxItT6wiud1lc6mv71CkcQUU8ctozksHSsK4eEaZvY4qY30dG9nQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVZ2mB8h; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708527169; x=1740063169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zXfcecKK7a0Wq45pUBJhy0+SLFreUTI3cAZpFt+oZHY=;
  b=RVZ2mB8hgRRGgoOwaHBepq4Tvqjssltwfb3tqFoRFqkrZWu/CIgKtkju
   wlA42KZMnlK8WJ1PDjXoehP9URGnw+BFEvFbncXqpC/k4wBY0ilAAsq5Y
   81jW+y+ahIp27sZJP1/le4UFewAXQcD3rbXs3sujP6R4Tj2j6ZsuzfInY
   2KpjqIxtCpDMcj5sanI5UkGw8qgDIibDx6urjPDhGqiYK39Fo5vYf6N7O
   T169CLwoQGpTAVXNy5F0EScpbYMrr1Qw5n62epbAKLNJzbEZzKNWUO9se
   3DRwlooV5gQ3Or+xA7102ef4ts6gqrJ+9zUT7LlGbYGlglVqnEVQdJ9fe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2551837"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2551837"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:52:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913318499"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="913318499"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:52:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcnxk-00000006NPr-1yzb;
	Wed, 21 Feb 2024 16:52:44 +0200
Date: Wed, 21 Feb 2024 16:52:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 1/1] extcon: intel-mrfld: Switch to use dev_err_probe()
Message-ID: <ZdYOPISUzbjid9l8@smile.fi.intel.com>
References: <20231222161954.2955905-1-andriy.shevchenko@linux.intel.com>
 <ZbuJ8zCEfU-ORmk_@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbuJ8zCEfU-ORmk_@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 01, 2024 at 02:09:23PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 22, 2023 at 06:19:54PM +0200, Andy Shevchenko wrote:
> > Switch to use dev_err_probe() to simplify the error path and
> > unify a message template.
> 
> Any comments? Can these two patches (with
> 20231222161854.2955859-1-andriy.shevchenko@linux.intel.com) be applied?

Ping?

It's more than two months passed...

-- 
With Best Regards,
Andy Shevchenko



