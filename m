Return-Path: <linux-kernel+bounces-72665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD57685B6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9217284E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D34060861;
	Tue, 20 Feb 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhTz2CCy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CED612E7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420190; cv=none; b=Ty03OZu5mPvMRu1Y4ngCj0lTb3h0dXkyzBG6M8qpTY5KqaPfwTIsQPK0FqH29Mdxb4B6Wvkhy4NK3XenMHyan3F9UZZV6oSHDtMsV4iPV07pvalswLkJZxgCCX0jOnwLFqJ7o3YNPq6miA24RC22ejNkm7cPmV4M3RfnqGcW7xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420190; c=relaxed/simple;
	bh=UZm4U+dAIR8HwmwBvV5EmxR9EJsRl0ZGSS0nEGfJIyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGyCnYsMC0g/mRt8sX1Qlkf2WQMvsvCeHxmcU842Wu8ttFBIDdw3rjd7jLkKJqJYbRIcwaKrj/TcvXWXfFs2qDw2PZ9QixWXzPmx61SvrCNxiPONUoBpzXuq7dQNS6Q8k5G/FbcENT6u+QRkTAwQojS7xcwqwcH9nzUAJ0Io6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhTz2CCy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708420189; x=1739956189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UZm4U+dAIR8HwmwBvV5EmxR9EJsRl0ZGSS0nEGfJIyk=;
  b=ZhTz2CCynYn1wcYFYPF3TK1WmdqsRrWdcS6YqFANHMehlLMT5Wfr3x+f
   35wjx0QyYx9fzxU7dEVYl1SrA9iWHpCVP5KAaORUSIDhVZQ1RCQiKsimF
   9NIZnuHi9h9RblB8ybdUQ/6pbCP6U/LnnTtpvddykOj119oT/LC/4zs7s
   zdrS1QTiOYWn9GihHRYc/3dEjPYIVhX6eNJFPOhEA/xed7JHKksoqn8nY
   efwGpt7d3bOf8uLsm1FaJUi4VQdxCQ13CbrL8HQCpo6pFpvzXleqbbMqu
   ZuR6XOZoDwnKxf6XkHNQmEbgj4hdwtjQsQJUzGRCU9pnlkpZRxzayTrjz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="24972222"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="24972222"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 01:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9334937"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2024 01:09:45 -0800
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
Date: Tue, 20 Feb 2024 04:12:40 -0500
Message-ID: <20240220091240.3316840-1-rulin.huang@intel.com>
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

Hi Rezki, we have submitted patch v2 to avoid the partial 
initialization issue of vm's members and separated insert_vmap_area() 
from alloc_vmap_area() so that setup_vmalloc_vm() has no need to 
require lock protection. We have also verified the improvement of 
6.3% at 160 vcpu on intel icelake platform with this patch.
Thank you for your patience.

