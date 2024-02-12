Return-Path: <linux-kernel+bounces-62074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE4E851B10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8807428677C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B16C3E496;
	Mon, 12 Feb 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6JfoiXd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014963FB2A;
	Mon, 12 Feb 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758100; cv=none; b=RfO5TtnbTDJAt2ygvpW17JnhRzGmyM+E1SWez/z1diHPa12AqyD2jGeJzttGkGTTHCCstuL0rlPA2ArqnYmsDOQTPbNslKCPSCRkNZfLLXYg8698oVJ09gNUuziJrvokmPLLParbCApRUP2M5tKnhxBS8nWo+GIkhx3KRnM1qQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758100; c=relaxed/simple;
	bh=DoX2nKXFKc5htRkK4Vo/8kvfuCoZLFfHUSFKyWZ0i18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+QZypXZnOdOnq4u28k9ZthEOqOZzE3WvcZk+HXRNqpWPZLAqcNWGhB5RZB/xYJD83VbwWvHCV62QUCtfduCNQ5CEvsv/k0U4Tjsu7Igty33D9JA17UNVneAc74Ys1Y3cFJw1naVQPafkgOuYMgOCBzCXFDpaEr0WG6kOusgKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6JfoiXd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707758099; x=1739294099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DoX2nKXFKc5htRkK4Vo/8kvfuCoZLFfHUSFKyWZ0i18=;
  b=m6JfoiXdh2dm5IEqevUHJhYRqyzWNgMZ4Gp1LqA9wUoZ/fBaNfjH2/QJ
   EebGFTG1LqJgPUu0wqdE8IIDnAmtisYrU2ammErKKA5IO7MNiajfct0xj
   4bupVhEMw0TBErtXFHvjjaSLsdQvPZ8Te/w8XeAQhQQ2iaOX/a/Wgb0lu
   tF3uI8cUlaQlDc6kYdId26gYpY/zYGAfzXh9rrz0n+nJLENhaWZ89zfoe
   NJsgoSkvVOpPFi5yiSf3V/XBIQhy0VnbO7IWKlOv3LiQd9QKhchZBvWt1
   uU8h+vtuqhDUj5XBZep0ila6xCq1lxm0seo0HOMc9RLFrWtF/onSBtr/+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5518862"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5518862"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911553414"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911553414"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:14:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZZtN-00000003xZu-1bgW;
	Mon, 12 Feb 2024 19:14:53 +0200
Date: Mon, 12 Feb 2024 19:14:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Message-ID: <ZcpSDOk-IQVasHud@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-15-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212170423.2860895-15-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 07:01:47PM +0200, Andy Shevchenko wrote:
> Add initial device tree documentation for Maxim MAX6958/6959.

Oh, this is an old version :-(


-- 
With Best Regards,
Andy Shevchenko



