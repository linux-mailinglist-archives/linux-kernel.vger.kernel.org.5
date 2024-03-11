Return-Path: <linux-kernel+bounces-98956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D471C878191
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C57289663
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FADF3FE3F;
	Mon, 11 Mar 2024 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvrjzZLn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF173446A0;
	Mon, 11 Mar 2024 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167125; cv=none; b=BYS6smxrg2Jpixi6AHrEQRm6FCyufIYytLQXnT1e4FmcquMIdbML7kyCEoRpQnk3MNZrGqHnUay0RK1LDo9865bkmWW5KTo7GzAxqIft3N+I/DjG07yBGIs0Ro9z4q2oHu17YvanZKQ0y3DfFpJFneLxajBpqW9c5v5P9Aa1dkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167125; c=relaxed/simple;
	bh=MJNrmAu6MEJIbI0R6vEjXEvYVSGSWFsO1GWoOeVc28I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp5ornkHdcba7fYlGPg3CYD9W+2dHpv5xmmBlUShKwqtvbLSk7tlYAahB/bSh3O//3gJUjII6eYNvUye4s8kZVVblWU5aOcoJNof/BrzmYKAq9BjalvKo763jd2Wq5FJD9kQDfh2iTJwKh9ENvhH4j3pkPzVoYXN2p2NKG3DXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvrjzZLn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710167124; x=1741703124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MJNrmAu6MEJIbI0R6vEjXEvYVSGSWFsO1GWoOeVc28I=;
  b=UvrjzZLnxAhqE1F59MHqkhj1pCA9PM68AkAT6aqlZ4CLjg6IoATMFWVD
   sMq9kFwYfhHOzPhQe5P98/VGn+GLeg8K/TqYNgn5FapBtwPJXZZNPx+vq
   QK2XgUDbbgb2AGXmchAocUCiAw3sNSHgkDE+4QrK4rGJ9q31JiptA9I/z
   OM3ubhuRo+av7mpBZoJLV6v+WR+tq33DGGOOdkkis/X4hwqzZ1IV8nRly
   ZZbbvsJ7qRhJ9a01lgEVeum6i0LZF8p83o7ka197cZhFpsJDYPgyhuNHJ
   h1P+QpHOftWE+7N4uU1QCaz5tBahAC6LtMLobWOD+qooTafUGrG+/H5fK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15470960"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15470960"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914361310"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="914361310"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:25:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjgad-0000000BeKt-1SoG;
	Mon, 11 Mar 2024 16:25:19 +0200
Date: Mon, 11 Mar 2024 16:25:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v1 0/5] media: ir-spi: A few cleanups
Message-ID: <Ze8UTyZQ_Ev6s4fz@smile.fi.intel.com>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 05, 2024 at 07:48:25PM +0200, Andy Shevchenko wrote:
> While removing of_gpio.h where it's being unused, this driver seems to
> deserve more love. Hence this series.

Sean, any comments on this series?

-- 
With Best Regards,
Andy Shevchenko



