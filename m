Return-Path: <linux-kernel+bounces-116019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F18894FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEA8296DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7517E3A5;
	Mon, 25 Mar 2024 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDEn8gUj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41820275504;
	Sun, 24 Mar 2024 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323361; cv=none; b=juOHLGIjX73EMqhngHqnngv8UOCRcxPdhda8PrKf5eQqiudGleRpmvfmpAGjS3bKhjG64gCOXBCwh9zPwmspUDoQZmyxEFTQ2jXMuCtseztIXUrhkbHUrizuzRNA7CDEfxH25bkX6Egl5wwrTyoIUk8hHDEAb0cAT+sS22jSve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323361; c=relaxed/simple;
	bh=3v2u52gHV9cGUvW7r3oyCpl4u5Lb7Ipc60LXIYLcw5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoQfvQ9uIdqJBB3G2Q9LKtIxSNEUVN7/fq7o9Wet2w72Sn0I6Ij+VsGPBR8W54qpc8qNPguUAL8si2Dce1IL88cadcNx79Y6XYud7fOLbzU0I+GNmhR6UjjHWO3X09dh3HHZqPphiOUjwWQs08sAazSxh6qX3VJWBTmGz0fgjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDEn8gUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC87C43394;
	Sun, 24 Mar 2024 23:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323361;
	bh=3v2u52gHV9cGUvW7r3oyCpl4u5Lb7Ipc60LXIYLcw5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDEn8gUjqpicwmrst9gr7sgS7M73kTq75DswU0f+TSZ1+fAniFHUsnAXMLhuJB0Ql
	 2SRkfDCp/YOJmcsrntsMxw0bVX1dTBE3ySnfNbXPk3Z+eN4Upzc96jTXc38NpmXWP9
	 kasywgceejvH0PjH7lcRQ2llvSwnHCIr3H/CZ3ph+Z82EypnEOk9HWOfvjwAtap3OL
	 UMe/s1kv9IMhvV1hiX7J8oK6KDt94IVTIMeFeNvp8fJUJLsEI0oUBiG8evZMryTSh4
	 TOwtegRP2YjbiV9lntxpbK743Xhnuhst5WEd1e8gg+62VJtluCHxVQ/7nGh6povRF7
	 0OaD1O2z2kgRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 061/317] cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
Date: Sun, 24 Mar 2024 19:30:41 -0400
Message-ID: <20240324233458.1352854-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index f644c5e325fb2..38ec0fedb247f 100644
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


