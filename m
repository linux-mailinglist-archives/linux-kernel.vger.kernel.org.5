Return-Path: <linux-kernel+bounces-73176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5D085BEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBF91C22859
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDD46BB45;
	Tue, 20 Feb 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Coegak4B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFE33D2;
	Tue, 20 Feb 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439165; cv=none; b=fj15MQkgeyU4+qHpRxCaGGRUagpVoQ+bu5KmX8MkBjBES+/hEzNxnSLftD5w5WMaAIpokdQKXwmyLJIH4dqBJYoh8khZWN09Mrw6eHFjB7j9VN1VlN5vWvywhRvqLGkpziuMCib1V/SFwDpup98bGcEFNxzQEbwvZSHsD9UIsE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439165; c=relaxed/simple;
	bh=bONvvWmk3kOvZYBjp0IbolILA+YFMyoyYSgD4Q190PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqYOViuyOgb49jJdeaGR2AeWp8T6tOOzI9LqTf+Sb5mf+kFq49OEKY67LlQDMh6yW20viKr3rJfK9vpzQe13PcdvgI6HgbRBrfotCjfo84V7jDHo+h1Ew3eOF8uXFLtDbTu1p65sSnuMQBaoU+4g8b6FUaDpmKqXIZuo+8QB518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Coegak4B; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708439164; x=1739975164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bONvvWmk3kOvZYBjp0IbolILA+YFMyoyYSgD4Q190PM=;
  b=Coegak4BQf7Y8dEKdUBF0TOJV0NU+yrh6v8eZnJzcSjKlxntgMy+FNvU
   oy5VohiSXSHq54GfHYl1PRDfEnQtqyyjhNGMyzxcH1SHtvmi51Q+w6Nae
   jYovs9J9SehU16s8TGzesl0heN4EG/8U/boR0Pn31XKBrjRASxLIR3+Aj
   iSz7Oosl9d22pVsoazEMGJHoX8U5FFK0/M7EIguc7e8reC2RfKjQ+TWna
   UjuPjIlqg+l5I/Vwnohhj/YQdsoeZ2D9QykHvQYzJXu7NXMSFpZ4s6MVh
   8F0A83OuZbv4HZc154YhHDryf98RiK/pDH/VC9LRWbGjWiP6JV7HSEmVC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="5499713"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5499713"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:26:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913084535"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913084535"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:26:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcR4H-000000066Zb-1afO;
	Tue, 20 Feb 2024 16:25:57 +0200
Date: Tue, 20 Feb 2024 16:25:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] wireless: Add KHZ_PER_GHZ to units.h and
 reuse
Message-ID: <ZdS2dRBPY8mj58rX@smile.fi.intel.com>
References: <20240215154136.630029-1-andriy.shevchenko@linux.intel.com>
 <87wmr5d4lh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmr5d4lh.fsf@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 07:23:06PM +0200, Kalle Valo wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > The KHZ_PER_GHZ might be used by others (with the name aligned
> > with similar constants). Define it in units.h and convert
> > wireless to use it.

> wireless patches go to wireless-next, not net-next. But no need resend
> because of this.

Aha, thanks. Note, I still don't see it in wireless-next tree. Is everything
on track?

-- 
With Best Regards,
Andy Shevchenko



