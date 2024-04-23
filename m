Return-Path: <linux-kernel+bounces-154406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37B8ADBB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E9BB222A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126D14AA0;
	Tue, 23 Apr 2024 01:53:43 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254018AEA;
	Tue, 23 Apr 2024 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713837223; cv=none; b=PT5Clw9ph0yowDvMhOg+DE00SFQV9T6RsMO+GlxbAnkiFQFqmKZ4MdlMx4tzs8Si7maRF1ecR7Y8u7F9Yuqad92ozJeFUtU9QsBnAHi09VLNqK3yMKKfNwnhxhECjG1o/egrieGY41xolR5waUyQNZlIrCxnbXSZax1R8PzvuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713837223; c=relaxed/simple;
	bh=rkhGnLZC+0HGmBOlbI66y/Bb6j9wHcPykoe8WzcWSgQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rgfQuS6CTagTBeghti2EYVeC3q6i57OcFtSe8/KdxpD3SMH/LT5NAfqraIbwVUfm96OTIrw7tC9zB+3XIfchPXwHThZvXwk09az2YsFGkVint7X2q0Fc0MULxLrdG6Xpl5px8+D6ySdBtY1JB+gGNICFejUWQduxNQe5PDOITwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VNlSW0FsGz1hwNY;
	Tue, 23 Apr 2024 09:50:35 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id D2BBC180060;
	Tue, 23 Apr 2024 09:53:37 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Apr 2024 09:53:36 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH v2 0/2] Always show mmap prot even though PROT_NONE
Date: Tue, 23 Apr 2024 09:53:28 +0800
Message-ID: <20240423015330.2206892-1-changbin.du@huawei.com>
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

v2:
  - Remove bugfix since the code is refactored in perf-tools-next.
  - Also apply to mmap, pkey_mprotect.

Changbin Du (2):
  perf trace beauty: Always show param if show_zero is set
  perf trace beauty: Always show mmap prot even though PROT_NONE

 tools/perf/builtin-trace.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.34.1


