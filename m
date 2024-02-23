Return-Path: <linux-kernel+bounces-78569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78986152A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37172282C01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80114823C6;
	Fri, 23 Feb 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A55PzkeE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF78BE7;
	Fri, 23 Feb 2024 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700784; cv=none; b=PJI4EsW/0nTp89ZaNy5BG0uAfsAXg+ptopougNM/b8fh50dfPGNlZOke8AIiI821V0udlVvD5BGF5UMaSB3etqo6sAgFTYfM/Qb8eLd8jf0fDYYZwPMVHreuDKWNK2V7unXgbPrRVjzbySBOr0t/yyNK5V9hinMJ8UVJKvt45nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700784; c=relaxed/simple;
	bh=DhqludqxWEdWFzaOd3Ag7hr7K/+Tti9ixKhnUJKWKMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCwgtVvRPKv99K9cCC805VwvT2d5lMjBywEsBtbxewvCqrO0qgumHRwqQz7gWBFnxu4vvzZzBU7NQLxwdJVhwIgGtcWT7csrg3tYY7asiU+v6Tk8+L3OXYZm719njynUeD9RHkO3NWKKitgE8a6uXe/tXqm95VG8wvwmeoep+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A55PzkeE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708700784; x=1740236784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DhqludqxWEdWFzaOd3Ag7hr7K/+Tti9ixKhnUJKWKMs=;
  b=A55PzkeELhnEgtn0Q2Ol++fD7lZEYBfoLlRWKjtx/qCJk0fELznqSEtA
   3sJI1LccFZTKWImmhGD3zTs6okQtKRlTfCVQlHEqMSfU91JMFMQa3i/4r
   cmbNvTOdi6lUUsK7jVmP4JKXd7yaOJUMOtP4jAy1OKKgjiq6qQ4xnvGfF
   2BEUuEDot34ZOWP7+eMZJ67qgsbFv0cY3Jsqca4idMeK89x3cC6d1BWyj
   jHmPMovLDIH6BXMg2Zq9h8fI76TIb8Ua1vgqkwvmuSkuGKrkjgVGl/gmw
   Lx/hB2OBDMygCy8v6f5mfevgk+w1qoyt9amvHNxaOxz2yf0ST20p78sIE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6834917"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6834917"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913748434"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913748434"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:04:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdX66-00000006viO-3Fyz;
	Fri, 23 Feb 2024 17:04:22 +0200
Date: Fri, 23 Feb 2024 17:04:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Collingbourne <pcc@google.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: Do not reclock if already at correct
 rate
Message-ID: <Zdiz9lWiCJ9Sg0bQ@smile.fi.intel.com>
References: <20240222192635.1050502-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222192635.1050502-1-pcc@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 11:26:34AM -0800, Peter Collingbourne wrote:
> When userspace opens the console, we call set_termios() passing a
> termios with the console's configured baud rate. Currently this causes
> dw8250_set_termios() to disable and then re-enable the UART clock at
> the same frequency as it was originally. This can cause corruption
> of any concurrent console output. Fix it by skipping the reclocking
> if we are already at the correct rate.

Makes sense to me from code perspective.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



