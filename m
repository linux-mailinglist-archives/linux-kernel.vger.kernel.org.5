Return-Path: <linux-kernel+bounces-161236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFBE8B494F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069F928264F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16B3C38;
	Sun, 28 Apr 2024 03:10:23 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6815A4;
	Sun, 28 Apr 2024 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714273823; cv=none; b=H1Pr3M2GSiJHmaK6BtFfOMBqiAAvyEsY9pnUTO0MQvjUYvljDmb+AIFFC/M/hdV24uFPvyRw7mYLqvETOr88PYWSdyNosbP/iaUJcJcyPalMQuuws6b6uT4y/py3q7ZbrU/iUbZTDnYYz8LCxpJ+K/Jb2RowiqeSTre8dJlc6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714273823; c=relaxed/simple;
	bh=1kXjQv1zzXklHU3QdpFzHUuhb9Ork7YSOhMFwJA2S4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aBLJGeIqamoiT0sC9ZXFQbbmKM/1NWaJfpcLIWDf1bmAJEc8pRX31b7bLLk3bSWYwI9sfLWXv0FcMBC/TQf+DZ6S/0f4kZqfn6m/ID0zpKIh2DG5VlV9TgHzcttRkC8jsyVslr1J6Z2QU6l9UAwgRZpK4n9Eedq3ZQ9XQsO4Dcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VRrwb05xkzvPqy;
	Sun, 28 Apr 2024 11:07:11 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 8143A1403D1;
	Sun, 28 Apr 2024 11:10:17 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 28 Apr 2024 11:10:16 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH v3 0/2] Always show mmap prot even though PROT_NONE
Date: Sun, 28 Apr 2024 11:10:06 +0800
Message-ID: <20240428031008.1535765-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100011.china.huawei.com (7.221.188.204)

Before: PROT_NONE is not shown.
$ sudo perf trace -e syscalls:sys_enter_mmap --filter prot==0  -- ls
     0.000 ls/2979231 syscalls:sys_enter_mmap(len: 4220888, flags: PRIVATE|ANONYMOUS)

After: PROT_NONE is displayed.
$ sudo perf trace -e syscalls:sys_enter_mmap --filter prot==0  -- ls
     0.000 ls/2975708 syscalls:sys_enter_mmap(len: 4220888, prot: NONE, flags: PRIVATE|ANONYMOUS)

Changbin Du (2):
  perf trace beauty: Always show param if show_zero is set
  perf trace beauty: Always show mmap prot even though PROT_NONE

 tools/perf/builtin-trace.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

-- 
2.34.1


