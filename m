Return-Path: <linux-kernel+bounces-118922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90FA88C142
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6761F62FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454D6CDD4;
	Tue, 26 Mar 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s0uX46cY"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE66A8DE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453902; cv=none; b=Bk3GCryCUZ5ed0uAROStvcJWKlpZospilFjchr1m3cJ2LB4IDlscVEls3z1mTpfCmHkiAVC2/MQaxiq8vTMit+3YLf0fuEpiSR8QejriXj1OU1hzJZvfJIz0G+A3djtnJrA6O4R+PDLLsD5Evv1FptJ4IULzHWGZeQD/41dFpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453902; c=relaxed/simple;
	bh=GM4PjaPLQ4/chj22HDtR5747T0MkKWb5cNlXQTCTRus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YIzKxd6Zvm8mbYdy7sBfME5l5uDz2jL1tIKF56OlKQrDQAZpFLZpQmSZ75Po/gG7iH6WL3uJNBbiUeWHmgBgi93n+7ItEcpXxfUGtAmWO5dIuLcebvENbsvjkyibyyTbImuhR7iF7+vgx4geqLno+WBBid5+JKP8uZFLQ8Nom6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s0uX46cY; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711453897; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NLM4CSFT3zJVwZgW7/wcQv49Benv25o3YSuk8C8j4y0=;
	b=s0uX46cY4ls0d2VjyYuIltNCp0QkL1JwfEBBkRWwzeikuv2oJBMvqlb+Mfsa+NiF4JkRvanbkejrt25pxL2MLYrB8YZdduF1tS4jsmwj1xp1DY/T0Pm0YNLyK0HROyqV9DKvhKXfR7FMuHY5Jv159tjb70in69+w1781DDiT6uM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3LKqy3_1711453894;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3LKqy3_1711453894)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 19:51:35 +0800
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
Subject: [PATCH 0/2] support multi-size THP numa balancing
Date: Tue, 26 Mar 2024 19:51:23 +0800
Message-Id: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
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

 mm/memory.c   | 76 +++++++++++++++++++++++++++++++++++++++++----------
 mm/mprotect.c |  3 +-
 2 files changed, 64 insertions(+), 15 deletions(-)

-- 
2.39.3


