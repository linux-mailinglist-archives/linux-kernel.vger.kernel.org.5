Return-Path: <linux-kernel+bounces-124214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD618913F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1231F21C78
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD413D569;
	Fri, 29 Mar 2024 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tbsA3jXd"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617733BBCF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695422; cv=none; b=lTXKYHNpNWWpnxrRl9kBuihDZPVykF/Is1TWMyaUjJv43/FltKZjKnztOdXk11q3onJlZUQwe/Cqgvx+F3LCM9tHAPa6Csk/MMepWoB6sKs5vUC90mKe9qT133riNEwqkKKTG8Myhe30kUFnPLY0Krvfrn3ccwKNreK7PjD/zRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695422; c=relaxed/simple;
	bh=BLcMQrxEbNur36OLU1AVP6ksszGpbaplWVqmlw869aA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pi7SOqHpsOM61c3a8f9zzOT0xSNJJOwqAyfNvcYhMJp6lJGcQx+Be5ncs9gCKubDxVxO6DJp3eR47G5yD1XRnlcolZuw3soTH6DoFyKQ35Pa8lgoWwty4/zNeSuuVLtHuFUv+UEHLITmpKVotMIYKPzb5RCVJpe9Wy/MFQqmilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tbsA3jXd; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711695418; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9DmfgnTwR2hgwzNr3ipH242u8MwneYBDqvFX9IPBCmI=;
	b=tbsA3jXdXlkCnpbz2lqPMWE7/4dGPPGPRe8cJW7VKtHqbDJitSE94AbGHfEDoqPlH3yIKYRD5F/dkZId+N/csUU1WMiW2GgTJLQAtQfUrK5UoYzYukGLeaV0z5zV3Zg+E4ks3uxGC2TL//R0rtavS71ai4VRinmHwFN36FQVIL0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3Vfrzp_1711695416;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3Vfrzp_1711695416)
          by smtp.aliyun-inc.com;
          Fri, 29 Mar 2024 14:56:57 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	mgorman@techsingularity.net,
	wangkefeng.wang@huawei.com,
	jhubbard@nvidia.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] support multi-size THP numa balancing
Date: Fri, 29 Mar 2024 14:56:44 +0800
Message-Id: <cover.1711683069.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset tries to support mTHP numa balancing, as a simple solution
to start, the NUMA balancing algorithm for mTHP will follow the THP strategy
as the basic support. Please find details in each patch.

Changes from v1:
 - Fix the issue where the end address might exceed the range of the
folio size, suggested by Huang, Ying.
 - Simplify the folio validation.
 - Add pte_modify() before checking pte writable.
 - Update the performance data.

Changes from RFC v2:
 - Follow the THP algorithm per Huang, Ying.

Changes from RFC v1:
 - Add some preformance data per Huang, Ying.
 - Allow mTHP scanning per David Hildenbrand.
 - Avoid sharing mapping for numa balancing to avoid false sharing.
 - Add more commit message.

Baolin Wang (2):
  mm: factor out the numa mapping rebuilding into a new helper
  mm: support multi-size THP numa balancing

 mm/memory.c   | 77 +++++++++++++++++++++++++++++++++++++++++----------
 mm/mprotect.c |  3 +-
 2 files changed, 65 insertions(+), 15 deletions(-)

-- 
2.39.3


