Return-Path: <linux-kernel+bounces-29732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BAE8312A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C7F1C221EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEB28F7D;
	Thu, 18 Jan 2024 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q2SumlNy"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6BB79E4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558754; cv=none; b=BtLVVp1UEZaj4sYXxhkp+gmL1cgmM7C+PwO/aj5/JPp6YqJ/lKqyqw7koi19lPqrgXYuvGOh79bTRkHwJSaP3+IjVZ0Z+HJziJEHAbB5PPzuFQgjsC7d95wdE7L0BccC3VsAL3j1gQeH2BakyUfTVrMe86bSfjGwnh0uQI8xKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558754; c=relaxed/simple;
	bh=OzKnacBlOGRsazVvabreopds5Qg+gZxPBfXopYaD548=;
	h=X-Report-Abuse:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:X-Migadu-Flow; b=DOVCt1pGVpmkNzDeki2cBgr5hI5BkT/pIrIh9aRn6+zrTwNQK+UIE26Xho3PwDDoE6K+5vpeQmO95Hh6ZbadKiU2MtFOefiUQGWYJYD7ul1Iy8B+zpOEFS2umENONd+rpBlu7XQKVnrx3eIKl9Re4ykaRCOiJJpPRGFwoUoArjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q2SumlNy; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705558750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sH3eJ1PeLEzp5iMX2ShmJd90S2HOzxuMkVgsHD8St1Y=;
	b=q2SumlNy5FfAKZtKClDn1OZKQxeQKmH5Ko8ONI9YBImUJweeTR0HEQzbzogjPn7TpyvV+/
	8ZS/gh2bUD/06yC8yrpxg0VMAs5WzeXGxNeSj0pCv/MQE6LWrhKsYgZJV2Dywlsff9GjUN
	lZXP7e+Ow4a2bjv8x9ynsVWigz+rWj8=
From: Yajun Deng <yajun.deng@linux.dev>
To: rppt@kernel.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] memblock: fix crash when reserved memory is not added to memory
Date: Thu, 18 Jan 2024 14:18:53 +0800
Message-Id: <20240118061853.2652295-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

After commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()"),
we set nid on all reserved pages based on memory region, but some reserved
memory may not be added to memory on certain architectures. The nid is
invalid.

Add the nid check, make sure the nid is valid by early_pfn_to_nid().

Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/memblock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index abd92869874d..4dcb2ee35eca 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2176,6 +2176,9 @@ static void __init memmap_init_reserved_pages(void)
 			start = region->base;
 			end = start + region->size;
 
+			if (nid == NUMA_NO_NODE || nid >= MAX_NUMNODES)
+				nid = early_pfn_to_nid(PFN_DOWN(start));
+
 			reserve_bootmem_region(start, end, nid);
 		}
 	}
-- 
2.25.1


