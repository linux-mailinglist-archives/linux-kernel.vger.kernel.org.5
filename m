Return-Path: <linux-kernel+bounces-48082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49678456FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88302283A5F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EEE15D5D2;
	Thu,  1 Feb 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jwb8tYP4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8215D5C2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789370; cv=none; b=HTXlFUIjkKPFVQoVMS2gSiB6cDS4PNcWCE4H0POz1Jlj0Mj+0VdQHeknJ2PeUpoyEHmOFm00oo8S9ctiQUfHV02+4qM+lyr1P+FO4pLi23+TvnbQkS7tE2nWHMpxEP4lk335ocpt0xNsLQo2rMHyxqkn0VoAGgoDpYqmky7Qa3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789370; c=relaxed/simple;
	bh=hGo79G13mOqo9qimsL0bK/DNGBIlAS3rawGOpSXyrZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8N80qLlPP4EkVnDR35AO6FQKHXuDmSda9TQFWFRZwy+rFCoF+iT7sXSmUFUkMtwOBec6fUkHPxK61VlvJjrmsXBch+Ab9D13IWOwAmfJ/vFabnn/Q8QrnEPIYThWEZUSouUFRkThpBwNI3P1LLWWRP56wTDLdErgdLq9y+8DSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jwb8tYP4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706789369; x=1738325369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hGo79G13mOqo9qimsL0bK/DNGBIlAS3rawGOpSXyrZ4=;
  b=Jwb8tYP4jWgvrTI4O1T/nnFCOyDcomnwiN1PO77hLxoFl/9upAl7aJoz
   a8GXPOv1bxDa6aUu3WIZzBv1prcWRLzJOsu/yfgwCPDnAcr6K+tYuaIKe
   rIO13jxoPNfGm0h10Bjg7JO6G/DQJLDOoPP4qdORBzdiSVQxwx0k92f4C
   tyiM2Y9/CpATVvTvOJw04DK3rFu5nG8WGpusRPLzaQjtIZSzJEGRQZrTw
   KGNSp1etbm7FulBaTAKVNOXXMfadVU9He6Nlfa8i0A3sUpM8FBv0oocFd
   jtd8EJTlvucqit1KIQ5p39pxIiEcszSu6awFz6PfOSWgPDRMtq62FfCiy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10632038"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10632038"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:09:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="912108895"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="912108895"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:09:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVsh-00000000pLf-2RBx;
	Thu, 01 Feb 2024 14:09:23 +0200
Date: Thu, 1 Feb 2024 14:09:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 1/1] extcon: intel-mrfld: Switch to use dev_err_probe()
Message-ID: <ZbuJ8zCEfU-ORmk_@smile.fi.intel.com>
References: <20231222161954.2955905-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222161954.2955905-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 06:19:54PM +0200, Andy Shevchenko wrote:
> Switch to use dev_err_probe() to simplify the error path and
> unify a message template.

Any comments? Can these two patches (with
20231222161854.2955859-1-andriy.shevchenko@linux.intel.com) be applied?

-- 
With Best Regards,
Andy Shevchenko



