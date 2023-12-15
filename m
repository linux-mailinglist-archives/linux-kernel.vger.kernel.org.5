Return-Path: <linux-kernel+bounces-1278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED87814CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6711C23AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD13C47B;
	Fri, 15 Dec 2023 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vj6uDuZW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C9D3C460
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702657063; x=1734193063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dryg73Lh7juDYIoh0VKY0VS11aUFe12BtdnUxm2iw4o=;
  b=Vj6uDuZWR3WDt5ye3kLE3wKynuzJ4uJDLsMh8aV2bqQq5nGz0vjcOq1N
   bNsUSc/7jqo9gV7x9l6ZYRk3RNbMzB5L/iJoUFj+iP8UY3HKYlySrssXg
   JG/S0pIoyH8lnojoB3qd96eVmXL2qcv/ZyrfmkDEmElUnibCfVSLc0AJn
   xkiqrvCBBHbm/NFCsGpFZm0WOR3QiF/VqShduP8WN7SmCEwiQPlVICW6a
   H/j6r42rxW8ZKTOAeyPa4nymdM7B7tec8cVi9lyP4dzj3aCIxCKKsKmDi
   fd/grKlzp5yRCkA9/jH55LZccBLqaxg+RWz/V223owF/3U9ltTk3JbHWU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="395035849"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="395035849"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:17:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="898190485"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="898190485"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.8.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:17:40 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Fabio M. De Francesco" <fabio.maria.de.francesco@intel.com>,
 Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] mm/memory: Replace kmap() with kmap_local_page()
Date: Fri, 15 Dec 2023 17:17:37 +0100
Message-ID: <5113571.5fSG56mABF@fdefranc-mobl3>
Organization: intel
In-Reply-To: <3867181.PYKUYFuaPT@fdefranc-mobl3>
References:
 <20231214081039.1919328-1-fabio.maria.de.francesco@linux.intel.com>
 <20231214114747.ddd42a1e567d2bd0f95f2095@linux-foundation.org>
 <3867181.PYKUYFuaPT@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 15 December 2023 09:40:33 CET Fabio M. De Francesco wrote:
> On Thursday, 14 December 2023 20:47:47 CET Andrew Morton wrote:
> >
> > [skip]
> >
> > I tentatively rewrote your explicit From: to @linux.intel.com, which
> > may have been unwelcome.  What can we do here?
> 
Sorry, in my last message I asked you to discard this patch and sent another 
one but I hadn't yet understood that you rewrote and accepted it. My English 
is still not good enough. Thanks for rewriting it. I'm perfectly fine with your 
decision to rewrite it to @linux.intel.com.

Fabio




