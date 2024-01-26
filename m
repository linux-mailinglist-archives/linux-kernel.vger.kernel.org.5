Return-Path: <linux-kernel+bounces-40273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B9D83DD6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924CE282649
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB811CF92;
	Fri, 26 Jan 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IkyvnIde"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AA51E873
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282735; cv=none; b=rHfJ5/p0Hd/rNk43YEeAqA1Skq7vHNaj2W+GCZ78JZoXuyA97nYSQShyrY3D9QAIdUgage1GtUFVMLt5KiBDC6SHDpp0kgYHjkfeM2q8w2JXYcRkp/JlC9VmHH1oVKNuzUHAB8WU+IvTlNL/GSqqwKOLM8qJm5KGlwjewnnSpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282735; c=relaxed/simple;
	bh=nRdDqIo0CuuDkPFpmOy7jAUoA1VsUwtHB9YZhdW7xbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FIClnCYtE2AFBosulzS72LwJKM4IDRni/NGxHV3jIuu1mm38z7gueFF+/a6OxSRYZ+DsFebxVZV9UkFv2VID6mLHZMKdp+tqw98qQ/5JhaVa68ySlKTjsRkyI4miyhgFnbgo7pHdcGjgUnTdeV6mWEA25ltfLpyFJMcPVi1ewyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IkyvnIde; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706282732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fxc6M49wsiZtuAiZJk8Hxt8gV/1ixSfY+RSkangwfeM=;
	b=IkyvnIdeEAXzyNoF0LqdZSDTbiTOQSu5etCNgZoKti/tjJbcin7DkJcC3ohdXGZT0Tnwyh
	/g1l+hlYRjpoHgsQS3F7EjYdzCdbyPl6t77EACOC7usJara6gjWSefTrR2k8x+WlfEOi3s
	WjM+WuvVeiatPmm6FNEI9O1LnuQ1/Ow=
From: Gang Li <gang.li@linux.dev>
To: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v5 5/7] hugetlb: have CONFIG_HUGETLBFS select CONFIG_PADATA
Date: Fri, 26 Jan 2024 23:24:09 +0800
Message-Id: <20240126152411.1238072-6-gang.li@linux.dev>
In-Reply-To: <20240126152411.1238072-1-gang.li@linux.dev>
References: <20240126152411.1238072-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow hugetlb use padata_do_multithreaded for parallel initialization.
Select CONFIG_PADATA in this case.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Tested-by: David Rientjes <rientjes@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 fs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index ea2f77446080e..3abc107ab2fbd 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -261,6 +261,7 @@ menuconfig HUGETLBFS
 	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
 	depends on (SYSFS || SYSCTL)
 	select MEMFD_CREATE
+	select PADATA
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read
-- 
2.20.1


