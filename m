Return-Path: <linux-kernel+bounces-82018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9A867DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6792907DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6952A1353EE;
	Mon, 26 Feb 2024 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKdY0dNo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87912C55E;
	Mon, 26 Feb 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967106; cv=none; b=rWofvR3vCtn64VyRba/A3o7UiNiZgFQZHJpsZUS8nGeXgyxoC1uwgfad2SEP4+pyns/EzHQPOWYtvZhV7a/xxajXNS9hs1EBVjzo++fmf8gUw7LsxM5uYPQKvn4tw0ZcNC+L8A53g7cwSfoiE6FoyfmxCffHrsiFoLZ3/SbLB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967106; c=relaxed/simple;
	bh=MRsBgIxlb/4Wq6P8y8ODlq2nplU2xHNAakSQBx9Hqe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKcxylM0baurjMTspuJgLs8rLUsnndXcxDqgFlBgvco8j5dSd5A+/au5VtGVby5OcsaBKnnDKh3HEj/huOxkao0xINjYLfvEaERwcqhVJg7OS1YQplfk1xqbWLyjTOTGYC2sG3v/l0hDpfLzdOTTEQYYuwC6eB6MLSa0bvVX9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKdY0dNo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708967106; x=1740503106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MRsBgIxlb/4Wq6P8y8ODlq2nplU2xHNAakSQBx9Hqe8=;
  b=LKdY0dNo8EuSYIzbvJLkRlnZqXGkRLZ3Dl4j9E2hsG/MxJytbTBg3dDT
   m5R3Wnq3dIyEDgvi5wGRoPV6Z+3tXtapKt3POC/zPPOGJwcVh//gfNYA+
   x27NCGZpVa3JJXafjlZq+YRpoWNnGcQTx/TpS/Hk0IE4A9OeW3jotdQWU
   /p7oov2nWbSL+3VrdV9Y+m2WTs/MHU9SQHgUP7UjZXDJDu3S3CaaoXTVz
   5wNn+6Vp0r7juVh3pXLj/B+C48QHJ0qJWuJB2exnejijq/0wZ+7Me5C5k
   /Dny1RYE1mFB7QBCdQ+BxvasE+gNOGE372ItLRcYyV11Wq2JNxKC5cwlF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13905916"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="13905916"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 09:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913882130"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="913882130"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 09:05:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1reePR-00000007k7J-2SR5;
	Mon, 26 Feb 2024 19:04:57 +0200
Date: Mon, 26 Feb 2024 19:04:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v3 9/9] auxdisplay: Add driver for MAX695x 7-segment LED
 controllers
Message-ID: <ZdzEud8hZ2fXsVar@smile.fi.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <20240219170337.2161754-10-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWpepH0P8g9dPfq1rsZRJsvOnoZ7VnjqTL9nkSGtKFpYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWpepH0P8g9dPfq1rsZRJsvOnoZ7VnjqTL9nkSGtKFpYQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 05:01:46PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 19, 2024 at 6:03 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Add initial driver for the MAX6958 and MAX6959 7-segment LED
> > controllers.

..

> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

As per discussion, let consider maximum digits as a next feature coming later
on. I'll take this tag, tell me if I shouldn't.
Thank you!

-- 
With Best Regards,
Andy Shevchenko



