Return-Path: <linux-kernel+bounces-33799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C2F836EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CAC628D904
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627B52F7B;
	Mon, 22 Jan 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyPltJOG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B552F6A;
	Mon, 22 Jan 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944173; cv=none; b=G/5TZDSr7S/lWEwKl00XKvn0T4ARBjF6kiwhDxFxFdL2qbWtZ3OloyYW5sEFhoRBWBlG5iBsKTjNkUwuNlKlDg3iwF2QcfenCm+Wbfarwnv0xWqqQm0ePVZp5HWu2aJrYP8GbBbTu24Ej01whxISLm6NESt+OT9e4WFMeIRUuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944173; c=relaxed/simple;
	bh=nMd8l1R4VjnN4kwtNc6jWq5EKtW15kh24YWU3Q+Oyi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=etNyUP2T/R0rqCpX5MoBE6WX4/DaVE63riUFACeK+hD86LH4rmxI+ymwrBsLwvambpFY3SzF0x4a9MkY5vkTYOFc3tfMw9RM9XKU6PzGp8tcgtN6QKGnluUJ+XGzW0oZyOsS3G83OY4BdP1ekodb9LsoFEMYMFG/WkdT6J9utps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyPltJOG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705944172; x=1737480172;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nMd8l1R4VjnN4kwtNc6jWq5EKtW15kh24YWU3Q+Oyi4=;
  b=PyPltJOGt7QrF0nktKDt8ECABUJ4lCMkGQZt27K0DT6vAhQZc0MkKbCH
   pxOZ/x6VxYXzNd4KymGP2zw42uIyiCT0qyHtd5YKDe96lDKCSSLO7f75x
   7epaRecX7zp2Cv0mJNavA/JzFQ4NTx9zS6BCSkwO1fl8wChyQ6LdkHkrj
   4aBDPUXhTsEadhYVTyNQopFacJVVw8QYjdXwxtzeeAdSGPldW3VQm0Gsi
   yJ4UBj2RQP63PVIjuIVi1o/95WjlGZMMnRQl9RsHwvmSAia0rxQ9lccC/
   y9sHWxDzbBT+OpT1Ez5O6+Xx0717B5VY0H/byB+vYPbtie/Ruh2p3wSzF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8379604"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="8379604"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:22:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="735237565"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="735237565"
Received: from mshelego-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.40.242])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:22:39 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-intel tree
In-Reply-To: <20240122092520.68a86f48@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231114141715.6f435118@canb.auug.org.au>
 <8734x8u4la.fsf@intel.com> <87y1f0sol1.fsf@intel.com>
 <20240122092520.68a86f48@canb.auug.org.au>
Date: Mon, 22 Jan 2024 19:22:35 +0200
Message-ID: <87o7ddnuzo.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 22 Jan 2024, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> [1] https://patchwork.freedesktop.org/patch/msgid/20231114081033.27343-1-bagasdotme@gmail.com
>
> This is still not fixed.

Thanks for the reminder. Commit 1a84c213146a ("drm/dp_mst: Separate
@failing_port list in drm_dp_mst_atomic_check_mgr() comment") in
drm-misc-fixes, likely to show up in -rc2.

BR,
Jani.


-- 
Jani Nikula, Intel

