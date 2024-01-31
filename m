Return-Path: <linux-kernel+bounces-46465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D66844022
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DE91C26346
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416747BAF8;
	Wed, 31 Jan 2024 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZVOxxJk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25E3770D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706561; cv=none; b=uxlWRMh7BJ/m/zZnONnd6eoOIzKqP8WRt/Iy+zPCs5tPMa5+NPhWmRc7ky8W8ssCOFDNaLpUFLDfZHMN4VUxqfqDtoBQjlaFxsXZi3EHEQja/e0ltnwqZeSuQImZfMP4koy3n0jJusQ2cdNUFU72vtgK6ccHfeULMrS4d5wwdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706561; c=relaxed/simple;
	bh=hLnu5IAc3QGNlNKTY3jsLCwnTnvQBY8D4pUs+0Lc3hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uA7UhloHgfUKPzCpNp9wrZOAjfR2eRUuPFTeojL+ghSjaY+kd53UQlw/hCn0XV/cD25NGt7wWYCwKUU6wPPO5xsRFtVJigozgMXM2zqG//sc/AxbrQ/rpCxrF3uZm7JA3FAeqOp+qY5z+2mvveg8k/hhZmiyrA+cytFzADL52WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZVOxxJk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706706560; x=1738242560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLnu5IAc3QGNlNKTY3jsLCwnTnvQBY8D4pUs+0Lc3hw=;
  b=XZVOxxJk0uiZTLE5VCdiXqYEh1MZ19OzcdyAGXzu8GNFzVniwzy3ozRm
   HyMePKAhkojWU0Mx+1r0wkpwl8s1cB26df8yU+CtKt8x1ZEg89S1kIWuJ
   1IzBDf6RXJFCMlCEwOKIh6ThgZbNBEO5uigl+EqdNNwSb0DLL6W189bpJ
   RwxXNBEYCmM37pn99c0zH4/E5xSK2Qz62VOVWqssWhtbRQhOEGkui+V8e
   rrkCY0beSpMUReGqPPvJZzSQ15NF07H9/6LCSwNKv9i6OrNmsIIfVetkI
   RF9zM8jSe3QKI+nqu2MADCymZe//xAN1j3diocCOVFA6G+RpA7/6RKM6v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10347935"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10347935"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:09:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822566327"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822566327"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.21.82])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:09:16 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] cleanup: Add cond_guard() to conditional guards
Date: Wed, 31 Jan 2024 14:09:13 +0100
Message-ID: <13504735.uLZWGnKmhe@fdefranc-mobl3>
Organization: intel
In-Reply-To:
 <65b82555aaf86_5902829447@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References:
 <20240129190100.329791-1-fabio.maria.de.francesco@linux.intel.com>
 <65b82555aaf86_5902829447@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 29 January 2024 23:23:17 CET Dan Williams wrote:
> Fabio M. De Francesco wrote: 
> > 2) By using cond_guard() it is not possible to release the lock before
> > calling other functions from the current one. The lock is held until the
> > current function exits. This is not always desirable.
> 
> No, that's not correct, the lock is only held until the exit from the
> current scope, and if you call functions from within that scope the lock
> remains held. So:
> 
>     func1()
>     {
>         guard(...)(lock1);
>         if (condition) {
>             guard(...)(lock2);
>             func2();
>         }
>         func3();
>     }
> 
> func2() is called with lock1 and lock2 held, func3() is only called with
> lock1() held.

Dan,

If I read your example correctly, this is exactly what I wanted to say by 
"it's not possible to release the lock before calling other functions from the 
current one". 

For example, if we use this (not scoped) cond_guard() in cxl_region_probe(), 
we end up to the switch() and then possibly call devm_cxl_add_pmem_region() 
with the cxl_region_rwsem semaphore down, whereas the current code calls a 
up_read() before the switch.

I think that in cxl_region_probe() the only suited conditional guard is 
scoped_cond_guard().

I know that you don't want an indented success path but in cxl_region_probe 
but I suspect that scoped_cond_guard() is the only viable solution, otherwise 
we end up calling the functions that now are called after up_read() with the 
semaphore still down.

I hope that this time I have been clearer.

Thanks,

Fabio



