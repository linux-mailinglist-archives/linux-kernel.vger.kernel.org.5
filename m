Return-Path: <linux-kernel+bounces-144184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F288A42D5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE991C20FD0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9969C6773D;
	Sun, 14 Apr 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaQ6dpy0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6AC65BAA;
	Sun, 14 Apr 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103692; cv=none; b=YHvsDFafClte5QiXkDxdDy5LsfL2LIsILF9U9+wywmWqh7JxtnZU6Q4Q5tmMNhwWWtZSJPyRbuzffVjLCaneCwUoFYf9NUHniY3qd1lQH0ZnOS5czRKA0kAS4fwKsJzJV1CXqDwgxNp4jLe3olSDJjx9tcMAmLbkC0Vr7yrYaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103692; c=relaxed/simple;
	bh=uD+ViLOa9S8ut1fdu47zbr3AGnB2izGuU5i0gc4OfAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pQUeFDh9DPpoW80kwVPDmRaZ+HmBe7FLVykMkqFbrgJTa1uIHDqeB3f9/VqKlB8bkls/kdKOZr1G8vuyuSJUrlcdVcZSqBnAONKiKUu7JMxogM9Z/DSLHBSjPwVk0nquOKcBgwGGbVUY9lKu7NJplRROkrwe9+9uo9WUSqDtWZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaQ6dpy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D3EC32781;
	Sun, 14 Apr 2024 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713103691;
	bh=uD+ViLOa9S8ut1fdu47zbr3AGnB2izGuU5i0gc4OfAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oaQ6dpy0/bZFcrzx0xa6ZdKbwZ+HWYPcJpZbV3mJlc9Dq36IRF4LECxztrPqtiNPC
	 7XVN4abjlpbnm8/njQc1ykYGjnh/adrBNBtj1xIAb6PZRu1j1rziVUHcobqRsbPh9r
	 BvfAUCOHJiePZQwdDsQo0NU/jOQT3+DQUP74PmizQLB7j5L750DQ3iTDZLFQIATRWG
	 U0qADXTKUBgiN5/L2aN4Je1lVHnt0VOTGlYjnpI/hTQFHD5HZjjGgpcAE8Oe4x6Dl1
	 hLBQaly2j27I6y50BVtTx9hS569sX19l54TYnChlmyHBS3u3XKm6JdDo06Xl0dd8Zq
	 9Z6nDTnohqfcg==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 16:07:34 +0200
Subject: [PATCH v2 4/5] mmc: sdhci_am654: Constify struct sdhci_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-mmc-const-sdhci-ops-v2-4-262f81faadac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=krzk@kernel.org;
 h=from:subject:message-id; bh=uD+ViLOa9S8ut1fdu47zbr3AGnB2izGuU5i0gc4OfAY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG+M2zh1fbUOLMtUAgWd7ZaDBybdesu8Pqk3Wr
 ulA4whRsXyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhvjNgAKCRDBN2bmhouD
 1yYND/95N3oZCFrYMsBGYpC2+FcOAL1vwWFiaX2dVzYix51XGD4L+7ljS4t73rlJcOghBqeCq45
 iCWZbuAH1Z8kjiHgOxqEtuGs4fPbqpNLowqd7gKj/rBT8F5Oo540Crx+XXwsscM6eELN5pdZbo9
 zrc0UBIWtlFX+GmJzFXwJ9zSezRhLL4NKBasO7/fp4Uf69gOQ661N7wgFAWvjLMN8OgcyFAMcFx
 z1Qtyu+EhbbUjs2TFCQZ1s5DWaURgdZfgOBJlMXKosu8lYSTewf/XBXoQvQ+3ynoN0F8Ev7Cxva
 oqdwjCZho35QWIKTqI0LrdCHf7x9llXmpClJKA8BMhOtU2A+eWz7UGJNRXukem0s/8r27ceyyOb
 x4ZCzemfdZS/ll+imkOnmbTJQ2jjZizHWXW96EtEbKFrl8XWfSmFExVriWKG0B439bswW+7EMrY
 /kVR5Mp8EkM1VvYumIpmXFdWM81LpWEo0EzUmSJDOPxLD7l76CwHnOd6LRRMDYZu46CNtICegnv
 MGSb/h23VixJvHV4wjpja3ZBmCNSoRsuV7yKZMCBkoSSAY2rt4Nw8s/ZMKzstPknVSumTrYF/bW
 bnbJG686tBvYyXX7Nnlk3bPO9hXPz5u+1hZOr3oF1HGgbFrO9UN/SOcLkSfGDdyvi7GZMAMEXS3
 HbeDvXXuNf7T+nw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The local struct sdhci_ops can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci_am654.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index ba36123e4ccc..17ad32cfc0c3 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -543,7 +543,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	return 0;
 }
 
-static struct sdhci_ops sdhci_am654_ops = {
+static const struct sdhci_ops sdhci_am654_ops = {
 	.platform_execute_tuning = sdhci_am654_platform_execute_tuning,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -573,7 +573,7 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
 	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
 };
 
-static struct sdhci_ops sdhci_j721e_8bit_ops = {
+static const struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.platform_execute_tuning = sdhci_am654_platform_execute_tuning,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -597,7 +597,7 @@ static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
 	.flags = DLL_PRESENT | DLL_CALIB,
 };
 
-static struct sdhci_ops sdhci_j721e_4bit_ops = {
+static const struct sdhci_ops sdhci_j721e_4bit_ops = {
 	.platform_execute_tuning = sdhci_am654_platform_execute_tuning,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,

-- 
2.34.1


