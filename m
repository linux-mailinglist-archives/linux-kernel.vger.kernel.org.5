Return-Path: <linux-kernel+bounces-66870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9ED8562E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2822A283209
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D00212BF22;
	Thu, 15 Feb 2024 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZ/tVpPT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96F12BEAF;
	Thu, 15 Feb 2024 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999430; cv=none; b=Yrum2QewLfM5Ucn2mpVPw/NLJ8NWNqvb6eaR2t8IsfxFGnqJzNQck3rmb9L0RTO61h473jqmTDwSvTJIvjJ5rGvkvmlJCN69hdMTIxtrDzRUbBOzUVl/cfHKvZ4m2eJGGSIeiojsElL7+nEtUR+a4YneHyDkLISNVsjuW+QKqcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999430; c=relaxed/simple;
	bh=zFgVeZ+HCPKzMsMvNy4bcqrK2mPXB/8qWs0nNlUKGR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKFOBT6WEGnO0X18WW8YFeKNxWqqMPZTPKAKBWkOtsXK8+RGica+kKTX+zCfMadAKX/46CYTNt/aCS9MSPXybPLKtoiBs+rPK2X7mPU38EzgX8criZ3WoaHnVg+NaK1XXbIRa0fjxWpPhBfrsTwUMkuNdbApD52KOlDFzZvHOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZ/tVpPT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707999428; x=1739535428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zFgVeZ+HCPKzMsMvNy4bcqrK2mPXB/8qWs0nNlUKGR8=;
  b=aZ/tVpPTUPNsEHgqs7GZHe6nXe+DXqfuX6VSjuWDJx6kY1uyuVRkQDvT
   fouf95ppAe1CMW1lWBPdfL+ngSng5JzOeCisQqMw+bi+O15J/Cyj9oMML
   43GNZonbWzgtd6bTqztxpyMVA7UOMv+F3qh+ZNHECipOJIbtTDJZJIi52
   jdQc9tH02jkTltF63CDhf0njznyLXjDbXjuYXuZer2w8yyi4Z5WYGO9J1
   FY81m5b1RrHz0RLn182JC3VcRFta2QD+FTE27nat9LOFv0JIC50R5fPKh
   d4q7aag5qvyoN7A5LAplMC7GZkbnh+/6Sl5EXx7N4ALvYSL065cRHHpq0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5049590"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5049590"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912156788"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912156788"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:17:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raafk-00000004mim-099p;
	Thu, 15 Feb 2024 14:17:00 +0200
Date: Thu, 15 Feb 2024 14:16:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 10/15] auxdisplay: linedisp: Provide a small buffer in
 the struct linedisp
Message-ID: <Zc4Au5Q_rOAx7_4Y@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-11-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVtqWBi4Y1tj74m4V4kp-3cFe_FphKKeY7zOkrbMVkKRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVtqWBi4Y1tj74m4V4kp-3cFe_FphKKeY7zOkrbMVkKRg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 11:40:44AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 12, 2024 at 6:04 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

..

> > +       linedisp->buf = buf ? buf : linedisp->curr;
> > +       linedisp->num_chars = buf ? num_chars : min(num_chars, LINEDISP_DEFAULT_BUF_SZ);
> 
> I think it would be safer to return an error if buf == NULL and
> num_chars < LINEDISP_DEFAULT_BUF_SZ.

I think you meant >= ?

> Else a careless driver that doesn't check linedisp->num_chars might
> overflow the buffer.

Okay, check has been added.

-- 
With Best Regards,
Andy Shevchenko



