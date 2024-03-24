Return-Path: <linux-kernel+bounces-113316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DC688835A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86191C23761
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E504193FA4;
	Sun, 24 Mar 2024 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZb1zh2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171519388E;
	Sun, 24 Mar 2024 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320117; cv=none; b=I2dOsbECQjaLlf/2Azmywc3SiqECA0dLmfQzLwtbouPO+LNv+3xuGZOvIJEg/ytfnFPeN+Ai76tcAzC+Thj+Eo+jU5zIQmfiR+FnGIAXqMhO00FB4mCSQE2WjmeSx8QhHidMIGie/rJ/UhViqUOMnoqvN+vQs95jKYd45+c/UVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320117; c=relaxed/simple;
	bh=gAqGlDlzDquxOD2+ZQhfbxc9Xuv12uclhQjuVIseTAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2szdohxG1jE5zgp7PO9YFd9fIF7kDkqfP+fh+bADpncSs/tmfZQA/58oAgZgeXyNza1NZzwL555nG7skQoLZvyetBRelvappNM8IEDjJqROr5jpFfFHuPj6ST+HSOqtfvyGvP2EXOCJTUtM6dIvQRq2P2cyCwhy4Tw0ba8bYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZb1zh2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C28C433F1;
	Sun, 24 Mar 2024 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320117;
	bh=gAqGlDlzDquxOD2+ZQhfbxc9Xuv12uclhQjuVIseTAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZb1zh2RbJMJzfCcDjhw0Qs0qSBdvbHsavrDhWSwbDwg4TkA1YGOl94Hqac4Wm+ia
	 xc2eYmf/BCMU62/6sjpxkKU3BpCzNRZb74as9Uz2CkaVVlTk2X6FuJjUspce7eCrVt
	 htqojgpxWszpOeIw5/MEzHeWrr5bsWELEnUJhx/T4W+Se6tBu1rxbTurVN7lXjPKoz
	 Y8vB4ULTYQ7o4p3EtqYNXjbH42Ma/KTr8eggqvs5BIg9CYphlPilt3oD6HU0MR/ehh
	 XosFGDC+7y/TW+XtEMtKa6miWA+HNCuUSVjJPCvhG51W4xoR2yhrLGfKHE/3PjhHsn
	 nMtGBVK4sbJlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	James Clark <james.clark@arm.com>,
	Kaige Ye <ye@kaige.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 425/715] perf stat: Avoid metric-only segv
Date: Sun, 24 Mar 2024 18:30:04 -0400
Message-ID: <20240324223455.1342824-426-sashal@kernel.org>
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

From: Ian Rogers <irogers@google.com>

[ Upstream commit 2543947c77e0e224bda86b4e7220c2f6714da463 ]

Cycles is recognized as part of a hard coded metric in stat-shadow.c,
it may call print_metric_only with a NULL fmt string leading to a
segfault. Handle the NULL fmt explicitly.

Fixes: 088519f318be ("perf stat: Move the display functions to stat-display.c")
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: James Clark <james.clark@arm.com>
Cc: Kaige Ye <ye@kaige.org>
Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240209204947.3873294-4-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 8c61f8627ebc9..b7d00a538d703 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -560,7 +560,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	if (color)
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
-	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
 	fprintf(out, "%*s ", mlen, str);
 	os->first = false;
 }
-- 
2.43.0


