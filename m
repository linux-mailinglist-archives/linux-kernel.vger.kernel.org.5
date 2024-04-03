Return-Path: <linux-kernel+bounces-129629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8CF896D93
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818161F245C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6013A3EB;
	Wed,  3 Apr 2024 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRnLEtzM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8E135A5F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142193; cv=none; b=cK246faV4r+suxaVQx5pLq1w/0xtvyvtV11lQ3juScvYxlOSm7OfHm0pMR26C5hlWeUIDij2g8FYaAesW6fN9DG52oHxlP9w0jJN9H9Vaq485jzOFSKCfPpSW5Dew42J8eonVUXOPPID4mUdpnqtgFRfHbLe/m/cluaIYF510MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142193; c=relaxed/simple;
	bh=/V3r6mouMg4nysOhPu3JMDN8B6nQlgu5I4ITmaj7yJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI2GoHCAef+VOdJrw0bo5PdlPhHp5+yuqNdjQ06f6jHTCldI0KQKT27Lpiqb0LJshH3iDMAywrtRaULryU9IEDOCpae8aG+o47JtIXBXd9Q8Fs1P8jXKbSD5cchW9ec9P8BvEP9u3PooZfEE258Sj9vxe9Fun7+TQulCWr1hiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRnLEtzM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712142192; x=1743678192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/V3r6mouMg4nysOhPu3JMDN8B6nQlgu5I4ITmaj7yJQ=;
  b=CRnLEtzMiHw69JJ1tlg+WqxMhGbIgy2ooiiL4qH897nwX7DVA1M2Word
   75FZjEE6NPZLYzrieG18nHG8P0l04Ub9QupvmgcmfhPOeqtsyWlgkNx81
   WP1eCeT2UdgYIQQL/vPLQ76KhJsvElzYyTPZV6RJ6xglg5we7d1XdzVcC
   O3IVL3nbQYPPlqMLeaC49K1YHW5Z3Kpa6z2HaPyBnjFP1ulV3Qyijqiem
   FgxeGuPROX8NhNMSxeehRqegyDP5FbIMqwIfixGrNFiQyOdahLebSsieK
   GLZ9hmexN00Vr8yJ+g4Cjn1F/cxph6FVty6DblwU8Y7plKAKVP5iL+nZj
   g==;
X-CSE-ConnectionGUID: Vc3Ni0V8ScaTl881Di2gcg==
X-CSE-MsgGUID: R7olSVOvS1qGapJ3koKFhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7592437"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7592437"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 04:03:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915179182"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915179182"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 04:03:08 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rryOZ-000000016Ed-3Pzm;
	Wed, 03 Apr 2024 14:03:07 +0300
Date: Wed, 3 Apr 2024 14:03:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 0/2] devres: A couple of cleanups
Message-ID: <Zg03a4_h1M-AByt2@smile.fi.intel.com>
References: <20240403104820.557487-1-andriy.shevchenko@linux.intel.com>
 <bf586356686053641b52902bf7928db08baa44ea.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf586356686053641b52902bf7928db08baa44ea.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 12:53:22PM +0200, Philipp Stanner wrote:
> On Wed, 2024-04-03 at 13:46 +0300, Andy Shevchenko wrote:
> > A couple of ad-hoc cleanups. No functional changes intended.
> 
> But it seems that since v3 my "Reviewed-by"s have disappeared. Is that
> intentional, should I look through it again?

Oops, it's utterly unintentional, sorry. I haven't done any changes.
It is basically a repetition of v2 (i.e. based on your code).

-- 
With Best Regards,
Andy Shevchenko



