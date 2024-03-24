Return-Path: <linux-kernel+bounces-112988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A088804C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB80281554
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9CC12DD87;
	Sun, 24 Mar 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzk5XxjY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EED12D76F;
	Sun, 24 Mar 2024 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319801; cv=none; b=J/vQRhB3HtW1YLyiPKNQvlICt8sU0C5MRLfHjqNh7MLTE/2GwZv+tq1pI/GmEE9N73C7AxjCeFKtTICRW2mlEPFPTrWfHou7G6crXwUkd2z5aZD5fc6PB5g/dkI8lscS/540c2dujKTvt/+omvkVJXKVczKqKub1tWk90ESjK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319801; c=relaxed/simple;
	bh=2jaq6Nv6r4YCmGhbPVeZlY0UKTMbM3LoqcudLDvUkVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omvlCUE8j2ji7ZuyL08z6Uw8+yxj1dowXOd7XnAG2CP3XHHBwSSs22GrJLMB7OiJz00jtiNQHQHCvHqV6c2ebj5QNRqaow2+lJS6TUktNbx3pKmLG0Bx1gX6upSrlWKA9GewIQZhzauKrN0G7vV08T466+qLPcX8NyAJhrroiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzk5XxjY reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8832C433A6;
	Sun, 24 Mar 2024 22:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319800;
	bh=2jaq6Nv6r4YCmGhbPVeZlY0UKTMbM3LoqcudLDvUkVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xzk5XxjYxEZp/ZcjinApYChrPkvo3LTITPlrpjD5NJt5EAW34Yzqo0fYJsGAj+rFF
	 9udgBqRawTo6jBN+fuqk1p4AGBuGu67yCh583qRHjgKgkebjeajVkKcZyCkPMaoqnN
	 FIwZ+lPR7sGvLhbLbpm4AZD2KJ5NyAorjVGZ+qlfSantIao9brw3RaDj6XChPeWmlM
	 TNQlbpVQhRVATQmSsG/f3eGIkuuxvpr52Fz81mn/6ojN6tOl0Ja8zzPrX4UocHKxF8
	 RXobDxCLVBc3AEo/84Imex5jiuxvU9FABytz1KbHhLIJFq/eym+1clyIvfmdhLRysi
	 +OeuoQAvw6ISA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	"kernelci . org bot" <bot@kernelci.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 101/715] cpufreq: mediatek-hw: Don't error out if supply is not found
Date: Sun, 24 Mar 2024 18:24:40 -0400
Message-ID: <20240324223455.1342824-102-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


