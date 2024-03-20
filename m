Return-Path: <linux-kernel+bounces-108757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2E0880F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5221C22248
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381123D3A5;
	Wed, 20 Mar 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3ck4nie"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B920DCC;
	Wed, 20 Mar 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930313; cv=none; b=Oh3GLLzWlfHFyYMIeMdUjvj5ez2uYiw+fqakZ8UIwf86SAwhKra1JjTcF12TqXk23YMG9zuvbsjMdaiRZ9Q5J5j7SBOv+/3S7k31oLGHpvk2U/5GfJMOX4n2JS3Bhdd/0Zl4B2YevT0u67wr+F0L7SUDgL/zNIh6BwE15+wkbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930313; c=relaxed/simple;
	bh=uTcargHZKKJsnlZ8QYB+opWvxlRzkGKEhRBmIEMOosM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnuyaZVl0uXua4wjRgYbimE+g1YkAf9X3bEJzaBkiWJ4+JyKgxMI6r6tFzUCsEdZXf3BIe3LkzuXMCdvFOLFl75V1DGBMSSw7U8cezK7bGXZ7nrGYfgrY0eQedp2TqZiZFdyK4VdFZ+hqTUVQaq0QyDdWMjEIpIDhYFaj9N5T28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3ck4nie; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710930311; x=1742466311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uTcargHZKKJsnlZ8QYB+opWvxlRzkGKEhRBmIEMOosM=;
  b=O3ck4nieOKRACVbB59zRZklqL9WqaUjX765FefxZDPDmITUdpGLwll3T
   P+dj9/aDhUX7fCzB9XZpkEw3WF+M62J8GJMYxPuliVJN3/iD3mIfRGMuT
   cQH47m9ts6GftbrUiUMqITSIqZrFUeybgarvMH8GcpkKYdadCYVDwAGKQ
   9yE4j4Pww/nw74NjSA1GE1+ranKLOVR/nl0j3MaJnO+YOSG0EpYDCJvcD
   EjQeRcGtmKvjIa7wI7y1obF2K+l0XhsCuVYpV5zVEEwslJiBXOxE2emSN
   SOY9K0gslD1zLTzVWShAPTvKMgohzoaiyDKQQZ2Mx3C/VdTNcG3BtSbaG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23303418"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="23303418"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914661971"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="914661971"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:25:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmt85-0000000EXTT-2jCU;
	Wed, 20 Mar 2024 12:25:05 +0200
Date: Wed, 20 Mar 2024 12:25:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] can: mcp251x: Fix up includes
Message-ID: <Zfq5geYx0KslkORy@smile.fi.intel.com>
References: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>
 <ZfloDwb0XMI7KryR@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfloDwb0XMI7KryR@nanopsycho>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 19, 2024 at 11:25:19AM +0100, Jiri Pirko wrote:
> Mon, Mar 18, 2024 at 08:34:10PM CET, andriy.shevchenko@linux.intel.com wrote:
> >This driver is including the legacy GPIO header <linux/gpio.h>
> >but the only thing it is using from that header is the wrong
> >define for GPIOF_DIR_OUT.
> >
> >Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.
> 
> net-next is closed, send again next week.

Thank you for the reminder. I have a question though.
Can net adapt to the existence of lore.kernel.org please?

I mean it's not big deal to me to resend, but:
1) it adds too much noise in already noisy mailing lists;
2) it brings no value since we have lore.kernel.org archive;
3) last but not least, it saves a lot of resources and becomes
   environment friendly when we send _less_ emails.

-- 
With Best Regards,
Andy Shevchenko



