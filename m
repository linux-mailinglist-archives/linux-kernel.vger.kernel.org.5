Return-Path: <linux-kernel+bounces-112966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A21E188801E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D41B234C3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999A7127B7E;
	Sun, 24 Mar 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXJB8BWJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB1312882C;
	Sun, 24 Mar 2024 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319777; cv=none; b=q2RJmtprufQAq3p+Z758PXV/IF0Ra4n80Qrf171ZqVTn/bqMiDWcCWwtr6D50nAcLneahP5Rne4JCOxPFl/Mdmx2hsWP/61i+ALBqLr8PDMx/opgZ3R7+A47ieu1Yumk7Fca6Y/LqmL7k0CqHE1+10pxhxzxzOVYShb8pqSaOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319777; c=relaxed/simple;
	bh=RiNJz9zlSFXEx8zYJSB1a4ND7aEOOQrZQdR/XEnpxN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+3m2zueTwVTSpJWkDtZAjaEFgO9l9Bb2FiRww3AxcrD7nuT00YOjR+WTzLXDvnhkQ3UvEkpUn5nuudpJ1KO1IfKdQdmW3ve0B7/P0q573Gq4idq+PrYj/Gi22VpZBylgF1Lfc5oCxNXvPwLNRTJHt6JEAFXKTlIZR6hlXBW/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXJB8BWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9DDC433C7;
	Sun, 24 Mar 2024 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319777;
	bh=RiNJz9zlSFXEx8zYJSB1a4ND7aEOOQrZQdR/XEnpxN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXJB8BWJadwdBs+vSLJdprGNC94d8AaJqVrNUp7q0YWULHfRJko7ii7qftWICISh2
	 zfsuApO1k4V8IBAP5QtZeKr+l/jc2pbHvmAdboUqM9axfNdl/hG+SiFXw3Rnm+AmTT
	 APFDBN6yS06fVzvn1h2gP5sqfck1aDffcoBWq75DpynQruk3ny0gWbFl2XGKtWkW4N
	 WKzS6TflnJjaYlhWTIaXcgbH8Petsog92UWTEUASTCy/SG/rUkxUPemIoO+XoQCYT/
	 hSlVQ4QeiaNH0IrIE9l3I6ug8eXnMyPXJePnhXznlhnqBoQCQnZ/aDYoxyJMoNyMFG
	 Ow4qSXuLRk8GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 079/715] cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
Date: Sun, 24 Mar 2024 18:24:18 -0400
Message-ID: <20240324223455.1342824-80-sashal@kernel.org>
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


