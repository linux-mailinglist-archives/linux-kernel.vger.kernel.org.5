Return-Path: <linux-kernel+bounces-48369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECAD845B07
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15966B28071
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE046217A;
	Thu,  1 Feb 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3PMYYq4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC762153;
	Thu,  1 Feb 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800433; cv=none; b=TLZaEMdIjjwmN4s02Mb0m1AmssE5eYGRlQBuCdFhgBs4IQrtrMib1wbMDWRl61Uq4Q3FFb6NeL1+8MZGOwcfhn5iAumrnRMZH2a2fVAMIn5Zec1pn/su25mbJl2ghSvCf69ApUbhVuJyoGlAd072kFQeLb2At40jvwUq5b6fuqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800433; c=relaxed/simple;
	bh=9ckWzzJ12lEtMOBToFzrFe0Ik5jELpvVYP3r7aY/Vnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dy/JumWZRVPTf2v503JELYCjFTcMLFD+JXPdxaHAuIpiCym3JgbE/83wbwQqRkUw326Ai6i2i/UKjKypkLFUZRI/9GqNVjaua6H6/MnLUHWTb1EOwtTERDFLkJFm2KGJmFKVp602TCcFgwn5K/9YT/Ve8+9Lz1mKa2okyBbCb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3PMYYq4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800433; x=1738336433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ckWzzJ12lEtMOBToFzrFe0Ik5jELpvVYP3r7aY/Vnw=;
  b=f3PMYYq479/q1w2cUU+pmhp+llbeg8eXfbkegZgK902t/D+td5rNpR63
   aqn5nzpVUNXaOYrW+9KZUwB/olfEn0rDUP9+J6UI5XuwP70ACYaz7wa19
   hOxaYLBG47edpRr3aUHIEjaI4m+TuNmdfPGrNFY/bU5jK16d9IMLr8qOU
   8vKBZTQlXxnBoyjl4/1nMbFhJVDpvBML3ZaH4w80U1lQ3UF6izh4itxkP
   sKaiZ5QynZVmEhZ8y+Yro7sdY76UIik3XR+fvk1iOiqdUW7JVhe/6yEkR
   K+9r8+HaSU++gIjoXxvLDafLJUJ1tL1+x00CUhLUandIm2b08z+rIkBYP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22413765"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="22413765"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:13:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4430453"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.2.91])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:13:37 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, dan.j.williams@intel.com,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3] cleanup: Add cond_guard() to conditional guards
Date: Thu, 01 Feb 2024 16:13:34 +0100
Message-ID: <2172852.irdbgypaU6@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20240201113612.00001d90@Huawei.com>
References:
 <20240131134108.423258-1-fabio.maria.de.francesco@linux.intel.com>
 <1785013.VLH7GnMWUR@fdefranc-mobl3> <20240201113612.00001d90@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 1 February 2024 12:36:12 CET Jonathan Cameron wrote:
> On Thu, 01 Feb 2024 09:16:59 +0100
> 
> "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com> wrote:
> >
> > [snip]
> > 
> > Actually, I'm doing this:
> > 	cond_guard(..., rc, 0, -EINTR, ...);
> 
> Can we not works some magic to do.
> 	cond_guard(..., return -EINTR, ...)
> 
> and not have an rc at all if we don't want to.
> 
> Something like
> 
> #define cond_guard(_name, _fail, args...) \
> 	CLASS(_name, scope)(args); \
> 	if (!__guard_ptr(_name)(&scope)) _fail
> 
> Completely untested so I'm probably missing some subtleties.
> 
> Jonathan
> 
Jonathan,

Can you please comment on the v5 of this RFC?
It is at https://lore.kernel.org/all/20240201131033.9850-1-fabio.maria.de.francesco@linux.intel.com/

The macro introduced in v5 has the following, more general, use case:

* * 	int ret;
+ * 	// down_read_trylock() returns 1 on success, 0 on contention
+ * 	cond_guard(rwsem_read_try, ret, 1, 0, &sem);
+ * 	if (!ret) {
+ * 		dev_dbg("down_read_trylock() failed to down 'sem')\n");
+ * 		return ret;
+ * 	}

The text above has been copy-pasted from the RFC Patch v5.

Please notice that we need to provide both the success and the failure code to 
make it work also with the _trylock() variants (more details in the patch).

If we simply do something like:
	
	cond_guard(..., ret = 0, ...)

to be able store in 'ret' the code of the contended case, that is 0.

Since down_read_trylock() returns 1 on down semaphore, when we later check 
'ret' with "if (!ret) <failure path>;" we always enter in that failure path 
even if the semaphore is down because we didn't store the success code in ret 
(and ret is still probably 0).

This is why, I think, we need a five arguments cond_guard(). This can manage 
also the _interruptible() and _killable() cases as:

	cond_guard(..., ret, 0, -EINTR, ...) 

In this case we don't need 5 arguments, but we have a general use case, one 
only macro, that can work with all the three variants of locks.

Fabio 




