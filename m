Return-Path: <linux-kernel+bounces-114105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348588886C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A369D1F26994
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F7915FCF4;
	Sun, 24 Mar 2024 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR/M3K02"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88C4D133;
	Sun, 24 Mar 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321408; cv=none; b=mwEq6zctVTnsJ2JvUcRAvUgVgYlp6R0T8N8454l/9dDZtdllxxa9YJRM5nbHlE6EJ/BOqhN+i4QrXrtgzTBAK8ofdNsZeOPuS6qVLpYlPJqFBOoN2YevXF4H8tNeBQR/t9O3q2LTP9Nk7Zp2kKTak1bin+lg6dURrl59PwwwaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321408; c=relaxed/simple;
	bh=RiNJz9zlSFXEx8zYJSB1a4ND7aEOOQrZQdR/XEnpxN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiL4D2K0MU9r1L/YUWkynLncQDVglOKh2HRTBxijNCYYYVPSq8eOhh5LoZHFA2AQgejqH0X1bc57NhT6rzioJMCmjVEbJFB3gAlkajV/uo2gTF/KeA/lup2gkCP4c/Cs6K0PjFa5I4hbb3Hc43elNCxPP9RArISVBuSOflTIsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR/M3K02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1467C433A6;
	Sun, 24 Mar 2024 23:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321407;
	bh=RiNJz9zlSFXEx8zYJSB1a4ND7aEOOQrZQdR/XEnpxN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NR/M3K022ROrNduZk6O1o2BSTvFVMp7IfX6iqH0tQMpzxgB7AmaC/BCSUpAV6m9GC
	 p6UmugQHv/8HA3h353k71Kl+XgXU1fbYIYRwj2XyTvb5RmPOtrXD1QVeTSj5Ly7hp8
	 nBgr7rTNYMHOUR+ftUboG0E02/3hXX15PCjlYqhRfJnX7DehmwjQRtYQZs0hF/v0SC
	 rbUnw2+Z6jGQe14pv4uaeTBSynacO1Xl2634+FeqrJKnBhQ1CcO82+LnEnyXvtdffZ
	 NtRrFkVRtpfIdIINBjhr/uieSY4vyKMEfTczbiUNRZvBbzJKs7DasrjzVpMPgvHiNC
	 H9Iqr5Comt0gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 132/638] cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
Date: Sun, 24 Mar 2024 18:52:49 -0400
Message-ID: <20240324230116.1348576-133-sashal@kernel.org>
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
index 35fb3a559ea97..1a1857b0a6f48 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -481,6 +481,8 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return 0;
 	struct private_data *priv = policy->driver_data;
 
 	cpufreq_cpu_put(policy);
-- 
2.43.0


