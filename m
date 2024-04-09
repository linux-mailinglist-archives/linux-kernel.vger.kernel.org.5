Return-Path: <linux-kernel+bounces-137361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5289E108
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5C81F20F00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DD71553BF;
	Tue,  9 Apr 2024 17:03:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CD15380F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682192; cv=none; b=UhTrIxkboRE0fZLWcSyWiJVkjUhxYhhugmZ0nJqG2jkgow3wSaGGQF/0RSvp7eHZZW9VpoRqGoNkrws7Xku37d3lGpMXpLFdF6+yogd1LoCgpzohgfrwDSnhEg54t55Q1PaoO5i5FT8vnvw9XZpsfV/oHKwO0j5t8EMV1ztKHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682192; c=relaxed/simple;
	bh=d+JCLobLbz8LzeA9bj7f36+VkqHhhgoup2ObWHc4L6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXWgv4f37gkMcNr2h//2Wwpt039EX5X36cTZ1oQxZ8y/bfQjDVN94OGpWp8zER1zHHq2v8nqXsIV8bKAb+eKN6IpldKTv31MkghfZixNJshKDeHB3RG0+DIp+DHzs4o6ThlrjbeScD0cpypG7S0FRNRyfVhRfiROlHu1fhan90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsD-0003vX-IE; Tue, 09 Apr 2024 19:03:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsC-00BKyG-UX; Tue, 09 Apr 2024 19:03:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsC-00H4tc-2m;
	Tue, 09 Apr 2024 19:03:04 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] gpu: host1x: Convert to platform remove callback returning void
Date: Tue,  9 Apr 2024 19:02:50 +0200
Message-ID:  <7e31909b1e536f0ddbb060b1aaa0a9e943687c8a.1712681770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=d+JCLobLbz8LzeA9bj7f36+VkqHhhgoup2ObWHc4L6g=; b=owGbwMvMwMXY3/A7olbonx/jabUkhjTRkt2NYWf5039772M/ZNqaeVP0RWnEVhNvPR29iH9HE /81lh7qZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAioY/Z/0rsjL2WOcPZt1C4 rNzs6k3F9LQEw/Sp5xSPHWj7x8Vk87vK5T/LiWfFnyvEVR89mCaeF1upJRa5RsI0wu2lH2O36UJ ppad23H9DLktceFZ7VUX7z9+MqikGa7buTNzwwfLjKc4jqemiT7k1erN4jFojjya2vr8Yrr5YPZ rTRjyi63S7/YvXtpcrnX5GWlU6VUddy/DL9FTN5749c9OKLTyX40PYMqwk2s5PDfneW6494VhVb aHVtNum707bHA534klYMvPRtQNbBIICnbYpPXr62uFxedEC/6p1e1qd3rv4m05zELNY5MW3Zipb Qtnb3bo+nzoyl011PDLz8fkGN7UfkXXKlhvPvys/cPwyAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpu/host1x/dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 89983d7d73ca..bc02aa28458b 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -653,7 +653,7 @@ static int host1x_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int host1x_remove(struct platform_device *pdev)
+static void host1x_remove(struct platform_device *pdev)
 {
 	struct host1x *host = platform_get_drvdata(pdev);
 
@@ -668,8 +668,6 @@ static int host1x_remove(struct platform_device *pdev)
 	host1x_channel_list_free(&host->channel_list);
 	host1x_iommu_exit(host);
 	host1x_bo_cache_destroy(&host->cache);
-
-	return 0;
 }
 
 static int __maybe_unused host1x_runtime_suspend(struct device *dev)
@@ -754,7 +752,7 @@ static struct platform_driver tegra_host1x_driver = {
 		.pm = &host1x_pm_ops,
 	},
 	.probe = host1x_probe,
-	.remove = host1x_remove,
+	.remove_new = host1x_remove,
 };
 
 static struct platform_driver * const drivers[] = {
-- 
2.43.0


