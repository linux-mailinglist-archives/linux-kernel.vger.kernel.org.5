Return-Path: <linux-kernel+bounces-81899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F19867BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B47D1C2ACAE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CAB12DD8A;
	Mon, 26 Feb 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRJI2YzF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B279512D74D;
	Mon, 26 Feb 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964676; cv=none; b=Jrk7WTgItAvVIXvp1VfCafUe5FuT1w78mfF2Zo6qSh98WneykyNoU+sW/YxLc4qEfoBaB8mOWjryo4ZoZweDCjt1iSp/8v+ht5gPmP2pBtRBAt8EpP20j7Ihv+mgx9qaeQwWLrEZzWtCBIT0pyCBHAufV/jvSi4VlwGzWl+eiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964676; c=relaxed/simple;
	bh=3/lHKkguOmtJzs2ExxNbRkvOsyAUWG+6gLyLF788gl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+H3M6hDY09xgS4D0uZ0NqzFGIQXs6w5z9tBhvn+jsOKNZq+ZZc0YkUQiiwH1oCu4yiWagmZdQRx1JU8FyeSmd3tyWNie/EQ542ZLJCVDS+NdFyOuPAYbVbFI+ZkxD+rIs5CGuS8Nuq6ozDzWScVCHbR2uT6dOgr9BFaEG/O8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRJI2YzF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708964675; x=1740500675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3/lHKkguOmtJzs2ExxNbRkvOsyAUWG+6gLyLF788gl4=;
  b=XRJI2YzFSNavNIsoQkWCrDTLKII5x02o/jmdgFQOkW1HCc0xSH+ASNgi
   HvUNj4afxphr+9QxYg15UttJQaetYJp6ACUK3u+LKiTdlbuoWdUjO25xV
   15axf98AUm69goSVw2OB2orR/35hiNTD3/OG6CK5fesk0H7GJzM7jm93M
   IGYJMHmrgU85qGL0EI5RmoKOnqiIoW9e+GQR8Gf6GKZkbpi1bfHk8F0D3
   Pg0qokBfsuMC8wDvKEgve4viV7EKNhpmSjUtChaIHZS1hdlVVURJMLA5b
   k0G7t6KGcdb/isHz6cwhIhxxYhxdRRPI4nHuaOJ+E2aiaBWvpZmHRUkR7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3184309"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3184309"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:24:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913880658"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913880658"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:24:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1redmH-00000007jOr-0fde;
	Mon, 26 Feb 2024 18:24:29 +0200
Date: Mon, 26 Feb 2024 18:24:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v3 0/9] auxdisplay: linedisp: Clean up and add new driver
Message-ID: <Zdy7PH8R21Zgzq1t@smile.fi.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <ZddRZWftWhMHUl23@smile.fi.intel.com>
 <CAMuHMdWQ1hx143eJYyCcEj-uqQ3uXLWfB_x70bQDn=wp3kQG7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWQ1hx143eJYyCcEj-uqQ3uXLWfB_x70bQDn=wp3kQG7A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 02:56:35PM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 22, 2024 at 2:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 19, 2024 at 06:57:59PM +0200, Andy Shevchenko wrote:
> > > Add a new initial driver for Maxim MAX6958/6959 chips.
> > > While developing that driver I realised that there is a lot
> > > of duplication between ht16k33 and a new one. Hence set of
> > > cleanups and refactorings.
> > >
> > > Note, the new driver has minimum support of the hardware and
> > > I have plans to cover more features in the future.
> >
> > Geert, would it be possible to give one more round of reviewing/testing
> > this week? I want to close auxdisplay for next merge window next week.
> 
> For 1-7 (linedisp and ht16k33):
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you for the testing and review, I have pushed patches 2-7, postponed
patch 1 and will see what I can do with patches 8-9.

-- 
With Best Regards,
Andy Shevchenko



