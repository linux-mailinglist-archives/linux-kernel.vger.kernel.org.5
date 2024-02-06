Return-Path: <linux-kernel+bounces-54708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7984B2B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C393F1C21B48
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD01058131;
	Tue,  6 Feb 2024 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LH/jS+gs"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932112F59C;
	Tue,  6 Feb 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216259; cv=none; b=OKD+i07NJhpIl3WMXR/x9T5aA4IafMprcaGR5GTHPVRErXmNI8XGC8pEG1n7SHht5GUi9OTyX2b4o4d2AgrfPeGb4+jAOdW1/Pb3ZLMueDMiTrlhsdg7beV+SdJU7AtZmEnk2gRcum3NA/UCKljdTzzQ5uinNxgr0i7ESSuQUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216259; c=relaxed/simple;
	bh=i371UdEhQpXaJ8mvQCXn8mXTIx12rvp+EJtokqwZJ0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h4HYfnUZH8+Q2YbdqTHfdjviRW0iwSRHmfRtvu4GpkZniCV5HGCmS3E5CkSBeHJiU9PEm4FjMNI0tCW9L/Lqp7w7oMVwaiaq+V+dyxQeBhvY/kW0ebEvjsEMU3awP8Oh8FaaXDnmMngXucy2TBK99RnPN9pOX5a8IXtaBkpGNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LH/jS+gs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416AiApb113600;
	Tue, 6 Feb 2024 04:44:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707216250;
	bh=fnMZZfEYZdxyhfRJnAJGVe2SVYyE9V81+i0dqrp0+hM=;
	h=From:To:CC:Subject:Date;
	b=LH/jS+gsZAjdpWXQCEkzCns5tn8qrTjMBvLE30s913ioKACAbH/Q09rDAgSctLJQE
	 kvHqUhmrdM/Il5wflJ4yo4AUGV5PGJ0g9yw4mI5ylN6K5UCVKylHX7P4JUQ4NAnfuo
	 xTp1TKQwgQmJ5dJsZHFWXlk4v1ziyqOUAJOB6Kuc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416AiAet028004
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 04:44:10 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 04:44:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 04:44:10 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416Ai6iS105184;
	Tue, 6 Feb 2024 04:44:07 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>
CC: <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2] clk: keystone: sci-clk: Adding support for non contiguous clocks
Date: Tue, 6 Feb 2024 16:13:57 +0530
Message-ID: <20240206104357.3803517-1-u-kumar1@ti.com>
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
Driver assumes clocks to be in contiguous range, and add their clock
ids incrementally.

New firmware started returning error while calling get_freq and is_on
API for non-available clock ids.

In this fix, driver checks and adds only valid clock ids.

Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")

[0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
Section Clocks for NAVSS0_CPTS_0 Device,
clock id 12-15 not present.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Changelog

Changes in v2
- Updated commit message
- Simplified logic for valid clock id
link to v1 https://lore.kernel.org/all/20240205044557.3340848-1-u-kumar1@ti.com/


P.S
Firmawre returns total num_parents count including non available ids.
For above device id NAVSS0_CPTS_0, number of parents clocks are 16
i.e from id 2 to 17. But out of these ids few are not valid.
So driver adds only valid clock ids out ot total.

Original logs
https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6#file-original-logs
Line 2630 for error

Logs with fix v2
https://gist.github.com/uditkumarti/94e3e28d62282fd708dbfe37435ce1d9
Line 2591


 drivers/clk/keystone/sci-clk.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 35fe197dd303..ff249cbd54a1 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -517,6 +517,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 	int num_clks = 0;
 	int num_parents;
 	int clk_id;
+	u64 freq;
 	const char * const clk_names[] = {
 		"clocks", "assigned-clocks", "assigned-clock-parents", NULL
 	};
@@ -586,16 +587,23 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 				clk_id = args.args[1] + 1;
 
 				while (num_parents--) {
+					/* Check if this clock id is valid */
+					ret = provider->ops->get_freq(provider->sci,
+						sci_clk->dev_id, clk_id, &freq);
+
+					clk_id++;
+					if (ret)
+						continue;
+
 					sci_clk = devm_kzalloc(dev,
 							       sizeof(*sci_clk),
 							       GFP_KERNEL);
 					if (!sci_clk)
 						return -ENOMEM;
 					sci_clk->dev_id = args.args[0];
-					sci_clk->clk_id = clk_id++;
+					sci_clk->clk_id = clk_id - 1;
 					sci_clk->provider = provider;
 					list_add_tail(&sci_clk->node, &clks);
-
 					num_clks++;
 				}
 			}
-- 
2.34.1


