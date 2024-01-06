Return-Path: <linux-kernel+bounces-18593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE8E825FD3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111591C211A7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEDE7490;
	Sat,  6 Jan 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7gH1ZWe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB547483
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704550706; x=1736086706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6o5SASJAjHggjTPxF+4jiLSwlA4i/EomIqUIbo30sTY=;
  b=K7gH1ZWeRUcbQ7q0opRW7XXhx4URnZ21SVs9qTfsHShmkP02JvvITWv5
   T9dxwHCBE8aI7WRlirpoufCcF1EbEO+8N0GgE0btmuf1RNmwqOAfS/YTZ
   cdNAW/kHE+VGHfVqusGx2WSCL/lUKYzJcUlJKtqAozsg3NbmIeoeo51/h
   yfgsdtmRrSg1wQWbuI8DM1VUpmWsw/V8u5a12lmvlvt47pVvQFw+ZK/GO
   q4MeDbIjCRW2lP/eBr3ViEhwSE+UF1+ECtEhNRK4ak1YuCq0PVxog9c6u
   clhZoGqY6sruLZIm+4aZJrshLtEgABGrmfaTt1JOs21xSKsEolagiNDev
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="461958656"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="461958656"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="1028009404"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="1028009404"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:18:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM7VE-0000000BvWx-0ucP;
	Sat, 06 Jan 2024 16:18:20 +0200
Date: Sat, 6 Jan 2024 16:18:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marco Elver <elver@google.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] list: Add hlist_count_nodes()
Message-ID: <ZZlhK6rF8gSy0toK@smile.fi.intel.com>
References: <20240103090241.164817-1-pierre.gondois@arm.com>
 <CANpmjNPsBUJy6tkOdRSJyWrS9CMUOQhQyb7_hwmw68pjjiEDWQ@mail.gmail.com>
 <2f4a5ea1-daa2-4ede-bdc0-6692d7d52e8c@arm.com>
 <CANpmjNMqzYsSh-DSsdFz4D_Ad0sAgf9J1A6CBz4fEOXAS4ejjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMqzYsSh-DSsdFz4D_Ad0sAgf9J1A6CBz4fEOXAS4ejjw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 03, 2024 at 02:46:00PM +0100, Marco Elver wrote:
> On Wed, 3 Jan 2024 at 13:04, Pierre Gondois <pierre.gondois@arm.com> wrote:
> > On 1/3/24 12:25, Marco Elver wrote:
> > > On Wed, 3 Jan 2024 at 10:02, Pierre Gondois <pierre.gondois@arm.com> wrote:
> > >>
> > >> Add a function to count nodes in a hlist. hlist_count_nodes()
> > >> is similar to list_count_nodes().
> > >>
> > >> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > >
> > > Is this patch part of another patch series? As-is, this will be dead
> > > code, and there's no guarantee someone will just go and delete it in
> > > future. Although this function looks useful, we also should avoid
> > > adding new dead code.
> >
> > The function is indeed not used in the project right now. I needed
> > it for a private module. If it helps integrating the function and
> > not make it dead code, maybe I could add usages at the following
> > places:
> > - drivers/gpu/drm/drm_hashtab.c::print_binder_node_nilocked()
> > - drivers/md/bcache/sysfs.c::bch_cache_max_chain()
> 
> If this function allows to simplify these other places, by all means
> go ahead. That would look a lot better than having an unused function.

+1, produce a little series with those drivers being cleaned up.

-- 
With Best Regards,
Andy Shevchenko



