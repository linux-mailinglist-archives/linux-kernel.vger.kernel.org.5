Return-Path: <linux-kernel+bounces-150172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48B8A9B46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F221F237EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5963161320;
	Thu, 18 Apr 2024 13:29:04 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C415E7E7;
	Thu, 18 Apr 2024 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446944; cv=none; b=CM40NzNGYddXkMYFZqAYfxdoq8lXKIA51gKaWvPilK7qrM7NIaPL8iUEBb5Qk9Ky5McMRkLBENkXi7TnWSdIRJUUXocZbDxbTJXndoyfMkGvVPixilq1PZdM+DbXbuPqu7TPuEdE9hxJWkC4X3ffpKpfdOu4ZEdRl5x3vBYraH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446944; c=relaxed/simple;
	bh=iUs7xG/uhW8TwkrUkPjyIZ+3/nnBo0K9yhCUdi4c6Z0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D51XpXR0M9tfrvtUvtrAN9fURVM9OhdJCEaiMfhgeKB450Y9/7ol8yldBDDCDRwvWq3tOTPQD1SGeFQDelAoMH/ROXGzOwbFllKIHB5+cBXV9oxbK/qgZCEkL2oAIAE3SdYsHrfn7CHQ7rDmT4GRd1cOgRIcIggr7ZK48tDFhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VKymf0J94zXlvR;
	Thu, 18 Apr 2024 21:09:54 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B108140390;
	Thu, 18 Apr 2024 21:13:14 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 21:13:13 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH 0/4] perf trace beauty: A fix and some improvements for newfstatat,mprotect
Date: Thu, 18 Apr 2024 21:13:00 +0800
Message-ID: <20240418131304.3188385-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

Changbin Du (4):
  perf trace beauty: Fix statx flags printing
  perf trace beauty: Beautify newfstatat flags
  perf trace beauty: Always show param if show_zero is set
  perf trace beauty: Always show mprotect prot even though PROT_NONE

 tools/perf/builtin-trace.c      | 15 ++++++++-------
 tools/perf/trace/beauty/statx.c |  3 ++-
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.34.1


