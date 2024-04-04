Return-Path: <linux-kernel+bounces-131640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4F1898A51
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF5228383E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD311BF37;
	Thu,  4 Apr 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiJyVHzv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0591182D8;
	Thu,  4 Apr 2024 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241757; cv=none; b=Aq1nLj8KyZzwe1Ortaduxs1nIVqJbNaUOAQMLlT60mGZkkvlNAiywwaKKEBMDkVqAvD2hX+g1TSKS0LetdBxfPUoIECzTudcAtEHaFonjb9psb+jPl+nncHOrX9nM/WoCnd+/FDEPJ1LbAOcA0ElAQPnpL40masNbKEXAiwwTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241757; c=relaxed/simple;
	bh=UTGGGrM2F/ayC3lHF5933J74dgJ9/c3oQCAPyRO10bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INwlwjjvoRsChwgyKCmmRhAYd2snm42+5qrsCFeGDK8mnKJ7tVCYDGL2Kja/TsxdjDsPVpZZ87A1XVciPonbDkqQ//7/EVEBkE1bRHKS4/4rjHvtqHqyfMS5BLkEhas3hG3cpcwK2S/2HCQz1TwApaxA43ph3U0wX26ICpgj6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiJyVHzv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712241756; x=1743777756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTGGGrM2F/ayC3lHF5933J74dgJ9/c3oQCAPyRO10bI=;
  b=XiJyVHzvgRKGstqwQMx2RTJqK6sPFiMvw8pC2VNKDGz1J/qCHPXeGCgT
   TR7TrpspnngN0pLLg/kl+O0/lxBKrHWVL+Yjc0aiWKkKxRHL/UqRmGVqp
   kSaMAvHrvVjGDrpvnhF8rlgW8teMl4YeL0Dt+WSKraxs/EyFGf4SuZvmy
   FKbpFijBKaGpzjc2KRM9zmtlxrIrviR5GAKh2TtybF+TjUEVyDAo28ACc
   509wnpGzg9YdXjdw5qAFQKp0RnwHdIeDUgEKfL7T0KoIXcF/aZsVtNsCi
   aLLfK05Uqr/5Fl0cC5T3O/YlBTxuYCxWQMvrWWukXKCJl2lDKxlxnmgPY
   A==;
X-CSE-ConnectionGUID: 365tAoy/TBqNXnhBpMAZ4A==
X-CSE-MsgGUID: bQHJr8d+T3uBXn/TyIDxdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7690168"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7690168"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="915220229"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915220229"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:42:32 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsOIP-00000001UBc-1qNB;
	Thu, 04 Apr 2024 17:42:29 +0300
Date: Thu, 4 Apr 2024 17:42:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [linus:master] [serial]  43066e3222:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Zg68VV8LW1A8g5BZ@smile.fi.intel.com>
References: <202404031607.2e92eebe-lkp@intel.com>
 <Zg1hBvRAxifo50sf@smile.fi.intel.com>
 <20240404065415.GO5132@atomide.com>
 <Zg6WF0DMePE-V1V0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg6WF0DMePE-V1V0@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 02:59:19PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 04, 2024 at 09:54:15AM +0300, Tony Lindgren wrote:
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240403 14:00]:
> > > Probably we need to check if the port is still open...
> > > 
> > > P.S. AFAIU the state / xmit is invalid pointer or so.
> > > 
> > > Culprit line:	serial_out(up, UART_TX, xmit->buf[xmit->tail]);
> 
> xmit.buf seems to be NULL, that's why this fails.
> 
> > Maybe we can set UPF_DEAD a bit earlier as below?
> 
> Lemme perform some tests later today.

Okay, so far it doesn't fix the issue AFAICT. The only reliable one right now
to me is clearing circ buffer before NULLifying it.

I'll send a formal patch.

-- 
With Best Regards,
Andy Shevchenko



