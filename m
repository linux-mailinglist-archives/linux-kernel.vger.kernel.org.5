Return-Path: <linux-kernel+bounces-144180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BA38A42CD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C97EB2129A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E10E5C901;
	Sun, 14 Apr 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQq5wXgL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856045C8ED;
	Sun, 14 Apr 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103675; cv=none; b=okM4XLcZIfDntWSdj1pnAcLJCnrRI+/b4cjg9liBo6jZcE0bnlkq9nNor9VvG4JmRYncDO9m/s0pu3cnSH9gCBiSrlEhGgP9L0AqpVyFiOqkV0XSw/pznMaM3cE9zGaumnG7CrY5K/j3n18C8Wj761iYfCMfmqmalzMt5j9UcOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103675; c=relaxed/simple;
	bh=LBKjOflq50K6oHxx+hmXhVsiE+uyRxdZpov79gdUMgw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AIgPaMt7eczy0r7HqO9h7G+KOWx7T8/X5uSFBrkK9kJ0YP0JmEj11VdbDhEmB1iGjtECyEckhKW8DqphT6GoMs1XivieDNnFWrWBZRu9GJNR2TGaDQJsenESlRcXPwJVSyxNoXjJmZTMD5emt6Hgavlh9ABTT55J2mOzvBGpL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQq5wXgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48514C072AA;
	Sun, 14 Apr 2024 14:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713103675;
	bh=LBKjOflq50K6oHxx+hmXhVsiE+uyRxdZpov79gdUMgw=;
	h=From:Subject:Date:To:Cc:From;
	b=AQq5wXgLq2ZwsJWKyKF84W0raDyljWXwhRJ7pT/ICFBLYWL+TNMJ0qrWUGGzRKNGj
	 AkxRdqkJhLIw1hbbZrsfq5jmB51v1rlYV2kdRJiRYTHUlNF4tzJroL8VzhBmOgTRIL
	 xRQHL/Yd+gPjes20AkEu2QET9iPS9/fbKeORd0XAMlCZH1pKQDK0Oo52raEPdd9bqi
	 hwBOWTlXRuHNFJOx+VKehO86mC1KsTHYNyHbSo2uJ4ynohkwSy6G37Dvpbgo0ujpxW
	 3J7jS47Sbr/BtIJX9O0snnhBYvw6xYrsJw1t/YnfQQWLahECwGkGdIF6jNGpOOR9qj
	 fNqVDGZ4jIBng==
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 0/5] mmc: Constify struct sdhci_ops
Date: Sun, 14 Apr 2024 16:07:30 +0200
Message-Id: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLjG2YC/32NQQ6CMBBFr0Jm7Zi2FCiuvIdhYcoIE6UlHUI0h
 LtbOYDL95L//gZCiUngUmyQaGXhGDKYUwF+vIeBkPvMYJSxymqL0+TRxyALSj96xjgLelc1tXG
 uVMpCXs6JHvw+qrcu88iyxPQ5Tlb9s/97q0aFunFV2fa1U215fVIK9DrHNEC37/sXCMn0iLcAA
 AA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=krzk@kernel.org;
 h=from:subject:message-id; bh=LBKjOflq50K6oHxx+hmXhVsiE+uyRxdZpov79gdUMgw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG+MmQgQloMmnXNmDSlxCABiDXCuVEgzoNBToc
 bL+CgvzYvSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhvjJgAKCRDBN2bmhouD
 1zmhD/oCYsbpYriZi8X7FA2IViSSujmcmcbuSE2vo2RkmdcE3EHMaeO1F8x91cJPk6ot5g7o6Ux
 dK1u7o62bFwPzMmmdXjFDV/x+STTA12JHOy2afIqY7onP9qSp6YG3K4aIv9yVgHTFX3sr3qwJe3
 YuGNk7WZQYvM8Il9QXAEoTB1wCwSB3BwS/DT6lc84L+J0VYFrJJgEOi2T1hCvsuqiz74yFQKGtN
 zjMwVtgvffa+qbyRwDKqElyQ+AK3bBAe4E1E/MZcvpAZqmFPa0WfCIACYk4pV2DSl3Dc9+EMipi
 y6C+nM8xck3oQ1eZW5nOppTZ2q675skhebpVqpeiFS8jff7+mKNCbL7sQ1fsOn1CncWLyz7PnKc
 1RsFVVtbyym1GrocAz3jsyIHxPJMuPlA/Gs7+x2PlmHr0K3trHBVxuKWojl/83XYbis2Uc2J6s2
 We2SI2d3k8Vb/vJpr+bexqxH2zPzzNGiZk+Be9c5Bb3CqDm9nSmkIdvju0A3MOqz9r2yeoUiNuT
 LT/tTmb22pVkdypnhkh3Ulgnj2PuECNNCqlsKK1RMrBRHstTb+FKsM378ZfnRHZE2JIgJeZnZtV
 iANpcI4hlv43T3ktVmhBr9dQ1X7o1cbrZ1TobneVL4Heuq0MfTj665l5nz5vDz/ajt6Kr/7QJ/6
 pYgCWjo9EAq5Uug==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Changes in v2:
- Patch 5 - sdhci-s3c: add __maybe_unused, reported by kernel test
  robot.
- Link to v1: https://lore.kernel.org/r/20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org

The local struct sdhci_ops can be made const for code safety.
No dependencies.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      mmc: sdhci-esdhc-mcf: Constify struct sdhci_ops
      mmc: sdhci-omap: Constify struct sdhci_ops
      mmc: sdhci-sprd: Constify struct sdhci_ops
      mmc: sdhci_am654: Constify struct sdhci_ops
      mmc: sdhci-s3c: Choose sdhci_ops based on variant

 drivers/mmc/host/sdhci-esdhc-mcf.c |  2 +-
 drivers/mmc/host/sdhci-omap.c      |  2 +-
 drivers/mmc/host/sdhci-s3c.c       | 31 +++++++++++++++++--------------
 drivers/mmc/host/sdhci-sprd.c      |  2 +-
 drivers/mmc/host/sdhci_am654.c     |  6 +++---
 5 files changed, 23 insertions(+), 20 deletions(-)
---
base-commit: f67245b3062cdc225b37003085bdb2916e1670b6
change-id: 20240414-mmc-const-sdhci-ops-c85762883004

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


