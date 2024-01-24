Return-Path: <linux-kernel+bounces-37655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095B83B31E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328B4B22366
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835E2134720;
	Wed, 24 Jan 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C5JB22Eq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981164CFE;
	Wed, 24 Jan 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128481; cv=none; b=W+YKXhQMjB69cbuMU1byctpN4aNDjn97nkI7X7GwHxMn+Z5o7rKjN/mlpFXyScbq2/Xco3spl2zOZpnOD21pVmqzQ0xkX+2IdE9yeogmPVcOXXMIoK1zYAfX/OEwoglO0z3KKq7HohUmBhdM+5jh1b7Mn9tLLj38tXQPYMIlc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128481; c=relaxed/simple;
	bh=njWPHFRX9VBUYd2HwT+iNnDCR9j7CQAq4CCN3sSHM5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NgoKaDSqrjOA5GpEbl2JbGgXchnO1xAVC6xzZUmRB7kbzO/qeDOxDdacRE+l4S2ARBnzqqEnlCq40XVkiB3+XT6SeudZu1wq3gwqLOD69UyGOlCunboX3r/kt1ll2XCZmYhwTFZ7SR6MwBL5O5ztwsJhI8BKxPh3jB09NEefIWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C5JB22Eq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706128478;
	bh=njWPHFRX9VBUYd2HwT+iNnDCR9j7CQAq4CCN3sSHM5M=;
	h=From:Date:Subject:To:Cc:From;
	b=C5JB22EqSKntWSOxCynR/3Q7KltjJGBsros94uUbGKsx1dC0xSmAdKdbrUjNOmBtK
	 /TxEDUHA4qPAfC9Pce4Z19DbgsQhTwCaPv6vY//qvjOjjjazKCkO06tkRpJnT7eYEk
	 AewFIv1eRaXAYaNbAI0YJ1aMHlZ69Av9QAkdHGVenR0zbBD1GxQ4B33sJbArvSygUz
	 tkomH6fOW9qRa3SyPWdoJWCki5VTvCr2avwut32LBGfbzp7MHm3HfRx+1JUhEYoa/w
	 sWYREUhas6l1uIC61K0kVrialRtZL1VHQDD3+bBqU4w/O2vsIXx1I6lXFbpCvpqNGK
	 veHP2lyYMhOeA==
Received: from [192.168.0.47] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5AFFB37813E9;
	Wed, 24 Jan 2024 20:34:34 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 24 Jan 2024 17:31:43 -0300
Subject: [PATCH] cpufreq: mediatek-hw: Don't error out if supply is not
 found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240124-mtk-cpufreq-hw-regulator-enodev-fix-v1-1-6f9fb7275886@collabora.com>
X-B4-Tracking: v=1; b=H4sIAK5zsWUC/x2NSwqEMBAFryK9tiEJIuNcZXAhpqONTuJ0/IF4d
 5tZ1qN4dUEmYcrwLi4Q2jlzigq2LKAfuzgQslcGZ1xlrKvwu07YL1sQ+uF4oNCwzd2aBCkmTzs
 GPjHUVuWmfjXegD4tQjr/K5/2vh88GESLdQAAAA==
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, "kernelci.org bot" <bot@kernelci.org>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

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
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index a1aa9385980a..8d097dcddda4 100644
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

---
base-commit: 9ac3ebaef3cc43ecd136911c44f1427286ee5a05
change-id: 20240124-mtk-cpufreq-hw-regulator-enodev-fix-f614019689d0

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


