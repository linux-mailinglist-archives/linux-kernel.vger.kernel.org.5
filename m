Return-Path: <linux-kernel+bounces-144181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566438A42CE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A98E1F212EB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F65D461;
	Sun, 14 Apr 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnfIEbd+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA65D46C;
	Sun, 14 Apr 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103680; cv=none; b=ceglLNBCDG9RXCEMsJjR+3fJzyNMsxBe1yPWFTr76OGRU4CdjHJpfjtLay6xsxSh/4M6qrhKJOiAusf6iLu005i/hHtmrG5z3heTuNN5o5H+6jeYqwyEbZzeXC5RJ7QLf/PcDmbMHs1TBev6BTTRVjG0UnUkf0TqWdMBTR+xtbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103680; c=relaxed/simple;
	bh=FSDsyMrRocq18g4fLSqC6+AUZYzqe2fK9hdMDuAh6QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aHyF6WVm3Znz1wCyN1JDJYVwU2fChMkT3mg8vWsPQk/GR/yonF+JC/WmdQfnyzRnNSKURzqMZzVbj5/BGEL3MkzrPddjXitH0EMoi6O1ry+nr4zHE6sHwZBsnTmf/P6I06xJZjZPdyMZED/FV5c4rLB9+RFe+FYHbmIksEg/L6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnfIEbd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F3EC072AA;
	Sun, 14 Apr 2024 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713103679;
	bh=FSDsyMrRocq18g4fLSqC6+AUZYzqe2fK9hdMDuAh6QE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EnfIEbd+5MCYFKh2VhTHFTH6NXU76DOmSoWpb+qRuHWZG6Ex+SR4JIoN5/r/IcNf4
	 NA0+w73+s4g4iYwuThsaXDL5sRNgcbWINCfFftQ9k5pQD/nxKviGRsipla9b7yNl3n
	 VIPW0GE6sYv6RSyCkym3OzbKxsL9qFL+SF1KsYiUrhPQ+6Tlyad9jrvJcoPOcmh+7a
	 b97n37FvZFbsmXo1arCj9NYGiFJpzdfR1CahEDX9b99XcMBrizoEDW9nNsSkR95+o1
	 s967r+DuNom7bcDWR7GdvWW8EooMhyk61zdJOlzrUXBAiC5oA74RTjFZmVKY4YmJPG
	 /fn8x1VW8fdxA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 16:07:31 +0200
Subject: [PATCH v2 1/5] mmc: sdhci-esdhc-mcf: Constify struct sdhci_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-mmc-const-sdhci-ops-v2-1-262f81faadac@kernel.org>
References: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
In-Reply-To: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG+MzDoL8lrBdv9R8C6qmMqUjwplc1m5xYrfV9
 NrCRNMyeJOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhvjMwAKCRDBN2bmhouD
 14prD/9nlRkNlLM/QIo2blytG5aPzmgHbhGwm0yTMFBi6vvnB6nNCQejT/LYXmFxXNxaFiFrnPC
 YJNE9cr7JB02D+rigbNGPmHrqipvLiwrBMnycjYTp+FCCApqLm+Qu3Vl9mWzwgXCPTZ4dRZZmGR
 FADjRf5vGVyosUOoKztiAw8N9ByMuoHAz5eLm5uleAQWcw7A72YDZQxuAM9ymDDGAVCtGo86h/C
 GNfWUorijHmsbY9kfc4wV1FvFwJoFK11zAOc/tfD60TmTTiwgbALsf4KNIpEA10WZGIZVO1WKjV
 SHzlm5xXPdlYYSI7P+Hfdlqm8NUccthLax+Jjo0W8pgo4uK78eVLyAb36IYw0cS8EJyfp7c7ftj
 62Kxd0G8paAx+izIWDPgztTwithZpA2MuKq89pKQr/H7Y5mir08yufuQP0c1RCm+aAKc7j/5r9d
 AlZs1Xd+/ycMPhmxaM+dx8GwLwTpjC+GL5Fruz5f6gLblS4jrLeKVJUDuedvC4geSA4CbP/9iGN
 x4u7bzTHdWhx19X+N5gI0amN+MNGLcvbWSgIsc6WSr6J7hfd5w7Dlyi+ACzFtr8tjUe3RW8s2fU
 V8Wkw/fotQzdHw6hfsOqL3HCC+S/eoLzjwd6IZKPjSILAszHRXBpDJ6kcwRxY8UXt63+sknvhom
 m+wMXmQnI/dI/TA==
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


