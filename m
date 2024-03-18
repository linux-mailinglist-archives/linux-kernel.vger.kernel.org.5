Return-Path: <linux-kernel+bounces-106004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D67D87E759
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A7E282922
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D52E644;
	Mon, 18 Mar 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7YSAUXf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA031A76;
	Mon, 18 Mar 2024 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757701; cv=none; b=Au3hwd/ZxoU2kLF6AHriSPKNkqPtpqiOgixoWzdPEXj/jzkXATPv/e8C56yfFJIImdVe2v5YUjqaZOBkBKesp/ttdxQNzwURT5OUsiLtJPcgRQM80lFYOabFsdW7Th8TglDJjyYCue54CyjRVSMG7PrjgNFxxYk19BA+sVdpxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757701; c=relaxed/simple;
	bh=bOJ14iLPnkMLtDJl/gqTtvnEkaWy10qJi8XkDMHmtT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMUOQZqFvXIllVNhVWQH5R+ic8CiqL7a5EajG/pUe5xXlBoLuHepZWif+eT4WGckh3oAypyRQV8cJeyhP9eSoN+rYMGhIxcKHez15jbgRAWwPj82GEoL3D8H2Xn3YCiX1t35MZTiC7ZqwzSvYqAEIkUsoMY5HZECoqyTryGAPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7YSAUXf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710757701; x=1742293701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bOJ14iLPnkMLtDJl/gqTtvnEkaWy10qJi8XkDMHmtT4=;
  b=D7YSAUXfxq3CXjRBlz8BqYioVYafOctmGgMeRsYvfKtgbNXK8K2KpBOF
   lz4SDLS+qDycl4fzAK1TuzMUIkfNX7IXBisJuwiuwLT8lpte0sZtQzNkQ
   /uvtunNzqKPc2hq928jTNAA2xR8d/4xtGB9H3Iql+Bhe42LWNOl4cd4qY
   9xdqApTUP4Xb9fva/6uvk9La7DzVcE/PDUf1fGV80adSpip2+1U4ARUy1
   3QvxQBcSLpQL3yZZSCCvH/Pjbtf4KYZt1k4Hk8SvPJVFpExGwMAan0tAs
   quF06dNwtI50rCfGowK7MmXCz6h4+ZqDpklhXJfNeEPf/IJEP5GrXmbBO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="17008804"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="17008804"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="914587904"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="914587904"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:28:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmAE2-0000000Duh8-3Wyt;
	Mon, 18 Mar 2024 12:28:14 +0200
Date: Mon, 18 Mar 2024 12:28:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: wangkaiyuan <wangkaiyuan@inspur.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: serial: sc16is7xx: convert to use maple tree
 register cache
Message-ID: <ZfgXPvR9rob-40tK@smile.fi.intel.com>
References: <20240318064216.1765-1-wangkaiyuan@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318064216.1765-1-wangkaiyuan@inspur.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 18, 2024 at 02:42:16PM +0800, wangkaiyuan wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.

Okay,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



