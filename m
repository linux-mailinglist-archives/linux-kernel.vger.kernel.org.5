Return-Path: <linux-kernel+bounces-61746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED8C85168E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C440B2ACAB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08353FB39;
	Mon, 12 Feb 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izXezvMy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825AA3FB20
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745529; cv=none; b=T5ZSSLiXb/iBpTEAekRENk3F/6esAGVudmDy4/0akTlcaKapdN3dlk6vX+wS3dEdYnsT3gWZPCO4bExt2UJ0xrTfZ6NAXStzNnb/mDaO6zFLDXqB49IDOcr8WExa4L/+c7jeEy79LxSlvH+17EzS0m6t2SWohLglmem6s8GgHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745529; c=relaxed/simple;
	bh=Vfzvbpzr303m6zym/V/4a84x1/vetDMZiaeagqOm0nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vtp41rru5DA8n2rdtkDpjuxiaxCVSLPSeeZbaF5S88VuEcCSJ3u4bjduGYP3hE1E5sZae4EZwlw8NY9eN4GR5wP1sS9XKnq37UA9+RT/ha9u7uC6qwHglAZCE2Gv8dLTKcETdtblcDPS/xWfjRnNZm6SgbS6YHWrFEShv2Ggqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izXezvMy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707745527; x=1739281527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vfzvbpzr303m6zym/V/4a84x1/vetDMZiaeagqOm0nY=;
  b=izXezvMyD84TI/qcrJYcwG6XE0dO6qhGhdctvnyupl+hi2WHx3BKJR/3
   gdaNsxBjIxc1g+QWunfIjJMo4DnLinloO9m/61YvqFOXoRaHwqJDgXRu7
   W/HGkBAa0Eze3q4MbaVt3dda7YyJoFLyLNSXjH6zeaOIv1YLE3JAXOmYW
   UkimaC5ibFX+rAphlHkwyB06WdQiMX+UdmAqeg0G5YbNNBpQPgpJDf05L
   iQZnmpt0T8GMEPpk3B+ohv/j1V2/pCpyR5fk8u0RTBpEEEA5qsN2fgHT2
   4TUCNvlIBura2vr7II2XGWksLI3EMcWLxkQrs/6+f64lbbBpluZAFGUyO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5534024"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5534024"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:45:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911485353"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911485353"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:45:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWcc-00000003uT6-3RZF;
	Mon, 12 Feb 2024 15:45:22 +0200
Date: Mon, 12 Feb 2024 15:45:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 1/1] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
Message-ID: <Zcog8iRIMZZ7JyOq@smile.fi.intel.com>
References: <20240212113653.2625776-1-andriy.shevchenko@linux.intel.com>
 <ZcoSqHIknAvalzf4@smile.fi.intel.com>
 <CANiq72kmGVwFo6hakdcFN6Zu9yDg+e+41W4HHEj1q-S_TV079Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kmGVwFo6hakdcFN6Zu9yDg+e+41W4HHEj1q-S_TV079Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 02:37:24PM +0100, Miguel Ojeda wrote:
> On Mon, Feb 12, 2024 at 1:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Okay, Geert agreed to be a designated reviewer for this and I think I may
> > establish a separate kernel tree on git.kernel.org. I'll send an updated
> > version of this.
> 
> Yeah, of course. We also need to move it in `linux-next`, so I will
> let Stephen know when you have it set it up.
> 
> Thanks again!

That's the next step, when we have the other things being established.
Consider to tag my v2 patch series instead of this one, thanks!

-- 
With Best Regards,
Andy Shevchenko



