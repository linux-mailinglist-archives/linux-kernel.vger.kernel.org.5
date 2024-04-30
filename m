Return-Path: <linux-kernel+bounces-163733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE10C8B6EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3DB1F24353
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4262713D63A;
	Tue, 30 Apr 2024 09:58:54 +0000 (UTC)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BA5127B70
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471133; cv=none; b=SQGVkTWNYabFSs73ugFrBDeXcnlfW/Z8IfJDNPneZrEtkqkwGr9FFbRbAx8zvmUAWzVYggfNxJYHLPkDGFyhfVDnj37vRSt/RkHyMvxeU2SORIORka7vzJOxVtLTOiMA5Pu9Jj2Exg7bsGOLkERGCw35/qh/gxBfqKfOwO2+IF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471133; c=relaxed/simple;
	bh=wYJBsZ1Psy2XQjY+LZVkvy93Tzfa/JKnhg4Y7abcKlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8QhsL/2g3+qMmya0bXGSBDj8TnJI/oxI4K5Y0rptTY2Ot7C94kYjtHsiLmJHwge8u3+4ZrlJKqXQ4BddLQDkabrz0vWVQ5s0egVDLBKa1UH3NlfFKLRDVFmJFGp+Dn+E4bVgiWrxAPazvP+WAQG3ErGyrOKTMy/RD62nHyoB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367343:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 30 Apr 2024 17:58:31 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 17:58:31 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 17:58:31 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <alina_yu@richtek.com>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v2 4/4] regulator: rtq2208: Fix the BUCK ramp_delay range to maximum of 16mVstep/us
Date: Tue, 30 Apr 2024 17:58:27 +0800
Message-ID: <1777b18c0faa1f6b7196630e679a03362686c301.1714467553.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1714467553.git.alina_yu@richtek.com>
References: <cover.1714467553.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The maximum ramp up and down range of BUCK are shorten
from 64mVstep/us to 16mVstep/us.
Therefore, the RTQ2208_RAMP_VALUE_MAX_uV is modified
to 16000uV in this version.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 drivers/regulator/rtq2208-regulator.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 97a97a4..39dde4e 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -53,7 +53,7 @@
 
 /* Value */
 #define RTQ2208_RAMP_VALUE_MIN_uV		500
-#define RTQ2208_RAMP_VALUE_MAX_uV		64000
+#define RTQ2208_RAMP_VALUE_MAX_uV		16000
 
 #define RTQ2208_BUCK_MASK(uv_irq, ov_irq)	(1 << ((uv_irq) % 8) | 1 << ((ov_irq) % 8))
 
@@ -147,12 +147,11 @@ static int rtq2208_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 	 * Because the relation of seleltion and value is like that
 	 *
 	 * seletion: value
-	 * 000: 64mv
-	 * 001: 32mv
+	 * 010: 16mv
 	 * ...
 	 * 111: 0.5mv
 	 *
-	 * For example, if I would like to select 64mv, the fls(ramp_delay) - 1 will be 0b111,
+	 * For example, if I would like to select 16mv, the fls(ramp_delay) - 1 will be 0b010,
 	 * and I need to use 0b111 - sel to do the shifting
 	 */
 
-- 
2.7.4


