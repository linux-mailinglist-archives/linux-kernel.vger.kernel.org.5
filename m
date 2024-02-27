Return-Path: <linux-kernel+bounces-83084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11423868E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E3C1C21972
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE8E1386C4;
	Tue, 27 Feb 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBlkBYr3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C571386B2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031498; cv=none; b=gtFjRlv41CjulSmPIASJxr30/3YlvFrY5yQwSh7ZplwWCLMt5jnrxxbnufbmAwXK0qtEqDqcK+b1Bz6W6SjM4JV/leVT5A2Au0HT7PolKd6xG7OGSjUM0QieiL/zZOIfvF8rHoib2p/5BVFieR9Q0Rsm459uHRXOQQtlmtSgDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031498; c=relaxed/simple;
	bh=5BkrVfq/dsxGg1/OWL6aETx1gf1I1h9Ra15WknjI/vE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AIi2hL4vqF2+VsZrMYxgTszG452/WHSKRrLcawRmsTRf9ssTJiCkgoGVZELKFl4U52cgSBm1aRCIZMkeISQ4pOJJ0wSvWO6EPUNtX7G3a8jLTbMB2wnUjoS28Ay76ccmoSTlpBd5JvjJ+DmE6QQAiGa6GTkeFjcfRCiioTSJXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBlkBYr3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709031496; x=1740567496;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5BkrVfq/dsxGg1/OWL6aETx1gf1I1h9Ra15WknjI/vE=;
  b=TBlkBYr3pLJJLrilpXPVugN4esGO7tMxzeCLz2WHTLTkCr9JuHS5MBwp
   CgytUqdPxKTJ338oLiAtradUU79j4k58KGAk49CSg3AJKfK+f/6ghRzcw
   +JEzXt3JBj4MR1+nsmCAv81eQIzLP8d92gDL7VLiRzzv/2nNk3JEmsEzu
   C546y/KoiKH6DWiBr6C//TZ/SfB0jJv19GDH8eWVhz7C5EFS+69Sb7lqG
   eNWzV6L1tKxEooEsoPATC01VmmTyL2WespIbv2epvlNWGxUzZZf8g/ui4
   KwyIq5UTxnzI4DSTlIPoXK1pLO4++NkdZ6cbepQPZfzEfWPJKwZdvpYNn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14787132"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14787132"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7349094"
Received: from bdallmer-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.187])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:58:13 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: intel-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, lkml
 <linux-kernel@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context at
 drivers/gpu/drm/i915/gem/i915_gem_pages.c:526
In-Reply-To: <20240227105356.GBZd2_RL9hjC_LupZB@fat_crate.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local>
 <87jzmqjir5.fsf@intel.com>
 <20240227105356.GBZd2_RL9hjC_LupZB@fat_crate.local>
Date: Tue, 27 Feb 2024 12:58:08 +0200
Message-ID: <87h6hujhrz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 27 Feb 2024, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Feb 27, 2024 at 12:37:02PM +0200, Jani Nikula wrote:
>> Is this a recent regression?
>
> Yeah, no clue. Hadn't booted that machine since 6.7-rc1... I can bisect
> if you want me to.

Let's see what Ville says, but in the end bisection might be the
quickest way to find the regression. Though I understand it can be
tedious for you personally.

BR,
Jani.



-- 
Jani Nikula, Intel

