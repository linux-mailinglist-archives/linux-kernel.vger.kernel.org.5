Return-Path: <linux-kernel+bounces-36070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D1839B16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DA41F2C3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9B4E1AD;
	Tue, 23 Jan 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="La4XnIXC"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FA3D96B;
	Tue, 23 Jan 2024 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045185; cv=fail; b=NfofUSldvzaZjFQiDQ57cLK15gfFI+rN0iS3q3O9cep1/kVg4NM16zQ/wHYS7uVL3CVDkhjZFPkfBmuEsKzn7Key0Xh6BUPyHbJjZele4c/BMslySbFfwkMQIwt6VylP9eWQUsD4bt2nqqKUiuLTsLeJ8uXuMAx0NrtyujD30B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045185; c=relaxed/simple;
	bh=cbqJ8B8zoNb1wL5cvsafYdWHOXGpucToAPhTV87jaLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozOByGrtClf2X1ryl3XTyjwaEyDgbr0tdqnEJ9ysTgIebIxA5V0tvvwHRyykQ4AphzLaYuhZxYOvpo218xkAwnz6FYn3T6+YoH54tbP2ZKxa8brDkSYRahDVolg2Nojvq20bF3VbzErzaCWWNIYmPDOY3yYLw1IzzdLPZoCZ1yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=La4XnIXC; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khDyxHkj9dE6PeQiXk9kJmXEuO7ORcQOQEEWvBxz35XXpHvKUi+4WqpK2ad4PKCT7ltbAJtuY0RHYCuszp9LPEP59m3vmaFqTIRSaxk57X1AUhI2tZHzNBttCIe94EaOXJI+cK70teIibFqCaI54/ppcXnCuQA/n9CTm1tQxlX+JgQXm5M2mRRNlxtM/r2WShogNmwwQaEHb7qKo5GEcHtJiunQXmfMYRSe+A1bpGxVJYaI0/y1yMJd0GJ/fHh1hrPqMdZwn5uJ8zYdEVcoQ8TEen8zoh1In8qiDWZew1sH9KSUIlN+ks6liERGUa7Z0B6Cmz1aZ5425cF1wchn3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcAD7n5DFC8zY5SMsqG6DN1S/Q3hAt3IaNHuvXjxowM=;
 b=dsKD3ydmeESuFWY0AAv1/MlZJn3WELzrgJBSnmhjks2ncMZbwO0cwdDKggew57YVELwZL870GMPSl5qhBQJdfF09RvAHFazM8L/2UCuw57XKooHzX5tcU9D4gRwzl44/LF4NSCw0i22N89sIlN1kkm6+3O3/kJ3DCO6ss3qGivrccjTyL8bW68A9CRPsjwe2DjNW/uHyYSI5EnpqVjonDDIxhL/+5e+apnhjV7M3fccL08wHpLns+sbPVR9JzpUTHWqRyb5wCIz3oG76I+Wo4wx5/mji2lJKtNNtHUPgOBI+WaCKlATJH2s0FMf4lXoNv72zpwXGvyORH3MWFVj5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcAD7n5DFC8zY5SMsqG6DN1S/Q3hAt3IaNHuvXjxowM=;
 b=La4XnIXC0IIxAUHYbxjX7BiodW+cftZV1oJoT7rj6LU118T/MzVxNMy95qEJZqs4+d0nqWbeFmUFGeb5ZPIPV2h+FPVHVZvrPKUgztGST7K3faVnl+SLGe1zA359VficS7Rh6XNPS5v85u88SmugHAHIJdx+Fx63krYsZkrN0/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7616.eurprd04.prod.outlook.com (2603:10a6:102:e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 21:26:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 21:26:18 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
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
Subject: [PATCH v3 3/8] Documentation: i3c: Add I3C target mode controller and function
Date: Tue, 23 Jan 2024 16:25:44 -0500
Message-Id: <20240123212549.3858137-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123212549.3858137-1-Frank.Li@nxp.com>
References: <20240123212549.3858137-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cfe34b-4733-41e1-56a5-08dc1c59f017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a94t3t/i/QNGAOSjOUfD0kKOj567dPK6ozTBPcSyHir74/0nIonRymZXyyoPUkM1pmCg9TDJ8AQ16HJOIfnubg4ZHi3wvrbGqEsh0LaFGu7m7cIFFlAxW0tygPi4sVnRHHhK4XPgDnFbMSddxUAK7gmMXM9DkhY8Z2L+R5lSFuGDsbRhlFI8Sh+rpJDEcAnju+jaYgItLqJqjBfrZwa7a6yKnibxM035CwlZMTYVY03uYwvhpTWT0duqj00PACKExJ3vVAZP1krn7WqFTzH8eGOkNDCOHeuee5ZiLPaM/noACSriZ/jjzIoPDXca8fjKgngb+qs1NiGl99fqiVwbSVqOcct65yUzoB+osK3WeXZlWoDCTVXBjrYyorc6CmO6u6O2bMctP010IjwzGkJCXz75PZQKheSl4McySvJoUSkRy/95XLvLvWnPw1EFIATEmE1ZkcVHPYer+UjOCVCk7G1jedxdZpSy28JYEDzyjINspPTJdpBX4fNFgaudnEQvNcHyrQtJYSP/voOMYiEPtNpMjJXYV59JdLGgeIuVXACbqxDRDTyLVXJiTnnqedf/riKE/nAaIpWWYmYKD/UPBBcIDqMdMStflBUcQBRTfbuyvaH1SUeR/ve2I3wTmVSQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(1076003)(26005)(2616005)(478600001)(52116002)(6666004)(6506007)(6512007)(83380400001)(5660300002)(30864003)(7416002)(41300700001)(2906002)(6486002)(4326008)(8676002)(37006003)(34206002)(66946007)(66476007)(66556008)(316002)(8936002)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TGm+a93Rdli5CSq4qokH205Wso/jFCRsSpM5Z+G3zNtiXxzeys5pDTck3u0K?=
 =?us-ascii?Q?QV2feL4Nx65sa10+y7I+F+aIQRjdxUg9TP3wNCWQXZCnITH5ednwwMGFpIa5?=
 =?us-ascii?Q?5cn7FvJUqgLZ1p3cuf2qxcKwMItYO0kKGrVDLE8dWvNWFYoRJvn1FNQgADw8?=
 =?us-ascii?Q?RzEf4jmGRBjdofLfbWs99v8jGMucxSBehti1EO/6urOQXBIzqGOpMh1n94D/?=
 =?us-ascii?Q?/sh1sZf10DOCf6M8Bvzjojzl7OGttI3eDJN2YkbWqzK1jROA8SBwzHIjInm8?=
 =?us-ascii?Q?MQvsg1/jtbbGs046iygSsUdJFAENeMAdp8gCXn4lwaU97a3ZX+JNDIiXBFVV?=
 =?us-ascii?Q?5nlQ6cwjdNJodJ9xMMAKgojnmHg27bpHeIHGVhi6I9yuRLimto7nI2n5UkDq?=
 =?us-ascii?Q?8vcHO5+XPg2xgUuLq9O76R3SqV0WtCqXe0a3Xz4aLoqrCcttn77UgkTpB9wm?=
 =?us-ascii?Q?kI6cXQSxdsh6q/VwlFr0a70BBut+BVlk7YhWLEfpSS64pY5weSnrAFRVix6m?=
 =?us-ascii?Q?NekHQZ6UjylYpuMEjiclelei/jqRXkb+ekmdJ6IT1sAtxwBT8XqSau1ez3p6?=
 =?us-ascii?Q?tST8hu/LU2PTNQR7UdPfRO4qa/tRo97x7Qw+KyIEvuabYu+B5CPY3oWP0aW/?=
 =?us-ascii?Q?Fj34lbcLqYuS0LjYXnIfYL6iMDrox0SUDRLcmjZ7lVDMEtE7OWycx7QP6s30?=
 =?us-ascii?Q?yeNCzpiMUeuXshi3lF4zs6kPALYbFEDHLvQ3XWoXSRF6o/0+1FFX8jqwrH+L?=
 =?us-ascii?Q?za/MF4HO171eFOzkKJDvHUdLoKfsnsnbGSLOTuGoxJFd5ttWHg7C7UZAXZAz?=
 =?us-ascii?Q?5PpHwd95PJ4RzDOdvBd8yEwHJEj/apuhr2HHn9v9gqZkAFP7jTtE0It3CTLQ?=
 =?us-ascii?Q?kT1oXGfgIRx/xO2VYzVoAUnBn68or1ACx67oSaqajw8muOgm4+VL0onacj3A?=
 =?us-ascii?Q?Ty51/c6NEGFhD0+UY+Zjn3+6EOQyvj9lcEsvFP6+9l8a7j2GQ1kbjlrVBhnh?=
 =?us-ascii?Q?mugFnWsKPOF5eUJQJPtWrvWz+AkWu9yzgWAhxd4awKdM3QgdcDWkhIRRcnh7?=
 =?us-ascii?Q?SjX7ENPxjx3PTo/cS6iWeljwRywnMTN2YNR/MRJZpB1wgWdnm8kGHmUvZ8N0?=
 =?us-ascii?Q?U0FmW+TRTGENDdBdnwdgJ4VP96FV8D5u7FSeBpCS8Qs6U9pjBpSdx0Fmro9N?=
 =?us-ascii?Q?ZmBh9ZgUvTd77XU40mr7KK2DjJZMMmwIFDEJz5mY7naQEHfMrHyCy8KZxoDR?=
 =?us-ascii?Q?MGDNILRtcUHIh1/yADV/sTruR+h5nzSKqpx22G0AFRsv+qRInejTz0AEpBdB?=
 =?us-ascii?Q?OqFzEquM/2CXkflsxAxJH2qs7r7tdsf0Hh3Wx0ubtZONPL8U/8w7CIHnyqf0?=
 =?us-ascii?Q?/sZnG6GWbgxFohBREIQ6FPJFcHay5IwCEiayrfX5jhOawC7Sj0GlSPNVRhNg?=
 =?us-ascii?Q?P209MjRdkE2BIiVGe7+JLlewV0v3aQuna6zJbsUANreHs8tJLN11GSgAF40Q?=
 =?us-ascii?Q?yI2kv9FjGkdEigZzbUNs2jKq5YqmFFHZ3pnDx52DCtnZmXTl5GYSrGD3bu95?=
 =?us-ascii?Q?wyd33ZL54E4FArxgdD+heAzACBXrXrT7DtbOfoqt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cfe34b-4733-41e1-56a5-08dc1c59f017
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 21:26:18.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFeEAn41sipYiQ0xnXr6D9FpoOTrRAR7L6NaaSjEv0WkqaT7It3dVFSIPszsWAkoJ6rAIHjYonM+ABDDxteivQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7616

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


