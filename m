Return-Path: <linux-kernel+bounces-73486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8234685C34F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D9E1F24A98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B24D77A05;
	Tue, 20 Feb 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBGAJPDE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952576C70;
	Tue, 20 Feb 2024 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452331; cv=none; b=usJMsYqbXPBCb7NakvReyX/m9X1VCtl7CxhNaGQ42t0YklxkpNJ4TLUFg+1Rq8y73sK2kMt0mieCOGUZhLdK25nI1MfW1jHxaW9h8s+lk/IUWWj5qw0tx7ZPG+oVsEDXCSaN07h1N03xgB7Pi+0FqmCn7x1PAcOeNwpqBFbB5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452331; c=relaxed/simple;
	bh=xY01WNSDg+fB4b3tzgDPOlMr8YfAE3F7j2PbUEDxlHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLUpRgCiIac9snN4G0mDzG+WCA/oikblj1afwXOHZquYwGHwJv5RtlMCtgJqeOOPR5za20o1ANP65tCBEVBvj/ZkEET9qCTgSDGdzCKRc7eovyP/shl/FWXabDJI6TpEwHPYxsZxmiiOWPnWorL1CNi8X/n4QWi7H/kYkbCdRo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBGAJPDE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708452330; x=1739988330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xY01WNSDg+fB4b3tzgDPOlMr8YfAE3F7j2PbUEDxlHs=;
  b=RBGAJPDExE66AXm4VwLxSBREE2jFUrJ+vbvROsJga32ZyMDT/cWl2Iqe
   fyA0BP5f01toMMUc5PPWUddLy2p7GVwR+7m6k2GD08PLjnJW4QaG5Qd6M
   I+HDm2RNLlUG6NzjZ5IJ/pIW/E84Gwuq9x9cRNVFB/N60AMTdkz6SQZeT
   luoNDCRWo3bHuX00cmXklJQb5Ju7X5e+UJB/a9jrpNsDsg2sJ54tqny1E
   lYoF5kSll9jceGu36K/C33OdYD5ROcvSq+tPaKnRh2Dm3r+DO7Gv1ianE
   H4k9UOLfqFrgmw1u2Tk/0mrhZgZj1EY5CORNHHf8dgZtogiqKKdk3nYqA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="3037655"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="3037655"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 10:05:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913118980"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="913118980"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 10:05:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcUUe-000000069WL-3Ueo;
	Tue, 20 Feb 2024 20:05:24 +0200
Date: Tue, 20 Feb 2024 20:05:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v3 5/9] auxdisplay: ht16k33: Define a few helper macros
Message-ID: <ZdTp5LQOTpL5ke96@smile.fi.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <20240219170337.2161754-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219170337.2161754-6-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 19, 2024 at 06:58:04PM +0200, Andy Shevchenko wrote:
> Define a few helper macros — wrappers on contaoner_of)() — for easier

I have fixed 'container_of()' above locally.

> maintenance in the future. While at it, include missing container_of.h.

-- 
With Best Regards,
Andy Shevchenko



