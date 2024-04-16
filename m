Return-Path: <linux-kernel+bounces-146769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2EC8A6AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32168281991
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33412BF02;
	Tue, 16 Apr 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="RSSyTrox"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2093.outbound.protection.outlook.com [40.107.14.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD2129E9C;
	Tue, 16 Apr 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269918; cv=fail; b=EYCSY7WhmGyTXJdsUYh5AeF4u9LGtE0y8J0Ith+etODTDL31ElGpJrnZaalgT8CiPb/Z9QNFf/t8HxvYHUaRgxmwMCXBzUIb6RsAE4Z7sjmjMatylu1ZJXcG99rxGyWzsiuSeg0IPB/scLvnYpgNaGHQHCHeDF0w18zi6xvwad0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269918; c=relaxed/simple;
	bh=9qcG7iz3fuDsLrOzdibbuaHhqB/sTiBM5Y03rQwu/g8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Psqemt/evKtSvy2yD223RIlaHmUGJOAvt6kwfa5Wg7aRRSCMuslT2bzcP0aXVVxkbIzXGqJiBa1gSMqHCWRGFunWK8YKjTaT+M9hPE3tTIQLqzY9qu4aofEG/281Zaka0LFUe0E5PH4UjKtMN/vbWQiDqQHuucqpE3JiOxDo2do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=RSSyTrox; arc=fail smtp.client-ip=40.107.14.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftleeA7dzRXMsmgqcz9iSQ/kG4OhdRKoOFODb7oG7mQH9pXbWFck0vBht0+kqS7TPjz9LV3qL/C24U9Psmrz3VwBdOUdu825PPul9hB0i1SM2ZZkBoHEHj+airxWlzKqTJ4bWaTokE8H7vIcneYSWkaq/7eMyxk/fOZXICnBP1Gcp9SmnoWDJDlLX8hsV1gLHJeSofHqyKOL3TjRSm8hkRyCiWir7xGAnL4v80Ol10uxAxdUJ+6a9gVwkwL1dOoNCzg+TLc6YG+tRKcf+CTNVKtrzZQxPz34W5tBeSz76OzLb8yrJ3reYyKXMyQR9Thl83ilMKR6jDD2Cy2Vkme65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CXGJvQlQE1Iieu+YOvD9q8PM9AIhDyaffeEMwspuFQ=;
 b=jaOUQlna+wn9cgxka+XSQc4H6Qo/NO/nWBGoJMbDzkf/asM2YRDCTWkPr4/XLZNj+TjlWIFkB5HMXLDrTK1N3/HTp//W7O2NWqQXts1i58/fzsoz7TXD1TAW5G5n19dhAtxe5wcA0AmX4wbr5nTBSYfTWRxRiEokBtO9f5erQ6hmoGqC/9Y2pJA6Km6W4RONTPxBAfXe8kHa14BaQ5mnELKPnDD6cqkDhpSUI/u7WijBJCoJDLINw3jRUlzKEaYO1kn8jREg+35i6m6EUt5+w9Q31aoLT9yeKB8P17pkASq/wMKBkhnvQfKFXcCcWLuCaC2WHPxrPkXFuhzA4YWAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CXGJvQlQE1Iieu+YOvD9q8PM9AIhDyaffeEMwspuFQ=;
 b=RSSyTroxfg1ntBeHN7AdhtayOa56jywLRW781t2xNBMIVZBZGbB7Ae+yT5UL9aTbnSIlazqggP0sN8EQhtWesfw/J+ig1pPYJ2OZqwQ1YhpWWWPeRaVcHwPgyLtUxO+D8suO/2gqacxGG7fe4L/NJwFAYa+O6IvPMU4jipttepGbFtP1qHGVnM4n++8Kd1r0yLN6J3D3YP7xvGC9HbVQl2lRlfky991M3GhGMViyFoOBH4a/CGO4TlWcooRQ93bqgfJ++HdKggPt2ZcrLYEkzes5m5O+h2HAqKQBQT26q5vOrIYoiYLTmyMAE35amv+PiB4D66/sxX18EEDwgU7N6A==
Received: from DU2P251CA0008.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::10)
 by PAWPR04MB10053.eurprd04.prod.outlook.com (2603:10a6:102:387::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:18:33 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::12) by DU2P251CA0008.outlook.office365.com
 (2603:10a6:10:230::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 12:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 12:18:32 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.169) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 16 Apr 2024 12:18:30 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VE1PR04MB7230.eurprd04.prod.outlook.com (2603:10a6:800:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:18:25 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:18:25 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] power: supply: core: Add POWER_SUPPLY_PROP_*CELL* entries
Date: Tue, 16 Apr 2024 14:18:16 +0200
Message-ID: <20240416121818.543896-3-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416121818.543896-1-mike.looijmans@topic.nl>
References: <20240416121818.543896-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dc197200-74ec-4cd3-a0dd-4f7fd874c623@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::20) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VE1PR04MB7230:EE_|DU2PEPF00028CFE:EE_|PAWPR04MB10053:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e377bd-b1a7-48d6-0135-08dc5e0f5516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 tfVjBKJhoXfQjFgWGSpUdvZiztfHVLwf9VSdxqmv8/ZMQAtuYtqsQ3o7nUR9sF3I+PEPOliSbv4NBJ4kxmUb3raG20vZrJhOMXA6YoazyoOck55vUSN8AuiBP3CIjOseSDbket6OVHZ2NDiCfBpOkuQO8lcS0u+O+34L6BUcaSSZAr91npYlL8mJQF51U5yfo5hte7Ypqkgf4aTwRFGP1kT53OjnN4M8IoxsibYVLMPHpfBXwQ7qAYj+gg+jRNZqngg2R9K+kkXXDil19rxwwYNnQ3qeGnwc6q8LaCQGOqL4VqBzIeCSUnmHx4qACAtQcbJXv/JT9DavPO6QhDte5mzTQ1eytBC7dwJFykDH7DLMxkYIuRgAoPAgj/zhTThAKTBimiT3FYG8IHxerLjGz8RzepX+cLFLwoHYMwkLrT19AgmrB1NL71WtzrE/kmNSCggmYjeegIHgpbCZeyFETJm5QRYQllRBnOzM56G/W6IDewwSGACArIhF2pLl7Ar/PbgOPYb3rkQY8vjvDl2mDxxPEh4U6PLI7dNINXjRGfAGZeDs8d1+c75U0KcekB+V21/QT+65wiiInyQqk7LEBqbNMDprpWGrD6zb6d6yzn2rgL/AXDQR0ucBgvTJ4tWR6TCV5bRx+yWqbT4u7VqurI0C1SK0m6oEe6QYBJMP7OpQTBZH5DJsfSbJr9w/DbUV2sbsRvzHZsZCvxHwX5ZYEA==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7230
X-CodeTwo-MessageID: dc67f059-2f8e-46b6-adbc-99c741076226.20240416121830@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0c7cca2f-7c26-4078-7ea5-08dc5e0f50ad
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wFXqZgw9j92C0Z7eud/WWrvXgaartii/YHSPuadVWMyuoTPhn0O4yzdyZfzBjSZolZGa/DPQfBJzzE7NqqMaZTQ4yASFoCfxKtMl+t7vy2WmsY6+OSvz8GjYrWHqRcKELjI6Mu9oTdzYcrYB1Ru0srbZRFSiI1dz22G/xdo1KfLpdXmdInsyVTydYnlAWBFPZO12mBJLrzj79OfKP7MGY7aU51sYhD3rkQvVC1OcDDkRrvLSuVUl3bDAMzrQ7SB7st211BK/sorjtc7mGUDQPfe3cSVYg6JmfFmH0so9kAQmRFooHnCQmMa9yQIvvI9SnckngbV+AlRCBmXKMxAVTnwz0/8WJL5AfY9BjOpx6S8K2H0it2qNXmovmbnsYKGFge6CHST19Ka/8PVRMmW+tI6r5CZ9K8+pOp5kQSkDrwhDhoNwx55MpqXuHT5XjAJZ+Zum3vWi8MttnymW4wWe+HgGx1xtd2qYRnS6cPc7aBjDyX/n9cFgRNFRCSoXC5wqmWD4NA0HnZf6KY2SQm9LvGzlDYk3QfZLBkpqPTBDVZIry3POlTp7/ElEbU2F9dnFGfoLD+3sW+zksfGxYZ2DNmOLGR4ugyZNnH5kpS0ohueNk/J/wXMSAV376Xpc1itLnuopB7+SGlphAZMm7qJ2dgVYB7DgHrAT5KfPgyxoPfkzExgpsLOOOmZa/WT2t+1GC0JmIdTwcaZZpUK089FVLg==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:18:32.4481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e377bd-b1a7-48d6-0135-08dc5e0f5516
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10053

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

