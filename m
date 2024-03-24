Return-Path: <linux-kernel+bounces-115822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B06889826
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB831F21D81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4455378282;
	Mon, 25 Mar 2024 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfG6YZgh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC783145B2A;
	Sun, 24 Mar 2024 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322033; cv=none; b=bZhh5ip5d9wYCTtsRTCrsQpyoEet5doNS+uSyQXOlr9NqVpm+IkF3BV+i7nUHcTfnNclxtRTq8/b7qhhkAkaySczGqH0oamLE4T0z50YJqEzd5XhGcoQmLHgmXmGqHDkqgfRdyohUwxeSdC8uzqZzuu4UQSxetEKL3kZSIUNZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322033; c=relaxed/simple;
	bh=+mmJq1X8ggrGC5bBCdN8KC/xh9zWt9V43RNjKymHVus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqe4tHitFDb92JW3ZzxtLcWwPHhBlL+a0OqBKbArxbW/Q8IkbHW2xxaOvd+X1DEBuQLATZkM1TVvzCGwnFCbtzADc4wr/fUd7GjVGP1Z/fb36H1w/qVoqIxsG1nNUcF+Kg6YA76/oZ5CIwA9rbSpP1A9vyI6soZb+ujAYTFJbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfG6YZgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF15AC43394;
	Sun, 24 Mar 2024 23:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322032;
	bh=+mmJq1X8ggrGC5bBCdN8KC/xh9zWt9V43RNjKymHVus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfG6YZghNUf/7AcwHpNvRuMQMfwcr8tseRNazfXuPbPRUsUKOhfYMOwiFsa+ANS9F
	 dIgydtQ7dbvVnX45qZwIt/5nuIyx50ENKSMV6X+eJ59IHApJoAwshngkehaMsAW7TT
	 bd4D1T2ZoZio/WqPQ3RmaNtLkpPo/3uR6p/lV3tZcGgqna3TIzIobFfh0nre0gECHf
	 4W/SGbwazDeGYUJhKn9PrR3aOtlH8mm0Kcu/lNVyB0ytGEZS+3CoMe7A0MOTSRDWj7
	 EPfxrMsD30brIhx+BrT0+8fiWE29hoGuQNvugsmcR8FmYUdg0ybAszkPgsCtXHU9lk
	 PyjyygZtMCg+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	"kernelci . org bot" <bot@kernelci.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/451] cpufreq: mediatek-hw: Don't error out if supply is not found
Date: Sun, 24 Mar 2024 19:06:20 -0400
Message-ID: <20240324231207.1351418-105-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 42240a7d826da..7f326bb5fd8de 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -308,7 +308,7 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
 					     "Failed to get cpu%d device\n", cpu);
 
-		cpu_reg = devm_regulator_get_optional(cpu_dev, "cpu");
+		cpu_reg = devm_regulator_get(cpu_dev, "cpu");
 		if (IS_ERR(cpu_reg))
 			return dev_err_probe(&pdev->dev, PTR_ERR(cpu_reg),
 					     "CPU%d regulator get failed\n", cpu);
-- 
2.43.0


