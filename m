Return-Path: <linux-kernel+bounces-56172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38E84C6F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DD21C22EBF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9365120B14;
	Wed,  7 Feb 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pFm0o0fG"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72120B12;
	Wed,  7 Feb 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297084; cv=none; b=Isq8gawBMisMC6xKyJE0A4+ZKdOXVQ99ojKsbl9BcgISbMxd7dAxDQRhPqgP6RaQtKZ5qwlGvgjtaNB9XUrqQ6eTfgUrpqdPI1qcjL7K4XVy9cB6b2ggXiJIkPfgVxglXu9RstsqAeqlGIlXVuBr+mbYUeyzGi22F5tzBweal0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297084; c=relaxed/simple;
	bh=ZNLMFoWciTitck67uVg21vy3FddYxalS3S4xIpSkUpA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gukTrbTMVUIRJR1HEmCC1qgknEdZCl1SfnbJpyxh6Pi6AItUkisfDQVbNlfLqHrVnm2s+1S6ELr7vL5z2P2tIraLE2wXAqX1ClWth1+fKvv+c+SdU3Cx+NqiuTO3n8u6AGC0LZuKLKcV1T/hUgp/jb8lUCfj7PdFtIm5LbMqvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pFm0o0fG; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4179BFoU003395;
	Wed, 7 Feb 2024 03:11:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707297075;
	bh=8+z5AzK6gRUDQ16vqNk0y0fkfcURB4sVIOGrxpLSLVQ=;
	h=From:To:CC:Subject:Date;
	b=pFm0o0fG+mElxBrb5cYKgYBaajTfxN6chy8yBq4qp6SAx/+VCq4LApq0ul6e8FvRT
	 DmQsmFBnmCvrceGBbFY3mQMGameS8aTEvxqEJkLWgZX/OOjAQ/S1C8QlGlIMnBiprs
	 3QZ4c3CJPorGxaTyWOKFHqJ24wnAOQL57g+3uOyI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4179BFmt115582
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 03:11:15 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 03:11:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 03:11:15 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4179BBeQ034511;
	Wed, 7 Feb 2024 03:11:12 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <kamlesh@ti.com>
CC: <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v3] clk: keystone: sci-clk: Adding support for non contiguous clocks
Date: Wed, 7 Feb 2024 14:41:00 +0530
Message-ID: <20240207091100.4001428-1-u-kumar1@ti.com>
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
Changes in v3
- instead of get_freq, is_auto API is used to check validilty of clock
- Address comments of v2, to have preindex increment
Link to v2 https://lore.kernel.org/all/20240206104357.3803517-1-u-kumar1@ti.com/

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

Logs with fix v3
https://gist.github.com/uditkumarti/94e3e28d62282fd708dbfe37435ce1d9#file-v3
Line 2586


 drivers/clk/keystone/sci-clk.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 35fe197dd303..31b7df05d7bb 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -516,6 +516,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 	struct sci_clk *sci_clk, *prev;
 	int num_clks = 0;
 	int num_parents;
+	bool state;
 	int clk_id;
 	const char * const clk_names[] = {
 		"clocks", "assigned-clocks", "assigned-clock-parents", NULL
@@ -583,16 +584,23 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 					num_parents = 255;
 				}
 
-				clk_id = args.args[1] + 1;
+				clk_id = args.args[1];
 
 				while (num_parents--) {
+					/* Check if this clock id is valid */
+					ret = provider->ops->is_auto(provider->sci,
+						sci_clk->dev_id, ++clk_id, &state);
+
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
+					sci_clk->clk_id = clk_id;
 					sci_clk->provider = provider;
 					list_add_tail(&sci_clk->node, &clks);
 
-- 
2.34.1


