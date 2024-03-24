Return-Path: <linux-kernel+bounces-115426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF6E889B77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91FE2C3B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F720C037;
	Mon, 25 Mar 2024 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjnAp9JD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3171D7922;
	Sun, 24 Mar 2024 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320607; cv=none; b=KBqKG6LpkTvJFfpKGg+9KG8ygVIiMSkMlqaInSg8TO7cPJ4O+FKvqXL7ByuKEufGc7fOnEoaG+2dgiyB8Gqc0CHs6okhBsmkT0fXmhAR+NjPMLiLQgQC3FaX7H/xLs9iVNODR0cO1XIX5+yx6cvhkKEU4nAe+td+5S52NKBZgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320607; c=relaxed/simple;
	bh=2jaq6Nv6r4YCmGhbPVeZlY0UKTMbM3LoqcudLDvUkVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oq3j8HKYASx0DPr/03YM0D+iR/Pu8+Z46vzsLDauXVKS/Jp5XWo008H6TwVk5rQlYm3JBCeG6+yrUnAYzZkOMP/TAzvkOivNSMRMVb9ADW+hsbSNCMnMkGzydx3zTYJrFZjgqOQqc9ssKZgQlBfFZROqG4N3vF2VdOBKHCzhqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjnAp9JD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF49EC43390;
	Sun, 24 Mar 2024 22:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320606;
	bh=2jaq6Nv6r4YCmGhbPVeZlY0UKTMbM3LoqcudLDvUkVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjnAp9JDgZD801jxWiQDrmjaO5I0cOMZCwRqpkHx0uIsgk6eL/SeLVaMiNXtvVdBn
	 gsZzOso4mq/IuIaFwajilz9pwRsj/VxvBMVRBiUZWaaxz5lSEqv4HN6HPFlHqhhQQp
	 kohxwv2vEyS6g94UrvUtdxzNH3GOvKQ0rEiVhGi78kwIkxshSARuUDRHxpeTB9vFbv
	 DBdfC2nXi92HErwXajyPy4D+UiMdTgbm55tuxrJY+FvzVuom6T3ayJVfXcT5nkTwbM
	 3AxYX101lnHTJJCNzRGFfzPoYbg7lI+48QkSnSkyP1vbxFZKXqN5D1SfC8RTfAyxl8
	 0PygE8CVUf6Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	"kernelci . org bot" <bot@kernelci.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 167/713] cpufreq: mediatek-hw: Don't error out if supply is not found
Date: Sun, 24 Mar 2024 18:38:13 -0400
Message-ID: <20240324224720.1345309-168-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit eaffb10b51bf74415c9252fd8fb4dd77122501ee ]

devm_regulator_get_optional() returns -ENODEV if no supply can be found.
By introducing its usage, commit 788715b5f21c ("cpufreq: mediatek-hw:
Wait for CPU supplies before probing") caused the driver to fail probe
if no supply was present in any of the CPU DT nodes.

Use devm_regulator_get() instead since the CPUs do require supplies
even if not described in the DT. It will gracefully return a dummy
regulator if none is found in the DT node, allowing probe to succeed.

Fixes: 788715b5f21c ("cpufreq: mediatek-hw: Wait for CPU supplies before probing")
Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://linux.kernelci.org/test/case/id/65b0b169710edea22852a3fa/
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index a1aa9385980ae..8d097dcddda47 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -312,7 +312,7 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
 					     "Failed to get cpu%d device\n", cpu);
 
-		cpu_reg = devm_regulator_get_optional(cpu_dev, "cpu");
+		cpu_reg = devm_regulator_get(cpu_dev, "cpu");
 		if (IS_ERR(cpu_reg))
 			return dev_err_probe(&pdev->dev, PTR_ERR(cpu_reg),
 					     "CPU%d regulator get failed\n", cpu);
-- 
2.43.0


