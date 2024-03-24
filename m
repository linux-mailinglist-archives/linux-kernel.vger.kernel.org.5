Return-Path: <linux-kernel+bounces-114120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A643888880
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA091C27293
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B138B23E42A;
	Sun, 24 Mar 2024 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIU9p3PQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22DB202384;
	Sun, 24 Mar 2024 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321425; cv=none; b=oGQHTOUyvI96odsa8w1LS1CEFLDNuZqJrnAsaEb5G2zq1sgoLh7hB3Dsc1baqmAy7iEDr9+de7PVrK1Zb6+a5umreGsmeHh0F4Crh64tHxE/4okwfNCM+Vc/bF8xeVJx+dTRWT8EQ7XjPqLBNk9Z1do8KspXOSD2uIvdHi3kDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321425; c=relaxed/simple;
	bh=2jaq6Nv6r4YCmGhbPVeZlY0UKTMbM3LoqcudLDvUkVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hL1xh5UwbrDY9yl++PZbBu+9wtcUdpHzMN1/1Im6jm2qavfQO8sAg8O7SsXqfhwMHe6EVHcQAWxIf6txcAKS5DRPZ6I7fxDGWjGrfkp/2gV0Z+pB48boSl/1UrLa4tZFR9zkmUYFu1J5cEocgrXgFMoEepp3P8r/mZbEcIj5OuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIU9p3PQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A25C433C7;
	Sun, 24 Mar 2024 23:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321425;
	bh=2jaq6Nv6r4YCmGhbPVeZlY0UKTMbM3LoqcudLDvUkVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIU9p3PQWXD3WWlwExVfQK1u5ZTI0KfUljV1+qNH0lInbr5Npu33Y+yR1H6oWfUNr
	 6itCZSHiyUc+QLfMbQQf9pnbRppnjT+Njvocl2u9AVklMH7bCd6RSX3z0PYiwPucXq
	 +X5QvLChBdeyUMC0x9J+FKX/NXV723QblShPDt6K4Q/M5AWmilafGhW5vjOqN2t6od
	 TpxJ7WSVshpsEIkYI/7+pO1D1Zgaeipas9wr/hBYWo0533vm/NcheSRKjyi2xpCyh7
	 jn91K9WVxE2CTTwY2e+oBJA2v/4q87w87dj8U9S8U+xYfZXToFm+JP86V79pSuEoDi
	 UkinF8P6eeFww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	"kernelci . org bot" <bot@kernelci.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 149/638] cpufreq: mediatek-hw: Don't error out if supply is not found
Date: Sun, 24 Mar 2024 18:53:06 -0400
Message-ID: <20240324230116.1348576-150-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


