Return-Path: <linux-kernel+bounces-144014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 591718A40D2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD331C20CBD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF720B20;
	Sun, 14 Apr 2024 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yweem3i9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A4208A9;
	Sun, 14 Apr 2024 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713078934; cv=none; b=NiQ8538aW/Xunwnrjni45Bo8+XkB9/wa+LBmqddPfYTXbBH8ZcT6ALsh3TokdUNkabAq9CLwY66Ckhxn+b58WvVftene51gBcRIUoXtoRGWOQAjsB7UTmlMkxuLJJ1gQuDolRiqnOI4ctrFv+swdfgyeP+w4OAbxL7lWq3Qgkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713078934; c=relaxed/simple;
	bh=FSDsyMrRocq18g4fLSqC6+AUZYzqe2fK9hdMDuAh6QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSyoRIGOsmzgn+ZAZB2xg1AK0/t0+53U7dQl+IAHZnajkwxEWj7ozotJD4ByGpUqaFMSE+Sz8u+pU9Bt80zKBbxv7rLQ5eA5ZzUPlq1THbB/CoKnKQaA44vH9XJfP+XAa+Ki/acTuIKPJcgVS7RMeshnTGtQ0nIMudSvYaHl8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yweem3i9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35D9C32783;
	Sun, 14 Apr 2024 07:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713078933;
	bh=FSDsyMrRocq18g4fLSqC6+AUZYzqe2fK9hdMDuAh6QE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yweem3i9k23kIpTiylQql9UeaoUhbg9HuJLnI1sI7Qs0MgjbmkcBeecOsDbO1FEXG
	 6yjkZHPAUWPcexJeHHLWYAtWl3n+1iSkiJI6G0G7a/415bWfE3828c+c/jCDTaltp9
	 RjFeIXh+aMl+mZGYREy7xyVDORE76zz7UPqoJLg2N3wD/Hih8WGlZsTbPxdERVEk9m
	 fdi4LGydC1UajTkHTB0eyho/eMcYE2CnEm3TJmL31E+oiLWoNnbZJDpd5ddiCJ/VAH
	 h4QMSZki2hpNga/roAiBcrLXzqrX8iBYmp7sGBRpYVEd+E7mpMb39VH4pYgJg6YvyZ
	 //B2L9Sh7wtIw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 09:15:14 +0200
Subject: [PATCH 1/5] mmc: sdhci-esdhc-mcf: Constify struct sdhci_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-mmc-const-sdhci-ops-v1-1-178539d68093@kernel.org>
References: <20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org>
In-Reply-To: <20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Ben Dooks <ben-linux@fluff.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=krzk@kernel.org;
 h=from:subject:message-id; bh=FSDsyMrRocq18g4fLSqC6+AUZYzqe2fK9hdMDuAh6QE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG4KJY/tl2Saj2U2DZ2YxrHCZv3dN/g6ktqpxk
 423BMPWqEKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhuCiQAKCRDBN2bmhouD
 177xD/96a+pBFWX3uU4APgT7ya9+7pUYqrDvrDZezeiEu3NGdVD0o29a/S+Mxyh92BjF4oV9VmE
 TGMBjIZF2PbTc3I/YB5aRMSWlMJSP4IgTlGm197JZ/seqeQyAOK8Tc5J8PhRlA0QNsBr9mjqpeE
 fsVw21ffJcQKxkK3/5tlPpjLcUPvwYrf+nc4d3iaFDGPIRqFp6vw7ckRea1EJsx7EhJ91uThbmk
 cnbez1s4ycgieVDz3B2N/OKIehaz5lM5MM1GJrPCdN+m9d8UWAkbKZnjQ0a3qlQuRMYF4qA3nle
 EEoZ8Apt0rDKHjPP4FbBNgDVyIeKrUmY8Z6n1hMejG9PLFnXR0QTcwCYyTwxYA2eWTfAt2tm7BD
 3JQDbypdM4sgHyi0RzFRre/JfB+4Nuu/UpD7oXza0p55DrEx8Sx1BL5hJXpxyssRQwMZMva6SnA
 OdSDkJLUql0bWGidIdzegMEHDa+yYO2dN766Qvy4o4kX7pG8vGl0JBeCz6j5B/5sMuz2J0pIDMV
 F3uf2eSdU6IdwFlGWzuUOjlZ5mB1396v1Y0JG6VdLF09uxZx5l3a5/IghFyHi0/0+OyTr1NHjqF
 wk5hWOxe8gT2x5yfxALM3+Vav9NWp+lvGK5VrIhjzL0IiZp/brHXDGkG/HPoJk/8KFZbtEXJFF6
 ukmn8TMymrQ3Gmw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The local struct sdhci_ops can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-mcf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index c97363e2d86c..3ad87322f6a5 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -335,7 +335,7 @@ static void esdhc_mcf_copy_to_bounce_buffer(struct sdhci_host *host,
 				data->blksz * data->blocks);
 }
 
-static struct sdhci_ops sdhci_esdhc_ops = {
+static const struct sdhci_ops sdhci_esdhc_ops = {
 	.reset = esdhc_mcf_reset,
 	.set_clock = esdhc_mcf_pltfm_set_clock,
 	.get_max_clock = esdhc_mcf_pltfm_get_max_clock,

-- 
2.34.1


