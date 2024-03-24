Return-Path: <linux-kernel+bounces-116135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750088998F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0533D1F26305
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5EA3AEB04;
	Mon, 25 Mar 2024 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEYYpD6s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715B2811D0;
	Sun, 24 Mar 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323678; cv=none; b=M10AsFJbW/T/BABlxt/ql5b+pDFgD94m0XczxvnxmEeaPWfeE4/ZOUY82M4urT6bGFYqvfdvHiJ+cUoJGJg8h1IGvNcAs2Ief6e58B+R6ih3yi1xCGKExD3wBPkDXhwJxXA7KYpNJtP21zlDtsYQTjmG9fvHQ+n2bmi7AGdkUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323678; c=relaxed/simple;
	bh=3v2u52gHV9cGUvW7r3oyCpl4u5Lb7Ipc60LXIYLcw5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NE3hXBIt/B1aJ0NPa8XZwB2xDSUmPLwpNkQqiGaCTk0JDqY0OhhFypG/v9Us9v143CRTKnwKLRXQ/Fc51pGwfHeigjv4mBiKHkOxfAEa21fnd9rGkcLSdIt0+i3svunUclhAo7SxFdnw9WfgzFM92Pc9/ElgipZjppyLFQtBstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEYYpD6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352F6C43390;
	Sun, 24 Mar 2024 23:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323677;
	bh=3v2u52gHV9cGUvW7r3oyCpl4u5Lb7Ipc60LXIYLcw5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fEYYpD6ste3NLXXBh/DGCAbRQk33R57iOY9PJmd5ei/HL40BYVQBvqu9nFMuJoAr5
	 9KV/epCU+/LtbFl4FkUkQwJW1DHtPc2HP4agSjIZ4grYS3+8otpPUQU6hc0VVu3Xel
	 aJ1NXRdZlKMZniBhFjv1qqWaIlJQgfOIo1IwXoGJ0hg3g9BxKwqkgMljQXPmKqnZIF
	 4DgweS+ubtjeiQYjHAPCCjQI7HdddO4Aoo0v5sD6/XIEE6tWzWU93iQsGif40SXgXf
	 FL9q+7njQzwafrXUNL6Y0Mj0uG/pHEc3Ka2O+LJ+q39ljdG1f8Z1/t1uRiOKFGNph9
	 oMkCK4LOki6dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 050/238] cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
Date: Sun, 24 Mar 2024 19:37:18 -0400
Message-ID: <20240324234027.1354210-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


