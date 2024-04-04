Return-Path: <linux-kernel+bounces-131353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CA68986A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCA728B2A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B0D84FD4;
	Thu,  4 Apr 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izz5NNCL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293D84FC8;
	Thu,  4 Apr 2024 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231967; cv=none; b=YBVV64nYySy0mxm8bpxBM3hvsbCJFMqj7M6Dq0XbSHz37g8K9QvvcL79AcPZxqAUAwyxkSK3HL6hd74UQOt4ABbmJtTwllRtO/xWwbPgEbCHL8dDouprpxs1lSmVG1Rw5TBD8HI+F+POJpg8GBRwdWY1ePII1Piw+eWjEFmyQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231967; c=relaxed/simple;
	bh=swy1eZbFCxFKWtpDguCItdi4aLCPH0dNfeYL5h55mrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeFfQagof0ZuvyoO6S79iF6+qnhW5LAm9zzd44KuxHB0NJbUOdzAeUXAmG2MypiI76yxCarXEXzu1XKV24tGKJIqTBQ7yBcolc7D7d+S4fW5ZErwePBT5mIYxbNE0qB/bsGKxGYoxCTW7OV0WjBj0t/epb9DwmmnQrjtc4cu1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izz5NNCL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712231965; x=1743767965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=swy1eZbFCxFKWtpDguCItdi4aLCPH0dNfeYL5h55mrw=;
  b=izz5NNCLd/uRn4L24Vhvzrlx6wJBbAtTmZbGSn4u0SLkDqTFSjYkzfzD
   cLXkN7AotY7SdsWnm8u7WimWLcgjS/nJHuVeUdXjcFtGy35mEocgMhpgR
   zjLaTR4SK7LQlFJoobGwVWLLxlU4luUtgv68QEvqhhi1+cRFP4l7IDBhB
   inyz4Mi4RRANn/9l0TtwTuNhP6ILLd8+V3ZAp33jAHKkF4JLx0HBon8YA
   oPZBkCxAB5YBJRA7aJH9L/sX2nB0YZ2smIySIf//2LuiAIEna0/83MHFz
   WtiWK/jXpmF6OB4EDTWubGNN4fr/A1YmEU2uPock/hxOBdxCAYzHUhW7o
   A==;
X-CSE-ConnectionGUID: 9P479gIdQL2pWziU7jm/PA==
X-CSE-MsgGUID: 1xbOcBDUTOWjNZHrUX040Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7349858"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7349858"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 04:59:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915216202"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915216202"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 04:59:20 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsLkV-00000001Q1P-1Yv5;
	Thu, 04 Apr 2024 14:59:19 +0300
Date: Thu, 4 Apr 2024 14:59:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [linus:master] [serial]  43066e3222:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Zg6WF0DMePE-V1V0@smile.fi.intel.com>
References: <202404031607.2e92eebe-lkp@intel.com>
 <Zg1hBvRAxifo50sf@smile.fi.intel.com>
 <20240404065415.GO5132@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404065415.GO5132@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 09:54:15AM +0300, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240403 14:00]:
> > Probably we need to check if the port is still open...
> > 
> > P.S. AFAIU the state / xmit is invalid pointer or so.
> > 
> > Culprit line:	serial_out(up, UART_TX, xmit->buf[xmit->tail]);

xmit.buf seems to be NULL, that's why this fails.

> Maybe we can set UPF_DEAD a bit earlier as below?

Lemme perform some tests later today.

-- 
With Best Regards,
Andy Shevchenko



