Return-Path: <linux-kernel+bounces-141867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5808A2467
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877801F23E65
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F11E175B7;
	Fri, 12 Apr 2024 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="bRQ9M8FT"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2045.outbound.protection.outlook.com [40.107.117.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75528175A7;
	Fri, 12 Apr 2024 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892366; cv=fail; b=kY/9I8m/oNhfDA3bC5XaealtjtprjP6NgivBrx9GXEJzYqQ/Acox0DQj8SBuLW6nRTklEB4Ifgw7l5GzSdDpbumgzAWu6frW7ZSlJ9fNcS2IRsI1V/P6Oc7L0ZkGivERLLJVvyefFiVgbcx22rA9zR2UzxAPkdfRV1Zh7vFR3Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892366; c=relaxed/simple;
	bh=4/T/NZ9d/DanJg2t/5V8EriwpovvYg+WIN+i8IDuqNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kAU8QEl9fJHD2mLoBFefQZpWnHIIW3lTcTsdPNupGGPVuuiCqMGcbJdTCd/rrW+4ZZj1DaVBZWZvM/+w1Cm+satBnsJ/RGGq8oJTTdjEz8P/bjfXetuQqOy0Y90ICKevH79hWW1+8Lu/o3aVeom96tFYLJ8Jc4IpSxvQJAweej4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=bRQ9M8FT; arc=fail smtp.client-ip=40.107.117.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0ZmPrU/6SU+8d9gPc3xFFURwhihv6NNXmXZsQcI5Nju95NXmG9S43e9qke600y9/G9Sr0lLjpNtc/ip9WOfMPJR094fvrqQ7W40Wuc5zS5oGLawaAEXnSINhZgPD6qxPoMtUs+fQE3NemhYaHkoejiNAECGRPPiQaWyRHHcxuQ4glnNP3ny8kD1rHg9RQkbAA/W7fRDm1HK9Y4FwJIVHemrYuCSnOOz4Tj16BplnzOtNgIaHg0fwby98la98Ud0+HKPl+4H3k1lRggfBlYKWrEMm4976yxkyltGgJQH5JQOhpi9fgD2x+mV3GHW4hl+j2DCo0FMcFB+XAi3ZKfJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YQ0xCloh9/5F+75o5FJlPmSjL39OwxGMYUfO14VWL8=;
 b=Af+X96Eu4nv54HaX/BEuJRAEZfD0fn2nqx5rZ90F53w42N/31PJQnsL7eKRXVKA+/bCovOcxrX7SGQmD2WeM7CX4E9l/qBQ1pP8EV+jCt09+/ioLR+mpQpV2p//LAYvsH/WYuh69KCYeMW/R0QJeo7NzwUtIxpcaXLfxkMlU7SKZiBKqTT6yjm9JzULxpsAj/Dlvodb0oGk/JotCZxvRQGQsPO3wkl+MeOu7PBo55CbIwf63esDFm4RXQEC8s6rdcZEfRgI2i+PTNiIYxDWjAbBGCGjOSAy9wGDvCL0Nim0DNRw67NvzlhqEzDWVZPuLVe4uYit1pCI2hYvOJMZo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YQ0xCloh9/5F+75o5FJlPmSjL39OwxGMYUfO14VWL8=;
 b=bRQ9M8FTusKXm1zS/D5Va85VRpopExrdw93FJHqhvGarPmdfNcefnnlffY2LLuZtI/7ViS9ledTn53SpGq3i22iTSUMxekOZ3NNcKnawqpiKy9VHKpSJqRSZy5v37DDrG8dMjZrQmT/01Ek1koxAfIxZqfldwOrNtW+URlPnwcuvO73fhyERbRmDewmLG/GLY3GeMi7mCSVAOZUBsAeKT7NmyjHdSc1Kczsg9wlAX71YcdwwjF35IJY3M00avoE47xDF+wIC2bi2+Tzays1Ua4tWMAJx5wAnvw3AseIgfX1R8KwoI9iDusKbKV4GDZsJDhXDaiDs4WTOb4NK86m8ig==
Received: from KL1PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::17) by SI2PR04MB5895.apcprd04.prod.outlook.com
 (2603:1096:4:1eb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 03:26:01 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:820:4:cafe::34) by KL1PR01CA0125.outlook.office365.com
 (2603:1096:820:4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 03:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server id 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 03:26:00
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] hwmon: max31790: revise the scale to write pwm
Date: Fri, 12 Apr 2024 11:25:58 +0800
Message-Id: <20240412032559.3352846-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|SI2PR04MB5895:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 72c64f69-99dd-4ad5-bc8e-08dc5aa046d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X5S43Aher04p03N7xfN766MtoS0JFNy6OHr5TPepQrEB4VtHlhcsbaNJ9TC/ZYOFP3cV/AfYuX15WBtk5k7+nWHIeUPH27Q/sabcu49qXb6blGpJIXOnJPmhj9OTT82N9qLQ5w1f3ZJ+ozqZHPWzyPddrSsOEKP1bNSzssurxER4q47+X3OWd4HsPZ0VdNJ6m820g6WO8DG99kwR5pNsKdfbKNKNXWZ91653e9wHONOCvr5cRtvWlfK81SxwekKF0JUsLV7n0W+g8XcwIFgVhcmUfvYFMa8tXNT7R0Z8eKF+u4//Cm7RHKCJhml8jhxqsmst71d8mjDKLkC3daUeCvbN3+xVqKaJYBo4XrZfWHwi+W9pWpGwoUtc/beWJtCedzjjNp/zhX00Rt7J7ooXVXRwxtp/GVaj596FjSYnfloeTTVeF5iGTKKGmqXEaSJp3WHeKygG1MJGhdBvUt1nlGFGRXKiLLHbmpL7UWFivejG9cwkj+CFcy/xsN66CNRmeuqZmf7LqNJ6/2NHywlnO1EN+5wetaZvu0IbSbybgYVZez99kM05zi9lcQ9aFkilsn9RCC/MSOqQgRw7/JEvqc/gFudO6O1dIj3ibUQ3rKhRDx2LlCu2vnXhISADSuxpxHIQ9X+6ogeQDYnpvJlFFE5Cld70VJ0oUCqDiGdjL5dGMP0YxnGx6OPl5KV0REfHa7Sm780VUM/BNNQlAyQ1gjnnx4KIbsGD1DXqwCLCA0ED3mK17eFxYWyC26tUWpp3
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 03:26:00.8237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c64f69-99dd-4ad5-bc8e-08dc5aa046d8
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5895

Since the value for PWMOUT Target Duty Cycle register is a 9 bit
left-justified value that ranges from 0 to 511 and is contained in 2
bytes.

There is an issue that the LSB of the 9 bit would always be zero if it
just left shift 8 bit for the value that write to PWMOUT Target Duty
Cycle register.

Therefore, revise the scale of the value that was writen to pwm input
from 255 to 511 and modify the value to left-justified value.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 drivers/hwmon/max31790.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 3dc95196b229..bd201191da1c 100644
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
@@ -343,10 +346,12 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
 			err = -EINVAL;
 			break;
 		}
+
+		val = val * MAX31790_REG_PWMOUT_SCALE / PWM_INPUT_SCALE;
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


