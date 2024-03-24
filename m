Return-Path: <linux-kernel+bounces-113092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0689888166
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A405287622
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BF7153BC7;
	Sun, 24 Mar 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj2RYXs/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7BC15350D;
	Sun, 24 Mar 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319900; cv=none; b=RApWwcH3l6JVwzswuPtdutABEFgHdUrijtiSr9KusQCyrneUPEULP9hQ5dYqk14ZrC3w12gWhZDTEd4LHpPKARW6xHwj5Ox2gcD5N9pHvptxLAajeFwT6zdWOybuTJU/+4tah0OqfPyu5H20z9gPpZ4yRtwB2YKHF0BkgIe2lhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319900; c=relaxed/simple;
	bh=QF9tLI7gf/p9jDhZggGqID7Hb+pxEccMgbICkwA6//w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4wA5+VjFKXNcbxxulqxhhv1IMxjHNV46woJrl3zsXDTdlukGlES2FUkbvVg2/Su76JveBiEb0hyeEqqfMV0OK91WCl5yeraZobcF3psgPayYStljGtE44UL9xSY0kbjgpGKxG5C9FOB/I87ufj++MU2GDfCN3Zsx5QdX6FZc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj2RYXs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63739C433F1;
	Sun, 24 Mar 2024 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319900;
	bh=QF9tLI7gf/p9jDhZggGqID7Hb+pxEccMgbICkwA6//w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yj2RYXs/dZhMHGWQJYvY/ljBGNjmYjkwkqTILk36ps8DBIL19uu1/pDG5hAWzABYB
	 3yb9pN4IolioDNHZO0YunA85yqZiHMotdc4ZkNEbAgr8YALWJpia4POCSFgxG3U67y
	 CjF2NRvN9Z0LkM3q152fQIJIPZEdDGSWXvPyWVBS1a+Nh3EU/BdxTMKpEA8szBtsgj
	 FECbFbFG+J+vjPnuicgV2LCkC9AljfYNmEsakd7WbEUgFOTaXqXgiS4tZFDJoJMTUs
	 j87QttewPWVBWaNHQGf4VLLkvyM1a1e1P9qrp0k3sXoOEcmsbWO5ZkkgyuGSr/2/VI
	 tRyzH73ILbMQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Raag Jadav <raag.jadav@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 205/715] pwm: dwc: use pm_sleep_ptr() macro
Date: Sun, 24 Mar 2024 18:26:24 -0400
Message-ID: <20240324223455.1342824-206-sashal@kernel.org>
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

From: Raag Jadav <raag.jadav@intel.com>

[ Upstream commit 7cfce2b80d5ff7aa713a7710bfe3a562707cb226 ]

Since we don't have runtime PM handles here, we should be using
pm_sleep_ptr() macro, so that the compiler can discard it in case
CONFIG_PM_SLEEP=n.

Fixes: 30b5b066fa83 ("pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240212130247.9985-2-raag.jadav@intel.com
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-dwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 4929354f8cd95..a4a057ae03ea2 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -120,7 +120,7 @@ static struct pci_driver dwc_pwm_driver = {
 	.remove = dwc_pwm_remove,
 	.id_table = dwc_pwm_id_table,
 	.driver = {
-		.pm = pm_ptr(&dwc_pwm_pm_ops),
+		.pm = pm_sleep_ptr(&dwc_pwm_pm_ops),
 	},
 };
 
-- 
2.43.0


