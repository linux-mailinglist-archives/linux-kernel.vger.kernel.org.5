Return-Path: <linux-kernel+bounces-61232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7326850F70
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74864283BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207311181;
	Mon, 12 Feb 2024 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kF2ZAwxS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABDA1097B;
	Mon, 12 Feb 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707729188; cv=none; b=tLB82YcjyPofxhLYdDbL9TsxUdB9pPO6q1oqgIlNJXSeRgb53u31EfRFTurOf0Vut+AgJlueQ7VTHoQ5ubQM3mKMApzgqlqGbawz5Z5U9d6onz2E+JwAqAzMnGGjgWIXbWsGmFdF6M4l4PPxT/4agXun/C9hAst548mXHO8ZIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707729188; c=relaxed/simple;
	bh=zQg70D7zlwaT01vgAiLlUs8t5uerkv7D7w9ZxCQ0BBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQ567xljlxSXGBfeH5/8r8Y6scFraSKbZv7MAFhy8CqQbcqi8lBWNHOsxLCV9S31/57uUb5le6NtV6wayYoEyh9cM1CtUBYj03T/mDug2LLEVK6GgJjTJ0BaayQgHy9mrObQK/AHW1Uam7LiuGDRqONbvNuriOgwlkW5GKTwIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kF2ZAwxS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707729187; x=1739265187;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zQg70D7zlwaT01vgAiLlUs8t5uerkv7D7w9ZxCQ0BBg=;
  b=kF2ZAwxSrl7LoA/z/zf355vZng+6cN6zcTFyTxL2nZpRGCNjgW0nViUf
   WEqnOoTa7uL41RWPEPzgM9n9wpBuX+jjIa3pb4y+rvWuVNYDW5yXHVQ2w
   uIS2Xf77nbfJFbs6FGmm5YKgJ2d98jyeTIP+0s5COhwfleRWXkgYhiZcB
   6sNWqHKhrEF8puRzp2Pllz4DZAUzNsG4uLYSQkb47qETJpl9wz3PTASeo
   y0dN07Qajl8s6WptOfsE6PajpVO9bStMAxd4NuvQXntFUw+kC3xc1uwdi
   f3yr7VC+UxHmi+nPGSruNE3IDNkSLUeVVE5St1Jgdg4ZiQ1afyqHUShKt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1576663"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1576663"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:13:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2541949"
Received: from belyakov-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.63.91])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:13:03 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Vetter
 <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
In-Reply-To: <20240212122652.0961dc7c@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240212122652.0961dc7c@canb.auug.org.au>
Date: Mon, 12 Feb 2024 11:12:58 +0200
Message-ID: <87le7q9hb9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 12 Feb 2024, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/tests/drm_mm_test.c: In function 'drm_test_mm_debug':
> drivers/gpu/drm/tests/drm_mm_test.c:191:32: error: implicit declaration of function 'drm_debug_printer'; did you mean 'drm_dbg_printer'? [-Werror=implicit-function-declaration]
>   191 |         struct drm_printer p = drm_debug_printer(test->name);
>       |                                ^~~~~~~~~~~~~~~~~
>       |                                drm_dbg_printer
> drivers/gpu/drm/tests/drm_mm_test.c:191:32: error: invalid initializer
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   e154c4fc7bf2 ("drm: remove drm_debug_printer in favor of drm_dbg_printer")
>
> I have used the drm-misc tree from next-20240209 for today.

Fix at [1].

BR,
Jani.


[1] https://lore.kernel.org/r/20240209140818.106685-1-michal.winiarski@intel.com


-- 
Jani Nikula, Intel

