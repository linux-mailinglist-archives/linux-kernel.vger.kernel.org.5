Return-Path: <linux-kernel+bounces-154520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F9F8ADD12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCB8B22220
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC626208A7;
	Tue, 23 Apr 2024 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bBLq3m27"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C91B966
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849537; cv=none; b=ZXKy92O+FdNh7ynmz/1z0965outbwlB/ewMrjb1v4vFlAriyEHmWpRjsg/2bZMzEEwASzsClGgqhS9ua23EZ/zTvkbxIZa34Alkalh8tZxJc96KgQmsr7I+4Vxi3VyhOZtRrYyC/bhQAqrH3+RoekI5P88nsCV2ZGtPFsI/tImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849537; c=relaxed/simple;
	bh=6djTsqkTarzrhTV+cox9vcQYxKM+8sUQh6gW5TSFx9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bae1hQEG1fptfd2DEIfBWL2qZA7DKdJJoegmVM/VOO7lIInDza08hVB4DumspUD2BgYVELcsdVqmXxPIaCsOWZ55t+UOa2N7WiSPnwTyBgn8X2of0mk9dpiX7+3clQe9acLfZxm/iczDRR6bgvU3PT3qE/zzj7rbPe9kUOaxVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bBLq3m27; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713849532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u+Gs6LB363taYfjAOAQVCNufxH8UGDdaQui3/WUq4mQ=;
	b=bBLq3m27Tn/gftsxnQ+b/3UOGu62ExpEaLl5AhSr/FXbLt9NTj4ccNhUHecUwNpOh6XBQl
	n0H2Hl4cbxfmZ7MnrEY9xq9LIdVxqQUzUOpOVSCjtO78dntHP4vMKox+oIqGghAnd8OgbE
	bj27r8Gr7uZCwrCrhcxfB7T8O9c903A=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] memcg: reduce memory consumption by memcg stats
Date: Mon, 22 Apr 2024 22:18:22 -0700
Message-ID: <20240423051826.791934-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Most of the memory overhead of a memcg object is due to memcg stats
maintained by the kernel. Since stats updates happen in performance
critical codepaths, the stats are maintained per-cpu and numa specific
stats are maintained per-node * per-cpu. This drastically increase the
overhead on large machines i.e. large of CPUs and multiple numa nodes.
This patch series tries to reduce the overhead by at least not
allocating the memory for stats which are not memcg specific.

Shakeel Butt (4):
  mm: rearrange node_stat_item to put memcg stats at start
  memcg: reduce memory for the lruvec and memcg stats
  memcg: use proper type for mod_memcg_state
  memcg: restrict __mod_memcg_lruvec_state to memcg stats

 include/linux/memcontrol.h | 25 +++++++++++++------------
 include/linux/mmzone.h     | 29 +++++++++++++++++------------
 mm/memcontrol.c            | 12 +++++++-----
 mm/vmstat.c                | 24 ++++++++++++------------
 4 files changed, 49 insertions(+), 41 deletions(-)

-- 
2.43.0


