Return-Path: <linux-kernel+bounces-148181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D338A7EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0056328128D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BBE1384BE;
	Wed, 17 Apr 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OS89q2jl"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB2131E24;
	Wed, 17 Apr 2024 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344082; cv=fail; b=PIYOpgvsH60C98vdAVUPIri5PoP8D1BQXZmwwBohiRNlyJyusQ7zDEndHzgxuROO9q0c7SKwUY/9MSsvQdgV3SVzyIi9+wgXkRCaHklNkEMclcDMhg/7N5DOpRMcW7AqX+jy8gnFzmkf6qdi5MPf0bBpfx1+RsS5Myw/PyOF7Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344082; c=relaxed/simple;
	bh=XcQ2R7YiJjsh7T/WxrW0Bm6pv+6NTzK2DqXe6ntFeqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxQN/SucdL8EwVFVhVBoVm0rfStfBVdx5kLrceNs+R2CxCRJ/DF4nlevQ2D0ldxqIs2M6tIGKPITjWr9FfkwhSQXVmjSX2AJDhQArroEhuEEirkVUs6T1yoVjPgn+aEHS2tLA+87AKYujBDCqj26V0h04WswZhqfN80Ic2q1JWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OS89q2jl; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE84bVXqxj/DEuC0vOI5qnOmNxNhZeYaRr2D3IIjWJtsBsj4HfETbJyfMQdRACb0/mFWdxXIwQlNJJOB1RKhTO+wOJkhf0tMd20X73nPSY6F/QF5VJrnvz3KcmurYdETeRv9njJcExE2ZbpDqGQdagiBzugPa5yBJxmCd/5pC8T9Y0glrDwzaM15w2aYgZN2Ce/hmS7X5aTBrbPk6EUqyPH7I2dv7zzkUbSgdAuoz+801K2tfRU+CQyO1BVNbLKPUBkp19fZlR80hGwip4fr66ObPIsnXW4FKNXP/x8dyWyieheeUduftmuvT6UyfkIVHh+cOUoVXEWNTTPwlhvfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlBLox3pqizc2S4V5n61qGSPgpILKHXqhYrZ6UbesPE=;
 b=TOKeyAnXXbU/HfMxEm3QaatsOq+ET65o3EjyCOT7JIIl8Pl6DUm6TrNTSjPO0urZcK3zejP5y9TnlY+um1K2/KzISsiKv+nXQJwjrkfyc7IiXIhv/k8xJLP0FHgbpn1SNObKQV3DoK8UVWWn2bOVliuPVGIGL5HAEkZS2CsRN7v7VrXLtNxyU8+7+k/1EDjw79GAKQ9axKDr/QpO3mUQCuO+YdyLbDMs2XkuzHc2G9eh43DP1BBVS0s24iyiyKE/hcefuYJPKdEq6TPN6YZPpK4x7nNQ3eTdfPB8Gnrnbwz/APrGOH16IqSdB7lzgjCfHKT82MlYcq2pRpuYikUdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlBLox3pqizc2S4V5n61qGSPgpILKHXqhYrZ6UbesPE=;
 b=OS89q2jl4Ap2E0gpxSKsLxhsRyvTBgpGvhYhdeQuCN6nPAeINWv3nTCm5BhO1d12myLDMhN+stK01xrffH8PJEoXEIr+DiZXf+k8YAAJGQv/WqG770+m+A4gmwkJGirNLmXs9K0NNsxtyQezrYJSkg1TUFSRURMiI2zf2bXD4vH2oLkBhQc04n9CvUtJZlryCQI46SFnpiV2xzROhsYjw3VernGrcLFlYzCsOqAkyptH/v+4ICAcyEOyj0aDlW8OM280f9+xjtFaeWyP4MeugkpW+B/MZFSAfISVaqB6ZXuryoMUc65y3qsNzVKfc0Pyv69djIXJZXFAahKSsNC1zQ==
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 08:54:36 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::cf) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Wed, 17 Apr 2024 08:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 08:54:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Apr
 2024 01:54:25 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 17 Apr 2024 01:54:18 -0700
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
Subject: [PATCH net-next v3 03/10] ethtool: Add an interface for flashing transceiver modules' firmware
Date: Wed, 17 Apr 2024 11:53:40 +0300
Message-ID: <20240417085347.2836385-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417085347.2836385-1-danieller@nvidia.com>
References: <20240417085347.2836385-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e90d5f5-4768-48ad-027d-08dc5ebc0204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0XenUvnf7Iy6AxDcRVFbHv7qCNxO/QdfCmJICjxDpryZv5MlccPvAR1mXZ7v6qroYvTIkYMzvs5teRalGpGlzA0Fcn0tKij7LWzAvkvnrtxMeZwvsnillWrNzvbgLLDUTKM63X4rOoHfyA+QLnZ5BbS3f5Gpz5JZ7G8NPBuhY5ikqwze/CdYLUX8wcL3c+DsPlVOw0/ZyUKznHwDAvhAc7cniazUq/wzz4Dq7UcKX4W19vF7h5BJX0UX5jRsdsjEqT2FaCo+A8PTcyQho8XrSpLGFBP98yfRU1+aNcf+LMmb685dCM7clFqerlWktT/RUDGFKkv4VwQ8S7N4NUo8JzXFtyzJFuQHI9lUAElTqBHeV7FOae1lvMikPrcnpzTzBCJuBXx23SSfJ16bkrbps6edP/c78MIdPyQrX0XwENv3YgwIs4x4VM3J2v2lmVYyof/0hxJgzT1aCJGZfao9N8PsNLQi8cC1pITImjRFqBWGLQBUkkePpLpZEDqT4SIwmodyFVrQHGBTZZOTCS5JJa15SE0HP/rDEox3LUOfS4qVr69DlEFftnU4RI2BfgUvOgtSKPYwhXuezueTuNOTh0r1kmwUil7J+f7IUbNIh0l3QMwizHgJNCPuwepYEUBYjjO5wCYsgBc8SlA4l4jMkz8gxPJpQQjB84ajWZHzcfUGj5uy6bIvsGukZ5PNRZkCVvwrHaycSg6yhMXs8c7huKPdb97Kqfdb+FmiF2uPgpSJIHMyc8BeRCMCVQqLN2lh
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:54:35.8885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e90d5f5-4768-48ad-027d-08dc5ebc0204
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599

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
index 4e63d3708ed9..76ec2ac0d013 100644
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
+The firmware update process is composed from three logical steps:
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


