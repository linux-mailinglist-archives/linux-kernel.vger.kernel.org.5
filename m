Return-Path: <linux-kernel+bounces-144737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E288A4A03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15351284D87
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6624F3BBEF;
	Mon, 15 Apr 2024 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="hqmtTrgh"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2115.outbound.protection.outlook.com [40.107.22.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783539851;
	Mon, 15 Apr 2024 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168807; cv=fail; b=pq/bpy9czBtRV0pEIIgdTgp67x6EvJMUqfGsD5PHxIABdDZfsG5tjQR+etxLAo4IOwTrGXPskrmjZEWupNgTsq5Mqhw95BgLn52D5KsrIbfKr+WVpyC1ow4Z24lPPsJ9QZQ37rt2dRMne1UC0+zr9EfqSXFNI055vay+llm2RNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168807; c=relaxed/simple;
	bh=9qcG7iz3fuDsLrOzdibbuaHhqB/sTiBM5Y03rQwu/g8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNis+ycK1r0kHt+qFrJGEaD2Yk6L4liLEr3IfqqSJnJBZgrTKDcUkX/LkWh1jMm0H8yAAuDojIQMdGoj5v+O+F+nnQ8AV2j9b9JRoTuBru1775DUGaIzVZ4o7+qxBVGrSI8FFCXpU8DlmifLclQP305UPijgAepat8mCg6I/k14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=hqmtTrgh; arc=fail smtp.client-ip=40.107.22.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBN/9wzZ2XZhtEPzRjmdCDit2oK4Y2/taYnvJz301G3IhqGq3rwbVyrQlj2Z/yJZ1h7drHL836cpT2rpeB5UZxudx+iZkbzaIx3RLvQIlWBIAwRwo7z3XsZpAlixUDNnELqmo4SovoSyuodtV4HRemqMo9Lc1rPT/Y5D8sfdX2ETWFDLz4eOVo/vqBUkDxmZJ9r6zhmreysEwmgEjrIOlmP8xxG3Ao59s1COZEnF6kHe4WWvP9E846aFpaFT8sSDl+izPqldVbYzjKyWVOpTSvK9gZCl2svvNUXJN2TAuTkgaUesqgcL3zX4OfYFPdhg/oujHmJewRc5JGiYdl0+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CXGJvQlQE1Iieu+YOvD9q8PM9AIhDyaffeEMwspuFQ=;
 b=Hj71x96EQpxAMEGtzjtVdkoy7/pSpnMUGXskT4F1AGyCX6iVzPxLethgd+SgH9K3N6XGQe00UTsOLyhKoEFQbd1DNaAwQOn3YWoU1Pg8WF5XZxSO2Uy2k+8MB77v3ggZW05DVnO1vT8JlfKzETzipzQtlwG53zgh3SfUQwW/eXVNRUrhPHQlzibSqsADmdXsglWH3F8VIrbLaNz1n7T3hdAmOlY3ItcghFMj6tEA1jgmMOwAxQ+VohqR9qNOfYuBTu14l6wZRltB0tOYzZ3uDNljcMIfeWtMdD3cb+bRHCukcXgKGwlxx1OGlon6SfZAKZd+mRAm/HtqzNtEP5h6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CXGJvQlQE1Iieu+YOvD9q8PM9AIhDyaffeEMwspuFQ=;
 b=hqmtTrghtCrmPt54ZzL1ZoF0iv5omnk2Jin5rpjX8und4pFKoL6UZntX4KdeiqyTS3VvKqpf3g12t3cBkBA7UR8ZHbl6LRgwuafn1W9baD2UPuMjLRzA1ErykoK0KwyyDHpAbQj/4gdC92PTQupqON75AkED4Wnzca8iVBVDfia4thdn9K0vxEn4Wl8BEbL3k5FnvGvzghkBTZYPAhKoWsHDljYzxg+ArTSwPG1wdLzi6zM4ZjJ6g/5AMK4BNez+5aK07m3MmO7B+Lfo4+S6wskxUOZDyZkYfoxxnRfKpboIY2ZeMSs1wandlBvKSdQxe8GUDHBIZBDB9Tu4cfpCgw==
Received: from DU2PR04CA0263.eurprd04.prod.outlook.com (2603:10a6:10:28e::28)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:13:20 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::48) by DU2PR04CA0263.outlook.office365.com
 (2603:10a6:10:28e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 08:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 08:13:20 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.104) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 15 Apr 2024 08:13:18 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:13:12 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 08:13:12 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] power: supply: core: Add POWER_SUPPLY_PROP_*CELL* entries
Date: Mon, 15 Apr 2024 10:13:03 +0200
Message-ID: <20240415081305.316107-3-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415081305.316107-1-mike.looijmans@topic.nl>
References: <20240415081305.316107-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.9dd4ffd7-8f51-463b-bf4f-d1ff27030b84@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PAXPR04MB8288:EE_|DB1PEPF000509F3:EE_|PAWPR04MB9988:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c23eb29-1f38-4c86-7eb5-08dc5d23e97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 0nGCCUq7/8QuW0s/Sw+f3VBsU6laUVuAeh17LpMSS6NHYlbMFr44mnVZ5Mzp0UkgNrEYQP/5zGfVMr7pST8ZsGE0DXqD2Xg/5vaSm3cKXOGb+X+K8TRKhxDQ7CaDEBNdOF7IC2CFQd8fy7CTUPO571+uOrxr+gz1I3EUYgzme2mxKzIa6yjTFHcwkxJNQhTmk3INgLOwQckLa1e1ZGSTggLmvjx0daHKXmiM7A306U1Emc9SCVn9+TJZvEsYwnEAzCMnnd621DKrXRP1wDSL65UYuaTcEZyYldQDDKU6vAMluoFQWKFss8zouX1X9oB65ENjiJrMn5hu02gFKF/1qXDrCLgyg2qU7k3JoMH31Z1/PKJCJwJIBlSkxNCw8z51PEnv1m3DWIpts1ailAiKNAu+2NC0gW86hKEe9PXS0VElG60a4ynpy13qQGxIZEcKNm3yfO8FQVZTLKyhjPnQ94Pg8+EqVU3J/0jLbEEGxEt+In54Th7GQjtG1j1GxaJ5x63lf9b4PXP7vKXI82Qvq+hfecIRugfPMP6H25gRDIoE9mbrl3Xmwm0DHhnOsK3/fVMeQEoJgi1rSLkTBL6YNb1N/0xpKEKu5tIvD2556P3NvGMPe4npE6Kr4nDf8xaAYFGCFp8iQaIdhb39D7hLU1ZqkkF+p3FZtDor7abTgPtd6ogphDJuUKdYcvmIwmW6oPm0ITnbOHweWgF4/bVNWg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288
X-CodeTwo-MessageID: 1f7827fd-2769-4c15-8486-04e5a232ee74.20240415081318@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	de705ab2-f56a-4028-a775-08dc5d23e4cc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BRklKNtFwo2akyyGwysJliJEBr/QvlPfwX1kCskItmOnjsaSNqOWXUsN5DGz63jmPMVsyW7ZC6XpNA5mQ24tPIz45/8d+yMRQhGnqhm8/k5EsdVbo6xFaUruADdWqEbYMSctxYHyqoqi7HVIcRXnSsP29EY4UMpDO8ZLNwfEsML9EnvNA1kbW6KOEeH4tNDRlXT5ei8JHtH3kiX3MxJvaVvb4mysHci82l0srRSXXpBiq3JlkIumHvq3bkUmsuDxFF/nIHRUy5sFQCNJqBGlQYqWKV2ZIoSxH4i9BUazuVyQZmBbXHCJZP6VUEyqcZnLLQkm31bYQWJuOkub6Rtnec0JqD/YMoV9OIQRxED9oSI4pCdjr5oya1ZW7uBZNbLupp0jnYNB586xUyvHk9hJOd7KHmuadIaRU1LKcTsTfhkRV9drED4y2mkAPrDpXjg/mi7H9dBYG79VMhUK/C+JNVPRhOw22cumYILJaxuDCc1WSeYCokgCSIAirHMjQ+TAQzkv+cCGttv2KXEddMDL+L0Yc6llG8Q/EnhCa8x2nRSCoG/H8B5F+X93pbzE3bSwx/gZHr1M47gr3da84naa38dYpYtTluuicm66ek2ddNck+mKfFI4chCDWTz/yJ9mqjl2i+YZ2+OhvaPutMhvmvPiISpal/oSNGSMREAPSzg3VJE2j7kmZZyVHiw4+R3UYbnyRKq6uHh0G8jBANQAcAw==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:13:20.1969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c23eb29-1f38-4c86-7eb5-08dc5d23e97a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9988

For multi-cell chargers (or stacks of capacitors), allow to report the
number of cells in series and the voltage of each cell.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

(no changes since v1)

 Documentation/ABI/testing/sysfs-class-power | 51 +++++++++++++++++++++
 Documentation/power/power_supply_class.rst  |  7 +++
 drivers/power/supply/power_supply_sysfs.c   |  7 +++
 include/linux/power_supply.h                |  7 +++
 4 files changed, 72 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/AB=
I/testing/sysfs-class-power
index 1f6a04a17c81..f5b194ad61b3 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -516,6 +516,57 @@ Description:
 			Integer > 0: representing full cycles
 			Integer =3D 0: cycle_count info is not available
=20
+What:		/sys/class/power_supply/<supply_name>/number_of_serial_cells
+Date:		April 2024
+Contact:	linux-pm@vger.kernel.org
+Description:
+		If the energy storage is composed of multiple cells in series,
+		this provides the number of stacked cells. Parallel cells aren't
+		considered here.
+
+		Access: Read
+
+		Valid values:
+			Integer > 0: number of cells
+			Integer =3D 0: info is not available
+
+What:		/sys/class/power_supply/<supply_name>/cell1_voltage_now
+Date:		April 2024
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an instant, single cell voltage reading. The voltage is
+		measured across the cell. The battery reports voltages for up to
+		'number_of_serial_cells' cells, in cell2_voltage_now and so on.
+
+		Access: Read
+
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/cell_voltage_max
+Date:		April 2024
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum allowed voltage for a single cell. This value is shared
+		across all cells in the range 1 to 'number_of_serial_cells'.
+		Typically used to trigger an alert for userspace.
+
+		Access: Read, Write
+
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/cell_voltage_min
+Date:		April 2024
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum allowed voltage for a single cell. This value is shared
+		across all cells in the range 1 to 'number_of_serial_cells'.
+		Typically used to trigger an alert for userspace.
+
+		Access: Read, Write
+
+		Valid values: Represented in microvolts
+
+
 **USB Properties**
=20
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
diff --git a/Documentation/power/power_supply_class.rst b/Documentation/pow=
er/power_supply_class.rst
index da8e275a14ff..42110cbbea4a 100644
--- a/Documentation/power/power_supply_class.rst
+++ b/Documentation/power/power_supply_class.rst
@@ -213,6 +213,13 @@ TIME_TO_FULL
   seconds left for battery to be considered full
   (i.e. while battery is charging)
=20
+NUMBER_OF_SERIAL_CELLS
+  If the energy storage is composed of multiple cells in series, this prov=
ides
+  the number of stacked cells. Parallel cells aren't considered here.
+CELLn_VOLTAGE
+  voltage measured of the n-th cell in the stack
+CELL_VOLTAGE
+  single cell voltage when the cells share the same value (usually MIN or =
MAX)
=20
 Battery <-> external power supply interaction
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supp=
ly/power_supply_sysfs.c
index 9d8540ce1f7e..4ea6b556f3fd 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -218,6 +218,13 @@ static struct power_supply_attr power_supply_attrs[] =
=3D {
 	POWER_SUPPLY_ATTR(MANUFACTURE_YEAR),
 	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
 	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
+	POWER_SUPPLY_ATTR(NUMBER_OF_SERIAL_CELLS),
+	POWER_SUPPLY_ATTR(CELL1_VOLTAGE_NOW),
+	POWER_SUPPLY_ATTR(CELL2_VOLTAGE_NOW),
+	POWER_SUPPLY_ATTR(CELL3_VOLTAGE_NOW),
+	POWER_SUPPLY_ATTR(CELL4_VOLTAGE_NOW),
+	POWER_SUPPLY_ATTR(CELL_VOLTAGE_MIN),
+	POWER_SUPPLY_ATTR(CELL_VOLTAGE_MAX),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index af5a4e700881..3c208dff8af8 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -171,6 +171,13 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
 	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
 	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
+	POWER_SUPPLY_PROP_NUMBER_OF_SERIAL_CELLS,
+	POWER_SUPPLY_PROP_CELL1_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CELL2_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CELL3_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CELL4_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CELL_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CELL_VOLTAGE_MAX,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

