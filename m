Return-Path: <linux-kernel+bounces-144016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE38A40D6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71572B21562
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB523775;
	Sun, 14 Apr 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiZdk+Vq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4922F1C;
	Sun, 14 Apr 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713078941; cv=none; b=SW0jRloE4rzPNC7C2S7q4gHWJBT8PsjOwjmqQ7GdSVUSEyI/4EE8+EEGM0ZqobyINTFRMuJ6C4v20aIUSovzh/qJ9OTpn0DlDJkybjkmD0eWnOJW8UvWlpF4hyhtJLe3Hna9WEkQkZHYp/m2gWMubIsJms5/m2cKQjBGCaIvBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713078941; c=relaxed/simple;
	bh=6xewGZjyB3FgtC9pR8X505+HKwYWfSCoiugoRhC/E3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+AdraFdUW2rR68xQyWJCp2DJZuQ88XElIxHMhjfvIGLWjUjwRCBWbilg6/FBqekI0GtpLZ0T4GnEjnCzDZd0WOsHTTLwimA4hUvRc3LCQ5bviEsZpxomuqD26G5C+sTME5ztExF3YA80+n0XqC8YWs/yQJkCiKLqbXt2FB9YTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiZdk+Vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206B1C32783;
	Sun, 14 Apr 2024 07:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713078940;
	bh=6xewGZjyB3FgtC9pR8X505+HKwYWfSCoiugoRhC/E3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RiZdk+VqjlMLeLqQctODOqA64wKRCEc9mbCR/17zAKmdLMdkoJkOyvO+a2KmJ43aH
	 dD9+LXEyC1bqOXLLnlpE8DLVcVNXg/alEedb/lFfGIi+XYzF09hJns4Q/XoG7H6AqD
	 21849oMeAmRrYUoHlXLZ8ALMRCO2Fb+y4bX1wjTOzHXrgPlYLFS9glms23N22grNnx
	 +qXwclSWCgXEgZ3ZyK1HvUzko+cjv4ArMQSbL80xo2N6YhyTcXOZNz9VceitfTfqDj
	 q7Fv8ZxPoDTm/B3pWtQsV09ksqhcGeuNT39Ubh7G72Fu4yLln+uCVXvJdbcHD2SUlp
	 reCo6ssh48B/w==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 09:15:16 +0200
Subject: [PATCH 3/5] mmc: sdhci-sprd: Constify struct sdhci_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-mmc-const-sdhci-ops-v1-3-178539d68093@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=krzk@kernel.org;
 h=from:subject:message-id; bh=6xewGZjyB3FgtC9pR8X505+HKwYWfSCoiugoRhC/E3c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG4KLqqTzbFGHsPVVDq2DBc6QTf8lMHeWUdHF6
 +eH8WCI7fuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhuCiwAKCRDBN2bmhouD
 11WkD/48GPiWAcr9XYxz4bEQK1AUdVjRLQAHbMgrQJSaKO1ItWrJNES/ihvPi+OOupU82wkrNAI
 fJYL7bySFpteMVI4gqBWM+7SP6+7SSy9ZCxxxCx9wYR1AojbGo+r1U0fobqFGq4th5gnkoN+Z46
 F0pjqKcgCYGJx/Pc+p4aDJhtT7rpTnXa0ZAZUlbvRtraSxbAC11GTPS4lkrf7QWlaJQ4L2gqIv9
 WEDf0SNeRjbcgJCR+JoLRWBFJlOHGk7TF1lM3hzuUqRqNjJ29WD9SoUAeTAf39XchcGmpnNlpOO
 oPaHHTrM7C9zIRJmRCD+0CZjWbUv7GybWnjzMhhH3CCXBNN3SPBmygt05nTWO51hZv+lAbkUIbH
 +ybaZ1EiaJus+evgMaRclxU+ECPokjaLbesqm/WGWoEZUCs3w2TGGK83Sqwg7+iqVmAlPOGIfPs
 Fzy3lEbW3N1Q0JGv0t0YGqFxIttnGgXWcdOrE+Z4/cghU2kB+8lu+HPSK75rySxs9GexiL1A4WR
 USWdTxmlU/4BbSsOreNKK2ow2IuYSng3yFwydjvWrmxrvXdl8G9UgWekjk4M5mUo3CdLcwoAwrU
 8lmzDXwFSM8mQqNCy7kzzP+NhWGqxF6NcqDfdCDrZcr3G1nm43thYi2NUUoIj2kYzM3CZ+ZeRag
 mf9DcI80mTmF4og==
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


