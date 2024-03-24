Return-Path: <linux-kernel+bounces-115065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9030F888CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18541C2A632
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251792F2D90;
	Mon, 25 Mar 2024 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5Ift529"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566732892BF;
	Sun, 24 Mar 2024 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324040; cv=none; b=qztxjFB3QacPciLg+puMwEtT/o/Yt8VlMtKxcjGugRrQNqF4vIEo7o1PMmDImJu20DukdDb6mrIryK53wLIY1fYWTnQafILjSfHzq1s6bncRPaYzjE1wot2e8XMU3ojDCHNl34Iasilqyc9Ht2D1aslB3sTqsgJyBCy7LLtmepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324040; c=relaxed/simple;
	bh=/7/1b9rks8twEubNpUt8qsAQs2IeCT+nNQFQ6FdH8sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTOe3nHqr/F1DEir8A4OSS6N4MSJMM9gfnlETDm3XCOluu0aORmPmyubzGCnGLNQUzFWGFMhTapy1ZMn6bKuZZ2lu2gDvoih2HlDyGmz3cKBn2y9V5762G57H5HskS9KAFakK082+LhwZzZv1ELVG904T/kLD8mzzl5UN/Cqdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5Ift529; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92922C43399;
	Sun, 24 Mar 2024 23:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324039;
	bh=/7/1b9rks8twEubNpUt8qsAQs2IeCT+nNQFQ6FdH8sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5Ift529qPMO+w4GK6j9ST7lPrONGI5MQKjCFHVDRj3xFaAAFHtVDz2fbSSCfP5ZP
	 w73QMkGC+1CO8P/f/mKAMY4K8dJHK6ypS/PKaWudCrZKVIWzU85UW7HQ6mGswVG4fi
	 ybZq/msTzyAu4kzdTMEub0KKntT/wcLxJdXH2IOXat2F88M6MQlBhiOpIUaL6XyjkH
	 CBIEnqtQqnkgQZTouUE0UmkYbO9UcTWkjSg9mTJ2vzEWgYmcV+i9eez4ZqRegjLjRe
	 +WhhxVvDbsf/XnTcR8JZXSYPP8GiSMhPnsZX0bnfkW6mpoR6W0pIe1WkNi0aMhJFjs
	 Jg6ckSnHSbTAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 040/183] cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
Date: Sun, 24 Mar 2024 19:44:13 -0400
Message-ID: <20240324234638.1355609-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Anastasia Belova <abelova@astralinux.ru>

[ Upstream commit f661017e6d326ee187db24194cabb013d81bc2a6 ]

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return 0 in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 541486217984b..1302e1900dcb1 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -457,6 +457,8 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return 0;
 	struct private_data *priv = policy->driver_data;
 
 	return brcm_avs_get_frequency(priv->base);
-- 
2.43.0


