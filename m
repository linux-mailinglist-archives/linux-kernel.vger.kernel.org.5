Return-Path: <linux-kernel+bounces-49595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999EF846C36
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD111F22F19
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895D77620;
	Fri,  2 Feb 2024 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNiTdcv9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4460BBD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866553; cv=none; b=osO1SWXgjxvjyeFcNxqv0IKStdJXr616z5LBmdr94mHXLnolBDWUbBkGj2tE0RW6m2FNO95ALoLZMo5zhku/RwsxUp2v3mLU5p6CB33yLaIjMvpcx5QoDc2xyCrZ00JeM/OdJ8oQO8wUaGkHVjddjZgvRGospmhm9YIJMZRSz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866553; c=relaxed/simple;
	bh=Pk12KvS9am7NU1bl61zs4c06uJtY1JFJXFeHg2W7QXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hVm0Sl4Ed7ls7azuMxzivQtoKkmsks2RzvfpvLWA00f221dQUHE39k0cbAfXupyrgl9C3r9mC7oyLSDWQ86EEOqMgPgKxy3LmBYaFLzQeTdjWga5goOvhLs0hzveo/VMNfCdNReqtWmWfX9Q2p83swG+muV/9LmyECcK0EWHEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNiTdcv9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706866553; x=1738402553;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Pk12KvS9am7NU1bl61zs4c06uJtY1JFJXFeHg2W7QXQ=;
  b=GNiTdcv9Q/W2EU+K0ed/KWUusHbdVs2j7E7Fv1xh9xRelPLF1H+SUwUp
   VlbG28qXj2KGV4ofVlQOdb/Jjjpre2OjMlmmqhYSBWIOyYnOVKf9AaqTT
   FvILR2+ehIwvE29Uy9iDdQFv7txab/S8A2KJyo6EltnE2f3+VD04VZqh+
   JdJfbzgYx9/2+wjUPBU/kXwhCehQ5vE1nbE597sHs7K2BnOhEaMTHX++a
   dmahxCFq+lvzMsT5ORqVy+lcxb0TCFTUQvhpYnug2mjsNvkS16xLYVGyX
   BDvhsh9Bdwaa1qaSowuxhxqG+AOpLVJu2iV1sMBIpVudPGbqqxtNCpjM9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="35315"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="35315"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="307868"
Received: from mistoan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.140])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:35:29 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Paz Zcharya <pazz@chromium.org>
Cc: Jouni =?utf-8?Q?H=C3=B6gander?= <jouni.hogander@intel.com>, Luca Coelho
 <luciano.coelho@intel.com>, Subrata Banik <subratabanik@google.com>,
 Manasi Navare <navaremanasi@chromium.org>, Drew Davenport
 <ddavenport@chromium.org>, Sean Paul <seanpaul@chromium.org>, Marcin
 Wojtas <mwojtas@chromium.org>, khaled.almahallawy@intel.com,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/display: Include debugfs.h in
 intel_display_debugfs_params.c
In-Reply-To: <87v878fc5h.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240131204658.795278-1-pazz@chromium.org>
 <87o7d0h73r.fsf@intel.com> <ZbuxsF7ubmL6lzdR@google.com>
 <87v878fc5h.fsf@intel.com>
Date: Fri, 02 Feb 2024 11:35:25 +0200
Message-ID: <87bk8zfbtu.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 01 Feb 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> On Thu, 01 Feb 2024, Paz Zcharya <pazz@chromium.org> wrote:
>> Thank you so much for the super prompt reply!
>
> FYI, looks like we've got some hiccup in CI, will merge after we get
> results.

Pushed to drm-intel-next, thanks for the patch.

BR,
Jani.

-- 
Jani Nikula, Intel

