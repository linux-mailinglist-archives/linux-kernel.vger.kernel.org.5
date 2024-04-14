Return-Path: <linux-kernel+bounces-144183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5168A42D3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75298B212A1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663E760B91;
	Sun, 14 Apr 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRLTY4MX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BA5FBB2;
	Sun, 14 Apr 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103687; cv=none; b=hyrrCaHogcUyWWOtSsS/TP4ezyHhJsrcKrK+jNHSNgBxaQvgQ5e9PbrmiZ5ww4EXgQ1m7EL2gfvgMvM7GdtowCjY29tNo1ch06/UeGN3ZS1xalkJSXCOjuwWgMkVrkwQ1gqRl8fDUkKxfTd9H9dMlbu6qbCbjdnqpSbxgi2ONZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103687; c=relaxed/simple;
	bh=6xewGZjyB3FgtC9pR8X505+HKwYWfSCoiugoRhC/E3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NeXjoJfXdBdDVyNnYLofuqN68Uf0fNhkuMZVMDCFF1/g73CVDTyjjPvXZ4Sh8rWQwPQqAXOiE5V0SUp7iIYdE7kF9JLCazNfyHW4Bb4Dhc1oyKAmdZMqt2Pb5k6FbFdaDLF+rVxgwBDiJXEIxiJeYhg+a2FnADZ0xYkhZAqQGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRLTY4MX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017A6C072AA;
	Sun, 14 Apr 2024 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713103687;
	bh=6xewGZjyB3FgtC9pR8X505+HKwYWfSCoiugoRhC/E3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qRLTY4MX68kxa6M8vARqsOX7U3DUO5EwZhtfo6KEW/cd0Wg+2XDLLv2R/CNVJ/WET
	 e0YXaWbg4iO1jjnDwUGganVlooKSbM4XwihOA+K7r8T+eiXTqHwKXnGdWVjMK5cFzC
	 XU7ROGPTRHDG1m+6RpZYcLirC4GVrEmKhKDvfdDJQMuUoJCHcC0elpXjN2O65zRz3m
	 eKx1Objl+3YTO8DULPbxIYp3COlEcGa6OK+ycvCRHQvUSNI5loTBEr86GtCKGSEONy
	 0gNl2um6LCWNfDaQWCNKh1ztlJ0RaL1bVUdIEQz0ecYBBSza0eWneBnCGO8NHmJtoU
	 l62Y82315FZow==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 16:07:33 +0200
Subject: [PATCH v2 3/5] mmc: sdhci-sprd: Constify struct sdhci_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-mmc-const-sdhci-ops-v2-3-262f81faadac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=krzk@kernel.org;
 h=from:subject:message-id; bh=6xewGZjyB3FgtC9pR8X505+HKwYWfSCoiugoRhC/E3c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG+M1HdNDD842vKUlU46JiescmqInXpP7Rg0m8
 f3vk1+YlyuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhvjNQAKCRDBN2bmhouD
 113oD/4peDmVoH23QGbpugtwZCbLonWFjZnrWL6FlULLtscTG3SnvdG1PXRbTh3sRUGXsfYF4ez
 GAdsFpgpVNF1sHlRE9xty52FVD6TxzD4yDRCuEvNdWFV1ARsoQ7yO9BWQFILTZ5o0AkMXlfBwOi
 kq0gw5N+bkcO1g2423yju97ySHS/0M/vhFm8UTCJmerk6cUJdm7Z1m8J6Mqz1R3f+Vy+aeVwT3L
 YB8lvddhRTyBqlcXGseNfQosEv4Bl1gSJm23Y7FMbVtJvz4VpmTTBNcLo2wFwUuf9QyJCjKRGxo
 bWaSpXuKTLy4Jk8JcL8OqKkRzmgd+xs8G3feN9R1k11VoVOHcAcqfslETC5Zmcn3OpTTfmiktSu
 pUkr6DQOvXbW73F2yeebb4avOS/9Q6pvXn1UrGO6bbJ8a0zAR6QG9kfip1FUKXKPTIEVbDPR4Ob
 hJx83nnNQ9YHui8fo01lwYFgFHtxbLFo/dG/QHgEL7KOGPErWaAlVchWmG7ZRroihV3m5CFAd0z
 LKZWipyQw132CAZkvhqitCM0BYeRMGYT/76dyEvGfQKjqUJB2D8XBzW/H5Fqcvj8b2PFh7Z9ItX
 OAcaBuoyJGY2k5nnD9e11HO68fjAhxhxnf2fzzpr6GTuPsQMH2wmRTCmMz25jB/K4bPeGRp6mu4
 AWVPSSuKigRsdiw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The local struct sdhci_ops can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 685b1c648901..8776f4287119 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -439,7 +439,7 @@ static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
 	}
 }
 
-static struct sdhci_ops sdhci_sprd_ops = {
+static const struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
 	.write_w = sdhci_sprd_writew,

-- 
2.34.1


