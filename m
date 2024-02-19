Return-Path: <linux-kernel+bounces-71402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6085A4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212931C21345
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613C936138;
	Mon, 19 Feb 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqnPE57M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C4282E2;
	Mon, 19 Feb 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349348; cv=none; b=NSvoBhjKbE8luSqK5U6ITj+XMgI//M0TeT1T4eXlWAxIIY9Cv7cPBHmrVdn5Fb5o8EZONt+vsr7pbquFNGVDtnqK+EKD8mm3OmT06sYLIclRZMXBL8v+/TfjbdLrTGwrWgmlDookQMEJi6C6QSJO/I/4uvnQGvS8E0Aw71uATXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349348; c=relaxed/simple;
	bh=wlw1F94G/Aq1BD/qlvGvrNwe+KTsxSdkouhURA34fik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFGfkwCznrFQ1wR+PYQA7CVEq5kwmjdy8RK61i/9nUXQ+aFsR2m4jPitU3Pbu2DlGBZ71xNSQ+pY118VZN4jCBWdj9oNmchLNryHL8kZueTfnX4UreRvLbMe59V/2kK4w/iH5+pEzRRAPLBN8x/e5SzVL89oPp5+0ztNDjbuhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqnPE57M; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708349347; x=1739885347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wlw1F94G/Aq1BD/qlvGvrNwe+KTsxSdkouhURA34fik=;
  b=WqnPE57MmkliMP2zmtA0xk1yHzChpnAGaQAsSkFIc5TSx+JbGFZg83AF
   UWU5OEocVx223nom72zVVs2UuLT3RYsgCyDgl5Fq381B/Xkh7j+huaVoF
   uPv1eRn4HfHTFzXpyQekegy575w8nfw7Gu6944megCNgU7Ysf8VJfjE3o
   DJyo8lmSwArn40IO4bKbcMl1xH8iTsnrHwIlhCInO4IO/7oEvoTJ8GNtr
   V8XeF+7dc+fzVnqWX7QHVFdduGx6fE3W3bWeKoxcl2+pECvAhtLqPRNc5
   P3zC2NEpFr/gjTUiwgTMCupOWSYVOqAVeDXFkVB+N+jL3zYnOW4wIX6ba
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2873920"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2873920"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 05:29:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912877099"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912877099"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 05:29:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc3he-00000005pan-3kCr;
	Mon, 19 Feb 2024 15:29:02 +0200
Date: Mon, 19 Feb 2024 15:29:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 4/5] serial: 8250_exar: Use 8250 PCI library to map
 and assign resources
Message-ID: <ZdNXnoQ4vEr4irIm@smile.fi.intel.com>
References: <20240214171044.3551032-1-andriy.shevchenko@linux.intel.com>
 <20240214171044.3551032-5-andriy.shevchenko@linux.intel.com>
 <2024021723-spellbind-citadel-d2c1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021723-spellbind-citadel-d2c1@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Feb 17, 2024 at 05:44:31PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 14, 2024 at 07:09:37PM +0200, Andy Shevchenko wrote:
> > 8250 PCI library provides a common code to map and assign resources.
> > Use it in order to deduplicate existing code and support IO port
> > variants.
> 
> Looks like you have a build error :(

Indeed, somehow I messed up with branches I have compiled.
v2 will be issued soon.

-- 
With Best Regards,
Andy Shevchenko



