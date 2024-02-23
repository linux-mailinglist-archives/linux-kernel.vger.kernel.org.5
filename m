Return-Path: <linux-kernel+bounces-78604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE618615B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF51C24304
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D7C823AE;
	Fri, 23 Feb 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHdjqIk3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73D8484;
	Fri, 23 Feb 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701860; cv=none; b=l8z69lkjcL59fFIELN9Agbfkh2nQ1qcoWhg0MMWlx32hYQ9Rk/TYN9jntA9qGO17bDFdBsfBuk8Hb4FNBE9WTK15czaKegnjnuDwMgNTGGrglMl4NwevfQpRh84ol6FhNZgo5TRiz3pc+ZH0+d/ObITN7a6AKqNb7cZ8HxS8MdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701860; c=relaxed/simple;
	bh=n1M9ODdndzesDDoGOlrNrkUhVypfznpSWOTOVRBHuqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzz+HH5t/jQmyw7EzDSFasWqc4/0+uy3SHlyYd6X7eFLsUCulKjLy5MEhiHD8POSj+jN5eRyfdEA3tWBIgfGRd+jfDeZ/+iiSXZP3cI+znaEaaZqBSdTK4pOCOlDWGeTV2+oVWBVch4602uKWVL2QDQY/DIYTebgsqTaSOVPRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHdjqIk3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708701858; x=1740237858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n1M9ODdndzesDDoGOlrNrkUhVypfznpSWOTOVRBHuqY=;
  b=bHdjqIk3SFwhU4imcdOLQbkpWX7cR3ZDoVG+m7FBR1Q4wbag5sqNFY+O
   8eCHowTmwHFgSJOA9bV1t15QAMTrlJhRkWNB3c4rxetH78wEv8OqRQQx6
   1X8vHQaiqKznCpnPJailh7iApqHx7D0HeAIYNkOQCxFoh0Ft9fmkCS83Q
   MrAcaumyvieo/bPAmiKToRmp8ghzTNAIPSV9wsieEIkZLqdV5WB2RWAAM
   PKhlkH00R+lAinJgKAJdC5zzvDTZXZK7yNKVxQ8ozJjFkFQ2tA+yFEbLh
   cRxdyn/krrYm8gJjtbuX5fcRXK39fp99af5hlgEEqspIc7eCigW2NUjQI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6837838"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6837838"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:24:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913748951"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913748951"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:24:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdXPF-00000006w0H-2Nh7;
	Fri, 23 Feb 2024 17:24:09 +0200
Date: Fri, 23 Feb 2024 17:24:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Saravana Kannan <saravanak@google.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 1/1] driver core: Drop unneeded 'extern' keyword in
 fwnode.h
Message-ID: <Zdi4mY15YGv1r4lY@smile.fi.intel.com>
References: <20240220175333.3242277-1-andriy.shevchenko@linux.intel.com>
 <CAGETcx8w8YhC89JOYkQgcXrZgqfXOUXHXq5+86OdHGSfqz0D=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8w8YhC89JOYkQgcXrZgqfXOUXHXq5+86OdHGSfqz0D=w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 04:52:31PM -0800, Saravana Kannan wrote:
> On Tue, Feb 20, 2024 at 9:53 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > We do not use 'extern' keyword with functions. Remove the last one
> > mistakenly added to fwnode.h.
> >
> > Fixes: 19d0f5f6bff8 ("driver core: Add fw_devlink.strict kernel param")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Saravana Kannan <saravanak@google.com>

Thank you!

I will send as a part of a series due to dependencies.

-- 
With Best Regards,
Andy Shevchenko



