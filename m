Return-Path: <linux-kernel+bounces-59863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2844B84FCB4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1A81F24E77
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA52E3F7;
	Fri,  9 Feb 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZYy4HpE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D924A18;
	Fri,  9 Feb 2024 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506333; cv=none; b=ODGQsiHlQucCe6gc+0bPTAZQB9z7Y1461B8rcLjbldshxIirrDFveHh1FV1W3+AOZmS9at/DJGdIWrWpsc1b0BKYQar98UCMJP2a857v3cYJqxukoqwPak3uluza4EkrWb/c4Jh27ZfsVDaaEenO28g2J8OfGknPV0hhInicWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506333; c=relaxed/simple;
	bh=xaL3FZHj5UTYJhVEphfvo4x9zI6VzgX8QmADlVyE96c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qi3ONRb6qGhZhcHHf6DHmiPQEjONSj/vnWbhqQU+fPN1l8ugmF0Zp/aD2/43iTye1Lee64xVnRIXPykSgt6jRqahCSY4GMFGrbi1hyHtht+x1umx7881EXlqvDE/qAR0V/ehc/8AgTHRaNb3uIhPrvSkUQXt3v7HkVG3WH8pJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZYy4HpE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707506332; x=1739042332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xaL3FZHj5UTYJhVEphfvo4x9zI6VzgX8QmADlVyE96c=;
  b=FZYy4HpEkxCerEqXIAjxQlmQdoX7ak2J+F11Cj35Er1ReglwRbSig4TK
   xPAEVAaEr0t0yk85A7MwjeV2HVpo3UfEFx0vFA/aRJeo6hfMSL76nXCU7
   4tH8cTSY4WKa0BgZHwzFA7qD+LjT1QEggkyQpdYVkt3L+uPeTCsOlCpVm
   kil+hXruyzUt1P2i0Uxj1Z2GEKwNh42oSb2J6GWLoSxQZtzVjVIvSy+y6
   +gArYJJBQ3o7/8Kud9otEnD7dfVE1RbkmDLds+XzpCQN5ZZn1xmzxL1IR
   HewT4RxKXV7wC5Jzn55Asy/rXpH73HRHJKgOBySXcBvJwScJsz1Ljd3uk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12858128"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12858128"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:18:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934506458"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934506458"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:18:44 -0800
Date: Fri, 9 Feb 2024 21:18:41 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pwm: dwc: Add 16 channel support for Intel
 Elkhart Lake
Message-ID: <ZcZ6kUkf-GktlU4p@black.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-3-raag.jadav@intel.com>
 <ZcUNe09gDtkztmbk@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcUNe09gDtkztmbk@smile.fi.intel.com>

On Thu, Feb 08, 2024 at 07:20:59PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 08, 2024 at 12:35:26PM +0530, Raag Jadav wrote:
> > Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
> > function with 8 channels each. Add support for the remaining channels.
> 
> Side Q: Have you used --histogram diff algo when prepared the series?
> If no, it's better to start using it.

I used it for a few weeks, but I think I've grown a bit too comfortable
with patience.

I'll use histogram for pinctrl stuff if you insist :)

Raag

