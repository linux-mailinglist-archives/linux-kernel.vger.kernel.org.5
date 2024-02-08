Return-Path: <linux-kernel+bounces-58394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9449784E5E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13487B25A36
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260F83CD3;
	Thu,  8 Feb 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pF27gAZK"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2057.outbound.protection.outlook.com [40.107.103.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AFA82D6A;
	Thu,  8 Feb 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411714; cv=fail; b=V5vufwrx2xa2PbjuxYLl1yPMR4PYBgNA39hMGiptewk3ZU19++CNpvEpUKCGVDL4mMStNkspeGwoE04l+NYnbBzUDttO+Sr2t2vejUNsyQppAFRtTC4XUULJz5+rlEgHE6S5pRBWM83eDovNOPzC9BgG0PPbeDqdxYvf+2l2siI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411714; c=relaxed/simple;
	bh=cbqJ8B8zoNb1wL5cvsafYdWHOXGpucToAPhTV87jaLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XEyR9qoNvgLIcoiOxZdXx+GmSOcsMHIatFhuiOkpMPDRYZnVgUYNAjPa6w94sOK5+mcwo86CwrswHZI2yX053CGDaqbW3dPVMIfHFferrhMjKmIFqNytihV/Csnns6wQl8vqfOMM+zG7joQznhO+5fyc9EtHiL1tmyAiREIR9dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pF27gAZK; arc=fail smtp.client-ip=40.107.103.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjsO17CvkYwM/Za8jTuYYqniMP1opXDUfF/LbLbpc4jyiW8AEV3lcRD1rvyzteWcci16dD8TDHrDRMzbm64MWtiGZS7Ylv1bBmLCQwxrxl1tTLLe2OSd0/3IAb6c7+qpOsWTr2kTL8qb3eMNn+nFdnoL8Vr/TDLi6iw2uGEIZpyKWB8E/Z7bPzupRcfww1T9QIhukwfvU6n2X8oIkW7YSMtyBIR5jPrIN4FsQF8rQnP6DRHhfOVby5wPc434SzD97QoDe9Cuu9jeNY8c2KsnohyDGgSDUp/0wcN6LGEB/4X/if239PwZXP3GRnUV6zumz8qhkN5XmdhLAyFEhhi7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcAD7n5DFC8zY5SMsqG6DN1S/Q3hAt3IaNHuvXjxowM=;
 b=oFlg0oquYR+rgfF80tHZz/eANY7IUwITq1c5alIlnIR9iFDLWEOsKrNX4K09frIsWgSoCVeuEOoAy2c/JuyAgOaRVQys9EKM6+ShK6ct5qiBfsVUNiHpP6UfDhjPC8AaYkBMx+TnWPmzxmaqVTZBLWGhGs+G+kUcNm86a9Hn+HfGlaSiOuaYxUIVuLiyw0MtQC3hFuc6YpyGmHuY4PYP1R1+Yh3VXh1z8BJIiYXbc/60J+oPWdsgpvgSCm/vl5GAUawt+5tw2dX5MDY215JfYlfH+9/gchn3rlQsWJTTzR4XeNEAPg2yfPqGUK9/1vbPWdPF/rQZ1/MIdhtZBSXx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcAD7n5DFC8zY5SMsqG6DN1S/Q3hAt3IaNHuvXjxowM=;
 b=pF27gAZKXB7efb5prm8LDkEIdhN0NQL1ROTaw4urWxM9Y03z9eLlkaqtjV4qNOlHobmRO942+7LgoN7y3DyM8INHXkhfBKGNuNuaaMRvsF7lJLLcaiyMkfqeEr4m/+7RW/Uq4s9AaGJ8b3qcmMvTpekVua5NfbjDEL5mGWZ60fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 17:01:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 17:01:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
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
Subject: [PATCH v8 3/8] Documentation: i3c: Add I3C target mode controller and function
Date: Thu,  8 Feb 2024 12:01:12 -0500
Message-Id: <20240208170117.798357-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170117.798357-1-Frank.Li@nxp.com>
References: <20240208170117.798357-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: bc82f11f-df49-4a2c-c170-08dc28c7a334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EW1Uu2wA5+cUMV+Vpot9boM12mJKpRwLvOE0rRNKP5ENagTri+SHeXXpfG0NOADTnAN1oZnTLq9T22c8CSHc0+7V9hc/VMScTfpY2ELbYdTvn03wOGaWGyqGMY7YY4tRDJKJ8AjX3hH3i5m0Ia0XCR++1WGLwbc6kyrTBYCRjbF6p0yLFrW6YgW0WdmpRtCwfPpkfbzI8ZA98K/SM3qbw5ezCEy7C/NuLMvRswa59Pw7iF+Eq+5B08PoAVK0hI4uoaaWlY+FheraO0BYVA6VO5Ugx5siPYx5WrDfMbeiGQh/lOZng30eXid3/dN4wK3hFiDNnOBUwTF/NLWLbclkITjSHdUoI/18HbDGxpsaThoOSGyMZmUGApgdrwSL7O0cJuXjmjMME48RB1StcVf1Gt770DKEtUrWsPSgPebshJtRiQLVs5HnVmEY9kkD7sC36ISvupSLzzSB1C0TGZAwtDvGtlQE2Hl+GKDRaBhgAQl25VAXtU3iQ3ht/Qaj811Fn0Q5WvmWcJFmX9pfpq1rooxzSSCJcOQVsEslR7VuNwUQu/cs2f3cvvxdaDXsZfohKnC2Sqx9DLw8xTeRBle0tyO1qg7ljRMlU0KYVP01q3p/Ki4LDAMYNDVgN/eT26GH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(6666004)(52116002)(6506007)(83380400001)(37006003)(86362001)(7416002)(41300700001)(1076003)(2616005)(26005)(34206002)(6512007)(36756003)(8676002)(8936002)(4326008)(6486002)(478600001)(2906002)(30864003)(5660300002)(66476007)(66946007)(316002)(66556008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jrk/jb30LEsA4Wc3yTNpXLwa7IPIdkE1sUKkUe8ohyU/mVVUCB60l7fBkRso?=
 =?us-ascii?Q?o4rLShmRzsmrGnnG7ID4Bg3aD7iyid/KY98KStepSYVoCut3yv22BvxMVgQT?=
 =?us-ascii?Q?RS2AV7dikHjJKpx7AdKgVUpXwtevpCSAdKOls50sNsrozUFnTElTaIO7uqM9?=
 =?us-ascii?Q?OIv3bEUmeGWO2JHiClwLK+iIR3GdXly0rZCT9/uQ+p1f7fH5eBntUKr9m7+Q?=
 =?us-ascii?Q?HrbMfJotVzD00DSdUwAyOYUH3pXLghs4RlM9IJfc09lS68Gsy+VcRljDENkO?=
 =?us-ascii?Q?ieXxay5+UTMpZdUvXkLSqigswtRuAsvQSf9PYrjVczvmtGPV1rjHFpRa17Mh?=
 =?us-ascii?Q?AvHD6o7Zao4F+sdhQoW5EKgO50EZdXOY01Yu4iHqMrBwHw5HI+JvHJcnmGoL?=
 =?us-ascii?Q?NIm1ZlSWxvL1crA3VkYB8xDoTpw9evF3AWr6MO450/hOc3ukYE0d5ZI/vLQ6?=
 =?us-ascii?Q?ZU/55EM2SWARY2Jn1wRtLgnqiLkSmV0CxniJP8V/8Nq2I0z/rlP7rlncniRR?=
 =?us-ascii?Q?cGDSqT9cMexv11Ji7afhk7kF+KSkGL8RBD3+jKU1jblMaWDQEOntKYxUhz+f?=
 =?us-ascii?Q?vHCVieRhMd620P3BfE7SkDtTBgDjxucLTct5/1w/OOl/6lRcCQieRQs0OKz7?=
 =?us-ascii?Q?N7s+deM2JRZ4yKJEWbRmuiXEZrKcN0pprQ/nUNX0ul9PJ/zENuQHk1ZHrACg?=
 =?us-ascii?Q?JmUod/8WU7mgLAOZjafqe96wWbKcwGxGAzRV1yeePEbkg9NsToWsfdrrNbjy?=
 =?us-ascii?Q?Etiift7VkTbdXFPzKwBHD2cm5060F2w5quKphv9NhsIcSx5Lx4JDxO9TA8xF?=
 =?us-ascii?Q?b33bo0ZC1SBWm1SoHKDHPZylmyr592AT/SK9mSNkKZVos1Ip2P1CeNx3gRid?=
 =?us-ascii?Q?TuXE6VAZoqju9eoAM7wCuOBSqk4wvD3gfL7DULT6gG1Z0t2oUfXBYFndsTIB?=
 =?us-ascii?Q?4xEa80hCTWoB3bcFpb6eNJk+zWOGC04elwNd/gzi4aRNn1w8XmvTGKrKoTlA?=
 =?us-ascii?Q?jK2uxkLIVvyJ4QaSr7aB2qmHSVuR8cO9ymxYmsZp4lmPa/5zVvPwevWYI8uc?=
 =?us-ascii?Q?irym7lbw942nYTh8AzpWb4a+FX09FDzSCpSLjJa/aw8HYVXX8EsaQtux5HQJ?=
 =?us-ascii?Q?+rZfTU+gjvNPLOCu0fEYmDusuVIablnA/EEgHn5gUzXDx1w13SgHBvlSLJZd?=
 =?us-ascii?Q?WHXjW5FaNokul8TMbzN+K3AtDPt43EUQeP1gCcpTcVoVptiHI4/kk4sx1f/o?=
 =?us-ascii?Q?2mCjgQWBb9hqR/HOr6E9hlepBBLxa1l4gZ9Zkw8wjpZUIfk4zt8zbRHBxk+Y?=
 =?us-ascii?Q?F1CQhvxIgO79+/aUcGlpbUwr7jmtdC8qe0qRp0NyPuhboKQKfkZVEMPNOkxk?=
 =?us-ascii?Q?LbVowX9SV/GbMnxOqq3R7ZQYe5rdJdNeMmzLkFZjCBsfUIYNBUnpRSujNWp+?=
 =?us-ascii?Q?0tQky7Im8DaX5A86yB4qANrttyakKNi0jbaVbnmxMxUAEc2/L2phX5KyCUBr?=
 =?us-ascii?Q?Qxso0roJRpQBEovbWrWQTOuJnALBtpLlBf5jcMGXr5VCCtfr4ZJLjgreZjZC?=
 =?us-ascii?Q?4KBTazuSxM4d+obaaLgVR85kpRHb37EcZIoAea5i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc82f11f-df49-4a2c-c170-08dc28c7a334
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:01:48.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioORrWEEYLF8nG+iqKIz3nvSRqkv06ALY1xfgZp7RGih/HfAfFoggBfysk4xrTKUks/i6OvrJX9rqq3wNc/yKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

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


