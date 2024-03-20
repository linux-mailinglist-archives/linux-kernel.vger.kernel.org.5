Return-Path: <linux-kernel+bounces-108758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A38880F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214D8284EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F6E3D3A5;
	Wed, 20 Mar 2024 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7rPQrVu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8933C48D;
	Wed, 20 Mar 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930375; cv=none; b=eMmF1n+Ov58csR6OTF7wy57N1GY9sgSlkP1L4z0D2qYUSAr5HQJpc5idXgv2ml/miW2rk0SSeYK+MTnvEZON9x1j1QFSed9CgtkYQcjXL7W4CBD7ovNlKLzbuySezA/cKX7qau5jpaS90O10HxAbyJSSfodlxiilZ2wqeCBhkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930375; c=relaxed/simple;
	bh=gUSwp+UFy627gBWs5T8M7qin00rGZoYovIOZ7OXQATA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6i/44d2Drocp0E+nJUWaTb57zcaS7tEm6S7KiDA80mryRQpWP/+mNwbqqaaIAwn4ts0H82LZKNH+GNHcRM5j44fQQtEnFHErABEt+CrpphGnlHiPnFS4+kfmwhRHvO04VDPEjea5BKj0QQLTxPabem7Q8jPDfPuwjB/XarhNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7rPQrVu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710930373; x=1742466373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gUSwp+UFy627gBWs5T8M7qin00rGZoYovIOZ7OXQATA=;
  b=Z7rPQrVudXEHHGF/FD5LSa4XaBPKoCOhHzyikQQKJp4uccJKwS1NicMc
   OW78+AEWmpyVmiJYiU+Y/qp7O2Drjtcc4nZI+rl3bPUVZb6LMazMCe+j3
   1fdG+5qlWx8v/U9WwkKLIIW176QSbmJrjxKa76R3tBP1HUxtHjkDrvH7E
   +r5vB+mb9wYwtjPrMznS0ltez2jEsMqz4de0ByW1cPhZ/g2r5KRZU1bbh
   DkoBJWmQyasT7u8eVYEitVK+0w1VhpSY4XOS/+w8zyMQfoSHfqJc8Jbzi
   FnYLw7SsVlsM8oxLbT1TnwR0JkUI5sc8Zc3r3W9WQSFIClyPXXKmrY0I4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23303653"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="23303653"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914661997"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="914661997"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:26:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmt95-0000000EXUK-3lml;
	Wed, 20 Mar 2024 12:26:07 +0200
Date: Wed, 20 Mar 2024 12:26:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] can: mcp251x: Fix up includes
Message-ID: <Zfq5v2lySrc7VKBS@smile.fi.intel.com>
References: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>
 <20240319-chewing-aptitude-db56f0a3fc32-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-chewing-aptitude-db56f0a3fc32-mkl@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 19, 2024 at 03:25:24PM +0100, Marc Kleine-Budde wrote:
> On 18.03.2024 21:34:10, Andy Shevchenko wrote:
> > This driver is including the legacy GPIO header <linux/gpio.h>
> > but the only thing it is using from that header is the wrong
> > define for GPIOF_DIR_OUT.
> > 
> > Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.

> No need to resend, added to linux-can-next.

Thank you for taking care, although it doesn't cancel my question to
the net subsystem flow in general.

-- 
With Best Regards,
Andy Shevchenko



