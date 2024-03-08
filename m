Return-Path: <linux-kernel+bounces-97086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 270BC87654D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A48287550
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B5364AB;
	Fri,  8 Mar 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LF7FWAoD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553410A34
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904526; cv=none; b=L8hx/Xv1uSWD9GzpmOwSCtFslfItMgQoZ6s6xbYtKxRPqKGUanVWZPsalnqgPaKI3v/oYeuZ8OziYGA/XW22YBlCtKoAvZHbtkLZ4wbVlt/BJuIfhITiDOR3V6Ta7Fl4jV7riAPEbPkXGvYjW/kK1VGiFdeZaC12EdbQAFzovlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904526; c=relaxed/simple;
	bh=pDtP91+/9FBnxVSNA2MPCx46kzd4j//SOx6TrloGR+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwcGtLTQEdxb+0oAlISd/58Ol9YMq7fZUt3LZ/QJHvfD8/+6wG/geHXuB5xesdQ+QK6Qm9SoKzWnAENeU+ztqkomVLLPX03laprbQ7TYYxz9516854HAK+Q0dI9X62ESkxlBZn3D6fRSSO0Ayzqnf6EgZch/ghj+rGqZtLg6Fgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LF7FWAoD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904525; x=1741440525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pDtP91+/9FBnxVSNA2MPCx46kzd4j//SOx6TrloGR+s=;
  b=LF7FWAoDBvL2kU8jCZN7jtlCM9iAtb6dO09JN0iU6ognQ4rqYFV/Kuav
   pEPwNv5MSDOIorNDn/TdEpnzpbNt5LD7fEHOafvZzS6+6pSLYeiqhcFZl
   duAT9g0XzWOC8Wq0beYvyviY/EYKRV6u5lBynWORPXghxaSt+PfZy79d8
   A8k6KTMOR2NpkV27qyBNJOMZn5B17KiqTnu1M7pnX+QLWuRchi46o3DMr
   dgoGkj8uBbwDjkewmXbgjtuFsQGTPtZNeAkLdkq7vqQ/UjBVzfU1rUiSn
   cF5KZclYgSkEkSaYsWMhTNnrSu7AcyLRnte5lNRRyNbTNCbfrAjEBr9rn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4492835"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4492835"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:28:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914246577"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914246577"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:28:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riaHA-0000000Aqk7-328O;
	Fri, 08 Mar 2024 15:28:40 +0200
Date: Fri, 8 Mar 2024 15:28:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] w1: gpio: A set of cleanups
Message-ID: <ZesSiO2Oojf5HTLM@smile.fi.intel.com>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
 <vsaqquulifmpk5fanl4i67nzag5huyibzy5lfr2jdsgk2dv7t3@5i4opts7npsj>
 <30beae0c-86fe-493e-b286-2573597a653c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30beae0c-86fe-493e-b286-2573597a653c@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 09:34:47AM +0100, Krzysztof Kozlowski wrote:
> On 07/03/2024 17:38, Uwe Kleine-König wrote:
> > Hello Andy,
> > 
> > I wonder about your choice of recipients. I would have added Krzysztof
> > to To and me at most to Cc:.
> 
> That's indeed odd (and reminds me Qualcomm proposing wrapper over
> get_maintainers.pl which on purpose put the maintainers in "To:" and
> lists in "Cc:") and I imagine people having filters depending on To: and
> Cc: distinction, but for the record: I don't care. People put it usually
> wrong, so my filters just choose (To Or Cc).
> 
> Anyway all the patches will wait till the end of the merge window.

Fine by me, thank you!

-- 
With Best Regards,
Andy Shevchenko



