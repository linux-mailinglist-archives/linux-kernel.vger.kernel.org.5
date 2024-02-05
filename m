Return-Path: <linux-kernel+bounces-52435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E248849819
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13801C22132
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045D17731;
	Mon,  5 Feb 2024 10:51:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249F17592;
	Mon,  5 Feb 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130279; cv=none; b=GZK/gnUDzufdSHaeVkw94t3lxcC1kUVcX2M8tg9vm6sbxSsEl4OhEAwCjOKYwfArLroJBcc/Zin8wHUGjKWBNyXduZWmWDg4d1u5vLwqZ3Yzhq+yfHXwD84IHC/bohMXPeF0q+4R/CFdgLfS11xU8M4KgGJ/WRITHvVjW1ASO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130279; c=relaxed/simple;
	bh=DoB2mUJR1wZPUsVzLJzgRS7J/E0RabBNUzGJ8kWAyao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkvoByI9BSS3UvcPZS6sCZLneFb59kMA/dc8iTip0dl0A+L7m9KCHA+e3Poni7jbCSsG28vmIsYzSOaTQU3sJIRoYtaFau7vUPcMHQj/XOUf8dH2mNqLKsKNWUinnbvXd2C6H69JSuFbg7qZSfig7NWOgW75QAmzpPp0iUst/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TT3673tzZz1gy2M;
	Mon,  5 Feb 2024 18:49:19 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 315371A0178;
	Mon,  5 Feb 2024 18:51:14 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 18:51:13 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH 3/5] perf sched: Move curr_thread initialization to perf_sched__map()
Date: Mon, 5 Feb 2024 10:46:14 +0000
Message-ID: <20240205104616.132417-4-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205104616.132417-1-yangjihong1@huawei.com>
References: <20240205104616.132417-1-yangjihong1@huawei.com>
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

The curr_thread is used only for the 'perf sched map'. Put initialization
in perf_sched__map() to reduce unnecessary actions in other commands.

Simple functional testing:

  # perf sched record perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.197 [sec]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 15.526 MB perf.data (140095 samples) ]

  # perf sched map
    *A0                                                               451264.532445 secs A0 => migration/0:15
    *.                                                                451264.532468 secs .  => swapper:0
     .  *B0                                                           451264.532537 secs B0 => migration/1:21
     .  *.                                                            451264.532560 secs
     .   .  *C0                                                       451264.532644 secs C0 => migration/2:27
     .   .  *.                                                        451264.532668 secs
     .   .   .  *D0                                                   451264.532753 secs D0 => migration/3:33
     .   .   .  *.                                                    451264.532778 secs
     .   .   .   .  *E0                                               451264.532861 secs E0 => migration/4:39
     .   .   .   .  *.                                                451264.532886 secs
     .   .   .   .   .  *F0                                           451264.532973 secs F0 => migration/5:45
  <SNIP>
     A7  A7  A7  A7  A7 *A7  .   .   .   .   .   .   .   .   .   .    451264.790785 secs
     A7  A7  A7  A7  A7  A7 *A7  .   .   .   .   .   .   .   .   .    451264.790858 secs
     A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .   .   .   .   .   .    451264.790934 secs
     A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .   .   .   .   .    451264.791004 secs
     A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .   .   .   .    451264.791075 secs
     A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .   .   .    451264.791143 secs
     A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .   .    451264.791232 secs
     A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .    451264.791336 secs
     A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .    451264.791407 secs
     A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .    451264.791484 secs
     A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7   451264.791553 secs
  # echo $?
  0

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-sched.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 26dbfa4aab61..54d79e560617 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3266,9 +3266,13 @@ static int perf_sched__map(struct perf_sched *sched)
 {
 	int rc = -1;
 
-	if (setup_map_cpus(sched))
+	sched->curr_thread = calloc(MAX_CPUS, sizeof(*(sched->curr_thread)));
+	if (!sched->curr_thread)
 		return rc;
 
+	if (setup_map_cpus(sched))
+		goto out_free_curr_thread;
+
 	if (setup_color_pids(sched))
 		goto out_free_map_cpus;
 
@@ -3291,6 +3295,9 @@ static int perf_sched__map(struct perf_sched *sched)
 out_free_map_cpus:
 	free(sched->map.comp_cpus);
 	perf_cpu_map__put(sched->map.cpus);
+
+out_free_curr_thread:
+	free(sched->curr_thread);
 	return rc;
 }
 
@@ -3576,11 +3583,6 @@ int cmd_sched(int argc, const char **argv)
 	unsigned int i;
 	int ret = 0;
 
-	sched.curr_thread = calloc(MAX_CPUS, sizeof(*sched.curr_thread));
-	if (!sched.curr_thread) {
-		ret = -ENOMEM;
-		goto out;
-	}
 	sched.cpu_last_switched = calloc(MAX_CPUS, sizeof(*sched.cpu_last_switched));
 	if (!sched.cpu_last_switched) {
 		ret = -ENOMEM;
@@ -3662,7 +3664,6 @@ int cmd_sched(int argc, const char **argv)
 out:
 	free(sched.curr_pid);
 	free(sched.cpu_last_switched);
-	free(sched.curr_thread);
 
 	return ret;
 }
-- 
2.34.1


