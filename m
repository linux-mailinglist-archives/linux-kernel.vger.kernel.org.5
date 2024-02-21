Return-Path: <linux-kernel+bounces-74254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB985D1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055081F26382
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBEC3B193;
	Wed, 21 Feb 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOS+T0/d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB538FB0;
	Wed, 21 Feb 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501529; cv=none; b=ZDwXKl/Zsl4FGHUXygJiScC5XuCVLHSyhiv1VSvveppGBBpSaTPOznJijXKdayhOntYzmwmFaAiNaKi7FhDKFr3Umt/PEe2ts1PSxyW7bUkG2+F7ozNuIfKXBfpWEFILcO2qoe8utPwIwaHEdAnJVaeIxfs7Je/lWCs1xW7QSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501529; c=relaxed/simple;
	bh=4L1uSqK5zq7J1AW0LL6jzERak6cNCAbM//6X/97wp6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il8vPrEFrvvoVGgKG/cERX8w5Lo/eXH+lhJf//fO8SGXZsqHOUC1M32C13gLDpvYC1T92UYiYBb/BifoyVN2MofPTTj6qdS+Mzu7K1bIWhWfdvY6hP6ytDhuVk/kchLEugIzw3f+S7mN8Z9r05Gvq035qM6Qym5ZtedNpDQrj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOS+T0/d; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708501528; x=1740037528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4L1uSqK5zq7J1AW0LL6jzERak6cNCAbM//6X/97wp6M=;
  b=EOS+T0/dWXINN6kAJ2yxJgoXZSX/ln+SPsBcsIzR93bFgoRfzRspQ2YE
   8Fr8wQFoMur0y2ygx0/TZqocpsA5PpEwt5l42mfOr05u+BkgBUBe6Tj4f
   XebcUM9FM509TT4KZ/FlEwwiPCjQUAb714aJwH3TicktBQlen3lLVGLQp
   q/7ebsBHpBsD4tWp3lUgMtxZCgH46Vu0KwTf86+qBhA5B+ddLzXQbQxaB
   Wa3oOx+Z4ASTOldU0sIAZ8kJzEWUOVVRsiZVqe0b+waU7rvQiLcGCO9Ye
   GplFvurE7Ozh674QmzXlVvdHvTDsOSAJLx9o0QVi9gII7IPsZPDWG+ysK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13349613"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="13349613"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:45:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="4988506"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:45:25 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 689FA11F855;
	Wed, 21 Feb 2024 09:45:22 +0200 (EET)
Date: Wed, 21 Feb 2024 07:45:22 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] device property: Move enum dev_dma_attr to
 fwnode.h
Message-ID: <ZdWqEnxlfy_SbE40@kekkonen.localdomain>
References: <20240220144105.2316632-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220144105.2316632-1-andriy.shevchenko@linux.intel.com>

On Tue, Feb 20, 2024 at 04:41:05PM +0200, Andy Shevchenko wrote:
> The struct fwnode_operations defines one of the callback to return
> enum dev_dma_attr. But this currently is defined in property.h.
> Move it to the correct location.
> 
> Fixes: 8c756a0a2de1 ("device property: Convert device_{dma_supported,get_dma_attr} to fwnode")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

