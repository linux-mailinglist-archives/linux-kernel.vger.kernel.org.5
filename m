Return-Path: <linux-kernel+bounces-16011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE58236F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CF81F25B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B351D698;
	Wed,  3 Jan 2024 21:15:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8031D681
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 88FFB83D74;
	Wed,  3 Jan 2024 22:08:57 +0100 (CET)
From: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To: Arnd Bergmann <arnd@arndb.de>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Lubomir Rintel <lkundrak@v3.sk>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	zhang songyi <zhang.songyi@zte.com.cn>,
	soc@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC RESEND] soc: pxa: ssp: Cast to enum pxa_ssp_type instead of int
Date: Wed,  3 Jan 2024 22:06:03 +0100
Message-ID: <20240103210604.16877-1-duje.mihanovic@skole.hr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On ARM64 platforms, id->data is a 64-bit value and casting it to a
32-bit integer causes build errors. Cast it to the corresponding enum
instead.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
This patch is necessary for my Marvell PXA1908 series to compile successfully
with allyesconfig:
https://lore.kernel.org/all/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr/
---
 drivers/soc/pxa/ssp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
index a1e8a07f7275..e2ffd8fd7e13 100644
--- a/drivers/soc/pxa/ssp.c
+++ b/drivers/soc/pxa/ssp.c
@@ -152,11 +152,11 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	if (dev->of_node) {
 		const struct of_device_id *id =
 			of_match_device(of_match_ptr(pxa_ssp_of_ids), dev);
-		ssp->type = (int) id->data;
+		ssp->type = (enum pxa_ssp_type) id->data;
 	} else {
 		const struct platform_device_id *id =
 			platform_get_device_id(pdev);
-		ssp->type = (int) id->driver_data;
+		ssp->type = (enum pxa_ssp_type) id->driver_data;
 
 		/* PXA2xx/3xx SSP ports starts from 1 and the internal pdev->id
 		 * starts from 0, do a translation here
-- 
2.43.0



