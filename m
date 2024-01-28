Return-Path: <linux-kernel+bounces-41663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B283983F601
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8371F21E1F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9823769;
	Sun, 28 Jan 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAd5oT8h"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB025776;
	Sun, 28 Jan 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454203; cv=none; b=Rn1cjpDk3T68WGVpcWv9ziNMeY1s2kJeEF+swdXyVY8T9tajC+Hd11rKndKZ1/e7lnY+1mL/xtoNneApewCBQNfn5cFHpEDBH+BNAC11RLxNPGm8rlpbAiafp12UcqU87tcfwFGPaakH3d15hcn28BLlQaAkuWxXazFrrC8VWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454203; c=relaxed/simple;
	bh=LxgPwOi6s8cRdAp/UoLC3e2ubN/oaoC82iDhatG/9BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdIVcnSdowotWYmNvufcsAWAC5EwXqKjrQvy9M3yM8jV7sFiZThfrnIu/TPy4xJs9qT9iSsyiqE681105w/sXZEaaK8q2yKHzqqWZQSv/TA85l9ASDGRr635KuyzBbroCuHk+jW5MQhItYORxzSfx4QuysHzK8eEL4qqvO0HV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAd5oT8h; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706454202; x=1737990202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LxgPwOi6s8cRdAp/UoLC3e2ubN/oaoC82iDhatG/9BY=;
  b=LAd5oT8hWH84nsdFxGDS8bJn5hUvgu4D9kuEtg9Nlyn/x+aXnROM3ZPX
   HQVHrsOCY9ChaI95TZDmHcYLxpTV4shLhtJDdgICNGI2TlW2hQR78TWE7
   hVMqnjbLssW1u2ahmC+WRNr/k3VbkR7NkvrLXYTbGz1tN/PwBMnspQdXb
   tW4MTcWnpFl3QYwlrpUiiq/+8XmxHsKDmC+2SIrtydyeuNMwM1/P7lXom
   FVijGo8cJURcEN3eBI6J52y9zoPAWZ2eDJiuDAh9Bo6KcS99SIBfpZ7u3
   +cekvVs10s77X1YGU3mwgh5HFVRj83iUJ1TUGdvs3gZ63kZgomsIheTSt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="433942752"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="433942752"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:03:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="960672167"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="960672167"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 07:03:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rU6bh-0000000HU6J-3HOx;
	Sun, 28 Jan 2024 16:58:01 +0200
Date: Sun, 28 Jan 2024 16:58:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
	edumazet@google.com, Nicolas Pitre <nico@fluxnic.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	dsahern@kernel.org, weiwan@google.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 15/22] net: fill in MODULE_DESCRIPTION()s for
 SMSC drivers
Message-ID: <ZbZrebRxvLmpamkM@smile.fi.intel.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-16-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122184543.2501493-16-leitao@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 22, 2024 at 10:45:36AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the SMSC 91x/911x/9420 Ethernet drivers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

> Please enter the commit message for your changes. Lines starting

Misplaced line.

-- 
With Best Regards,
Andy Shevchenko



