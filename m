Return-Path: <linux-kernel+bounces-137314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E515989E07B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305F6B24340
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1476713E3E3;
	Tue,  9 Apr 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B51Ub3Qy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED4A137C2A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679916; cv=none; b=WHyvqSPMrBP/m04oSa/GAHrO2RENdT69bD8ZDFzwOv0rS3DveZinV3YdfCelfRZtiXXnQ9qAj2GCvqBMJthRUWm556Jd8niF2/W48EhOZbZarkutW2WktqDs/bpDHv7uSGUnhZDtuHzRAid5/HrQq6G5+NOaRIU84Mk/TW6X928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679916; c=relaxed/simple;
	bh=+cjrGu90UubJL76esXMipBZVAl1+63up9ZPbsgzMTl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hScpEnYHMqlBXjL+gb0bnQ/ykwH4boMAKyS5oi/QrauprhHPuQNtpgj3264YkfIZHPzQFzFrdqIKtAfg//C+5XCrh+UNM7PBN5O2/zum50iOz7lXEGMOA1kKa1qGk0GOHCYxNbejbB0OYg/vXuYGWG6ye2YkJuL6VhQIvrAMp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B51Ub3Qy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712679915; x=1744215915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+cjrGu90UubJL76esXMipBZVAl1+63up9ZPbsgzMTl8=;
  b=B51Ub3QyiZN0LCTyIe0mJi3kMBos1UeXjaoEianA3sRqX2yRwiqQggZi
   n7LF3bEsNyTwDKULbzlmBtdOUQJ1VbsLExxFCx3XO2Pv+GS29BhK9CmKO
   CKKdSrMfxCrV4JD+PQyLls4a4D5yBPDAscopnj7+weTT65NlneupvP0KX
   9Cjr2x/zeONMes+q8vM16TJB+6ozlVeAqbjFHkp3srBTR948Kt9tVVQpn
   a+DoDDYjx6FTsUIOpiIYcGGaTssbyiaWl00OFjpRI1iwK13MPyE3kzD5f
   rqxao3YQPTwpFdVZ4brGIfM1eaqDmuoO/nvglPeDxDyBFxNHcBJi/AfYz
   A==;
X-CSE-ConnectionGUID: iktY9IiZTnCtwSUlOZRoGw==
X-CSE-MsgGUID: 7rjC0sP8S4+wPkglQCtTjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18610065"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="18610065"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 09:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915404275"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915404275"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 09:25:10 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruEHT-00000002r9y-0iDB;
	Tue, 09 Apr 2024 19:25:07 +0300
Date: Tue, 9 Apr 2024 19:25:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH 2/2 RESEND] sched/topology: Optimize topology_span_sane()
Message-ID: <ZhVr4i5F1uWyrJ15@smile.fi.intel.com>
References: <20240409155250.3660517-1-kyle.meyer@hpe.com>
 <20240409155250.3660517-3-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409155250.3660517-3-kyle.meyer@hpe.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 10:52:50AM -0500, Kyle Meyer wrote:
> Optimize topology_span_sane() by removing duplicate comparisons.
> 
> The total number of comparisons is reduced from N * (N - 1) to
> N * (N - 1) / 2 (per non-NUMA scheduling domain level).

..

> -	for_each_cpu(i, cpu_map) {
> -		if (i == cpu)
> -			continue;
> +	for_each_cpu_from(i, cpu_map) {

Hmm... I'm not familiar with the for_each_cpu*(), but from the above
it seems only a single comparison? Or i.o.w. can i ever repeat the value?
And what about i < cpu cases?

-- 
With Best Regards,
Andy Shevchenko



