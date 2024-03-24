Return-Path: <linux-kernel+bounces-113723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3735988863D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCE31F23D55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0921DC7ED;
	Sun, 24 Mar 2024 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+5NUZsE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B186AD0;
	Sun, 24 Mar 2024 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320706; cv=none; b=Mq0srs3zuUmGgnuHrU6cE9I1TgjnoBr++3KSXKYS7tur950vGcG/4CaIQqJ/Dm7K7IItR2LMx/SbIRqigPqjKssOyvVb3rtjDSS0eoOGxA7UaswD86V5dPkrYtmVcfFc6V9H5CDBQAeE6oEzI1W354Cj6b2ylQavPTSCUPD62T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320706; c=relaxed/simple;
	bh=OC6s1nGnzvG27cdhEV9v+152Ge649GD6EUnGf7Ba9Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPKtxHZWOrRjxNNYfB/V4FHCSSkPDJZRGkq188OWydI+1QKLIvKEMTeggjqIVkUa9nEDSlxAcT+QqDMiexLVyXwcV8GJ8bw/l1SOjgiN+sEKVpbr677K1DFPtlalQzWfomSMj6u8RVf7jJRK5ZgxuK++HJH9iM68NHrKe7Ajdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+5NUZsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D987C433C7;
	Sun, 24 Mar 2024 22:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320705;
	bh=OC6s1nGnzvG27cdhEV9v+152Ge649GD6EUnGf7Ba9Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+5NUZsELkUpUeje0JT2uO037NFH6IaR6UE/3QjRV13CQn8hos38U+J3KQ90QzNDp
	 HxFhIsPv5Eg0ACu8kPLFfjsjgNIPUiR6X5gAmtKIItDB6mUy/PtzWgJpDioH3SqDi0
	 px+MGKX3rh1e5MkYRHHg8L4b2Ar6rDCM3wvg+eXLQVIlM0iUvlcTG5k7Ginq59qoNC
	 J57kOOic/p7v9T8Owsf5MEVQ+dOZo4yRuk6wixoVDfD1YJwV/UHuoarVhRzmMseg6r
	 ZjB7cD2aWHTWLgd8f889yiccbQTVp6ynniyGpGJOEPlF+tbZgKLYJxITrddE5bjzIK
	 7MDKF6DyD2kmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 267/713] powercap: dtpm_cpu: Fix error check against freq_qos_add_request()
Date: Sun, 24 Mar 2024 18:39:53 -0400
Message-ID: <20240324224720.1345309-268-sashal@kernel.org>
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


