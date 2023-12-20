Return-Path: <linux-kernel+bounces-7222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8025981A36A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203B31F23058
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C441850;
	Wed, 20 Dec 2023 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hi7fM2zJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94640C08;
	Wed, 20 Dec 2023 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703087888; x=1734623888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E1GlkXmlweQP+n3h7Z9iPg2DFXrdFol7FxqzfRAKa1E=;
  b=hi7fM2zJZJnJ3PVQN4cHDQzxApIfx0/orOZjKEacbmpt3zguXIl2Or29
   XRpzMo4A1qFFSrdDBtGer8GQayrQbHKte/9W/1Z2hihCV8cTG7Mk1xV4Y
   JHiBG86w4/GKIHbRotK57Qwk8367yVqcRbxNsZ+4uZJT9eHU/wAN5c5MS
   QmhtAiW3EEbuVwb0MyRo1Z03aAZEk5fa6vrAnXxcojCsA6CP69gIOxpiu
   bp0dmdxGlz7OiZKqBZMclM8gX8kCoi/pxvlFejs0izvzm/iPhypZPxKt3
   S2Mx8RS2H8DOH5rLZFTGrDXtI8QzRcnimJX+RyJX6wblHZvG2+MExD0gv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9298353"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="9298353"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:58:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="752606023"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="752606023"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:58:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFyxM-00000007atZ-0YZu;
	Wed, 20 Dec 2023 17:58:00 +0200
Date: Wed, 20 Dec 2023 17:57:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org
Subject: Re: [PATCH 15/18] serial: sc16is7xx: pass R/W buffer in FIFO
 functions
Message-ID: <ZYMPBz3BbOzSCEog@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-16-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-16-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:18:59PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> To simplify function by avoiding cast.
> 
> This is similar to what is done in max310x driver.

...

> ---
> If deemed appropriate for stable kernel backporting:

I don't think it's eligible.

> ---

I don't see the necessity of the change, OTOH it's harmless.
The problem is that commit message is basically "Yeah, we
do cargo cult." Because I haven't seen what casting you are
talking about.

-- 
With Best Regards,
Andy Shevchenko



