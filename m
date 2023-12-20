Return-Path: <linux-kernel+bounces-7191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1E81A304
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5CB1C23AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61DC40BEC;
	Wed, 20 Dec 2023 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLbAt94y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A641212;
	Wed, 20 Dec 2023 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703087294; x=1734623294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RbrZmm7bLHOk3RDn2KGJzngxVDY6BtVI+//FYJluKKk=;
  b=bLbAt94yEx8PrJkSFSr/0xPFsBPskb0JoViurTmG9MzF0eQs5UqH9Y0I
   fmsCD6cib2JTa0qoh5CQUSqp29AqK7a81KtnLSjto3BO10xadb3efnhZf
   X4MNRrU7a5pEL4Gb+r+6OjtcLIGfufNpl4ORIqu/tpKR3eNcYl41rbJO8
   OseBAeYwBBj7BljcyuRUEXcpQ7nLZxif/xlzmcFjgL0D5zsv+cV4vT2XB
   vpCnkY1ySXCURaVcKZWdPlKRf98mfyy0/fkM/swfp55yVemyRiCQIRWKt
   JJUvvbVaeXUof0sR3C5yKq/7S+X11+QMV4RfGrCkxLcstgKkm7U0dpo6O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="482018907"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="482018907"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="776380739"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="776380739"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:48:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFylf-00000007aiL-1ZDN;
	Wed, 20 Dec 2023 17:45:55 +0200
Date: Wed, 20 Dec 2023 17:45:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 05/18] serial: sc16is7xx: use DECLARE_BITMAP for
 sc16is7xx_lines bitfield
Message-ID: <ZYMMM9uaoKD39oPy@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-6-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-6-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:18:49PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Replace the explicit sc16is7xx_lines bitfield declaration with the generic
> macro DECLARE_BITMAP() to reserve just enough memory to contain all
> required bits.
> 
> This also improves code self-documentation by showing the maximum number
> of bits required.
> 
> This conversion now makes sc16is7xx_lines an array, so drop the "&" before
> sc16is7xx_lines in all bit access functions.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



