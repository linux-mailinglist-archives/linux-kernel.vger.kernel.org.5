Return-Path: <linux-kernel+bounces-128443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF39895AE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4915828AB9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B847B15AAA6;
	Tue,  2 Apr 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+e/lanQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AE17BB7;
	Tue,  2 Apr 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079660; cv=none; b=nt114t7+FniA0jzo/D2tGEbozDjA/e0bmzIC3xB6aaj37a69MTIWnR7fRdLrlLyvt+DNR+fS0wQYU8xPzZl5ealor/2ej53no2x2y0O0zO+R5POQokdLbM+Cm/I2tFK5jfh5Xdvw2gk0Xy/8Z6UhQEBfa9Dk16Zpn6I+km1ScEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079660; c=relaxed/simple;
	bh=vhg0oaCb7THdZc8NXM2XN52ZqPajlyFdXUg7Sg0+Uu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEg2WNxp20ScUsNdHkrgMwhB71Z3tp7Qvz+dV+grChxEH4mPs7raxpwpc/qLf+77VObw819//AHjXnUWjxxwQxd09vuRmfECri291enOma2ALBEaWZQec8Qm4hFNjmg/zsIXw5pqY07Ti/ocuQ92H2wd50bQTaegTYLLElDzPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+e/lanQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712079659; x=1743615659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vhg0oaCb7THdZc8NXM2XN52ZqPajlyFdXUg7Sg0+Uu0=;
  b=M+e/lanQQBW/ai5nAzUL+blIz2jaRMT6cMQ8eoJBnpOnD8nmni0wLy6Q
   Q3BbeVUedb38HCY4oQt12BnjdfhAtUI2hmGhEo6wrLhVNGZTkkeb4zs9U
   3KQoVS1jKR8Z8NHomuOMCh/jVYPSOvUk5qs73uXvPnZV1eyH7GPK2Zztn
   f6s03IG52IJ7fevsWap/qb3vVAfRwk5bBB0cvVjX26IjyRham0DR2ZfXg
   AvmI4uyl70QCjAyhcc6etWwiMMni51bEEqARFSSaTxD+M0RDr9Uzy6jyN
   whtA8HrRWwyD6ygpLI/NlAMQFLAYKLgzRaY45+LIlSb3c5LGspw1VDCgl
   g==;
X-CSE-ConnectionGUID: YnCjPX6USDKQ9YIw7xQYMQ==
X-CSE-MsgGUID: NM1LW2YkTNyms/T9OxeBsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10235408"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="10235408"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915148327"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915148327"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:40:56 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rri7y-00000000stb-0xtv;
	Tue, 02 Apr 2024 20:40:54 +0300
Date: Tue, 2 Apr 2024 20:40:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 13/16] serial: max3100: Extract to_max3100_port()
 helper macro
Message-ID: <ZgxDJZmdzhK3aa0i@smile.fi.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
 <20240402154219.3583679-14-andriy.shevchenko@linux.intel.com>
 <20240402133209.910f63378eb40fa27363f3ed@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402133209.910f63378eb40fa27363f3ed@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 02, 2024 at 01:32:09PM -0400, Hugo Villeneuve wrote:
> On Tue,  2 Apr 2024 18:38:19 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Instead of using container_of() explicitly, introduce a heler macro.
> 
> heler -> helper

Seems v2 will be needed, I'll fix this.

> Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



