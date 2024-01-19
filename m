Return-Path: <linux-kernel+bounces-30756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB3B8323FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEA42864EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E71469E;
	Fri, 19 Jan 2024 04:07:37 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516C9186F;
	Fri, 19 Jan 2024 04:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705637257; cv=none; b=reJQrAaKXpQ+vpKNIgvGUxweQz0kn8tT5x2EOGOU+BHnEwK7L/yzq8dz0voYBQo4sG7ZCozS6nQ/xlZ5gcy6/+GksHipkBxhosCYY0F5ljVjbY+L3jKzGODzkxBRs0rK9lf3vk9YtiKrwjUURHVw8xWGx+E+JhgVjtOx4rAVn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705637257; c=relaxed/simple;
	bh=M4gbtCrIsHu5bBKP/offlfUWfKenppOsqw7RpHvE8zI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCnXyNt3xXBvsoW4jfC3qriaOPt+EgJ+CwHqgJH7D0ggkhJF7Jiz1oI7uncwxIuoGOn6yFTUcVIPfozxZp1Dd4gvI90IjZeCAJzKOBYiAZQKO1sTYZRxwNtZ4YoTGFZpJjbMtS+0qyjNCuyGjWZ6R980wM/pDom8U0rAdiLsWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TGQyk1393zvPsW;
	Fri, 19 Jan 2024 12:06:06 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id A85181402DE;
	Fri, 19 Jan 2024 12:07:32 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 12:07:31 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH 1/3] perf record: Fix possible incorrect free in record__switch_output()
Date: Fri, 19 Jan 2024 04:03:02 +0000
Message-ID: <20240119040304.3708522-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119040304.3708522-1-yangjihong1@huawei.com>
References: <20240119040304.3708522-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)

perf_data__switch() may not assign a legal value to 'new_filename'.
In this case, 'new_filename' uses the on-stack value, which may cause a
incorrect free and unexpected result.

Fixes: 03724b2e9c45 ("perf record: Allow to limit number of reported perf.data files")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 91e6828c38cc..fb8d4067b76c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1830,8 +1830,8 @@ static int
 record__switch_output(struct record *rec, bool at_exit)
 {
 	struct perf_data *data = &rec->data;
+	char *new_filename = NULL;
 	int fd, err;
-	char *new_filename;
 
 	/* Same Size:      "2015122520103046"*/
 	char timestamp[] = "InvalidTimestamp";
-- 
2.34.1


