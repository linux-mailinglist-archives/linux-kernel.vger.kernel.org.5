Return-Path: <linux-kernel+bounces-63403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC305852EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2661128333D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A34436AF3;
	Tue, 13 Feb 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZSClFad"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5932C8B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822844; cv=none; b=B2Edk9B87u2KIkcEamIfFjouPTBvThDNJrMxqTWWUsoRupUivZnQpCgZbU6Uc27cgIiJmCPmsR5K6ZEQzA9Gg0XWtjhpZ2c3Bgw9KluWSdH5CWeKulmFVjQptcBTzbG4UOZHEjyCjW9KZj9er9qeo7Q5oxoBUoaEnXAU4LBFeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822844; c=relaxed/simple;
	bh=EG1EZw1Wj3VaqQqg8ln6Y174YJHRi0e6BlwHMvR9T8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VKW71BQivWn4mlF3PndNlW4uy+Od+zlTyLTlzyUAqNd+l23BGEtQv9isMP41sGYJSdnYgLuVJFUO2ciq3tt37X6Etmvgm0mM4TmIWaxBmL8OwztvMRmvGEjmwuU8GboAO6cF7PZxYj9OVnApv6Ct1mw+VsXa1Pwi/0jn8aiGMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZSClFad; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707822840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AI3Ra2sQ8veiZ8Eia6tE4Ic8YKKMR3VVEKXPe2BHlbQ=;
	b=sZSClFaduLax0DxszdkKqA/EFs81dCIDgkUqYn1K24eJu8/VWr7vSm6o41CzUBgqbT/7VH
	2cLtrJW0XRrUzZcljmuODvsBo8k4/tU5Q21eLSTljqCDp05juTrxe+mWKIm6GEy5ai8/V/
	nn1Wh3ipvTAlC85GbUu9eG/Ds0TvIJk=
From: Gang Li <gang.li@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Jane Chu <jane.chu@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Gang Li <gang.li@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Gang Li <ligang.bdlg@bytedance.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 0/2] hugetlb: two small improvements of hugetlb init parallelization
Date: Tue, 13 Feb 2024 19:13:45 +0800
Message-Id: <20240213111347.3189206-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series includes two improvements: fixing the PADATA Kconfig warning
and a potential bug in gather_bootmem_prealloc_parallel. Please refer to
the specific commit message for details.

For Andrew:
If you want me to include these two fixes into the previous series[1], I
would be happy to send v6. Otherwise, you can directly apply these two
patches.

[1]. https://lore.kernel.org/lkml/20240126152411.1238072-1-gang.li@linux.dev/

Gang Li (2):
  padata: downgrade padata_do_multithreaded to serial execution for
    non-SMP
  hugetlb: process multiple lists in gather_bootmem_prealloc_parallel

 fs/Kconfig             |  2 +-
 include/linux/padata.h | 13 +++++++++----
 mm/hugetlb.c           | 15 +++++++++++----
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.20.1


