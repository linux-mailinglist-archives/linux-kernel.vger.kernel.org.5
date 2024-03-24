Return-Path: <linux-kernel+bounces-113517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C216B8884F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40A41C243B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C381BD5C3;
	Sun, 24 Mar 2024 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6zueLXR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBA1BD055;
	Sun, 24 Mar 2024 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320318; cv=none; b=RUO52dGB+m6It3y+1SlSTBm/FMvZOJvGUPkpmUPS8TzStWQul/MIfq+pjqdrSX5cDWAayG/paeZN0Wefhn7zoqOWIkmxuQI1452pQujAgz6PK4EHKEY4GQD+/p0ydeskbGLCDiOzXmEkXrS/uWmThIiq1Of7kAv1Y6FCY+4+kHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320318; c=relaxed/simple;
	bh=hSWJsyMXKNufAowhEHMrAyisklCi8WXHFbnrQ4nf+go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPB7kJdL4qy4kmGcc8lXvUwgo0DIDiynBmSsX3g1+PsXyFA9BLAWpu81Xdvrl49rUM249zG8HjyvAmchplQGd09j15jLqaD45C1oRLGFXOKIZUcUEgW2PlnLIaFo84SEOIRbO7b/dEGKHTZn+E+I17p4heb3K4goRoLwZf2Igj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6zueLXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48437C43390;
	Sun, 24 Mar 2024 22:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320318;
	bh=hSWJsyMXKNufAowhEHMrAyisklCi8WXHFbnrQ4nf+go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6zueLXRMf5i4LIPwUtIAI7EnJ1nOTm0iAv0chYRrKMKpcBjIFzN+yLASs4Irusni
	 gfsfCPLQYIiLQ07khePiVhlj4AAeYOIHq2AjfDbm+YzpIfm29R0/4BmSQ8WvVCK18x
	 WdS1QzQqirORPjCBx2l4hk9+bmhd2kIvPZZb8SwrG3ZsARqsLwSXysquSJ90FyF+kQ
	 BpfIwmaSCJLPbrbJxkElDsFAU+TaBhcZftrgNj5MTRLDQI1sxR7uyJ3oQGoCCFaDBC
	 /uaexg1bdIW8csAmDvNerQls6gT4FGKrJ3GnfoRKPIJSy/fR1ft/GPFmfK+/kSuHhH
	 R+0VBP4m1PaoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 626/715] hwtracing: hisi_ptt: Move type check to the beginning of hisi_ptt_pmu_event_init()
Date: Sun, 24 Mar 2024 18:33:25 -0400
Message-ID: <20240324223455.1342824-627-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index c1b5fd2b89741..4bf04a9778407 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -998,6 +998,9 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
 	int ret;
 	u32 val;
 
+	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
+		return -ENOENT;
+
 	if (event->cpu < 0) {
 		dev_dbg(event->pmu->dev, "Per-task mode not supported\n");
 		return -EOPNOTSUPP;
@@ -1006,9 +1009,6 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
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


