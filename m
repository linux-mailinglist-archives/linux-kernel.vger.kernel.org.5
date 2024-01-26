Return-Path: <linux-kernel+bounces-40538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613CC83E21F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DCF1F24AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927E9224C9;
	Fri, 26 Jan 2024 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hnNMvmH6"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5D21A04;
	Fri, 26 Jan 2024 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295685; cv=none; b=FN9OGtKo6IRB3k1Ph/eSRQSKbLGl3oJNi9tghQToS5KUiBCGKleep1HRjTPzkJgNp8L5UheO/wj9bKVNhzYkdhBLEwIjr39Ay17vm/tYVy0js6TM4RRm0/2TM0zMOWFRMD7qOd32f+pfDXpUHhm7ESBYzgN1jJbZQraEvN874CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295685; c=relaxed/simple;
	bh=85dAb/dDmFrF4oFSp1ZL2gDWKRF1dNwmGB3QvaBcPws=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gpkP7V6jpk0e6Ml0zC+ZXi+PeW0OIXFMt89cTwYDT9NEbf9YA87kee4KDwnTgnPoQ/cIx0GGg8L6kQWXFPctpBcZc3mawA0GOU4Dah9XcqdGFdV1kaiB2QKeBs1ndOYt83pkQNCPpeHDmioWgV7XNoTXGOsfwqLHID1TWIVNYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hnNMvmH6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40QJ1BIB095643;
	Fri, 26 Jan 2024 13:01:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706295671;
	bh=NwF79J4QERfbFo+oO9aZ7C3Ltm7a+qI/pEWqX7Hx6fA=;
	h=From:To:CC:Subject:Date;
	b=hnNMvmH6b8VmM6hHqk57ZfNx9ezkYLMLYZurIy8++gnVII33BgVVTbJ7vjKFUJoWI
	 GWnU6UQ+CWwvzCGZ2SxER5Jwujgdi+/roMWg1DyjV7yApgsv5h3YTkdDYFm7SwWkZp
	 opxSnwqJZ1BKKmArDT0pqK5yTfoB67hrSVa+hHaA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40QJ1Blh057870
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jan 2024 13:01:11 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Jan 2024 13:01:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Jan 2024 13:01:11 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40QJ1A8L013671;
	Fri, 26 Jan 2024 13:01:11 -0600
From: Andrew Davis <afd@ti.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>, Yangtao Li <frank.li@vivo.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH] mmc: pwrseq: Use proper reboot notifier path
Date: Fri, 26 Jan 2024 13:01:10 -0600
Message-ID: <20240126190110.148599-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This driver registers itself as a reboot handler, which means it claims
it can reboot the system. It does this so it is called during the system
reboot sequence. The correct way to be notified during the reboot
sequence is to register a notifier with register_reboot_notifier().
Do this here.

Note this will be called during normal reboots but not emergency reboots.
This is the expected behavior, emergency reboot means emergency, not go
do some cleanup with emmc pins.. The reboot notifiers are intentionally
not called in the emergency path for a reason and working around that by
pretending to be a reboot handler is a hack.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mmc/core/pwrseq_emmc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index 3b6d69cefb4eb..d5045fd1a02c1 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -70,14 +70,8 @@ static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
 		return PTR_ERR(pwrseq->reset_gpio);
 
 	if (!gpiod_cansleep(pwrseq->reset_gpio)) {
-		/*
-		 * register reset handler to ensure emmc reset also from
-		 * emergency_reboot(), priority 255 is the highest priority
-		 * so it will be executed before any system reboot handler.
-		 */
 		pwrseq->reset_nb.notifier_call = mmc_pwrseq_emmc_reset_nb;
-		pwrseq->reset_nb.priority = 255;
-		register_restart_handler(&pwrseq->reset_nb);
+		register_reboot_notifier(&pwrseq->reset_nb);
 	} else {
 		dev_notice(dev, "EMMC reset pin tied to a sleepy GPIO driver; reset on emergency-reboot disabled\n");
 	}
-- 
2.39.2


