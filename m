Return-Path: <linux-kernel+bounces-117604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A3B88AD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169BC2E50D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BBD839F6;
	Mon, 25 Mar 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7gp0UkC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867B50A75
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387814; cv=none; b=pbjPniVFTiq7n8b6RA+RZF+BvAclLnxJx/f/69gWnjK2ol9gV9pwcWVifiu4468w7MkFq5siKEIA91O2ORYpTJrMIP3gz1ayPXcIULE9lv3jejhAOr6Dpd5WcNNXQ/a1iBw9rNfUJcdCGJ3XlzAXFsjZAKYe/zz3YIzVXQ1u5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387814; c=relaxed/simple;
	bh=C1gj64oqzU8K3xQSmB11kUUJwdYaoF7IoZAlc1H4pL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs3SJRKxWXnivzMi9TD5H7aVb98kcJcS1GnUiudhiO+keeVPUEAMGOymH5GL4BvCwZiTuLx5GznRaotWDq0TK8bPrXUcQV+V3O/AW/ZI4YxIntPbvT6qKrRjXxmsBn19yvE/vN4cgIjioJeo5xZ2xN8YHPkEmiCDIGy66uSAZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7gp0UkC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711387813; x=1742923813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=C1gj64oqzU8K3xQSmB11kUUJwdYaoF7IoZAlc1H4pL8=;
  b=O7gp0UkC0kiYFhu28f3AaDxqcUHgm3zGjdpjh67XrC1X8tg7Bqa2P94X
   Y8tiQY+MxecEOxWCN+lZAFDvMC8DPPBaqBlFrRbTbMNmnjz34lhDKslgG
   TcAWDrxVoxwlYMxJiyjMDVabAPUwCJri6GR2s/Wt97sqp4myXYXFZTMyq
   CAT8+isnopR+trwaWsi7mwohjAhRhmNNcQpv4GoImRhgK4Zg9Qv1np5MU
   kVRg6p6RJKvewS1jHAgIBgW2EIBfFsrfrynVdRzlWQqfx/LD2n4yIyBJ4
   VXCd7vL1lk7XE997Zn8kb0HdX9KeDgSxFKu1RGp8N/fB7G/yrfug11izs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10200887"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="10200887"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="827784775"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="827784775"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 25 Mar 2024 10:30:07 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 25 Mar 2024 19:30:06 +0200
Date: Mon, 25 Mar 2024 19:30:06 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context at
 drivers/gpu/drm/i915/gem/i915_gem_pages.c:526
Message-ID: <ZgG0niB5wBxkWBkR@intel.com>
References: <20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local>
 <87jzmqjir5.fsf@intel.com>
 <20240227105356.GBZd2_RL9hjC_LupZB@fat_crate.local>
 <87h6hujhrz.fsf@intel.com>
 <20240325163342.GEZgGnZpROSN4euuLb@fat_crate.local>
 <ZgGsVBnpme-syWCG@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgGsVBnpme-syWCG@intel.com>
X-Patchwork-Hint: comment

On Mon, Mar 25, 2024 at 06:54:44PM +0200, Ville Syrjälä wrote:
> On Mon, Mar 25, 2024 at 05:33:42PM +0100, Borislav Petkov wrote:
> > On Tue, Feb 27, 2024 at 12:58:08PM +0200, Jani Nikula wrote:
> > > Let's see what Ville says, but in the end bisection might be the
> > > quickest way to find the regression. Though I understand it can be
> > > tedious for you personally.
> > 
> > That still fires with 6.-9-rc1. Does Ville have any suggestions or
> > should I bisect?
> 
> Sorry, completely missed this. The culprit is going to be
> commit 1de63528e728 ("drm/i915: Perform vblank evasion around legacy
> cursor updates")

Hmm. Actually should be commit 0225a90981c8 ("drm/i915: Make
cursor plane registers unlocked") already.

Apprently I had CONFIG_DEBUG_ATOMIC_SLEEP=n in my config
for most of my old machines.

-- 
Ville Syrjälä
Intel

