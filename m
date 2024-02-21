Return-Path: <linux-kernel+bounces-74261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF9085D1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EED01F26AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F32E3BB2E;
	Wed, 21 Feb 2024 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNq1alFL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355473BB24;
	Wed, 21 Feb 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501805; cv=none; b=OfijhhLnQHmLs/U5ZMhQL2oeGnluqtp2m+ahOJ8mgoxY5f7VJBx/Fp9VDAlwhLxy8BTHN5RyVC4hG4EhsZVKTGIl0cCp4hN6svc4EUDH2UGRR03Trikv6zddTFPNgEVvr2XWwjHig75UeaDNVPRud9Si/ovXDwdHiBhEp3QZwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501805; c=relaxed/simple;
	bh=BfDQZ0zpRdNfmhg0jDTuQpE46xClKwDJrSeLkbBaq4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egITI06A4SzeqQNOxgjvJYb9TgSAlIsFQMl2ZO3kCwhWSIg1W/dF5DPReEYLs1lONwXKdQYn9Fg6/STeHm2bEUwwQrNvdls9dfBE1Ao6yjmIHgxNxQ1myPIVc3BrdI+Zg9/Me5lZGrgRB2S03xZ62U8EhCsiDiZyWXpDWkLGWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNq1alFL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708501804; x=1740037804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BfDQZ0zpRdNfmhg0jDTuQpE46xClKwDJrSeLkbBaq4s=;
  b=dNq1alFLw7opu9NdLnUmeGYjSC2oHVVRXcLCWzpP/zQHj12zzeXXKmNS
   9SX4VBIfAH604SWfC7M6lQvvUDkrsX9Zfa/H89gfKdZfHF8N/ef1jWdFa
   pqFuu+IAlvo243u4yThiIh/X/8ZVHxUejiq1HbT9Uwt27J6jI/m0vzW7Z
   ctGznpSJ5l4uB0Nb2mWsDXqCj/CTny9Jz4odSwt878hZGcTJLl8X56Ol+
   ThT4iu3ROslO0xoSZkON2C1RPghMft0+pLt8jmChY5NKSGUyf0OwEGXKv
   DEEIvnuT7zj8hmA6my55LGmY3FY4ylXTSBXrSGhrVmT2kW8bx0ryzcSYF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2785481"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2785481"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:50:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5199242"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:50:01 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6AD2E11F855;
	Wed, 21 Feb 2024 09:49:58 +0200 (EET)
Date: Wed, 21 Feb 2024 07:49:58 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2 1/1] driver core: Drop unneeded 'extern' keyword in
 fwnode.h
Message-ID: <ZdWrJhHmQm-WdRWQ@kekkonen.localdomain>
References: <20240220175333.3242277-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220175333.3242277-1-andriy.shevchenko@linux.intel.com>

On Tue, Feb 20, 2024 at 07:52:53PM +0200, Andy Shevchenko wrote:
> We do not use 'extern' keyword with functions. Remove the last one
> mistakenly added to fwnode.h.
> 
> Fixes: 19d0f5f6bff8 ("driver core: Add fw_devlink.strict kernel param")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

