Return-Path: <linux-kernel+bounces-11260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CCC81E3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC752816FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ABD5A0E8;
	Tue, 26 Dec 2023 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBTDUQqX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133859E59;
	Tue, 26 Dec 2023 00:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4946C433C7;
	Tue, 26 Dec 2023 00:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550273;
	bh=l1ZGCzegb8q1Eycnu3c8u1xiEov4Q4BmErjk1cmFIOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBTDUQqXkbf7Khr5Abc7MkEPbmeV0lOQrwuglkDnz+nwvldg6vPIo00E6OGcyjR9e
	 +ZdoJ6WEGzUoG1a0t1U/X6Ac2TfezdL0a1IgIQlx1oMLDcY1+1HbNzcTYzv4eOFYHc
	 zixeK1FSAOG4AXq7rXhZyc4wQ3ifxbGackMj1h+otneouO1GooNn72FTiGLWoFwZXZ
	 lB9nqpnoU+S2LDitKT8/bti9W5m06+Yc8+0XRjbytcn1zll0zPa9kHip7klLRglqVr
	 mJQZkNWUDVefulJxR5xGt9DtPszzJJnwUm3qQ29FxNGkc6scruXyRJx92ztZjb9Uzj
	 o/BrNd/EtjQBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/11] Input: amimouse - convert to platform remove callback returning void
Date: Mon, 25 Dec 2023 19:23:53 -0500
Message-ID: <20231226002420.6303-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002420.6303-1-sashal@kernel.org>
References: <20231226002420.6303-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.145
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 42b8ff47720258d1f6a4412e780a480c139773a0 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231201133747.1099286-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/amimouse.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/amimouse.c b/drivers/input/mouse/amimouse.c
index a50e503548323..cda0c3ff5a288 100644
--- a/drivers/input/mouse/amimouse.c
+++ b/drivers/input/mouse/amimouse.c
@@ -125,16 +125,15 @@ static int __init amimouse_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __exit amimouse_remove(struct platform_device *pdev)
+static void __exit amimouse_remove(struct platform_device *pdev)
 {
 	struct input_dev *dev = platform_get_drvdata(pdev);
 
 	input_unregister_device(dev);
-	return 0;
 }
 
 static struct platform_driver amimouse_driver = {
-	.remove = __exit_p(amimouse_remove),
+	.remove_new = __exit_p(amimouse_remove),
 	.driver   = {
 		.name	= "amiga-mouse",
 	},
-- 
2.43.0


