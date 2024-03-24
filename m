Return-Path: <linux-kernel+bounces-114187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39BE8888FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6BE1C22B48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB17324BBFE;
	Sun, 24 Mar 2024 23:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxOnJ491"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7730206C8C;
	Sun, 24 Mar 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321509; cv=none; b=EqMB/WMJN7o0lxYC7W+nCGx1DHPe680hEjB0ervvwlUHmvx74WaiiIh2DM5AICa9p8+n8tVjH/37s2qdkkk1Drs4P5EWqM3sVTl1B+9txjvhMAY0cfkdKd9dQcZ3LuLhC8HTBKuFRRSfkZe1fYiNlFoalbpRBTFNlYXHC9x71RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321509; c=relaxed/simple;
	bh=OC6s1nGnzvG27cdhEV9v+152Ge649GD6EUnGf7Ba9Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mb9IZCEdctYrqngGf+pJmeFEZkjlCvlgmTP7Bw/UZHt86uaPRqpE+7KzBCHWXh0tve/AiToUhQNEXb5hpMcDU/WLgEzuyJlflbNPa+0d8Y9XJxPGK49X5R1FB3bZEN/ZPgfVcoufPBq8Ua+roRdfKsRaGMNbBsYyUOT1240OAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxOnJ491; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6172C433F1;
	Sun, 24 Mar 2024 23:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321508;
	bh=OC6s1nGnzvG27cdhEV9v+152Ge649GD6EUnGf7Ba9Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxOnJ491VcerR1igwDtxVrHetg7tPB6uofzlfJRAPvs4XZjgqpjFKZlfUxcWf3hMM
	 0hyfzGRy/kzAyWk3Sa2RGTj+8Q6RGuvBcUjY3dpcoH6Oby8pD/PQ6mE3XVC2h5k6pR
	 PL5tpbQhM0iK0T52v+PpIK+q5O9ruWz2d6H4cGvhjS41NjFW/rEVN8/L4s1x4copE2
	 h9c5qzPrsI8T86m9VpKCRR+Y5h+eJbRgV6lQR2aD2kk/2ymfbYkXZAMA4aq97/umXj
	 vW8MUBH/lwtP9o4iPafEP8UNaQ1wk4/oDdb0J95mBRpqQ2YFof8dcpL2GasUbNi0iE
	 yJyu9D3BUoPQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 234/638] powercap: dtpm_cpu: Fix error check against freq_qos_add_request()
Date: Sun, 24 Mar 2024 18:54:31 -0400
Message-ID: <20240324230116.1348576-235-sashal@kernel.org>
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

From: Daniel Lezcano <daniel.lezcano@linaro.org>

[ Upstream commit b50155cb0d609437236c88201206267835c6f965 ]

The caller of the function freq_qos_add_request() checks again a non
zero value but freq_qos_add_request() can return '1' if the request
already exists. Therefore, the setup function fails while the QoS
request actually did not failed.

Fix that by changing the check against a negative value like all the
other callers of the function.

Fixes: 0e8f68d7f0485 ("Add CPU energy model based support")
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/dtpm_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 9193c3b8edebe..ae7ee611978ba 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -219,7 +219,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	ret = freq_qos_add_request(&policy->constraints,
 				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
 				   pd->table[pd->nr_perf_states - 1].frequency);
-	if (ret)
+	if (ret < 0)
 		goto out_dtpm_unregister;
 
 	cpufreq_cpu_put(policy);
-- 
2.43.0


