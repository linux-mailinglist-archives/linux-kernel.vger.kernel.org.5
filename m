Return-Path: <linux-kernel+bounces-113957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8EC888EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E1D1F2788C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6A15575B;
	Sun, 24 Mar 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHjSjUg0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CC12CD8D;
	Sun, 24 Mar 2024 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321068; cv=none; b=IHFZ3JOzAbomXG/nl7AxIz7w8pxfuegtsmyySQCQd2XM8S1vFhOFghFAR/9QEiaNNPNv4srEsSBX0LsK1SDAPS7EWKA8YnhrGNGtBI4SF7yfwynnw+mnX7HaPnNOCbMw5nxZrhxOHPS2GylZEFJgg8iw6PNRJkljnR/ITpAJ1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321068; c=relaxed/simple;
	bh=9UOR8yfN7Io1/nGO1CWtAhcJh70F2yuivoI9uxE5Q4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvB6GIpZrbE5CZW8gu0EZ6lgp/ZyPb/Le52IGTyDkUUdUF7gv1wEV+bvefZHcmYNPFLIM0CyJwrlxgbfVFz9gUa5pAlgbzL+8mx6gEPQVZK38Aoszp/h/9pG4XdilUvlLvCE/equcc7j+cyHmxRgAlnn96rHVwqb5PXV6DP0ab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHjSjUg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9FEC43390;
	Sun, 24 Mar 2024 22:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321068;
	bh=9UOR8yfN7Io1/nGO1CWtAhcJh70F2yuivoI9uxE5Q4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHjSjUg0B7x7SHcvFUMQzTSiOITGoTrGMcWqinwHaWaUC+zycjielriNPks1h6XEK
	 MspamQnzwNpKHDXMtJ3uVeCTZWM+nAA90Ou81q7ooE9FCsr4kgCoQGEgt6cfaZ6KQ1
	 45uEsX/2DfB+Gkawy9Lzsh/JtUcNUg2EFR6u3b/1stcNFx14Wh9T7DKoWPB6vSTQNt
	 OWqZJEFXA9SqEoFwMhRHDW4GvbFePq/fqiPkNYvgKMwHPf5X4nkCJyZwa298j1WP2G
	 oUrRJncEDrV6WPlFfyIomtMfqjtw0GLyj0viJXrZ7p7dI1teDldUQDhsxObLvlQsru
	 yMnm4ECVyO1Mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 632/713] hwtracing: hisi_ptt: Move type check to the beginning of hisi_ptt_pmu_event_init()
Date: Sun, 24 Mar 2024 18:45:58 -0400
Message-ID: <20240324224720.1345309-633-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


