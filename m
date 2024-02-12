Return-Path: <linux-kernel+bounces-61711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C4185159B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B511C229A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE93F9F5;
	Mon, 12 Feb 2024 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D93vROQO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4A3F9D8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745061; cv=none; b=rZepW7O94tAvi1JDar2F4i7Va7Hftnq1cYPNT4S2q7wNW4HbEGtyZmRwtMKJY0EDXCZrcB2j/U6kfuMwkNGltBN8Q4L+CPhrPWVe0pCIWD9k/x2brr9ZqhNFbrVrc2cGOiTIERE2b6uABxXzQU76UsgUMQY9+sO4E2UFIa5XyNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745061; c=relaxed/simple;
	bh=U3HHDxdJjXTkNdoZK6mhtwdYybK7T5L45T+6eT+26Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNWWhqt1WkUnvwj+/kbdPCmhimfOVtXTYAdfyz1jNVu21lMIjB4YL5DdePn+sAFKjPBhUYVQQSwx6fdp258yJaCcBJYoqmLkwK+CQB1Dx1LSueLoigY0lv9TC+w1454wboPrsr3sclkYxS8Ns6eDUuOElBO1glkl2PxbOUwk690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D93vROQO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707745060; x=1739281060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U3HHDxdJjXTkNdoZK6mhtwdYybK7T5L45T+6eT+26Pc=;
  b=D93vROQOi2rp1dmMkRj8yzoxIaeK7MSfC62IVXPPVg7BHCi4ncM3QE8n
   woygeHaBFH74/eg1xDlh/wz91RlqQp+Kd2DTZmp8PhMbhoVSwFo8ReZ9t
   cwems6Ps8t9qMbuqmdx349JjMp/pGOERXj+bk8f/Edv51OYDf9VZp0oDF
   39zxj1cLCB05x75vlmC7/RrPI5ipLHqNXCyq3VZmnuOkY5VauXqDu62BY
   G/+HYY3MnhgZJocZFROMkSY+nlfQGE9bgA9YsbCARvkHFKcBwn6zJftcQ
   YdcJsQBEqNIQZa9WMr9pHX9ePYgHr26JczBgBPuSi3HWNtOeW32ve/4m5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="19226847"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19226847"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911483984"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911483984"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:37:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWV5-00000003uLq-00Jw;
	Mon, 12 Feb 2024 15:37:35 +0200
Date: Mon, 12 Feb 2024 15:37:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/3] auxdisplay: Refresh MAINTAINERS for the subsystem
Message-ID: <ZcofHlhoUsmPcjqM@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 03:23:52PM +0200, Andy Shevchenko wrote:
> Update MAINTAINERS for AUXDISPLAY subsystem in accordance to the last
> (administrative) changes.

Found a couple of issues, but I will wait for tags other comments
and then update the whole series.

-- 
With Best Regards,
Andy Shevchenko



