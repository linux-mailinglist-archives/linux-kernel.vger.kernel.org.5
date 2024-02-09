Return-Path: <linux-kernel+bounces-59408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD484F672
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE971F223A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEFF657DB;
	Fri,  9 Feb 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfeRV0ec"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB32E630
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487483; cv=none; b=cJl9ob0N930PR79bJZx0PpgMeK2zjQR+LybCjXqFWbzYAfkLcSS54w22TD+xy0R7WN10/Ma1iYAN8pUwc9lc+rdope7WXq6L+y3QvGpct8TEyQJNmndOTU1wr1l7A5vm8G3TP/fJuhm4fn2/9HWCXiRoWtxWN4x/RdjHhNkGzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487483; c=relaxed/simple;
	bh=vwibz1UBzunx12UaIjzyxed9fPynUv8i4klDAWlf9Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1OQI/h/x0zGnxfMCW9QTTXVzkcGUL0wExr7yAd8FS7Bv5sFUJI6HmASJs/bYZ7Rhim3DioEbZrQoBpJeXB1BZEs8+sKiJuUZF3MHIxVVJB5h/15l25idEvXgcRbSDsD/k8iZkF5pzXiSLUBNMwFT/+zvphsZa0duVmwbi9Y9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfeRV0ec; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487482; x=1739023482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vwibz1UBzunx12UaIjzyxed9fPynUv8i4klDAWlf9Ow=;
  b=BfeRV0eceV4GA6FvsU7lczUfU1mJmrFC4z48eFv0Fb8Jms5asfsGc026
   kYmns0g22p7W2jUa9fOHorWwPtpeDCkHpJD8hCzoQasaowsnRKYAl8hsN
   MIcylxrHEic9OlQc9pqkLIfYB9II2bZimp5lneeNDJQRoK1udP4ZY7buP
   Fl+3H/hh+T/Fj/fRCOkUwrBzJmRuh2XKvwCZLM5PTnFfk515aKUVDF0MH
   o7c6iWUAKEok9naWUngAmTHQN8vDU7YVdTthU9caUSAQlxTaffTcKD1wZ
   kSA1b0iK2xO9AEgx2p+52i02BA5qljou7EHPns9Sq8dFQK2ZDUZfdAXqI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="23911768"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="23911768"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910717014"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910717014"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:04:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYRUa-00000003AOw-0R6p;
	Fri, 09 Feb 2024 16:04:36 +0200
Date: Fri, 9 Feb 2024 16:04:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 1/3] bits: introduce fixed-type genmasks
Message-ID: <ZcYw8xH7xZJPQYpz@smile.fi.intel.com>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-2-lucas.demarchi@intel.com>
 <ZcUwK9DAVMVzq1Mk@ashyti-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcUwK9DAVMVzq1Mk@ashyti-mobl2.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 08:48:59PM +0100, Andi Shyti wrote:
> On Wed, Feb 07, 2024 at 11:45:19PM -0800, Lucas De Marchi wrote:

..

> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> 
> Lucas' SoB should be at the bottom here. In any case, nice patch:

And it's at the bottom (among SoB lines), there is no violation with Submitting
Patches.

-- 
With Best Regards,
Andy Shevchenko



