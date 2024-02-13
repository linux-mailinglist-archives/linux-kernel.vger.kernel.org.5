Return-Path: <linux-kernel+bounces-63115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533F7852B19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43CB1F22065
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6C5182BE;
	Tue, 13 Feb 2024 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JEOBt5OX"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F57822319;
	Tue, 13 Feb 2024 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812828; cv=none; b=LEJ9G+6tDODOrBhGjuDRB2yorw/ipmdiLkmyRjiFWdmMPjESOZyfm/wt07efpV0giFA7quEAiQ5vcuZOBCv2GlKqBMqeTdEpIVfcibWO1Eohl8y36YepBYWlWsNq5MVhojOFA9KyYQjw3VwWzSxNIFrBL6/uS0UTnbbogS6Xa6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812828; c=relaxed/simple;
	bh=uQ3pvkYlbb9sP+1HniO8vjtexme1WQGKUWPzjjcS9jU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qJlklJ8uSpP9RmqECUYC9ITcoIkZiYEtIWT1YQWouA5MLbV3D3HizcxABRSbH3NT4LSF4iRZtUnivWJ+lS0YBBDFNkUDfhHXLaEoKw2xsn+P7RyoraWzeKd3cOEbIMDKiVS4w2NPiTm/4W3sBle2f3o6SSfRV/vYNC/HMEmfPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JEOBt5OX; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D8Qr3E049651;
	Tue, 13 Feb 2024 02:26:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707812813;
	bh=efVT6VYP6+c1CNm4+amsfIbNPIkqQ++4RigN9/iTUGI=;
	h=From:To:CC:Subject:Date;
	b=JEOBt5OXFXIq0UCpmKVle7JORkfKWb+EKI8MpCpJO2mmXPaROubeP6qSnjOtL4Ynp
	 KymtsCniLld8mUfa2k00racz+VCxvElKUh2YyKjNlLojP/0sQm6V1gB7TOGv6bWcM7
	 eXhVXr3O8u7+2U5zsJY1SfMEFcT3McYePOhJ07HU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D8QrB1010740
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 02:26:53 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 02:26:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 02:26:52 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D8Qm5k102902;
	Tue, 13 Feb 2024 02:26:49 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <kamlesh@ti.com>, <francesco@dolcini.it>
CC: <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v4] clk: keystone: sci-clk: Adding support for non contiguous clocks
Date: Tue, 13 Feb 2024 13:56:40 +0530
Message-ID: <20240213082640.457316-1-u-kumar1@ti.com>
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

[0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
Section Clocks for NAVSS0_CPTS_0 Device, clock id 12-15 not present.

Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Changelog
Changes in v4
- Added only incremental chanegs as per v3 discussion
- Updated commit message
- v3 was Reviewed-by, Dropping Reviewed-by as logic is changed
Link to v3
https://lore.kernel.org/all/20240207091100.4001428-1-u-kumar1@ti.com/ 

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

Logs with fix v4
https://gist.github.com/uditkumarti/f25482a5e18e918010b790cffb39f572
Line 2640


 drivers/clk/keystone/sci-clk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 35fe197dd303..eb2ef44869b2 100644
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
@@ -586,6 +587,15 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 				clk_id = args.args[1] + 1;
 
 				while (num_parents--) {
+					/* Check if this clock id is valid */
+					ret = provider->ops->is_auto(provider->sci,
+						sci_clk->dev_id, clk_id, &state);
+
+					if (ret) {
+						clk_id++;
+						continue;
+					}
+
 					sci_clk = devm_kzalloc(dev,
 							       sizeof(*sci_clk),
 							       GFP_KERNEL);
-- 
2.34.1


