Return-Path: <linux-kernel+bounces-54503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F9B84B00F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6301B1F26539
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55212C7E4;
	Tue,  6 Feb 2024 08:37:32 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051A12BEB7;
	Tue,  6 Feb 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208652; cv=none; b=UvlrWof64JJvIqcb0eB7p0y91fSfAkgBMiYGMxsz7xymCuwBDUMJ5rJIyw6arGpucBWxNbG1IX1q4iLlIcA6kioy/3PrSIPLFkujwhKkXQM+3oAo7O3ya+aNPaVnpnDs9t3BbVwWUW16K3U/fcM+T/kR/yN8Wc2cW+2WPQ+SW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208652; c=relaxed/simple;
	bh=/xpATSrVpRUAb/2rTYqzEK+C8mbseixibxzL286QETI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcyvtcHoM+yKFvqNNJ61zlA46iGlJGh4ju3bUXtTSH8a2XgnZNKFZg+3o0AKTl2CixMwR6kg+HR1/V9BReskV/558Qw2+PS9Jue/opcDUOm7/Hd8tkRTP8iaVZOqVkNc1tOs5vSY/Osc1HcSIol3Znt8yeQv1RXbbD5adbEqVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TTc703Mnqz1vtCj;
	Tue,  6 Feb 2024 16:37:00 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 200C6140390;
	Tue,  6 Feb 2024 16:37:28 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 16:37:27 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH v2 5/5] perf thread_map: Free strlist on normal path in thread_map__new_by_tid_str()
Date: Tue, 6 Feb 2024 08:32:28 +0000
Message-ID: <20240206083228.172607-6-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206083228.172607-1-yangjihong1@huawei.com>
References: <20240206083228.172607-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)

slist needs to be freed in both error path and normal path in
thread_map__new_by_tid_str().

Fixes: b52956c961be3a04 ("perf tools: Allow multiple threads or processes in record, stat, top")
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/thread_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index e848579e61a8..ea3b431b9783 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -280,13 +280,13 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 		threads->nr = ntasks;
 	}
 out:
+	strlist__delete(slist);
 	if (threads)
 		refcount_set(&threads->refcnt, 1);
 	return threads;
 
 out_free_threads:
 	zfree(&threads);
-	strlist__delete(slist);
 	goto out;
 }
 
-- 
2.34.1


