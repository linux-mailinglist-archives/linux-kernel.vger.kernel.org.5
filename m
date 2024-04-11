Return-Path: <linux-kernel+bounces-140233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4B58A0F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B22286479
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F2A146A82;
	Thu, 11 Apr 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVptyOIV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB4A14600A;
	Thu, 11 Apr 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830857; cv=none; b=eHr7M0mDiPCpP6NAlwueSkHKdjsHa2P4Yfup8hcxlfNSv27bWJlaF28ODZXiAXr+tkq18fqTrR8czyTxNONfuCaKwKkqEizkNyyUkizJ96bi0SBZgSumsPZ/3kVfTQ7cBjwTB0BXbE+9JUQjuQZz6oyhVFLU+QSciWlew22kmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830857; c=relaxed/simple;
	bh=1x/PkxfkX3229wBLwIHcxsQMEV1xkmCCZ2CTgH7kbKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT8Z4AyH4BsaVBXpFH5Xbctv7KEZHFYAkU7RR0rPIIDQEnlH6cTMcoDy0ltjZzv25FoOghpqJRh1k/A+gK0CeEagFG1pB1P4tyKZZbzKDHWFrjkAvV27KzVSAZCwqLQLISOUeFU0f5Oi1y2Y/4C7TKD+Zd5Ux79StA96pHcMCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVptyOIV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712830856; x=1744366856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1x/PkxfkX3229wBLwIHcxsQMEV1xkmCCZ2CTgH7kbKI=;
  b=CVptyOIVaEbKpuncNNGeVR510suiME4ZdlUffl31/byM2d80iAiAM2QU
   z8VLaus+j9xYz72MD4QjwKK6haquVSdD7SpDCuw8vT1bL/B4R8rchdia1
   mXgot9Yllz42hEbt9XvyZUo6nmSE+LWUdaj8NbSoeY7W+Rhqbr0fUl9V1
   uZHPcwz9vc5vYN9TcNiaIeGIs2Ucy7ANslJJC/XEkpB0JJJyvg0su5Mua
   17XYvVkB3G1n8VPGnzzN/tHx1kYDySIIMEzpG4Wv+kvbZ65rqm8gwd4/p
   i73pfR9oLXVrxtc69Ri1pnjGX+WQZU8ReyQZoQA6jd0JE9j0oqu0CV/vR
   w==;
X-CSE-ConnectionGUID: VAMo7WpQSqC6qnrD2FzjKQ==
X-CSE-MsgGUID: 9ThY3Z4uTo2H6KFBcUHT+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18941117"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18941117"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:20:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915459522"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915459522"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:20:52 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rurY1-00000003JuV-2NCD;
	Thu, 11 Apr 2024 13:20:49 +0300
Date: Thu, 11 Apr 2024 13:20:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Alexander Couzens <lynxis@fe80.eu>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH wireless-next v1 1/1] wifi: mt76: mt7915: Remove unused
 of_gpio.h
Message-ID: <Zhe5gbfhTh5V3jSh@smile.fi.intel.com>
References: <20240228200321.3607764-1-andriy.shevchenko@linux.intel.com>
 <ZhbOEqO4BIE4q7Vv@smile.fi.intel.com>
 <87o7agz4r1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7agz4r1.fsf@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 11:24:18AM +0300, Kalle Valo wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > On Wed, Feb 28, 2024 at 10:03:21PM +0200, Andy Shevchenko wrote:
> >> of_gpio.h is deprecated and subject to remove.
> >> The driver doesn't use it, simply remove the unused header.
> >
> > What should be done to move this forward?
> 
> It's applied to the mt76 tree:
> 
> https://github.com/nbd168/wireless/commit/b648ed2b4645e9cd0285aba576cb6f800c218b30
> 
> It will come to wireless-next in the next pull request, usually there's
> one per release.

I see, thank you for explanation!

-- 
With Best Regards,
Andy Shevchenko



