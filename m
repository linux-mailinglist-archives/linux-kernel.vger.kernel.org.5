Return-Path: <linux-kernel+bounces-115508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63598889C04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E5F1C32BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6EA237B80;
	Mon, 25 Mar 2024 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr/+Vgqr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21501EC645;
	Sun, 24 Mar 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320950; cv=none; b=nInpGBgEn9jo6nJCBVy/PywLAVXmGBgTZhaqAVabBKq3XDX6zspUDBHtYG2g5R92SqCvFrk5nbcKAZakKhtUG7Zw1EnWLTMLlurR1Pz0GkYeOTjY3SQMKm3EZzrlwBjx93WEEpC0qmvo1YEJpnwXtL/IFnrqZMNNC1g1jBCuVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320950; c=relaxed/simple;
	bh=sdiZ1qUDoyOouFFJuBLt5ddv90gXD8wwmSNJapd092Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBlFiPFp5iuS//tqWL8hSbNCUdW9V9w2HXy5lxsY7M8UXdwMuLO/R2fAIV/XeGKpgSCUR7bAVrJ7vO9YXA60mEBI2hkAn5IQtj7IZUP395ITNL6A+m2T6bjCqA8D8QL9GEzXR4Z7BaXFn2ZLhkukR/Bpc7BcGSkDrQLtbw3SiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr/+Vgqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CDBC433F1;
	Sun, 24 Mar 2024 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320949;
	bh=sdiZ1qUDoyOouFFJuBLt5ddv90gXD8wwmSNJapd092Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lr/+VgqrE6NyKVnXd+Gs5IRVEG94K8jla2UQYRfNPa8GnUyLB5lVaJnZwtFux67gv
	 F4cLLu+YHXGet20mUvMRDk5/7XHMFIfYAnvTxRMC8gX1bZuuucdHITDwgocXObdd2t
	 IC18kRwMF5T9d7OZXBA7XIiBb2vf+fo4yuJhoBFa5vIS4KXTUlELlaQcnYjvbrVudY
	 hPd03y9Me5J0dyadD5QJCIm2H8hb25Yo+kDkEXVwPB+SAQr2XR2WsBNCfJL2F3IamO
	 0omegl4/MD/5iz7ol4WXScPOULiVJs8W9IKK/UVphGUTQg8Y1HeVKM2hZM6Wsxm5tQ
	 SwQZMJuhyhpRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ian Rogers <irogers@google.com>,
	kernel-janitors@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 513/713] perf pmu: Fix a potential memory leak in perf_pmu__lookup()
Date: Sun, 24 Mar 2024 18:43:59 -0400
Message-ID: <20240324224720.1345309-514-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ef5de1613d7d92bdc975e6beb34bb0fa94f34078 ]

The commit in Fixes has reordered some code, but missed an error handling
path.

'goto err' now, in order to avoid a memory leak in case of error.

Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: kernel-janitors@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/9538b2b634894c33168dfe9d848d4df31fd4d801.1693085544.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/pmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 33e783fc908fe..aaa013af52524 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1019,10 +1019,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	 * type value and format definitions. Load both right
 	 * now.
 	 */
-	if (pmu_format(pmu, dirfd, name)) {
-		free(pmu);
-		return NULL;
-	}
+	if (pmu_format(pmu, dirfd, name))
+		goto err;
+
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
-- 
2.43.0


