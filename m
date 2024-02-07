Return-Path: <linux-kernel+bounces-56758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E4684CEB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B961F294F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298878063F;
	Wed,  7 Feb 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWRaHeqM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B020DCF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322502; cv=none; b=q2smFnZBEfSy3rBjMdPqZUjO6E/CCPEgh9+ltggaH4MgibzBvwsnVQBVUtOyWcZueb0T5jDjIVd6j8We/dQbYz3q9XB3j0NrgTZvSexULQXIB/8zolH5pvrvVDnRSLyX1eFtZAi5fdIi0u5DBB/mlh2zt0+/vMVUDgwchxZP+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322502; c=relaxed/simple;
	bh=bRv34uQOR+2xooBmdJ7DBwAiwXJ9lsQaCEasenh4uqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+bCYBpCfg2Z/HnvlKAAOryAXYd5qxuaWUrA0NEaJ1an97RUAXURqkg4wa7BL19hhsAEvOP5pjVLP9x2wrHH+r8UY2wvDK09KKiDajz9vo+EEvO/7NcJNBS3b5oDdeZjuVr0ZHAd2zcZRBiVWwobv+t+YmTWqwjkNY2H5TaAjig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWRaHeqM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707322501; x=1738858501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bRv34uQOR+2xooBmdJ7DBwAiwXJ9lsQaCEasenh4uqA=;
  b=dWRaHeqMQacQKT1fzWMz2YCDcGcFFk8Has0JtgDGnbouIHTUCNMILxUL
   8H7RVU31QSn5NdvPHiTbYbtqtnRrSXf2SXmyQjyH1dxI+awG9zNznJhG5
   AzN6Qolz8uLStcHkgrZ2Om9cHpxT+P9kmSUyZANGmGGC139CUgTEZaBC3
   0FZLjScLV2OxxCQN2pYbiiEzNMR4C9FuM8pbD4wgiRlJFpk25sEwhoO3d
   dyQw2+ZGQ7rhwTKnAD8iGIsE9riNJyhOZYlQecNUmgLIh1wwbpxw1gn26
   HZaKSH5QtNjmILyYaoHpOwq8dwN48VGO+JPojhUtoW1CQD7SoPBVhhVOw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12380017"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="12380017"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6138197"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:15:00 -0800
Date: Wed, 7 Feb 2024 08:16:17 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, yangyicong@hisilicon.com
Subject: Re: [PATCH v4 1/4] sched/topology: Remove duplicate descriptions
 from TOPOLOGY_SD_FLAGS
Message-ID: <20240207161617.GA21939@ranerica-svr.sc.intel.com>
References: <20240207034704.935774-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207034704.935774-1-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Feb 07, 2024 at 11:47:01AM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> These flags are already documented in include/linux/sched/sd_flags.h.
> Also add missing SD_CLUSTER and keep the comment on SD_ASYM_PACKING

s/Also/Also,/

with that, FWIW,

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
 

