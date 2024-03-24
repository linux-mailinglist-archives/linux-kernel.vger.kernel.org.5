Return-Path: <linux-kernel+bounces-114673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDF18890A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BB71F21F65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412A667A1A;
	Sun, 24 Mar 2024 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAMzxlEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B615ECE6;
	Sun, 24 Mar 2024 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322311; cv=none; b=HAAHU9DcvGc9G8k+l2ISE1fNpSh/ns/TTLupfCJ1R4txes2eNwwFghV1bS9n4YW7M0pGMSMsZ7mo3Oflubigh/C4asuDQe4P2dRnUVXNsapYJU7tLjovYKbvxs3jYm+xwub8BGHpfo7MrnLqwsmktIBOByEO7enhi1WcIYK0AwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322311; c=relaxed/simple;
	bh=0kQe5i0v4EzY2JFCyYouDdAzyy+xhdCnAy0nMcN5xf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewWlrli8xvDNAqTQZk0dJAZseMw01csb8z6hOjuwh9+Fni1jvRlAXQoTcB01NZWZDDHhbfVsvhj6+n3Sd84kw7PlRElX9Po+m6O3M5em+Ba49IYg9OzrGiRCyxT1Fys951BG00h+7ooWLih0uOLxwe0of8ngtdw5kiZkishMkdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAMzxlEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C1CC43390;
	Sun, 24 Mar 2024 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322311;
	bh=0kQe5i0v4EzY2JFCyYouDdAzyy+xhdCnAy0nMcN5xf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAMzxlEdALUTVcmAmki4u9tMAjvaJvl2DDfvxGHEZsXweKhZCnpjivwRJuE6vNre4
	 SjYs8Buk7wYGjXOasGV/6iTM6v3SiNRVN2iXuWawhStktWYcxGRqmmn+NQthios7kL
	 B96n7m0pU57KXk28W4cqCcgnnzm1Ys1PkcfQzBC8Oq0BX46FbeZ6ExbuHiUPRSisyE
	 qUaltFT90frWAJOyhYlM662ceyZfoJgBwvJZZI4XoMEMnrzMgOlLAWPL9GH8Kxbwnj
	 DVikY5tYh/JSoRIdFz+tnu5QYj4+yr6gCYOzVVb0z8PCfnARxZIa6N8GjcEIps5ZBA
	 BAAj77AE69JWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 395/451] hwtracing: hisi_ptt: Move type check to the beginning of hisi_ptt_pmu_event_init()
Date: Sun, 24 Mar 2024 19:11:11 -0400
Message-ID: <20240324231207.1351418-396-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yang Jihong <yangjihong1@huawei.com>

[ Upstream commit 06226d120a28f146abd3637799958a4dc4dbb7a1 ]

When perf_init_event() calls perf_try_init_event() to init pmu driver,
searches for the next pmu driver only when the return value is -ENOENT.
Therefore, hisi_ptt_pmu_event_init() needs to check the type at the
beginning of the function.
Otherwise, in the case of perf-task mode, perf_try_init_event() returns
-EOPNOTSUPP and skips subsequent pmu drivers, causes perf_init_event() to
fail.

Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20240108121906.3514820-1-yangjihong1@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 8d8fa8e8afe04..20a9cddb3723a 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -654,6 +654,9 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
 	int ret;
 	u32 val;
 
+	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
+		return -ENOENT;
+
 	if (event->cpu < 0) {
 		dev_dbg(event->pmu->dev, "Per-task mode not supported\n");
 		return -EOPNOTSUPP;
@@ -662,9 +665,6 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
 	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
-	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
-		return -ENOENT;
-
 	ret = hisi_ptt_trace_valid_filter(hisi_ptt, event->attr.config);
 	if (ret < 0)
 		return ret;
-- 
2.43.0


