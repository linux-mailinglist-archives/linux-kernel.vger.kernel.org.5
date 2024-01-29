Return-Path: <linux-kernel+bounces-43434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3808413D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE551C237F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCC1157E60;
	Mon, 29 Jan 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ssoPUgcn"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0D152E04;
	Mon, 29 Jan 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558036; cv=fail; b=oLDKbPZySA9kQtB+MY43CE7rDaUJ096VydQRcTaoYzwsS+zf1RbDdClYxqlW5gqnKJnep3mYhSadQeAP0pwfxdQqem82dbw/1QJqvysJvisZmeblLgnuqtXWHQ1GjmLUCqw8MfDzmsp9mO2/woUIUkasubFs3ccqdr4ZMruo4yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558036; c=relaxed/simple;
	bh=cbqJ8B8zoNb1wL5cvsafYdWHOXGpucToAPhTV87jaLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+jdEm2LANuogGQcT8X8XlTqrzF9oHCbNzQuPQ4fSJNwKjLrCqfIxx8+a+1Y6fsY/VrlH1j5CsVxCf6Gh4k64CkskIETIychxbYe1tQw7i1ZUloBn/ii3DPThAq19GMA6w+E1LN5DyVsn1ebir/max+gfgGEv+H5F4T+yxH7yCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ssoPUgcn; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0eMs1/W21l5IKG2eWnZU8JrSHWZIpNRXhxvl5AATNT0I3DvO5CYD4ThdKLPSh1SKFTcXVUAovfg7838M9ZwRCOPyIhTWT5pqDz2+DEzh6P0AyzDWmWM2jMYG/0YMXc6aQbSpXYIcPNck1jZTsUlVgB05BKVvZIxEWxq8XJJC8xB4Xw3XiXBGoZYMo2Ul5DPs5D4C9d9wVlqJsBUxPpq28ifttPe6TLDNp4kSh+csDeItlfyJS8A713zmwNmLdmamqGHqpkye03eVsJwDLk3b0k63hKzcgPYnw5b+cWlUt5gv8EIhuyIxOByHCF25Ql8/VcG4LrZgwSjWx8dY67Rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcAD7n5DFC8zY5SMsqG6DN1S/Q3hAt3IaNHuvXjxowM=;
 b=jZIIvs1G5Fxn2lkbbXvjH46riwkua2XFfGLNCbEcoNLqXd49fsAv3ftTomE7xxB0a6DjLD37h9q6Oi+VHwf4tN26sRcARTe7ZrMXe9jHs8knx029smcg91WxqJOPFC5xuKoQDhZDp/VC07Fy23zcE62WVLCBC7E6UF5r4d/pKfQRt5WmeLji47gN1Dii9ycROP43rJG3zrhYjXeRvXbMXL2YZn+UZhjGPIVC20h6avX6A5tUHfhMeMYyEqB7+Q82P+PMI1P5S5DmYegPKfQvTxVJFAo2Nz55Tqftm409XtlfL7F9CqPgR17LI/qy6aIgS8FoF2WxuMutWmEt/q6gKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcAD7n5DFC8zY5SMsqG6DN1S/Q3hAt3IaNHuvXjxowM=;
 b=ssoPUgcn+15+mPgAAce82MIIqJ3gQTa2kkqmoSsQ2xGL8itA7oH6UhrbJpi3XSFPiumvcRJaZnIzHnaXzkrGWG8hT/oWXdxNnHA6NZdgrKkhcx1STs9g7IYEPQxQ7lid7GEzDHi+2zMIDTMK9rm6NuNX6bgMXd8S4q0mksnMh5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 19:53:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 19:53:52 +0000
From: Frank Li <Frank.Li@nxp.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v5 3/8] Documentation: i3c: Add I3C target mode controller and function
Date: Mon, 29 Jan 2024 14:53:16 -0500
Message-Id: <20240129195321.229867-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129195321.229867-1-Frank.Li@nxp.com>
References: <20240129195321.229867-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0bebe6-b49b-4226-6304-08dc210404b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FSq5PMtO+LkAm378s142POwdrhpXzi4D9Bvh8b4tJxeCeJhGQTfsY0/jdkElrxi8wel4AuSPSc8TqZO009WNDYDNBi1R9MTtbLyZx3xRHu6IqdeD7fsmbQTH6s4d6JQNbaO9V1NGcKNm4R14ktb5PPXe4efyNIdxGqDuh+wdWeq1eDeHJbZ0OxGgEU9UTIFYwnaQxhLQnsi/5ufmgGgOUN8OiQCGWzZeSrM2L78nRKdoEIBvQ6YX81OhtSU8qi2qLxvHrRP75I+QmV7o09a1uVuTKq48qbuZNk+wzvOhxPmQr8iiNrip7eUlqJyAYAAyQLO/25IeomZXN2J7z5OdJKnjDZx6FlX2ZDdUKXOA2Nhu2mtZkAy6h6bbRgivmSay4M1ZFlRUxlJxTFVNbl+1YAZyBwsx6IBOljdM0Ebn8Uuv4alPAkbNRyN4oWOFEPbdg4n4XmpGxqX/MWq7am+rVMTbG+pO8YE86KM6iMH3pk2A5rM+k5Kjx9buMNMpzx7xGP1vhVHP32+2u4Ax8ufS2+mRpRTDs25hmfXZcBM+MxTVgjPhcdAIAGL9r/xairqfb5K2KpFv0y60fEwN3+5sDQPz4Erv6C5EHTwX8YOsLNt0ZGvZy0BCjOSA+w7hRkMD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(52116002)(83380400001)(6512007)(6666004)(6506007)(38100700002)(30864003)(66946007)(4326008)(5660300002)(8936002)(8676002)(7416002)(41300700001)(2616005)(316002)(478600001)(6916009)(2906002)(66476007)(6486002)(66556008)(86362001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6H/IqtcWM0xx8888+x0uXSEdPkdjE8ty0Z2FjsTpbhQbUDTrc5DlWv7VTU8?=
 =?us-ascii?Q?kRJe816O33t1OJdk1Q6DB5TDrQgmnnQ0zb5XKXICJLLFEfVK1ZHA2pFVYQTM?=
 =?us-ascii?Q?5IYANJi0W4qLlZ31pyjfY3F8CiQnrmGHWbAuhnfYLR3sm5GL1V3u/KiqLnHV?=
 =?us-ascii?Q?h9gTz4/Wru2a4FapyCAlrXujq3alAfJ8SY77Hx2GS/bDpzk4tyluuieOcCr0?=
 =?us-ascii?Q?OCNJ1wO+IIoZt/bctcQ/6KryYOrcnJj0sfd625um8ZvnMhCAmxVUmnMHTO7R?=
 =?us-ascii?Q?Fb/xKXQDkQfjpqxNdaM1VIGAe+WbBvwr9iuiKdQxsRVqtEZbfTPDS4Hd4lbB?=
 =?us-ascii?Q?nsEois2LaSqRBjodO87126qKBMMDW71jaVhBIFGWPsoFQRrVRn+PfgwxllDJ?=
 =?us-ascii?Q?3MQvLaL3JTI3aHP8DQRqOpF4bJx6IX7RXOZ3YayYtTc9GgTmq8kzW188hbhs?=
 =?us-ascii?Q?EzVqYlf4AXcD4SNh1pkoVKr50ZXexCSEB9CViE5tnOljhEDgKoA45xcf05V7?=
 =?us-ascii?Q?dDEYaewXv0kBf01TqKP+X7kN8kt2PHYWX7XMf/OG/QQ9qwv9QR7fP9p2lltr?=
 =?us-ascii?Q?mkBy4DsPSrwI5hRcVHuDRhh10s0u7xAEU8+81x3EE6N1m97nAcfspEDj9V+T?=
 =?us-ascii?Q?lL/gaOLV5FLbMBTL1VysP9ntIFn0gh5dPXdqjBMV+HabensDG0SoL4F2CqR1?=
 =?us-ascii?Q?xl1DmR1UjXg59r96md9QaqHExnb6I2zkXb7T3Ke4/zwKj3EIMDfjp1uTwjx1?=
 =?us-ascii?Q?QDwOsxWftDDFtyDLZoLNfIlex7l9mdXLpxXuhmJAyRkaIwtkrzwXD+sqDrQe?=
 =?us-ascii?Q?D/7QxmjnX8SZxLkhxbc3wE5dnKUxE9qwBnZaTyPP32EAi1EgRnttP2a5YR6h?=
 =?us-ascii?Q?dOvEY6iS9rwjtia/ndFrP2vIgIHpWGfzrYF2OvquO0IaMGXS2c/WYv8ucJ2f?=
 =?us-ascii?Q?mrnF05FQXdmuZjdynKiK8/nevT+ZUG4B0r+ODxZiJxY3SFRn2Sqok1uzDEXs?=
 =?us-ascii?Q?CNBWMrlaSZS55h0/EUiT+k/DIY5OpbwIGMf+IhNJegICqAd8oUGZuS9+IqjW?=
 =?us-ascii?Q?UOHTo/XWR492zofJhPvaTbgFAqcYWCqhL+/Uvkzbp3NUwl95WG7eUUZaSM/Q?=
 =?us-ascii?Q?HnBg1QOhLEXXr1sP3OIn8J915jCnbfe0/HNilp5QY5q5ycTnDTobgKrx9Yn8?=
 =?us-ascii?Q?wj7x+xF/atyE+V3ahePJ4Ym1YGaOXDRF3fDqJpr64YP9/NJ+RQs702EJsHbD?=
 =?us-ascii?Q?Z7Rzl6Re2g0h5X1q0UlannH7/P2qHcvcT++AWOJ+58C3NryHREM6oPG+XP+u?=
 =?us-ascii?Q?6OSQR2vUgZgYCcTz2kXrYCVUqY8nieGxlFNAg4j6BNPj4IlVkuxE7wEdvFnU?=
 =?us-ascii?Q?FxyoTM8CnNGPJW6UBoUcdN+TeB8NlSx43ZvxLG8smJL+sThMmIGvSXdAhWjC?=
 =?us-ascii?Q?OUktao7F8JMwBbnkMbos7YVuX02YilmIy3DRv9N6Akc0x+pjCc6dykrxKpoa?=
 =?us-ascii?Q?AdDvhp6cUHEBibUktIBP/Z6rsQjBxke8FyJU6j2KEsAz1s19wTj8OQqssdp7?=
 =?us-ascii?Q?fTp/+UAxVKtXpLb2fPlq5159dOUpPNgh6q33an9x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0bebe6-b49b-4226-6304-08dc210404b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 19:53:52.4503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbvJWIeePRN6iiklaOMLs7rVvkPZplVqHK3QLCRr3cniId9hnl+G+9crDuLpyKXs2X6WNC23Z1v0ZlMqMN0CAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128

Add I3C target mode and tty over i3c func driver document.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../driver-api/i3c/target/i3c-target-cfs.rst  | 109 ++++++++++
 .../driver-api/i3c/target/i3c-target.rst      | 189 ++++++++++++++++++
 .../driver-api/i3c/target/i3c-tty-howto.rst   | 109 ++++++++++
 Documentation/driver-api/i3c/target/index.rst |  13 ++
 5 files changed, 421 insertions(+)
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target-cfs.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-tty-howto.rst
 create mode 100644 Documentation/driver-api/i3c/target/index.rst

diff --git a/Documentation/driver-api/i3c/index.rst b/Documentation/driver-api/i3c/index.rst
index 783d6dad054b6..345a43c9f61b0 100644
--- a/Documentation/driver-api/i3c/index.rst
+++ b/Documentation/driver-api/i3c/index.rst
@@ -9,3 +9,4 @@ I3C subsystem
    protocol
    device-driver-api
    master-driver-api
+   target/index
diff --git a/Documentation/driver-api/i3c/target/i3c-target-cfs.rst b/Documentation/driver-api/i3c/target/i3c-target-cfs.rst
new file mode 100644
index 0000000000000..1fcf829dc4ae2
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/i3c-target-cfs.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Configuring I3C Target Using CONFIGFS
+=======================================
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+The I3C Target Core exposes configfs entry (i3c_target) to configure the I3C
+target function and to bind the target function with the target controller.
+(For introducing other mechanisms to configure the I3C Target Function refer to
+[1]).
+
+Mounting configfs
+=================
+
+The I3C Target Core layer creates i3c_target directory in the mounted configfs
+directory. configfs can be mounted using the following command::
+
+	mount -t configfs none /sys/kernel/config
+
+Directory Structure
+===================
+
+The i3c_target configfs has two directories at its root: controllers and
+functions. Every Controller device present in the system will have an entry in
+the *controllers* directory and every Function driver present in the system will
+have an entry in the *functions* directory.
+::
+
+	/sys/kernel/config/i3c_target/
+		.. controllers/
+		.. functions/
+
+Creating Function Device
+===================
+
+Every registered Function driver will be listed in controllers directory. The
+entries corresponding to Function driver will be created by the Function core.
+::
+
+	/sys/kernel/config/i3c_target/functions/
+		.. <Function Driver1>/
+			... <Function Device 11>/
+			... <Function Device 21>/
+			... <Function Device 31>/
+		.. <Function Driver2>/
+			... <Function Device 12>/
+			... <Function Device 22>/
+
+In order to create a <Function device> of the type probed by <Function Driver>,
+the user has to create a directory inside <Function DriverN>.
+
+Every <Function device> directory consists of the following entries that can be
+used to configure the standard configuration header of the target function.
+(These entries are created by the framework when any new <Function Device> is
+created)
+::
+
+		.. <Function Driver1>/
+			... <Function Device 11>/
+				... vendor_id
+				... part_id
+				... bcr
+				... dcr
+				... ext_id
+				... instance_id
+				... max_read_len
+				... max_write_len
+				... vendor_info
+
+Controller Device
+==========
+
+Every registered Controller device will be listed in controllers directory. The
+entries corresponding to Controller device will be created by the Controller
+core.
+::
+
+	/sys/kernel/config/i3c_target/controllers/
+		.. <Controller Device1>/
+			... <Symlink Function Device11>/
+		.. <Controller Device2>/
+			... <Symlink Function Device21>/
+
+The <Controller Device> directory will have a list of symbolic links to
+<Function Device>. These symbolic links should be created by the user to
+represent the functions present in the target device. Only <Function Device>
+that represents a physical function can be linked to a Controller device.
+
+::
+
+			 | controllers/
+				| <Directory: Controller name>/
+					| <Symbolic Link: Function>
+			 | functions/
+				| <Directory: Function driver>/
+					| <Directory: Function device>/
+						| vendor_id
+						| part_id
+						| bcr
+						| dcr
+						| ext_id
+						| instance_id
+						| max_read_len
+						| max_write_len
+						| vendor_info
+
+[1] Documentation/I3C/target/pci-target.rst
diff --git a/Documentation/driver-api/i3c/target/i3c-target.rst b/Documentation/driver-api/i3c/target/i3c-target.rst
new file mode 100644
index 0000000000000..09ae26b1f311a
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/i3c-target.rst
@@ -0,0 +1,189 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+This document is a guide to use the I3C Target Framework in order to create
+target controller driver, target function driver, and using configfs interface
+to bind the function driver to the controller driver.
+
+Introduction
+============
+
+Linux has a comprehensive I3C subsystem to support I3C controllers that
+operates in master mode. The subsystem has capability to scan I3C bus,assign
+i3c device address, load I3C driver (based on Manufacturer ID, part ID),
+support other services like hot-join, In-Band Interrupt(IBI).
+
+However the I3C controller IP integrated in some SoCs is capable of operating
+either in Master mode or Target mode. I3C Target Framework will add target mode
+support in Linux. This will help to run Linux in an target system which can
+have a wide variety of use cases from testing or validation, co-processor
+accelerator, etc.
+
+I3C Target Core
+=================
+
+The I3C Target Core layer comprises 3 components: the Target Controller
+library, the Target Function library, and the configfs layer to bind the target
+function with the target controller.
+
+I3C Target Controller Library
+------------------------------------
+
+The Controller library provides APIs to be used by the controller that can
+operate in target mode. It also provides APIs to be used by function
+driver/library in order to implement a particular target function.
+
+APIs for the I3C Target controller Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used by the
+I3C controller driver.
+
+* devm_i3c_target_ctrl_create()/i3c_target_ctrl_create()
+
+   The I3C controller driver should implement the following ops:
+
+	* set_config: ops to set i3c configuration
+	* enable: ops to enable controller
+	* disable: ops to disable controller
+	* raise_ibi: ops to raise IBI to master controller
+	* alloc_request: ops to alloc a transfer request
+	* free_request: ops to free a transfer request
+	* queue: ops to queue a request to transfer queue
+	* dequeue: ops to dequeue a request from transfer queue
+	* cancel_all_reqs: ops to cancel all request from transfer queue
+        * fifo_status: ops to get fifo status
+        * fifo_flush: ops to flush hardware fifo
+	* get_features: ops to get controller supported features
+
+   The I3C controller driver can then create a new Controller device by
+   invoking devm_i3c_target_ctrl_create()/i3c_target_ctrl_create().
+
+* devm_i3c_target_ctrl_destroy()/i3c_target_ctrl_destroy()
+
+   The I3C controller driver can destroy the Controller device created by
+   either devm_i3c_target_ctrl_create() or i3c_target_ctrl_create() using
+   devm_i3c_target_ctrl_destroy() or i3c_target_ctrl_destroy().
+
+I3C Target Controller APIs for the I3C Target Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used by the
+I3C target function driver.
+
+* i3c_target_ctrl_set_config()
+
+   The I3C target function driver should use i3c_target_ctrl_set_config() to
+   write i3c configuration to the target controller.
+
+* i3c_target_ctrl_enable()/i3c_target_ctrl_disable()
+
+   The I3C target function driver should use i3c_target_ctrl_enable()/
+   i3c_target_ctrl_disable() to enable/disable i3c target controller.
+
+* i3c_target_ctrl_alloc_request()/i3c_target_ctrl_free_request()
+
+   The I3C target function driver should usei3c_target_ctrl_alloc_request() /
+   i3c_target_ctrl_free_request() to alloc/free a i3c request.
+
+* i3c_target_ctrl_raise_ibi()
+
+   The I3C target function driver should use i3c_target_ctrl_raise_ibi() to
+   raise IBI.
+
+* i3c_target_ctrl_queue()/i3c_target_ctrl_dequeue()
+
+   The I3C target function driver should use i3c_target_ctrl_queue()/
+   i3c_target_ctrl_dequeue(), to queue/dequeue I3C transfer to/from transfer
+   queue.
+
+* i3c_target_ctrl_get_features()
+
+   The I3C target function driver should use i3c_target_ctrl_get_features() to
+   get I3C target controller supported features.
+
+Other I3C Target Controller APIs
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There are other APIs provided by the Controller library. These are used for
+binding the I3C Target Function device with Controlller device. i3c-cfs.c can
+be used as reference for using these APIs.
+
+* i3c_target_ctrl_get()
+
+   Get a reference to the I3C target controller based on the device name of
+   the controller.
+
+* i3c_target_ctrl_put()
+
+   Release the reference to the I3C target controller obtained using
+   i3c_target_ctrl_get()
+
+* i3c_target_ctrl_add_func()
+
+   Add a I3C target function to a I3C target controller.
+
+* i3c_target_ctrl_remove_func()
+
+   Remove the I3C target function from I3C target controller.
+
+I3C Target Function Library
+----------------------------------
+
+The I3C Target Function library provides APIs to be used by the function driver
+and the Controller library to provide target mode functionality.
+
+I3C Target Function APIs for the I3C Target Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used
+by the I3C target function driver.
+
+* i3c_target_func_register_driver()
+
+   The I3C Target Function driver should implement the following ops:
+	 * bind: ops to perform when a Controller device has been bound to
+	   Function device
+	 * unbind: ops to perform when a binding has been lost between a
+	   Controller device and Function device
+
+  The I3C Function driver can then register the I3C Function driver by using
+  i3c_target_func_register_driver().
+
+* i3c_target_func_unregister_driver()
+
+  The I3C Function driver can unregister the I3C Function driver by using
+  i3c_epf_unregister_driver().
+
+APIs for the I3C Target Controller Library
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used by the
+I3C target controller library.
+
+Other I3C Target APIs
+~~~~~~~~~~~~~~~~~~~~
+
+There are other APIs provided by the Function library. These are used to notify
+the function driver when the Function device is bound to the EPC device.
+i3c-cfs.c can be used as reference for using these APIs.
+
+* i3c_target_func_create()
+
+   Create a new I3C Function device by passing the name of the I3C EPF device.
+   This name will be used to bind the Function device to a Function driver.
+
+* i3c_target_func_destroy()
+
+   Destroy the created I3C Function device.
+
+* i3c_target_func_bind()
+
+   i3c_target_func_bind() should be invoked when the EPF device has been bound
+   to a Controller device.
+
+* i3c_target_func_unbind()
+
+   i3c_target_func_unbind() should be invoked when the binding between EPC
+   device and function device is lost.
diff --git a/Documentation/driver-api/i3c/target/i3c-tty-howto.rst b/Documentation/driver-api/i3c/target/i3c-tty-howto.rst
new file mode 100644
index 0000000000000..43a129b18e938
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/i3c-tty-howto.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+I3C TTY User Guide
+===================
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+This document is a guide to help users use i3c-target-tty function driver and
+i3ctty master driver for testing I3C. The list of steps to be followed in the
+master side and target side is given below.
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of target controller devices in the system::
+
+	# ls  /sys/class/i3c_target/
+	  44330000.i3c-target
+
+If CONFIG_I3C_SLAVE_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/i3c_target/controllers/
+	  44330000.i3c-target
+
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of target function drivers in the system::
+
+	# ls /sys/bus/i3c_target_func/drivers
+	  tty
+
+If CONFIG_I3C_SLAVE_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/i3c_target/functions
+	  tty
+
+
+Creating i3c-target-tty Device
+----------------------------
+
+I3C target function device can be created using the configfs. To create
+i3c-target-tty device, the following commands can be used::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/i3c_target/
+	# mkdir functions/tty/func1
+
+The "mkdir func1" above creates the i3c-target-tty function device that will
+be probed by i3c tty driver.
+
+The I3C target framework populates the directory with the following
+configurable fields::
+
+	# ls functions/tty/func1
+	bcr  dcr  ext_id  instance_id  max_read_len  max_write_len
+	part_id  vendor_id  vendor_info
+
+The I3C target function driver populates these entries with default values when
+the device is bound to the driver. The i3c-target-tty driver populates vendorid
+with 0xffff and interrupt_pin with 0x0001::
+
+	# cat functions/tty/func1/vendor_id
+	  0x0
+
+Configuring i3c-target-tty Device
+-------------------------------
+
+The user can configure the i3c-target-tty device using configfs entry. In order
+to change the vendorid, the following commands can be used::
+
+	# echo 0x011b > functions/tty/func1/vendor_id
+	# echo 0x1000 > functions/tty/func1/part_id
+	# echo 0x6 > functions/tty/t/bcr
+
+Binding i3c-target-tty Device to target Controller
+------------------------------------------------
+
+In order for the target function device to be useful, it has to be bound to a
+I3C target controller driver. Use the configfs to bind the function device to
+one of the controller driver present in the system::
+
+	# ln -s functions/tty/func1 controllers/44330000.i3c-target/
+
+I3C Master Device
+================
+
+Check I3C tty device is probed
+
+	# ls /sys/bus/i3c/devices/0-23610000000
+	0-23610000000:0  bcr  dcr  driver  dynamic_address  hdrcap
+	modalias  pid  power  subsystem  tty  uevent
+
+Using Target TTY function Device
+-----------------------------------
+
+Host side:
+	cat /dev/ttyI3C0
+Target side
+	echo abc >/dev/ttyI3C0
+
+You will see "abc" show at console.
+
+You can use other tty tool to test I3C target tty device.
diff --git a/Documentation/driver-api/i3c/target/index.rst b/Documentation/driver-api/i3c/target/index.rst
new file mode 100644
index 0000000000000..56eabfae83aa4
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+I3C Target Framework
+======================
+
+.. toctree::
+   :maxdepth: 2
+
+   i3c-target
+   i3c-target-cfs
+   i3c-tty-howto
+
-- 
2.34.1


