Return-Path: <linux-kernel+bounces-146123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3188A6102
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11021C20DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404F1400A;
	Tue, 16 Apr 2024 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="bST5UUct"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2074.outbound.protection.outlook.com [40.107.215.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372917573;
	Tue, 16 Apr 2024 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234142; cv=fail; b=aUmdq+tJoHaMxexCv+ndczJbiRQUHt9nrykUBxliy4LLsnJwVjmtlMvyxi4ZQY9x3IDZq6Z3fvz5+USsQATk++sTF3wfHWi8lvSUeGrXY2GQUUpPRnvc0ad+YLvica+XK6LSFIamnxML/pGXe10ZDgl+7KPzFSOV5Ye7Wx/c2pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234142; c=relaxed/simple;
	bh=PQDs637DkJ0XvgnVWdoTkmAByxh1JzOkkkEy25w+9IE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Rhi9qdNKTvq/zuqisoEyBmuebuN2AFWBCBTpwg7W6nUJKk/V0MoPpr3DaSxRAH7J+/32ZhUZbCckQIJwcpf9EY7YOS/TMIJs/TqXN7Y+V7WhPFwrNoxIhoOkrW6HT0j61sV0MFNtS9EjTGOg26DSI+RgCDFPoJXTfJ51czDoQ+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=bST5UUct; arc=fail smtp.client-ip=40.107.215.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFBK53Kxfj0F74zpWCyAiS1gr5DdS8GNYHEKKKAdDB6X8ANWHBNxKb7zRYCiTR/r7QGPU3N/uD2sZQBaM1FEf14ksY81+qPI18TLN5nGJZVqM7oCwG+4uY4543YbSqOJFwLKI0fgo5cl2fV9AYl6F+IGBm0MMfbuySZq8GdU8DAM1UNI2KrwhG9bI7X0U6awbCSWeLgrFWsLhooG42eio5jPycCCEH9CAx3d0f1YFHVYU5XbCwzkz/wQDt0arbBjw1GRVmiZjRC/iwPIewPPA1sZnonttYl87x/nR4F4KPdbYrc6GDsauzEvW4DdN9DdGYblK+qVzNACnCzatmf5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6CRusoxnO+qUgpzFyJM3lu2bRTxIzxeM6ppgObmV8I=;
 b=jR2KBmAJ7t/SacAYY+5wtmLkayww89NeMzBAdpPSAoJdRKMAfCpT8GnmOv4R6U2QXEFWowTTPpG3mrdw39Wmch57V7rBUHO4B8dC0fJU8T6pAar3JHf82lpTmvWDGjmKW4PKBjfGa0IVT0otQupV60C8mWOq37qePYG27qhFsZMysrqO7S4oy+4/yi62NLbHuDF+B0mJdjJnOpar+9oeONEQkbIel//j+bXVDGnFAgQQntfRR10msiG3PIRbhxqU6CwYQq0pEUlEPLKi98p24ozGLi/rYpElv62l6zlntGW317vYDIjNdN2Mg4XvlkxzIHMVRjmiyg/JU8nf7iNZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6CRusoxnO+qUgpzFyJM3lu2bRTxIzxeM6ppgObmV8I=;
 b=bST5UUctJEDjOUi0wGsceGaiMdpm+KBEdrsIjyia1l0lK2PchLL3D/XhFtRBFso0VZh7SVRpMhFCNdf0v31WAQwaEYHRZDr5+oLAZzN8aoAp6/T8eGAj8zlkWMUAeSSkGa2JrzGflsBnQGx5kB2SR7j91U7c39AfhSs0hX4EtV4dnoqqGU6HhG4xmpip9Gluwl19vWQj5XtGg/JkizA8pKu096cooKPQxG/foQfvrzaOGvPpf68n0+52JoSEybP3rM7s4aSWKDoeZntXT5X8aX2QDHR5uNyntbixqjCdJmMCfGsyNYQvltGoBXshEAkf47a+NQSuc4mlRz38wgU6VQ==
Received: from SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) by TYZPR04MB7665.apcprd04.prod.outlook.com
 (2603:1096:405:45::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:22:15 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::ae) by SI2PR01CA0047.outlook.office365.com
 (2603:1096:4:193::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Tue, 16 Apr 2024 02:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server id 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024
 02:22:13 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: max31790: revise the scale to write pwm
Date: Tue, 16 Apr 2024 10:22:11 +0800
Message-Id: <20240416022211.859483-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|TYZPR04MB7665:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 46b3f515-bef2-4ef4-b334-08dc5dbc07ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7vm6W+RW9uq1rV2DFLnJZb59bcSSf/PooonhEHDv1KiyzWsACD4b2snMMyM1PhCNJqyHx++x3pPLWpGM9n/2zhZ9TA3t/jZD9AhqQwGrq6YL3PNTf/zG35cqtnV+bqMHB21UvutWj2njeGcesmmzQHUV41VeSh76dlPblLjFpFM0BrQqL/up0gGHBdLtSD1xBj2i6XZyq0vwMe+hZkT4nEeqtrUpbwXfKN83Wwa/3/dxNax8YEAETeFZWw6zzaqeBsf9ae7+VN5yMUf1uc5wSktGtcoLQ8Du8mf003NGczEI8mN3Jqz3kidqBgqfa50VkxYFMqEXmL/gIY3RFgY8wQEBx8x2xEFJinKciu7IF6oB2hhFzfeL7ikg7dOjWFx6B2j1e1dEwlSavyXQdfNiZ6+ASF28n2jth/ZjPcRr66jJAEjgiLx7sG4BtXZuNePc2+6mhfTA1BHdY3N55igILOc8TkykIGGaLr35slGu5WnAjFdoG+Mzpu4J1bQ+ulVql1SWe+dcai6M/f+QdEgR6VNT94cnfYT1tIdivYnCZjyUOgfYArUy0g8FuuMvZU57y9xWYX40Chqxl4CbbgL6zorWdG5LJdUki6B2VWj855JVvBFa6cwcLP0yWFQjJJhabFVON7CTrXu9XupMEY7c5yfAjRTXZ0EUceX/K5hL8b4lS9mnmd5uC0hgsO+DyCPQGk8EwadQK5jFIjX1CGPQsbZ4kr4tb7RQJTYJLefr4b9I58sTKEzpzOOU3ONmu399
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 02:22:13.9991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b3f515-bef2-4ef4-b334-08dc5dbc07ba
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7665

Since the value for PWMOUT Target Duty Cycle register is a 9 bit
left-justified value that ranges from 0 to 511 and is contained in 2
bytes.

There is an issue that the PWM signal recorded by oscilloscope would
not be on consistently if we set PWM to 100% to the driver.

It is because the LSB of the 9 bit would always be zero if it just
left shift 8 bit for the value that write to PWMOUT Target Duty
Cycle register.

Therefore, revise the scale of the value that was written to pwm input
from 255 to 511 and modify the value to left-justified value.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 drivers/hwmon/max31790.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 3dc95196b229..7aa1aa63bf1b 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -49,6 +49,9 @@
 
 #define NR_CHANNEL			6
 
+#define PWM_INPUT_SCALE	255
+#define MAX31790_REG_PWMOUT_SCALE	511
+
 /*
  * Client data (each client gets its own)
  */
@@ -343,10 +346,13 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 			err = -EINVAL;
 			break;
 		}
+
+		val = DIV_ROUND_CLOSEST(val * MAX31790_REG_PWMOUT_SCALE,
+					PWM_INPUT_SCALE);
 		data->valid = false;
 		err = i2c_smbus_write_word_swapped(client,
 						   MAX31790_REG_PWMOUT(channel),
-						   val << 8);
+						   val << 7);
 		break;
 	case hwmon_pwm_enable:
 		fan_config = data->fan_config[channel];
-- 
2.25.1


