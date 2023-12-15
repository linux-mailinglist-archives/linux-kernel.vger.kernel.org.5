Return-Path: <linux-kernel+bounces-1140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C2814B09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB751F24B21
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0847358B0;
	Fri, 15 Dec 2023 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MI2OTpBd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AC34CFE;
	Fri, 15 Dec 2023 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652308; x=1734188308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xNI9zmJFSg33rN1tJ6eP4QEDvxIpJ2d9bmw3BCAyoLY=;
  b=MI2OTpBduriXcVo2Twp3A0fhTbdPb7/zrMpeFxCSqAS3qS/wbglusff8
   TfME5Sk4VoVEetvJfs6IRDhO9fQGzvaQdJneC0B+JN/3V8LbHWIkJ4MxJ
   UF50LNri5MY9/AFJf5MzBWSiI1+wQXhSdbRZ5kN6saFImUoHCjl16YfWw
   2OTAm74p8U4krsxMrkBeGTw8SjdCAku8JuDZ2k7rYwkit2NTdiASfVtsQ
   62qqBpICpYPoRb+hiVZt76VO6hlVEs12JOJRh9jqaXkWQyuF0xtxxJR03
   zYIzxS0DS74mHMZeZ2HdKrtMMf4ijJTcF4QwQkSPJBM8OQEu69he5nq0c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2455364"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2455364"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 06:58:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="845147457"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="845147457"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2023 06:58:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 485BA3A3; Fri, 15 Dec 2023 16:58:24 +0200 (EET)
Date: Fri, 15 Dec 2023 16:58:24 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Add Intel Meteor Point pin
 controller and GPIO support
Message-ID: <20231215145824.GY1074920@black.fi.intel.com>
References: <20231214154653.1087747-1-andriy.shevchenko@linux.intel.com>
 <20231215064417.GV1074920@black.fi.intel.com>
 <ZXxl161aJ8vZyiPw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXxl161aJ8vZyiPw@smile.fi.intel.com>

On Fri, Dec 15, 2023 at 04:42:31PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 15, 2023 at 08:44:17AM +0200, Mika Westerberg wrote:
> > On Thu, Dec 14, 2023 at 05:46:53PM +0200, Andy Shevchenko wrote:
> > > This driver supports pinctrl/GPIO hardware found on Intel Meteor Point
> > > (a Meteor Lake PCH) providing users a pinctrl and GPIO interfaces
> > > including GPIO interrupts.
> > 
> > This is driver for Meteor Lake-S and related, correct? Why it cannot use
> > pinctrl-meteorlake.c instead? Same way we do for other desktop CPUs
> > whose PCHs have the GPIO/pinctrl block.
> 
> Meteor Lake-S may or may not have an additional PCH, so the SoC (on-die)
> pin control IP is serviced by pinctrl-meteorlake.c, here we need to have
> a different file as we would have a name clash. Yes, it means that on
> the end user platform it may be two pin control drivers!

I see, thanks for clarification! Then this makes sense.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

