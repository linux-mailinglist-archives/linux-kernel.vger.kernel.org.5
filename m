Return-Path: <linux-kernel+bounces-128412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8FB895A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F0FB2D4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF715A487;
	Tue,  2 Apr 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVWmVU0N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F214AD3D;
	Tue,  2 Apr 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078073; cv=none; b=VdvUPGZCxbScWjnh4pIhCZrCzD1w3qUAf6wKzom5Eky+kGYgXfePVjcvd27810RgKesH3RgYVJ9TrQ8M9YZDJkcr+LHoZ3RzSVChO7sXkZ+tsWmTM/QY675tVfCyUjntJy5C6pOZsdpNqfPTUwiI/d7J45+IY6F9zUcyIMC8cE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078073; c=relaxed/simple;
	bh=q0UKhpoGPHKhj58EoPT3zVOoCjDm9q73MeOh5CTO2wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZKII6c2ZocDTFwEyFulVH1kFXLhZIhL/4H6TK6PrAxBRPIswX10EalMOxD7TCTF/akHI1SqZWVMBALY4/wUxtkWtI6xKIhPdfMv0Shb8SBr4AihD18UDqiWkiy3InwX9HL+qGX5HITJ9qFJnfGV21u+f+z9jFcykt69cBYzM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVWmVU0N; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712078073; x=1743614073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q0UKhpoGPHKhj58EoPT3zVOoCjDm9q73MeOh5CTO2wQ=;
  b=eVWmVU0NJpeiwzIS1fwxOeimlTZcNYV3vnH5eudUISl+n9ud6DAJ0Qn1
   H03SxY0uVpIro0p2kij/dyuzDaAFm1cWMCktrzI6U21H5U0iT4oM/9WgJ
   uZSACHGu1vrCdQKQXfaddVMK2r15bG300fy+v6pFqTdreoq4flJw7v2w+
   nhf6LRmro6DFXTvjsu3atORXDBX1bmWipbF8Ec3hNRsDhHmmcFoQaBtK4
   PKuT+9evdlp7njfL2ELsid2tUitZ7XuhXECSru/BKmAT3b3ESv3KlO0zr
   6o6ggilYJFh3Xk/7r840A70LJlERykL0xkAMxfi8v4PlazI8y59UYy4Ry
   A==;
X-CSE-ConnectionGUID: 9/6nRc0aQQykLGL6Vomevg==
X-CSE-MsgGUID: NtTniqdLSlGzcOlDIiFYkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7384270"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7384270"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915147527"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915147527"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:14:29 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrhiN-00000000sIa-2C3C;
	Tue, 02 Apr 2024 20:14:27 +0300
Date: Tue, 2 Apr 2024 20:14:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 01/16] serial: max3100: Lock port->lock when calling
 uart_handle_cts_change()
Message-ID: <Zgw881ApbwJrozAw@smile.fi.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
 <20240402154219.3583679-2-andriy.shevchenko@linux.intel.com>
 <20240402130715.7f1292b774ee0b2f056a6e95@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402130715.7f1292b774ee0b2f056a6e95@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 02, 2024 at 01:07:15PM -0400, Hugo Villeneuve wrote:
> On Tue,  2 Apr 2024 18:38:07 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> Hi Andy,
> 
> > uart_handle_cts_change() has to be called with port lock taken,
> > Since we run it in a separate work, the lcok maybe not taken at
> 
> lcok -> lock
> 
> and possibly: "may not be taken" ?

Thanks, I'll fix this in case a new version is required.

> > the time of running. Make sure that it's taken by explicitly doing
> > that. Without it we got a splat:
> > 
> >   WARNING: CPU: 0 PID: 10 at drivers/tty/serial/serial_core.c:3491 uart_handle_cts_change+0xa6/0xb0
> >   ...
> >   Workqueue: max3100-0 max3100_work [max3100]
> >   RIP: 0010:uart_handle_cts_change+0xa6/0xb0
> >   ...
> >    max3100_handlerx+0xc5/0x110 [max3100]
> >    max3100_work+0x12a/0x340 [max3100]

-- 
With Best Regards,
Andy Shevchenko



