Return-Path: <linux-kernel+bounces-48066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A759F8456D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474BB1F28F31
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B48016088E;
	Thu,  1 Feb 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgCX8o+r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB22915DBBC;
	Thu,  1 Feb 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789026; cv=none; b=rcwDPuxi4ZJdkX076C0O6LKRB2vDkVkiI3oCffTjuO7rJ7vdPbhGTSHJjjjw1gCY5PJgcL33uexLMZKh9sXT875dgFnYcXIqe5xMmvjr1GdA9oCd4XCTH2bbFG0AnivRrXTtgqctpf8mixrIwYFnvfjyxydUFXEcuS/qxatR244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789026; c=relaxed/simple;
	bh=bTHveruBOFFObOLd37q/myHWD1UCJBG+iQPhvAGyc+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM9py4eVOD0NntYnu/I1TFWDm/3+Qi42wQ3SZRBHpOOW1HrDl4amG4Z/vKkC4hkJg1pEHAJKCvL1Uv9N7VBxlyVlHlds5VdaqM18mdbGbQxv3wg+3RLbK0JRDHLNL7Ym7yLFh0Y/ZT1oTqaZkxihgZvnpY/9fbtzkfSnjf3SI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgCX8o+r; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706789025; x=1738325025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bTHveruBOFFObOLd37q/myHWD1UCJBG+iQPhvAGyc+M=;
  b=NgCX8o+r6RK9l/MOu4wE3rOYX5/Y3ugg14JDEJoiVenahPQHTx2IsoAN
   jQuNwLwFP/GGkz/Skxgu5w8mCzhHeL3yl2x9TJvw5rRJO8qeyUQU2RHan
   UGt/fsPxTNZQ8Khxx6oNJdVPEoakyZCmzK2gW0N/ZveCq4jqgBYeAScte
   o6ZUsc2RcyJujwtkc7xRzxmlAMPWd7lEiGOgLKetiVKNdKrDj+9X/EOuP
   LCiLqPafYNC7RuoqxRrYqVyYnZtPfjdzbajx1YjZKt6Qu4h/fW7ahj0CW
   77pIJ31KZVM8mr/mF0plyzBYsh/eFGyyaqxvMoCh/wdfOnE8gmq41IIlu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10630086"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10630086"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="912106809"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="912106809"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVJR-00000000oog-2o9m;
	Thu, 01 Feb 2024 13:32:57 +0200
Date: Thu, 1 Feb 2024 13:32:57 +0200
From: "'andriy.shevchenko@linux.intel.com'" <andriy.shevchenko@linux.intel.com>
To: "Corona, Ernesto" <ernesto.corona@intel.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"Castro, Omar Eduardo" <omar.eduardo.castro@intel.com>,
	"'omar.eduardo.castro@linux.intel.com'" <omar.eduardo.castro@linux.intel.com>,
	"'arnd@arndb.de'" <arnd@arndb.de>,
	"'jiri@nvidia.com'" <jiri@nvidia.com>,
	"'vadimp@mellanox.com'" <vadimp@mellanox.com>,
	"'mchehab+samsung@kernel.org'" <mchehab+samsung@kernel.org>,
	"'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
	"'davem@davemloft.net'" <davem@davemloft.net>,
	"'nicolas.ferre@microchip.com'" <nicolas.ferre@microchip.com>,
	"'robh@kernel.org'" <robh@kernel.org>,
	"'lukas.bulwahn@gmail.com'" <lukas.bulwahn@gmail.com>,
	"Filary, Steven A" <steven.a.filary@intel.com>,
	"'amithash@fb.com'" <amithash@fb.com>,
	"'patrickw3@fb.com'" <patrickw3@fb.com>,
	"Chen, Luke" <luke_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH 30 7/7] Add AST2500 and AST2600 JTAG device in DTS
Message-ID: <ZbuBaRyZJR9-ZS-K@smile.fi.intel.com>
References: <LV8PR11MB8463F88C2364A08DEF3ABAC28B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
 <ZbuBOmtyYdlmnCBa@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbuBOmtyYdlmnCBa@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 01, 2024 at 01:32:11PM +0200, 'andriy.shevchenko@linux.intel.com' wrote:
> On Tue, Jan 30, 2024 at 11:32:48PM +0000, Corona, Ernesto wrote:
> > Adding aspeed jtag device to device tree
> > 
> > Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
> > Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> First of all, please use --thread to git-format-patch when preparing the
> series.
> 
> > Cc: Jiri Pirko <jiri@nvidia.com>
> > Cc: Vadim Pasternak <vadimp@mellanox.com>
> > Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Cc: Steven Filary <steven.a.filary@intel.com>
> > Cc: Amithash Prasad <amithash@fb.com>
> > Cc: Patrick Williams <patrickw3@fb.com>
> > Cc: Luke Chen <luke_chen@aspeedtech.com>
> > Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> 
> Second, please avoid flooding commit message with unneeded details, i.e. move
> these Cc:s to...
> 
> > ---
> ...the after this cutter line.

Also, you may use standard versioning pattern by using -v31 next time for
git-format-patch (31 is an example, you may choose the correct version).

-- 
With Best Regards,
Andy Shevchenko



