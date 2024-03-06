Return-Path: <linux-kernel+bounces-93990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A6B8737E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631AA288088
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B404131746;
	Wed,  6 Mar 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRh2z5x/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291FE130AFE;
	Wed,  6 Mar 2024 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732355; cv=none; b=ZeXSBqKkuD1P7E03whgmWZeBO7qCUhAZCp4+XbmNHLEIYWrT13WW5ix0KY9bU534qapDrHOcPvJNxDpNr0JGSU/Ww07RuoaIYqmP9ZNpJsHYnUO7jR//7G/++Onzk9gtezjAGn7PxZRSFcfNMgteavBFvFs8DshkPsasUngl8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732355; c=relaxed/simple;
	bh=EWzERcgJ3gRSC618OjmqDgGRixGjDHjDqIOjuHDHl/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTkljFXcN0g/gD3qcgvD3LjSx1DUL16KATo0j+3lkpnTkhs7fzYIQr6atn0aMbMwGWejWh8WX3b1lzybVo33oR7sTnuRNt7srkf9oVyBCYCbazoXoNKmRIzxHKMbggJ44bKf1ALhS2QSCVr0aQVI8jL/doF/0utuE7QJETpe+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRh2z5x/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709732354; x=1741268354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EWzERcgJ3gRSC618OjmqDgGRixGjDHjDqIOjuHDHl/E=;
  b=HRh2z5x/NldfLV1pSyk8JPXiSIysN4h0WH9C0yxItRadPgzZYSMwysYE
   JcodictuWlfQEvZ/ItmL3NYivuCtViirBPYyFZvzO5heD45liZI4TylB4
   ChhCKG5nI3JClzTobydlxsgPbAKPjVNnPvMah4fx6xWbnT8xnBR9TgBUG
   SiXR7NMUhIMFMs4rtIUIyUAQO3ngEZJABTECIJsWabk3NbPolsfiDIRQg
   3ldO6TN+4H4R7xTPT1nWkq0nzThIwPVnkEirF2f8swZ8MxcqzbJnI3Yi+
   J0vTorT1tFAukWs6NGv+iQM54U8R6XEf76I2AGvf3ENdW+Y/UpmMx4IPL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4207812"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4207812"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:39:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="914178648"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="914178648"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:39:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhrUA-0000000AHHd-3JzQ;
	Wed, 06 Mar 2024 15:39:06 +0200
Date: Wed, 6 Mar 2024 15:39:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 3/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <Zehx-v7h38TPJWwe@smile.fi.intel.com>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
 <20240306080726.167338-4-herve.codina@bootlin.com>
 <Zehrd/VgW5AnfJEu@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zehrd/VgW5AnfJEu@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 06, 2024 at 05:11:19AM -0800, Yury Norov wrote:
> On Wed, Mar 06, 2024 at 09:07:19AM +0100, Herve Codina wrote:

..

> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Why? Shouldn't be Acked-by?

> Would you like to move this with the rest of the series? If so please
> pull my Sof-by, otherwise I can move it with bitmap-for-next.

-- 
With Best Regards,
Andy Shevchenko



