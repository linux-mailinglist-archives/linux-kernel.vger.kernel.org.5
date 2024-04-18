Return-Path: <linux-kernel+bounces-149895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005318A9780
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCFA1C21314
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340215E7E0;
	Thu, 18 Apr 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JEVIQa6N"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343415E5C6;
	Thu, 18 Apr 2024 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436550; cv=fail; b=bdk3H5Zvm4PSumakd/KHXSRDDP5+3wUy/ZcE8xdgqjCG6jMgGq/vVfdbRSZHvCcEc1nKvkdLWbteuNBlj8dHq4lHd3qELo6GiwOwjqmX0oPEnPBxAtK5HWYU/X4JORivZHJwpPt+b8skCfsbocj/3YsZSgMhjFsAEMlVVpj0pA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436550; c=relaxed/simple;
	bh=BDXDoN0Di9pbsJHMR53z1nGqZsL6dPQwhsb/cUsSNJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCy9e+skxFErRdaRwibnEp4XpApQdS2GSXE29vnktc/YB4vJ1UFAwFc0t5+qm9KVcNmB/TnvRIv9tPQU4iKgzvKdjapQKVZlZf5JvHhzlNkwoOPE55KlVcGn2F11GqKSAgvGFo2NuqVzrF9+pNAG15Zq966p/mWmvJICuxSw5PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JEVIQa6N; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Citre5RB2EJAo/90ph5plJQgEi6Fl5r7hjaNtDD7LT0F1+qajej1v34ZRpYxRVZm9qnFEq+Z7VjYw67CqpPLZ4ti5Vv1AzelaIhTa6Q5a4BvzwKESJeOF8HYpHsPb/d5DnrDrON+kIlPnc7b8WSC8YW+CSgUAtKec9C+fMDKwvt0Da6l38Ky+nj5UI0WHGDnewMVGY9gNB1mi7YOHOywvFpGjtP2w69aGhvJN90pf6Rvu3ibYhofasy7/fgIawYlRsA0H9Mb5owjZOe7TZTMaEso1lQO4r+nepQpwDFRQIuRPO/PAN5iQNPrH9ReQnbSa2PDMHzLgrJUj7U3GZLxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rujS6xBEO7WodqPtAMGKg1T0RaLnMfkV8FbL5X0PQNQ=;
 b=Tw5NM71TlEgMndgBtkilM1gkvKpuKPZ5TBfT+4L1Wv6PajN1Nciveuxh+VBiZsGmPDhrExnEFpR5Tqom9b8VV+cDBD7iafcjCElPBK6+/CbVxKru82o2drBq0ilszT2mMLfvM0Pn5IlPoXEp3/IQKCc3uhAi9GT501SW0MpG+7XbjG+B3ItR+ATuMiyCNbYDAc6nJkUGFioJr6ditSXZRCJoqHwGDYFC5waT/BDZwlRE9f9TZIfyBKw3A58QlcjwkuLHxTft4YVU0UP2r9edaszUWTQVxscSw8/IUQmN4W3KjdceNKFTtAEpIy32vvSfrjm8bZ/+ndafn0MGs4Oe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rujS6xBEO7WodqPtAMGKg1T0RaLnMfkV8FbL5X0PQNQ=;
 b=JEVIQa6NpQIk5WMajEeYK8uhYydI1+YgOgdFQbj6u2GNyB7S4VokA2PGK2ZfK1yNrdKTe5zdynmewv9WYbkrDvxIl9gOQxf8gB5JVewOorO864dc5AgxDXX33uj522WP+dOZQYisMVSfO2CGUQWR1wAUcHd7t3220x+G0p9CvyEj77+40MawoXLA7s4RP8I6RO0oQCGBS9gCXQQiapqsEbjmExVYNdf4No5iFJxk3eImsGxyqmMewpGRWaGcPlmRvgOhg0h4BAyUa5LtW1XHd+svMrvEEITf5HVXE0C4q06m5N4eglQPCSXkndyjqlWdMa6Y5e91RpH1R8cBqdU6UQ==
Received: from CH0PR03CA0078.namprd03.prod.outlook.com (2603:10b6:610:cc::23)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:35:45 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::54) by CH0PR03CA0078.outlook.office365.com
 (2603:10b6:610:cc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Thu, 18 Apr 2024 10:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:35:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 03:35:29 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 18 Apr 2024 03:35:24 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
	<sdf@google.com>, <kory.maincent@bootlin.com>,
	<maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
	<richardcochran@gmail.com>, <shayagr@amazon.com>, <paul.greenwalt@intel.com>,
	<jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mlxsw@nvidia.com>, <petrm@nvidia.com>,
	<idosch@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v4 03/10] ethtool: Add an interface for flashing transceiver modules' firmware
Date: Thu, 18 Apr 2024 13:34:48 +0300
Message-ID: <20240418103455.3297870-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418103455.3297870-1-danieller@nvidia.com>
References: <20240418103455.3297870-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c59d7c6-be1b-4310-06c4-08dc5f934dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YE2w+sHWgUMlt1zF71eWHPdUGLXOGNWZYdwvV0sEUAgQZplzcFTeC0gco1zh6FFtBX5Zksckrcx+HVVlErhvkH4oEbsPJcqulyL66GsjCqOxI/EPiTf1X0tRot/dMgBZTTlvf+iKsW8+ChXm3MwHJSAIV/hm7y6UOzuilkq2UbyucNGiz0qam3ZZLSYdTbfsp3fX/DJH92Js8sRNIQCzxeWs+7v9cyeBGE1Da7tZSWHNn+wSG7tzMo5Vi7StQFBJqMcLhR8sqXYfP1Z6g/xciuci0G+vePAOxmnRwWriKlhjSXKZNKac5i9ofK2p36PFGlLld0e6h4WsdLBCcz01J9Z1sa9/xPynEKgz3kB2aqYt5SUCfafT4zCmxeYRvpsALTTgyaMsX1BF1a7gnFmwJWrWHZX0UvTC3j6FMut3y4fuc4PJ/89V1EvDi8Eg0xNO68Kxz6WPS7Od4z/lcyrPYwnkF0Vv9Cd+tEBE2Lo0u8sYOZgFasY09nGYAaRYQ6+riMZnkd8Tv9In8jKHlLk9Y7j21EbffMWIg9L+9S4V6FHIqsr6kRfUn/SOZS4Xpt2aQAEXJvmFyl1SYYBjOcXfvPgoUgXSAEZy4QF2xSLm5xFP+eAg5a+Kxx9mWt1z/AJG6qR76/ToRkHtjsOA6bF+yZ6d1uifN4yxGiJO0w9KL/kW+QwzZomGCuqZxPWHpXO0e6R4lDiO9naO2g/9OIeyhWDyPmyiQEaxkqT2WgS6pJ7UnSw5Za2lbczSZv8bOlBX
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:35:44.9432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c59d7c6-be1b-4310-06c4-08dc5f934dde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906

CMIS compliant modules such as QSFP-DD might be running a firmware that
can be updated in a vendor-neutral way by exchanging messages between
the host and the module as described in section 7.3.1 of revision 5.2 of
the CMIS standard.

Add a pair of new ethtool messages that allow:

* User space to trigger firmware update of transceiver modules

* The kernel to notify user space about the progress of the process

The user interface is designed to be asynchronous in order to avoid
RTNL being held for too long and to allow several modules to be
updated simultaneously. The interface is designed with CMIS compliant
modules in mind, but kept generic enough to accommodate future use
cases, if these arise.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v4:
    	* s/is composed from/consists of/.

 Documentation/netlink/specs/ethtool.yaml     | 62 ++++++++++++++++++++
 Documentation/networking/ethtool-netlink.rst | 62 ++++++++++++++++++++
 include/uapi/linux/ethtool.h                 | 18 ++++++
 include/uapi/linux/ethtool_netlink.h         | 20 +++++++
 4 files changed, 162 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 87ae7b397984..718073f4fb3f 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -20,6 +20,10 @@ definitions:
     name: header-flags
     type: flags
     entries: [ compact-bitsets, omit-reply, stats ]
+  -
+    name: module-fw-flash-status
+    type: enum
+    entries: [ started, in_progress, completed, error ]
 
 attribute-sets:
   -
@@ -963,6 +967,39 @@ attribute-sets:
       -
         name: burst-tmr
         type: u32
+  -
+    name: module-fw-flash
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: file-name
+        type: string
+      -
+        name: password
+        type: u32
+  -
+    name: module-fw-flash-ntf
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: status
+        type: u32
+        enum: module-fw-flash-status
+      -
+        name: status-msg
+        type: string
+      -
+        name: done
+        type: u64
+      -
+        name: total
+        type: u64
 
 operations:
   enum-model: directional
@@ -1715,3 +1752,28 @@ operations:
       name: mm-ntf
       doc: Notification for change in MAC Merge configuration.
       notify: mm-get
+    -
+      name: module-fw-flash-act
+      doc: Flash transceiver module firmware.
+
+      attribute-set: module-fw-flash
+
+      do:
+        request:
+          attributes:
+            - header
+            - file-name
+            - password
+    -
+      name: module-fw-flash-ntf
+      doc: Notification for firmware flashing progress and status.
+
+      attribute-set: module-fw-flash-ntf
+
+      event:
+        attributes:
+          - header
+          - status
+          - status-msg
+          - done
+          - total
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 4e63d3708ed9..d09342c608e8 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -235,6 +235,7 @@ Userspace to kernel:
   ``ETHTOOL_MSG_PLCA_GET_STATUS``       get PLCA RS status
   ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
+  ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``   flash transceiver module firmware
   ===================================== =================================
 
 Kernel to userspace:
@@ -281,6 +282,7 @@ Kernel to userspace:
   ``ETHTOOL_MSG_PLCA_GET_STATUS_REPLY``    PLCA RS status
   ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
   ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
+  ``ETHTOOL_MSG_MODULE_FW_FLASH_NTF``      transceiver module flash updates
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -2020,6 +2022,65 @@ The attributes are propagated to the driver through the following structure:
 .. kernel-doc:: include/linux/ethtool.h
     :identifiers: ethtool_mm_cfg
 
+MODULE_FW_FLASH_ACT
+===================
+
+Flashes transceiver module firmware.
+
+Request contents:
+
+  =======================================  ======  ===========================
+  ``ETHTOOL_A_MODULE_FW_FLASH_HEADER``     nested  request header
+  ``ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME``  string  firmware image file name
+  ``ETHTOOL_A_MODULE_FW_FLASH_PASSWORD``   u32     transceiver module password
+  =======================================  ======  ===========================
+
+The firmware update process consists of three logical steps:
+
+1. Downloading a firmware image to the transceiver module and validating it.
+2. Running the firmware image.
+3. Committing the firmware image so that it is run upon reset.
+
+When flash command is given, those three steps are taken in that order.
+
+The ``ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME`` attribute encodes the firmware
+image file name. The firmware image is downloaded to the transceiver module,
+validated, run and committed.
+
+The optional ``ETHTOOL_A_MODULE_FW_FLASH_PASSWORD`` attribute encodes a password
+that might be required as part of the transceiver module firmware update
+process.
+
+The firmware update process can take several minutes to complete. Therefore,
+during the update process notifications are emitted from the kernel to user
+space updating it about the status and progress.
+
+Notification contents:
+
+ +---------------------------------------------------+--------+----------------+
+ | ``ETHTOOL_A_MODULE_FW_FLASH_HEADER``              | nested | reply header   |
+ +---------------------------------------------------+--------+----------------+
+ | ``ETHTOOL_A_MODULE_FW_FLASH_STATUS``              | u32    | status         |
+ +---------------------------------------------------+--------+----------------+
+ | ``ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG``          | string | status message |
+ +---------------------------------------------------+--------+----------------+
+ | ``ETHTOOL_A_MODULE_FW_FLASH_DONE``                | u64    | progress       |
+ +---------------------------------------------------+--------+----------------+
+ | ``ETHTOOL_A_MODULE_FW_FLASH_TOTAL``               | u64    | total          |
+ +---------------------------------------------------+--------+----------------+
+
+The ``ETHTOOL_A_MODULE_FW_FLASH_STATUS`` attribute encodes the current status
+of the firmware update process. Possible values are:
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_module_fw_flash_status
+
+The ``ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG`` attribute encodes a status message
+string.
+
+The ``ETHTOOL_A_MODULE_FW_FLASH_DONE`` and ``ETHTOOL_A_MODULE_FW_FLASH_TOTAL``
+attributes encode the completed and total amount of work, respectively.
+
 Request translation
 ===================
 
@@ -2126,4 +2187,5 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_PLCA_GET_STATUS``
   n/a                                 ``ETHTOOL_MSG_MM_GET``
   n/a                                 ``ETHTOOL_MSG_MM_SET``
+  n/a                                 ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 95c2f09f0d0a..332df9f36062 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -822,6 +822,24 @@ enum ethtool_mm_verify_status {
 	ETHTOOL_MM_VERIFY_STATUS_DISABLED,
 };
 
+/**
+ * enum ethtool_module_fw_flash_status - plug-in module firmware flashing status
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED: The firmware flashing process has
+ *	started.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS: The firmware flashing process
+ *	is in progress.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED: The firmware flashing process was
+ *	completed successfully.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR: The firmware flashing process was
+ *	stopped due to an error.
+ */
+enum ethtool_module_fw_flash_status {
+	ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED = 1,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR,
+};
+
 /**
  * struct ethtool_gstrings - string set for data tagging
  * @cmd: Command number = %ETHTOOL_GSTRINGS
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index b4f0d233d048..c98c635c532f 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -57,6 +57,7 @@ enum {
 	ETHTOOL_MSG_PLCA_GET_STATUS,
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -109,6 +110,7 @@ enum {
 	ETHTOOL_MSG_PLCA_NTF,
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
+	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -994,6 +996,24 @@ enum {
 	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
 };
 
+/* MODULE_FW_FLASH */
+
+enum {
+	ETHTOOL_A_MODULE_FW_FLASH_UNSPEC,
+	ETHTOOL_A_MODULE_FW_FLASH_HEADER,		/* nest - _A_HEADER_* */
+	ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME,		/* string */
+	ETHTOOL_A_MODULE_FW_FLASH_PASSWORD,		/* u32 */
+	ETHTOOL_A_MODULE_FW_FLASH_PAD,
+	ETHTOOL_A_MODULE_FW_FLASH_STATUS,		/* u8 */
+	ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,		/* string */
+	ETHTOOL_A_MODULE_FW_FLASH_DONE,			/* u64 */
+	ETHTOOL_A_MODULE_FW_FLASH_TOTAL,		/* u64 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_MODULE_FW_FLASH_CNT,
+	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
-- 
2.43.0


