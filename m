Return-Path: <linux-kernel+bounces-116644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAB888A1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0A31C38519
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E48189A2C;
	Mon, 25 Mar 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO9qjg06"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E222E17D24E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358330; cv=none; b=P5NeZWUNY9i7DN/G11cyIJmjBxcBGDKrdN+91Hr8U+EgX+7pIQCHHDUZ23YPrBN9naTzdva8o/p7HixZ1+poemlgMqL42ief205VjzutW0AjIUaaUMOYCR44YGXTyja0CBLC9LVm3ug4s1B55rjg5UZmf7Sjx0Qy+zeNT3Q9mps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358330; c=relaxed/simple;
	bh=qWQyoJs9pVjCqc2Pa3KfTf+rHmXe8/PnXNXrea71Hk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaP3LHf8GjrPA8OOG8iP/yTXCPKMf8odp9s4papq9am2SUu/IpwXPF8TxXxeMD+P85agh55cG7+7afs9RchNkF+G3eLTUkE++Iufta8XllGQlQluaGTUlxmuIdXUeQ5sitHLgftEZVIKhRnuQL26YiAvXt11ajRPPMnTX2HMFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO9qjg06; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711358328; x=1742894328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qWQyoJs9pVjCqc2Pa3KfTf+rHmXe8/PnXNXrea71Hk8=;
  b=gO9qjg068vpIO5Kh4Q0oD/zjUqeqsQyIjK41YcJHHdLs4KgtfbcPQgrO
   NThRAHAkyZUQylR2tH7mBknzX54nfMUR2NpwLF9/fZ3AJwxg43BYX1npj
   EkIwCT93mpqk7OtAPzC7mw/YoFM+XsC1zmEfPLw+VejkjVgccA4dMw5Vl
   95fP0+DmF5AO+ukzhG9HU2bNIbBPcfR6Vr69lYK8DtlT3D+6uO0TdyPk4
   +sXKfUoAo6/kubun8mcADMES/s6P+Cy7ZGLop4UBUtXnaMBBned7UACsN
   2HtbmVxLzW82oa5sciANl4dSsH6UWdPoZLFh8Q+q17KI0DT+v+gHiHFxs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="28826428"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="28826428"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 02:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914837371"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="914837371"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 02:18:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rogTa-0000000Fvcn-1hGy;
	Mon, 25 Mar 2024 11:18:42 +0200
Date: Mon, 25 Mar 2024 11:18:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, elder@linaro.org, robh@kernel.org,
	parthiban.veerasooran@microchip.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: pi433: Fix includes & macros.
Message-ID: <ZgFBch_ccGnZBCmz@smile.fi.intel.com>
References: <20240324093201.793485-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324093201.793485-1-ikobh7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Mar 24, 2024 at 11:31:58AM +0200, Shahar Avidar wrote:
> 1. Untangle include hierarchy. 
> 2. Update #minors the driver can accept.
> 3. Make use of general macro instead of magic number.

> Shahar Avidar (3):
>   staging: pi433: Use headers in appropriate files.
>   staging: pi433: Reduce N_PI433_MINORS to conform with N_SPI_MINORS.
>   staging: pi433: Make use of spi mode macro instead of magic number.

For patches 1 and 3
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



