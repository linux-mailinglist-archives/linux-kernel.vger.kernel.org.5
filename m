Return-Path: <linux-kernel+bounces-59302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E505384F4D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B111F258EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01D33CE6;
	Fri,  9 Feb 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejo5BZcM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93DB2D60A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479370; cv=none; b=MWpiSQQ853PdafQ9s4+oz14nZDQ7lvSqhHyAsSQsNqx3kx0jUiB4ER7xyqEXbCj4h4BEf5JTwTBMaivW5sfvgPRGWxOQbsCYLp91fMheBojfF6UrrMX5prmZ/UH5fXMtRZem98EqWRlFAvLsjPNXORwV1SR2p8duQnBesox3VUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479370; c=relaxed/simple;
	bh=yHIrMU+ZX5RuinTIn+nTLh+yX3ofZbcBqkJFfJ3tlV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RI9n6lOXCED+J+UcYVEO42Xe71K2dSX0rGk1ZhvLS0olf+v/LhqXIbcm6LGiIRMzMB1BjKX10eM15orO5C8YnET2f8zdVg0kQVugchBCZWv/O/81ehaBYZcnsPB02tkYVy3SD1wEKPVGgHJHefNr1Fa5mXOeghnzZvlaYuMi1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejo5BZcM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707479364; x=1739015364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHIrMU+ZX5RuinTIn+nTLh+yX3ofZbcBqkJFfJ3tlV0=;
  b=ejo5BZcMEKeKetkimvQaEdntNkNa/8hEzqIWFNNKVcbCDTAxhSy+gwy4
   0el8QaNrM+7CRKTDg01PqHexBcbsI6FYnbUw2C5PBeR6qyEir+p/eUhOE
   IJt7nOg5oALXmq+b7EuEYIfBhRZuv4Z6UFnS3LwdNOm9V6fAY36thFXfC
   FHOTbINFda+NgjnEoWyjuK1mZU0Q8toVq13xyJT4aFNfvh775tunO2vJJ
   FIubSnJC9+/lw7HOX3YeC+KcMFrQ8hlIEardJwohHvXBiuIleB26LOfkW
   OUo/13a1q0lxM5w99tGyKbrA3jV0iFV408ZuTtZGc5YKq6eILbo2o4UZx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1724690"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="1724690"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 03:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="32704905"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by orviesa002.jf.intel.com with ESMTP; 09 Feb 2024 03:49:21 -0800
From: rulinhuang <rulin.huang@intel.com>
To: urezki@gmail.com
Cc: akpm@linux-foundation.org,
	colin.king@intel.com,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lstoakes@gmail.com,
	rulin.huang@intel.com,
	tim.c.chen@intel.com,
	zhiguo.zhou@intel.com,
	wangyang.guo@intel.com,
	tianyou.li@intel.com
Subject: Re: [PATCH] mm/vmalloc: lock contention optimization under multi-threading
Date: Fri,  9 Feb 2024 06:51:47 -0500
Message-ID: <20240209115147.261510-1-rulin.huang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZcNMa-CFEDNWDO2J@pc636>
References: <ZcNMa-CFEDNWDO2J@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rezki, thanks so much for your review. Exactly, your suggestions 
could effectively enhance the maintainability and readability of this 
code change as well as the whole vmalloc implementation. To avoid the 
partial initialization issue, we are trying to refine this patch by 
separating insert_map_area(), the insertion of VA into the tree, from 
alloc_map_area(), so that setup_vmalloc_vm() could be invoked between 
them. However, our initial trial ran into a boot-time error, which we 
are still debugging, and it may take a little bit longer than expected 
as the coming week is the public holiday of Lunar New Year in China. 
We will share with you the latest version of patch once ready for your 
review.
In the performance test, we firstly build stress-ng by following the 
instructions from https://github.com/ColinIanKing/stress-ng, and then 
launch the stressor for pthread (--pthread) for 30 seconds (-t 30) via 
the below command:
/stress-ng -t 30 --metrics-brief --pthread  -1 --no-rand-seed
The aggregated count of spawned threads per second (Bogo ops/s) is 
taken as the score of this workload. We evaluated the performance 
impact of this patch on the Ice Lake server with 40, 80, 120 and 160
 online cores respectively. And as is shown in below figure, with 
 the expansion of online cores, this patch could relieve the 
 increasingly severe lock contention and achieve quite significant 
 performance improvement of around 5.5% at 160 cores.

vcpu number                     40                           80                           120                         160
patched/original               100.5%                  100.8%                  105.2%                  105.5%
 
Thanks again for your help and please let us know if more details 
are needed.

