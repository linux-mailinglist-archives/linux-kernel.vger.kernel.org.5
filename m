Return-Path: <linux-kernel+bounces-113102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17019888179
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06A71F2191C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156215696C;
	Sun, 24 Mar 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiRPpfp+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BB15530F;
	Sun, 24 Mar 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319910; cv=none; b=doTcro/jsOriSIj9RIohir6XPqKmNizd0xK8DHOSUQcYpB7A0Hj7B7yj8n9a3HdLh9Snt4H2/dYxfy/X6n+nD8rBI5L3QqgMh5bfNrs1nK6t+Rl4+B3N1hiE6Yk2zECwwBhId5bLgnVmJJaJKZTEm2KxiByMUcuswcL/ZiWBWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319910; c=relaxed/simple;
	bh=OC6s1nGnzvG27cdhEV9v+152Ge649GD6EUnGf7Ba9Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHJ453o1MI7JkBe9gwOnWPBVs3pMHS2/MHf4CNXIeqDzSLr9FJ5LjE891IqKrhLWuMwotKMB/xuU61XmpATSyOlD9LBvnhaJa/zuIgjLkzGKMvCeFFfk7hyuk9GDha4Qa74XIcSu3y0cakQh2FNiWECdFFLxNv5oFBNLiHWn3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiRPpfp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B386C433F1;
	Sun, 24 Mar 2024 22:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319909;
	bh=OC6s1nGnzvG27cdhEV9v+152Ge649GD6EUnGf7Ba9Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiRPpfp+kpzLZ3NwyrkyMij71Ny6Eq4ga9Mwhvvf0Tbxr2nrCe7hGDKFP24xTB/db
	 +7I/W/wq8PyUq1roK9FxWpyskCeLldYhxm3FiAwwg7uH931rYEte0YxxbkBk4WEy8e
	 izrWcgIEvzPJMpisvDa7NjxKzNXOS+PYHJARBk6/TghLZ9CBKvUrOyuv/dUkslkWHN
	 nRkWfMJW9Rg2Oxq4beibr6hh9Le3fikd+aj6oVPWAFx3vmvghAXa5dCxm0gD/Jq9pV
	 Al+aWFfkK1FoAghAuUdiSnbheaNUe4mHYQFAD85aDfcZT8ycx98GCHvwgzWvSfPnfE
	 FboJuyDszODsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 215/715] powercap: dtpm_cpu: Fix error check against freq_qos_add_request()
Date: Sun, 24 Mar 2024 18:26:34 -0400
Message-ID: <20240324223455.1342824-216-sashal@kernel.org>
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


