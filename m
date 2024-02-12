Return-Path: <linux-kernel+bounces-61454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3024585129E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A2E1F238E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270D39AC9;
	Mon, 12 Feb 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3lQSYuu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7039FC0;
	Mon, 12 Feb 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738622; cv=none; b=jf2/RX6i46vdERRwZ1AOsfG7gor6mvjPKSOLFPMyuq0+tncS4ZTYwYmRc0qO3c/nRahOjLw2S0jwgMyVxziRI2HTTVtEU7/ajTuQI7aMvgIJKUFDer6xfybmiAjOm2+ODiic88ETbs97TcViGbRaPoHe3vqRB4aCwuknXe8OtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738622; c=relaxed/simple;
	bh=zJ060dchQ2Wc2UN/j+Vrc5RN6W12O560DY3JiXNzlew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyz+lVDW9R9nghSW+1ziq+K0wIbhpF0KX++Jsar5uW1QlG2t8T7aJUOU5ZLL2eS04X1SLUdaviUOVe8PDPSsa21Ciseb9JncsNLG3CkcZyGxnN6VgxAm6d6tDweLj3oidmMgzx6b8hMR+DutbmM6WxQJlaKgBD0bL3sHPtfnduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3lQSYuu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707738620; x=1739274620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zJ060dchQ2Wc2UN/j+Vrc5RN6W12O560DY3JiXNzlew=;
  b=Q3lQSYuuZltu8AFAbQz2LrouHm9aawJX2JMjpVh+ucl7C6ZySWAuGPlB
   GMwFMnVbGsaiGVoP3JVWAWgOW5MJWK15GtbfAQOhal7gvOC4hQkMmqVYk
   UwsFbbXsuhU2Sf0F8iQ4Nb313eFMmCf2rxoa86HeIB33Xx7MnCH9KmVCV
   XitcK1QXQJzbLMybCc5g5JG8pjkG5Q0DoDLOojUaQ2Z+3wxtMglD03Z3s
   DNXya3AelXGipYByPsiQhYKl+nTPF8/DUoZCLINwpO9GuvY8+DeGDmIeC
   +NssTpXbS2zoltQWHC41D+8ZPY3vBku5mmGcq3J8w+k203RMJrlVtrJNf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="2055106"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2055106"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:50:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911459839"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911459839"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:50:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZUpB-00000003suL-3EH2;
	Mon, 12 Feb 2024 13:50:13 +0200
Date: Mon, 12 Feb 2024 13:50:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Robin van der Gracht <robin@protonic.nl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 10/15] auxdisplay: linedisp: Provide a small buffer in
 the struct linedisp
Message-ID: <ZcoF9ZxPBkVS_6Da@smile.fi.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
 <20240208184919.2224986-11-andriy.shevchenko@linux.intel.com>
 <20240212092500.62f006cc@ERD993>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212092500.62f006cc@ERD993>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 09:25:00AM +0100, Robin van der Gracht wrote:
> On Thu,  8 Feb 2024 20:48:08 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > +	linedisp->num_chars = buf ? num_chars : min(num_chars, LINEDISP_DEFAULT_BUF_SZ);
> 
> It's not a big buffer, but now it's always there even if it's not used.
> And even if it's used, it might be only partially used.
> Why not used a malloc instead?

malloc() infra takes more than this IIRC (something like up to 32 bytes on
64-bit platforms) or comparable sizes. Yes, the malloc() along with the
linedisp structure might make sense, but will require more invasive change.

Do you want me to drop this one from the set?
(I have no hard feelings about it, as I see better way and just having no
 time for taking care about, as it's not the main point of the series.)

-- 
With Best Regards,
Andy Shevchenko



