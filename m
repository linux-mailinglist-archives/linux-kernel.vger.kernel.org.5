Return-Path: <linux-kernel+bounces-48069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6018456DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0AA1F28E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1BA163A87;
	Thu,  1 Feb 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuQfNKpL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E92161B6B;
	Thu,  1 Feb 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789035; cv=none; b=Pqd+GQ7Y3YgyW+4b5q4uTwzuuFm1lOmfw6R2yzvTNdsdHz77KLalObCdiKSlN2Gfd+8FFL2AS0zNrBcR6M6xSByHHNsZOIfj2cnH7RCGTzlCWytRIydAcDr6N4A5SCCDUXd8tCp0ZF6bpJX9Q2hBezGmxLDJXEOn3EIBLdFSioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789035; c=relaxed/simple;
	bh=HmMQXeLGQdDe0lD1nXkW7jz/UDWrlhubI0Aip/rEHN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSOrHI2vToI9NK7wqfX+qo2N8tuCyn95NFRnjXe4wGkY2tfre4mJogucqDmIksUdMxoLYq3x1iUmzCeCJBKbPozFURqbc72u0M6tcjxxbbrP2d0kAAt2Z7gECAg9jcys+1tpHLj2A3iRAcoWB5ByTPOixjhdImai0BtqZGlAj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuQfNKpL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706789034; x=1738325034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HmMQXeLGQdDe0lD1nXkW7jz/UDWrlhubI0Aip/rEHN4=;
  b=XuQfNKpLwOujWx1ziuTuzPg+zkyL5dKICwu8or0Flqg3do3m5andIX8M
   4BuGZiYLp9Omi6ZQPNgWl2tP7yLb5g7Dn4o0FxhPGXIwpFK+5l7FGQ+IS
   rXmey8H3st6o44jgnZfYaL8MiRVGfEmq6bfRD7OZ/utyOAY/c0VfMuuJH
   Qd8qYbkfWav+99YLj9nqtIWFTGWln2hGXWbaYCe7B94HfI2pwoSBTyCjz
   L6zatSTPGJj1wLMbyX6yeE89dvEKhSFFwk7siR8wzd9m00KrYLiY7hrg/
   gtU9XRwQIa4XXAOJaz5+4nrDIlNbQgk+qEIA9ibujqX8vHZcoXFVEZqL8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="60251"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="60251"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788919040"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="788919040"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVIh-00000000onx-0xJW;
	Thu, 01 Feb 2024 13:32:11 +0200
Date: Thu, 1 Feb 2024 13:32:10 +0200
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
Message-ID: <ZbuBOmtyYdlmnCBa@smile.fi.intel.com>
References: <LV8PR11MB8463F88C2364A08DEF3ABAC28B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR11MB8463F88C2364A08DEF3ABAC28B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 30, 2024 at 11:32:48PM +0000, Corona, Ernesto wrote:
> Adding aspeed jtag device to device tree
> 
> Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
> Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

First of all, please use --thread to git-format-patch when preparing the
series.

> Cc: Jiri Pirko <jiri@nvidia.com>
> Cc: Vadim Pasternak <vadimp@mellanox.com>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Steven Filary <steven.a.filary@intel.com>
> Cc: Amithash Prasad <amithash@fb.com>
> Cc: Patrick Williams <patrickw3@fb.com>
> Cc: Luke Chen <luke_chen@aspeedtech.com>
> Cc: Billy Tsai <billy_tsai@aspeedtech.com>

Second, please avoid flooding commit message with unneeded details, i.e. move
these Cc:s to...

> ---
..the after this cutter line.

-- 
With Best Regards,
Andy Shevchenko



