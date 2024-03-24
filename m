Return-Path: <linux-kernel+bounces-116316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE8889E35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE751C358C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3B3D323B;
	Mon, 25 Mar 2024 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVDbu7rZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120FB183B8D;
	Sun, 24 Mar 2024 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324258; cv=none; b=fVD7lVfCWuTiboUGhYdaoWkx9Vi2ua++PLRLubkh+zDagHtSJbZyLC+ezx/OzXxe3Plm4lZLndG+L1rCTLwcX4yWnznVkpjvKS5hXztHsaPCzWYM7JW3eExu7aS5rnQBaFzBX2VUyi5PNOnTSiSo3uj4wCgiG+MaqnOcz9ixbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324258; c=relaxed/simple;
	bh=/7/1b9rks8twEubNpUt8qsAQs2IeCT+nNQFQ6FdH8sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqFSndJu1U1xFEklDdE3SHDYbUVj4W/+UrMjlFKNy+OJqapAQKBRRZUGv/xSWki7oxcckbyLV9IsX0xphGclR+3aUlCNSXojGxv1+6pjkextB7cHoH6noiXvA7QpdG5qDtG5x51lW7z+aUy9XPMoT51rm0Jnzwzf30ugbGKCnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVDbu7rZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B548C43394;
	Sun, 24 Mar 2024 23:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324256;
	bh=/7/1b9rks8twEubNpUt8qsAQs2IeCT+nNQFQ6FdH8sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVDbu7rZML13csxl7Y+8xuHjEClBj/izOWzwipHX40Xsa0z/cG/UY1FAIK2B2pEqG
	 Oj6Ju6QZXhjyHRiTKHN0qk3BnLZ8c9/a9iSFbFx5QdIKcstH1ieT9RB6bDSJhcAU/1
	 WZr/MT9SsK9Ae6ddTLJ6I4mUudAB5fRpB59/AAfI1mda4hv5iMpm7ty4ykwIijT8RD
	 /QGRhnbEvBxVCemQ8i6dcl/W0NcJxQUDY7Ylf635OWyKbNaikFoyGxes1jf/MFcITy
	 L8yXCwjdaryU2exfZdxovTflQI2Nyf69ES7+k+AvgUR8SZY/cHMRHS3Hq1G+e2Iaxg
	 7X47nj1JMXJTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 037/148] cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
Date: Sun, 24 Mar 2024 19:48:21 -0400
Message-ID: <20240324235012.1356413-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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


