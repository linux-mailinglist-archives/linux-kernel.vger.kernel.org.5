Return-Path: <linux-kernel+bounces-81575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E48677C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6F71C2248B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3E012B166;
	Mon, 26 Feb 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWN8WwXt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA712B153;
	Mon, 26 Feb 2024 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956183; cv=none; b=Ka7PHxyjrm0MqwPa80gQyqzV04rHFlQHs7jeyovCA+kFU0a87DstEsygxhfTI1kcUlqfk3dxVTvXiBjMMHMNJXRZOdpocto7NtGjEr/TY694iU2Z/WrVtZh7lpAa0qOenzs10r95twDA9f/y4eOZyH0ptHdDVK639J0V1+37wzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956183; c=relaxed/simple;
	bh=7Z7s+7K6qK0hm+ekPc/XuC1GYu0iF/JrZMMGFhkN+MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJNd7EfBPIMC1jAW9+nJ+nY+DikmP2yZPkZswmrWxALMSOIlSiecB1p0LcgbiIrdlIs7czwYtui/+TxqGA1/+OCylzyfiatFZHSdrqV3IYYVPu0ucpgNKE8nlQ+Q4VHzZ0t04M4vyO7NNsBeX9BmDvpuSqE+9laojVm2DQcJB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWN8WwXt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708956182; x=1740492182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7Z7s+7K6qK0hm+ekPc/XuC1GYu0iF/JrZMMGFhkN+MM=;
  b=WWN8WwXtFGc5F5feq/ZJ/N+u7FVSRX2X4BJMPVVqqyU/xOiqK6h800/T
   fWHtdH60LPPPnoDNFqCNwpMdgbeOQwssYfbZmcpz96ObFC6KYVYgZtnOI
   mHtSpW94ojQNGY/3jJzbp2eBuV69Qth0mtoMZyGte78SjvXl5S0IEBZ96
   Bma8Rh1M5KEWObhsXdf542W/RklS1JKdsDadWyirgTfSLbZ93Df9givWY
   F89cl9hAcxDlbMjiyuUrEFyz3K3/TT34gFal5GWgWNEUN7B8e4jYykcHp
   lxVFtK2Vuggh8EdnL44hXDxGtD4QAFPLXSg4NzJQuiH4U+F/Isr3/2MnW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6186914"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6186914"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:02:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913871402"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913871402"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:02:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rebYw-00000007hFX-02Zu;
	Mon, 26 Feb 2024 16:02:34 +0200
Date: Mon, 26 Feb 2024 16:02:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	gregkh@linuxfoundation.org, petr.tesarik.ext@huawei.com,
	rdunlap@infradead.org, james@equiv.tech, broonie@kernel.org,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
Message-ID: <ZdyZ-e6m_rFG4dY6@smile.fi.intel.com>
References: <20240223143833.1509961-1-guanyulin@google.com>
 <Zdi3UWWRfKw1N_Jn@smile.fi.intel.com>
 <CAOuDEK1KbZ9=W3ffWN-h_AAhbB9RqJvKsnF4G9qus3o2wkk=3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuDEK1KbZ9=W3ffWN-h_AAhbB9RqJvKsnF4G9qus3o2wkk=3w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 05:15:00PM +0800, Guan-Yu Lin wrote:
> On Fri, Feb 23, 2024 at 11:18 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Feb 23, 2024 at 02:38:29PM +0000, Guan-Yu Lin wrote:

..

> > > +     if (kstrtoint(buf, 0, &ret))
> >
> > Why is it int? It seems like flags, should not be unsigned as u32 or so?
> 
> The ".event" member in struct pm_message is an int, but the values
> assigned to it are used like bit flags (e.g. PM_EVENT_FREEZE=0x1,
> PM_EVENT_SUSPEND=0x2, PM_EVENT_HIBERNATE=0x4). Is this an intentional
> design choice? We might need to change the design accordingly.

It might give a subtle errors related to promoted signdness.

-- 
With Best Regards,
Andy Shevchenko



