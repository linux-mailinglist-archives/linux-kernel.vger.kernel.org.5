Return-Path: <linux-kernel+bounces-67024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC38564FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32E31C24146
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F1A133411;
	Thu, 15 Feb 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OurA5zC6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B6133298
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005106; cv=none; b=g5yExhJ/luHjTdhsHOS5LOGtwRFGQsCfYZ5mT7VPe8/8WaGcjqO/Rlfe1ddJ7cl42vfrzNoBMcnEYY1jxQRW6u2G2IVok5bEVNHvYBnImoDoB+jmGP7RYW17iQ5zVYp7X0HqiY7PZ70sUsAGLUYgFpOQWlnTtlc2TrDMkEoe8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005106; c=relaxed/simple;
	bh=wcmjIxGB2DbqmTi/nOX3I60/8Enx7okKCq4LfkZVTLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlQO3CQv+AwmT+dPKFg5ODZtxBoFhDOUF0l7XN3uuWn2HhKw5HUHHWY279R7a+SC/LpvRrFgiv//kg6uGXq9wskiCftbXi7uJDi8nrQYUdJuD0qNOl8zjqGBDQLC963r3Brvg+BcUD0mbteXgBp5RF6vGkCXifeXGGZxrspI0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OurA5zC6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708005104; x=1739541104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wcmjIxGB2DbqmTi/nOX3I60/8Enx7okKCq4LfkZVTLM=;
  b=OurA5zC6qJGQr7mn04LD43UgZxxfnC1LHIg7fbNiru4aVzC4yCgMqn67
   WY84IkaIRpNv3oY/4B5Pm0r2JXt17axQN4GU2ZzycA3T/D0TQ/UhvMTh1
   UIp7+J9Nvrm6hOdiKh8BhHuiTD2h7g11SEydTlyVNRvmAFdNdIZmnxImS
   3xev1IyVrfwfboH5WTuXWCAPnB1ox5eFJj/07ZhVtyj7fg+haVE9JIuha
   Trn9HSDw+o4ZbkjHbQD6gePnp6A/J8JkReKbyYRt+xCGEs8PjvD41q4lI
   SOfiYceU6Xb8WsawN40JZBq+Im4UzyM2q4pNHKh4NX/VQvtcwlnLsm2J5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1964490"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1964490"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:51:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912168991"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912168991"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:51:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rac9L-00000004nsn-2Rj5;
	Thu, 15 Feb 2024 15:51:39 +0200
Date: Thu, 15 Feb 2024 15:51:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Move upper_*_bits() and lower_*_bits()
 to wordpath.h
Message-ID: <Zc4W66VdxC2udn64@smile.fi.intel.com>
References: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
 <CAKPOu+-Xy1E_bZMDJu8YQB_s235k3k3GcbeNNP=Vkn2aC1uk_w@mail.gmail.com>
 <Zc4Wu4dAJTXcGGVs@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zc4Wu4dAJTXcGGVs@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 03:50:51PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 09:53:48AM +0100, Max Kellermann wrote:
> > On Thu, Feb 15, 2024 at 9:49 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > The wordpart.h header is collecting APIs related to the handling
> > > parts of the word (usually in byte granularity). The upper_*_bits()
> > > and lower_*_bits() are good candidates to be moved to there.
> > 
> > Sigh. This was actually a copy of my patch which I submitted a week
> > before yours. https://lore.kernel.org/lkml/20240209164027.2582906-34-max.kellermann@ionos.com/
> 
> But it was not standalone and the series has issues AFAICS.
> Nevertheless, I like it!
> 
> In any case the wordpart.h is only in Kees' tree, hence can't be applied
> separately right now, so if you continue with a series it's technically can't
> be applied before v6.9-rc1.

Btw, you need to look to the patches by Ingo, you are repeating some of them.

-- 
With Best Regards,
Andy Shevchenko



