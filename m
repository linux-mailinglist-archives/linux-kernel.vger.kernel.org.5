Return-Path: <linux-kernel+bounces-78345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B5F861239
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048A11C21446
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37D07E773;
	Fri, 23 Feb 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAEdihN8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0722EF5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693611; cv=none; b=JrkBqbdqrq3T9P336WXoxB7uYwN2jW4dqmtiQEJ4mkHVZseiRltLaGuHfjKezsb5urYxVSU+Kq49cRSMgbblJC2i78G6FfJY6Z3lS7xBHXD5QYWMrHt9lYNSj+yd8pfcRTV0CLOE7Egwe3S5qxp4Y8froXoDOZSoUVV6EXGhPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693611; c=relaxed/simple;
	bh=vrHViwPtfViEodYrYu27uDWOfGFSmxsgqGqcy7hiZeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj9lLa6Nfh3SKbiDO+xenNamgmtVFNIhOgtsiTn6WZlqqrXDOUGDsQYMrt0hazQUplHScZAIsDFEYQFYrQh4ayTJMVAa6H53VcsR9yie/A6r9Ab8l4/jJmZHH5FmpXUXztKu/6N+QX5W7GW2TCRnWJju8NPx90lA3IR9p/MKZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAEdihN8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708693609; x=1740229609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vrHViwPtfViEodYrYu27uDWOfGFSmxsgqGqcy7hiZeE=;
  b=bAEdihN82roZzTL7Z0FLWsQAjO8hTpiu0bS+8vlNIj7gOXoVddeE4FAS
   ljSdLUCqMbepLWzz1TZyMqgtxlXPfn2aGlNxp9IraLLbX2eGNQqwr72MP
   tAg+vzpoUN1uIgR5zzTuWEk+bQF5P8iIxE1IjrCAAoSIPQ1Csyn9Tid9V
   qRuRQChSxVsUyWw+SRzf0QedrzqLgSS+OcRETde2FCmg05Z8xyJYF9Q21
   F00jnSI+OSaVenecD4fGW3bk8xCVdEJ+xxxqSZtsvjNnFboUPwWON2HBG
   +pW7IqHadHuPZyxIODabtVd9tOW/bl84BnocSLYHS6F/5QhyUH/PUquWs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3164262"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3164262"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 05:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5859032"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by fmviesa009.fm.intel.com with ESMTP; 23 Feb 2024 05:06:45 -0800
From: rulinhuang <rulin.huang@intel.com>
To: urezki@gmail.com,
	bhe@redhat.com
Cc: colin.king@intel.com,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lstoakes@gmail.com,
	rulin.huang@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	wangyang.guo@intel.com,
	zhiguo.zhou@intel.com
Subject: Re: [PATCH v3] mm/vmalloc: lock contention optimization under multi-threading
Date: Fri, 23 Feb 2024 08:09:25 -0500
Message-ID: <20240223130946.112890-1-rulin.huang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZddDdxcdD5hNpyUX@pc636>
References: <ZddDdxcdD5hNpyUX@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> 
> Hello, Rulinhuang!
> 
> > Hi Uladzislau and Andrew, we have rebased it(Patch v4) on branch
> > mm-unstable and remeasured it. Could you kindly help confirm if this
> > is the right base to work on?
> > Compared to the previous result at kernel v6.7 with a 5% performance
> > gain on intel icelake(160 vcpu), we only had a 0.6% with this commit
> > base. But we think our modification still has some significance. On
> > the one hand, this does reduce a critical section. On the other hand,
> > we have a 4% performance gain on intel sapphire rapids(224 vcpu),
> > which suggests more performance improvement would likely be achieved
> > when the core count of processors increases to hundreds or even
> > thousands.
> > Thank you again for your comments.
> >
> According to the patch that was a correct rebase. Right a small delta on your
> 160 CPUs is because of removing a contention. As for bigger systems it is
> bigger impact, like you point here on your 224 vcpu results where you see %4
> perf improvement.
> 
> So we should fix it. But the way how it is fixed is not optimal from my point of
> view, because the patch that is in question spreads the internals from
> alloc_vmap_area(), like inserting busy area, across many parts now.
> 
> --
> Uladzislau Rezki

Our modifications in patch 5 not only achieve the original effect, 
but also cancel the split of alloc_vmap_area()and setup_vmalloc_vm() 
is placed without lock and lengthen the critical section.
Without splitting alloc_vmap_area(), putting setup_vmalloc_vm() 
directly into it is all we can think of.
Regarding Baoquan’s changes, we think that:
We prefer put setup_vmalloc_vm() function not placed inside the 
critical section and it is no need to lengthen the critical section.
We prefer use judging (vm_data) rather than 
((!(va_flags & VMAP_RAM) && vm), and it is enough to deetermine the 
conditions for assignment. The change seem to be wandering about the 
judgment of va_flags.
Hi Uladzislau, could you please let us know if you have any better 
suggestions on the modification scheme?
Thank you for your advice!

