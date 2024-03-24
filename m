Return-Path: <linux-kernel+bounces-115410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769138896D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD031F3441E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547E92046FE;
	Mon, 25 Mar 2024 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpzL/7ll"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF0142E84;
	Sun, 24 Mar 2024 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320589; cv=none; b=Me205az5hhj0Qf5SflTSAvB7VY6bye2DbiJCG/IVVY3qN3lurk9NAqA6ZUc1GD7VAYReHHp6GX5vlxm2bzbleGg4HKNpKXoNlckEg9B9cd0RJZNy9ixmlre937JlX5LEo1kz6r1gEBOQ+LgnsfpaDguBIIOOhHCzsbKR9WPiY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320589; c=relaxed/simple;
	bh=RiNJz9zlSFXEx8zYJSB1a4ND7aEOOQrZQdR/XEnpxN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fC+xoj8kETGDkKHfJQ475tI+nuD78pgUPIijxyeWmw1E6kia3Ry5Yox2ShVe4aZ+DFAmpu+95DqHNJeB7L5/pbDR0yQvcGdC2jT0XxurvgaOdzlHEW8pmXByit2591QpWPcTXvPwuiqvVk/6k1ugXQC27iOlJKFBr7Y6G7sZfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpzL/7ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D91C43390;
	Sun, 24 Mar 2024 22:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320588;
	bh=RiNJz9zlSFXEx8zYJSB1a4ND7aEOOQrZQdR/XEnpxN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpzL/7ll9r47e3rn/dsfQNZ44CHhzs4d4+sFqlIY2B9xHMGcrKoZKEozqtvW5+2jk
	 ExgHZAJ27+VfMtyC2EACFbgO8NXatyVmJy5lW26ec6v6wHbHfO8mBgIUqSViIhHv8d
	 z3xUNzJPjUkB3XXUAwTYSEfLNTP+rbTdrBKpejmwlR3Bw+2uzXebH0wW0RnT5KJXwy
	 2tF4iGK2DQjKVZLZrs4JfbWyu/2JUOkW23pNxOLB1pd6zyukk3geq/R7AjchVxy4cy
	 g8uD29MlY1N877XQI8kJXuzXjIsoFCNBy3IYJTvG8w6kJHoMoHLT7xkkK7nRApDQKO
	 dopqXE0LE7Nmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 150/713] cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
Date: Sun, 24 Mar 2024 18:37:56 -0400
Message-ID: <20240324224720.1345309-151-sashal@kernel.org>
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


