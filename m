Return-Path: <linux-kernel+bounces-115894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71454889887
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D21229E10B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A355386617;
	Mon, 25 Mar 2024 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4Wi4FKW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406D14601B;
	Sun, 24 Mar 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322086; cv=none; b=pAQKtvzfPMo9bnTRJHVNJ0H+gsRlpr0MOmumZYuMPEZZ6VrnTT0kUZQ9WiI62HbCG8ZeIOUpmx9XvpFCDcj5KDqTG/Mc2PnIaMkr4EdRH8N3502e81AFe8ji0AkLtK/MLqe3b9jdNPtBo5zsnqgciUj75jy5N4O4oolW/3DTT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322086; c=relaxed/simple;
	bh=OC6s1nGnzvG27cdhEV9v+152Ge649GD6EUnGf7Ba9Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbGaEQEIvrWZKXSXk0Oa1th6GnhmhYXHKA/sMlTbWTNbhPrudjuKi//TlKPIJv+eLfC0VOq5gnJ5cdlPtmCKozXu16fBvfXqNUS4hCygcnQIxMLxFz7ZjGajq0euUr+7bwoUU5rNklPGcaesUVapqZpUGpEsK9zWOrRg099wEFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4Wi4FKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA98C433A6;
	Sun, 24 Mar 2024 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322086;
	bh=OC6s1nGnzvG27cdhEV9v+152Ge649GD6EUnGf7Ba9Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4Wi4FKWMUm3GKg4EP2rytxxnr4bEGd2cYu1Wfl/sxmsjKm/fWpnKNeLcweJiZdN8
	 sYb739cYjvIqQeI6y/sSMtQugbe6CM6/jhguDBCV5jlk85JVqv/mtVD6r561Yec8q0
	 rGu+fZwcPfxi2J2B3OBBixI1+5+uzi06Sq1J1/rsvkhU+x4e8H7UehE1JDuPDCPj/1
	 XgWZE7L093VPRgSnwMcAE87uNuz8bJoi2/FaitG+kcJuz3wRX5JumUlavZ2nBsHF7w
	 LpZse7Dm/L7NbwvgrYgqgQv1K5gUdNDG/bzitJHn2v877L+yGfeoHmhgm4ZArRuE2r
	 f78hRWfkY9ZAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 160/451] powercap: dtpm_cpu: Fix error check against freq_qos_add_request()
Date: Sun, 24 Mar 2024 19:07:16 -0400
Message-ID: <20240324231207.1351418-161-sashal@kernel.org>
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


