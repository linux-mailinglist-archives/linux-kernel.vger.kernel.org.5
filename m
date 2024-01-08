Return-Path: <linux-kernel+bounces-19491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D96826DB9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06441F222C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25060405C4;
	Mon,  8 Jan 2024 12:23:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353C405C5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T7tTj174cz1Q7sX;
	Mon,  8 Jan 2024 20:21:45 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id B9A401800C7;
	Mon,  8 Jan 2024 20:23:15 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 20:23:15 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<alexander.shishkin@linux.intel.com>, <mathieu.poirier@linaro.org>,
	<john.garry@huawei.com>, <linux-kernel@vger.kernel.org>
CC: <suzuki.poulose@arm.com>, <yangjihong1@huawei.com>,
	<wangkefeng.wang@huawei.com>, <yangyicong@huawei.com>
Subject: [PATCH v2] hwtracing: hisi_ptt: Move type check to the beginning of hisi_ptt_pmu_event_init()
Date: Mon, 8 Jan 2024 12:19:06 +0000
Message-ID: <20240108121906.3514820-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)

When perf_init_event() calls perf_try_init_event() to init pmu driver,
searches for the next pmu driver only when the return value is -ENOENT.
Therefore, hisi_ptt_pmu_event_init() needs to check the type at the
beginning of the function.
Otherwise, in the case of perf-task mode, perf_try_init_event() returns
-EOPNOTSUPP and skips subsequent pmu drivers, causes perf_init_event() to
fail.

Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---

Changes since v1:
 - Add fixes tag.

 drivers/hwtracing/ptt/hisi_ptt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index a991ecb7515a..24a1f7797aeb 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -995,6 +995,9 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
 	int ret;
 	u32 val;
 
+	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
+		return -ENOENT;
+
 	if (event->cpu < 0) {
 		dev_dbg(event->pmu->dev, "Per-task mode not supported\n");
 		return -EOPNOTSUPP;
@@ -1003,9 +1006,6 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
 	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
-	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
-		return -ENOENT;
-
 	ret = hisi_ptt_trace_valid_filter(hisi_ptt, event->attr.config);
 	if (ret < 0)
 		return ret;
-- 
2.34.1


