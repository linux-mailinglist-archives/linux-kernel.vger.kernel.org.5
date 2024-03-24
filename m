Return-Path: <linux-kernel+bounces-113376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCAF8883D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14A1B23499
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861119F525;
	Sun, 24 Mar 2024 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrNrPf+N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644E19F501;
	Sun, 24 Mar 2024 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320178; cv=none; b=qwo4I0+ftczx8lsjuE4G5og9MdkIMSYJDKtku9Dg1mbhuAi9dGZgeCAveyX4XpHkjtSmzGzp0kGlvHPBvDtsA0yE8jjBlu0VtRbEMOViNn9L1RBhcX5vcM+6fDAKK/+4/Rz665dbIXX0w38B7gNrsx1CXRPuNpEo/NuQjWgF8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320178; c=relaxed/simple;
	bh=4R1K5XCsgWuPw6D5zIv86PhgnTtk3Z9jomPfPWJlF9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S70vOJ1hQBk8iXze55/EoU7LLOVpyGpszywEy1WQxsMVhctpRx7NGX/6xfpMJm8MOITdv3NOiCsIaAO3Um4MRxOTlDGhxLPkdryC9d8O0fdDHPFKfA+c5g+Y6RX6KAntCoi0+qtycIQbv0MQcLI07Y8M3Uj2JRnJPKVm5sOgiRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrNrPf+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A038AC43394;
	Sun, 24 Mar 2024 22:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320177;
	bh=4R1K5XCsgWuPw6D5zIv86PhgnTtk3Z9jomPfPWJlF9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GrNrPf+Nvh54K+Eu6Z/Rz5tP4Br3AfUZwNGUhHD/f9UIZHCh0l29TaIvE9/2zPhcy
	 PTG5VbQeTnlrHY24g1J1b8siFyf5DCZBMnStcyygIF2GvgoN4kZJrSOFyEmG0Z2eFD
	 O6H4HxiikJL+7RZdBEKQpRTaPsxrwn26Uw7MG/OrgW60sG/18IrL1VAzGAPhucbGoe
	 wHBfNvD9WiBZ/b1kSa35G90LTCiqrdHez0ZgjmOLCiazVl+2r01Vqt1JSxWjkk+rqh
	 XD6EkQrE9lk9G/8J+PzJISCorukqutU8pEzcZ2KaIkJqytyJDKPqfBWNn4ssWRixGU
	 f9GB9/MlSJcwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ian Rogers <irogers@google.com>,
	kernel-janitors@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 485/715] perf pmu: Fix a potential memory leak in perf_pmu__lookup()
Date: Sun, 24 Mar 2024 18:31:04 -0400
Message-ID: <20240324223455.1342824-486-sashal@kernel.org>
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
index 88b9aa7d3a27a..6b82f4759ce69 100644
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


