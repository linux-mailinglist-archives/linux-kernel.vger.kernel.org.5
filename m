Return-Path: <linux-kernel+bounces-114427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F41AF889018
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94FFB3765A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1285214037D;
	Sun, 24 Mar 2024 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+BS5Fpi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87621C19C;
	Sun, 24 Mar 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321840; cv=none; b=SuuiTjtOOWV1Kz0eg/FhLOyUkzEKzjBj8nT5+tMJ11U0OgpFdUDJhZ4b21yC5o6ZJyfST5+0B4WkZi8Zsb0zow7gpsP4o1b2Dn9+AqljAke2FXGdg6pPiBLGhgZlMeWKwHPl8gjn+rhG3pms6ZVAPkTTd/smJhJqbGSEXV+Quc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321840; c=relaxed/simple;
	bh=9UOR8yfN7Io1/nGO1CWtAhcJh70F2yuivoI9uxE5Q4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDZnfaxbF4LeDq8CI3+uXKS7iSo6e43gZWjoF2PuiTP4PENeGGXSCLeiqzu5BWw+MhVwMXIhD5rgEhwdCkiH8gw125AkbKSbjURqcSbW9bNxdrNUp9mz+qyjh+iQC4XC3WFiI/5eKtj0LmJDJUSXCbC8yWKS4y+CUbP+QBU7DE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+BS5Fpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64939C43394;
	Sun, 24 Mar 2024 23:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321839;
	bh=9UOR8yfN7Io1/nGO1CWtAhcJh70F2yuivoI9uxE5Q4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+BS5FpiG3jsgJH1fRz4ABWCJ3KYXmw8NE7rnYCeHkl8We1ZDzryC/vDVLb14Q76M
	 M4xudgAn1OsjFau3fi2w6p06APvHcPuIjFsBuABIOgfqXM1Y00nSEwiGMIDXCm0I/e
	 sfKd9Kt14XVbhclMDoQjyL9hksF5oLKlqRaZGnr5OAt5nmaG3wSefKf8WjBq6WyNSq
	 L6uBIaQ/tqjWF1b8U0vreMH1uK+l5WW5wvgt1XLZrv2teFm4d7WZJLNFZ/7uWqJbmH
	 MlhrnH6JYfEKe7o5UHYlD2xt6p/rxZrmmeIXPOnszae3SsY3puymzFJ0GU7W1Kw7s9
	 yoXs8CMLtkl9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 568/638] hwtracing: hisi_ptt: Move type check to the beginning of hisi_ptt_pmu_event_init()
Date: Sun, 24 Mar 2024 19:00:05 -0400
Message-ID: <20240324230116.1348576-569-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index a991ecb7515a3..24a1f7797aeb6 100644
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
2.43.0


