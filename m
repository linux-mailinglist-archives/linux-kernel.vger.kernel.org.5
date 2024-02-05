Return-Path: <linux-kernel+bounces-52030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2284930C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4F7283AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A70B64A;
	Mon,  5 Feb 2024 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cOON0SHv"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154D0AD32;
	Mon,  5 Feb 2024 04:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108600; cv=none; b=eITWtNZQGRipG0CHGtmCTyjhlTuU4Mmmk4LAoIo9Bsw5Ed86wJOVe1pBMEpvcPBIWeNkVG/hCsL2hggGW/OPyEhF1IEzmZfEfHPEeOyXDtDXXwTJ78GF1w9zglAebwEuefkSj2j/34VHNLh/5YTh8416YCd7UkbseVSyaHrK+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108600; c=relaxed/simple;
	bh=NduTLHFnZfhCN2CkJ9oqz73qOh10y1E+6FLyT0zEKO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EdqwiqhH40g+E1KDV4zvWh41ASQy+7XnpODDEJ0BhYLbxbaxC4AcovFFtxvEwM/y88Qea600VzZ4sMxY75gOeabL3YMEeRETn8Gxgdx4Z08LzIOLye9U/ZdoiRrtMRdKynymlMdiOb8dbmrxfJjrxB1yam+3sXBMsa+XZ+FOmb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cOON0SHv; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4154nElG022636;
	Sun, 4 Feb 2024 22:49:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707108554;
	bh=Xtnfb8xnQNhu/YXCkFubO57gi1E2WQInflCGp92loXQ=;
	h=From:To:CC:Subject:Date;
	b=cOON0SHvZCUNGkGhchQdw7q+4bpaFV9mnhg0AQDO9GSCKkxzkOuEaWO4QqUa16+49
	 8k2/LwQs8SjG+mM/LxQCT4P5MFcvljlwbtCJQur5gjTgjPJ/wlsLXMot1TxnIoq7XD
	 VEOLYb5P1K82DJE/Hbm4pkl6bK9Gv1MupKij/z+Q=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4154nE5h031263
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 4 Feb 2024 22:49:14 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 4
 Feb 2024 22:49:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 4 Feb 2024 22:49:13 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4154nA0K035269;
	Sun, 4 Feb 2024 22:49:11 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>
CC: <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v1] clk: keystone: sci-clk: Adding support for non contiguous clocks
Date: Mon, 5 Feb 2024 10:15:58 +0530
Message-ID: <20240205044557.3340848-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Most of clocks and their parents are defined in contiguous range,
But in few cases, there is gap in clock numbers[0].

Driver assumes clocks to be in contiguous range, and assigns
accordingly.

New firmware started returning error in case of
non-available clock id.  Therefore drivers throws error while
re-calculate and other functions.

In this fix, before assigning and adding clock in list,
driver checks if given clock is valid or not.

Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")

[0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
Section Clocks for NAVSS0_CPTS_0 Device,
clock id 12-15 and 18-19 not present

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Original logs
https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6#file-original-logs
Line 2630 for error

Logs with fix
https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6#file-with-fix
Line 2594 

 drivers/clk/keystone/sci-clk.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 35fe197dd303..d417ec018d82 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -517,6 +517,8 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 	int num_clks = 0;
 	int num_parents;
 	int clk_id;
+	int max_clk_id;
+	u64 freq;
 	const char * const clk_names[] = {
 		"clocks", "assigned-clocks", "assigned-clock-parents", NULL
 	};
@@ -584,6 +586,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 				}
 
 				clk_id = args.args[1] + 1;
+				max_clk_id = clk_id + num_parents;
 
 				while (num_parents--) {
 					sci_clk = devm_kzalloc(dev,
@@ -592,11 +595,20 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 					if (!sci_clk)
 						return -ENOMEM;
 					sci_clk->dev_id = args.args[0];
-					sci_clk->clk_id = clk_id++;
-					sci_clk->provider = provider;
-					list_add_tail(&sci_clk->node, &clks);
+					/* check if given clock id is valid by calling get_freq */
+					/* loop over max possible ids */
+					do {
+						sci_clk->clk_id = clk_id++;
 
-					num_clks++;
+						ret = provider->ops->get_freq(provider->sci,
+							   sci_clk->dev_id, sci_clk->clk_id, &freq);
+					} while (ret != 0 && clk_id < max_clk_id);
+
+					sci_clk->provider = provider;
+					if (ret == 0) {
+						list_add_tail(&sci_clk->node, &clks);
+						num_clks++;
+					}
 				}
 			}
 
-- 
2.34.1


