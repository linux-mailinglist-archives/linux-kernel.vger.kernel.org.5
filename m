Return-Path: <linux-kernel+bounces-36689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382C83A50D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CD01F25654
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D24517C60;
	Wed, 24 Jan 2024 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4mJ4EEP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916417BBA;
	Wed, 24 Jan 2024 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087886; cv=none; b=k67BubJ7pSTiU8yzP8FtzxT6reNqVP6uD0CBTEy5dRxkwQm5ZrA5CcFKv6x94Pp+dnmy0zP7T7vvHODIPru4itVMmVVqjzd3pAJW3+gvLZ1jPRmhrtNjtRd3+rHK5PJdSGTbV5fkkuBBkYgG8I4oV1Jz9c64E9wNj9QKIAN4js4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087886; c=relaxed/simple;
	bh=0uEt3QHC9f3bYP1Js3HWf0U2lMrJMdiCAo8M3PruTPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qQd9HTm/qVhTMc70MmdS7avlHC1zBsflICweVMhmbPxCEcgLXBfzkuITwEQBJ6lg+jX69KHylGPm+CFXJuilqq0qDHf3J1/n/U907S9/oylh3kueaMyLqeoe/44khnSagX61aGS58MCll2PTZlcxJlmr5fULCQtY7yBPLCvtnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4mJ4EEP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706087885; x=1737623885;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0uEt3QHC9f3bYP1Js3HWf0U2lMrJMdiCAo8M3PruTPo=;
  b=i4mJ4EEPVUMUQqfFXZwjNxbzE8L04WF3hm+yBB/130W3W/aSSZ8vSrV7
   +HlFR5NFwROt04JSgI8uiwj28OAxUw/4E1E5Prz2jzrDR6hWUN08pVYdc
   zVXeWwCMIqSP1zBldazxYu7CGE2kRuUVM7DnfumOEFOHanXZaNqjIn9vs
   QB6Pk1BjybeLYmNsigeFi72eTMyw/dqSHL8JzJCf5en2zypeX6QunTzpF
   AY8Xmyx9VfhyIgb6emesB0Z0hcfQ37gFG5CZaORSTYUc38CkwGU2w5L29
   T7UQ9KYNy1k/sy11+XY42E6XOGaZZedY5ftkK9INBPJkmv/W0OXS13l4t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15313325"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15313325"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 01:17:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820392409"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820392409"
Received: from komalav-mobl2.gar.corp.intel.com (HELO localhost) ([10.252.41.195])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 01:17:47 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Cc: intel-gfx@lists.freedesktop.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, intel-xe@lists.freedesktop.org
Subject: Re: linux-next: Tree for Jan 23 (drm/xe/)
In-Reply-To: <152521f9-119f-4c61-b467-3e91f4aecb1a@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240123132929.7cb6ea4c@canb.auug.org.au>
 <152521f9-119f-4c61-b467-3e91f4aecb1a@infradead.org>
Date: Wed, 24 Jan 2024 11:17:44 +0200
Message-ID: <87le8fks3r.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 23 Jan 2024, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 1/22/24 18:29, Stephen Rothwell wrote:
>> Hi all,
>> 
>> News: there will be no linux-next release on Friday
>> 
>> Changes since 20240122:
>> 
>
> on ARM64, when
> DRM_I915 is not set
> DRM_XE=m
> DEBUG_FS is not set
>
> ../drivers/gpu/drm/i915/display/intel_display_debugfs.c:1091:6: error: redefinition of 'intel_display_debugfs_register'
>  1091 | void intel_display_debugfs_register(struct drm_i915_private *i915)
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ../drivers/gpu/drm/i915/display/intel_display_debugfs.c:19:

Does [1] fix the issue?

BR,
Jani.


[1] https://lore.kernel.org/r/20240124090515.3363901-1-jani.nikula@intel.com


-- 
Jani Nikula, Intel

