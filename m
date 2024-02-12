Return-Path: <linux-kernel+bounces-61706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE5851592
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B9E282202
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB253DB9A;
	Mon, 12 Feb 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcYptDb3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D863D99E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744979; cv=none; b=T6wZ8uAbj75+39haiVkRKEN7+aAsuNERnynR/xy0lOuHYlQ6DeqKJX93zQfc/7P0wVhANtG5NDD2F7+UE+D2lUyr8N96uYRR3Nd5ogzE2ZpsPCyDLgT1WU8ubn9pV8S6A/70yF0o67k1XoFXrQlMVj2VebxN44pqg5/nOIoA8uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744979; c=relaxed/simple;
	bh=TW2CSdVYIub/goe1WKuXyYiZXm1j9zzBXYlgffNdpWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnJNVPCy3Zh3T5ECUMBsLlKpMQE/dcirccWI57icEpfoVSnzi4c740BahfCgDIMv+b7g94pSgdG+BF0jv30Uplf6yTF7qp5Wqrkz5NvorsRMKGaYDyIFYfEWKd4SpNPn2K00Z2jqOUthxoEuk0k++R+25HlJJk9taZrcmpYv2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcYptDb3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707744977; x=1739280977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TW2CSdVYIub/goe1WKuXyYiZXm1j9zzBXYlgffNdpWE=;
  b=mcYptDb3xFhFhYrqyRzkhk+SCzHJEV2mQDScXQMWTiqdQ5VMS0eEfXbr
   w0j9nJbKxe5SmOiA6F5ZBtWQq0MlJvgaghf2NECj7kEp+xUvSeZ8+Ryjc
   QY6QfB2UGIsjCIWxzU/BZ0ZdR+fnkSj3tA/amvOVSMPAyMq/FGII8kdgr
   SSCbdmG2/ISd5FowdgI9FXgvA/i4Ta+ZRS4Ef4N0HZjaSFzOpzTJv93gt
   j44sTWgegQV/FrXS9JKcKjhrdJKii1e/yttxneLgDmH1GQnvITvLh/95K
   +hNaByYN8ymdjTX+xkFJV7iAejqaaOFNPk2LG6PMUcn4256mIJ1y6hj4E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="19226749"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19226749"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:36:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911483686"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911483686"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:36:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWTk-00000003uKl-1hOH;
	Mon, 12 Feb 2024 15:36:12 +0200
Date: Mon, 12 Feb 2024 15:36:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
Message-ID: <ZcoezKt4zKvO8jOf@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 03:23:53PM +0200, Andy Shevchenko wrote:
> I have no time for this, but since it looks like I'm the main
> contributor for the last few years to the subsystem, I'll take
> it for now. Geert agreed to help me with as a designated reviwer.

The typo ("reviewer") has been fixed locally.

> Let's see how it will go...

-- 
With Best Regards,
Andy Shevchenko



