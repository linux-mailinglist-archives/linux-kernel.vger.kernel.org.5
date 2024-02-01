Return-Path: <linux-kernel+bounces-48399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AA4845B73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676691C22947
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6177A0C;
	Thu,  1 Feb 2024 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uWlRAYy/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC5779EB;
	Thu,  1 Feb 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801162; cv=fail; b=LWO4v1VFh7T5Gf9uzMDXxPSlNxAaM+do/l9+jLW9RoZnHrgK400AWkuNtkEz6lYcFpR7O4X8A4zLys6+GokM7EnT8Cl+3RzCb4BgEVZhnEKXKIMOXdX1iT0I5/pqfbwD4l0MvFeRFDhe3YTanyTeJSTHYfI35kB+fbnek0wFKcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801162; c=relaxed/simple;
	bh=si5gyNKs36hGLG8De4E27+Qtr600ENRJxhY8C4NkxY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/gFA+vnqO8+oewslWwf86YcSlBAp1zur8s8FjrJt8wG+AoyOX21532KerdsbHWPxUzwvUEpg9/T9iOyG/8t3zdmWmXZ2e12iPTiWU5IYiYXqf71KeIENWYk/4r/ZL1p3+7MOhGCLM8YUqhvZCbkABs/Sbvf8OjVcVHvXXClijI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uWlRAYy/; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h15Z2nTQ4U/ioWvkfdcYTTSWb/Wjwac446Zj3O8IixCG0+/IjgjXkWCb9dhk2SuN26BYjf5qpVZliBdUu5eMWL1MRPP0/DU9VtNceg+aIYtfq2ldeh/BMSZZVzM4/0ksSR9JUjp7isWy9Nio0Ak3ziE1/FCS+Plwg4eziw8YfP1MyY6lbozAnBvIImkPTpUECu3sI+iIPL5bFYBpyf8vfogmFOofIt2aUd7Axl0TLMKZgcfOZueo6f3Fj84GZ7smFPOhR9Lkgc9fWi9G5TmqedF2YI1OyWXE3K9ubMTCU8RukkVd1f0M6OTwIwdlW1favKQnXYkLgkc7f9eN+X3L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUAnH/StJZjgg6j2S4ErHaX/LBWWzs4aXC80hw6QNT0=;
 b=TJ3VTYw/Oysf3TWEkwVXg22M8cWAqPVuVz36vtdpbISIe//Qo+qxRmSOtNlSmRMvpoi/8IXTEV3mTxPTjEodb0UL2k55RF+xMstRawRypJFdNuD9FVNqtzkGP4hisKwhZ+CcsljF1N6g0a79oH7iuRDWuA+EBT1RgnAoxxFKjiFr7LqteKMXbGDYKBmxe/fCX/cxJQxvnmj3w4qW4cAxyc8stKtkTacujeGkhlItBPU6p+E+YsezWyUKkVO53kZy+QYzvTVygDCcvZfOBx2fiGDndZAnCHonWiSWGLzstQYKM6U8MXitDKYVwg1QirPnScUY3gKDoAKvNbpnqqumXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUAnH/StJZjgg6j2S4ErHaX/LBWWzs4aXC80hw6QNT0=;
 b=uWlRAYy/OsQkdsfM2UGTGzdQEI0t1E1pM6AapOx4yvHM+WFzNLND6CWsnlrs1bINy7IbNQoag0rgybzklJI8cT0wLhgncPZGAoqInkXkTkZBLvO9TZuNqTJREm54AungaG1/L7/wYDGXGyhVe9LuIn5JNQzcWn88Ns9QM0lnoqbXZVqr7/cbmLzlYI02IbNKmheOU11+8pnVHhxlk9P+ROtKkMDwmULn2PQR36bmg+2ZuFnEs7Kms9F9bUFwCV2C6WYb558fUZg1NolX+NQVNRCfv94SO68j2ffTaUqs4ii3adM3GmqGfV1zINp9ZqiQaisPTPCqKCmEI2b8iHSerQ==
Received: from BN7PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:20::19)
 by BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 15:25:57 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::25) by BN7PR02CA0006.outlook.office365.com
 (2603:10b6:408:20::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Thu, 1 Feb 2024 15:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 15:25:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 1 Feb 2024
 07:25:39 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 1 Feb 2024 07:25:33 -0800
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
	<idosch@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [RFC PATCH net-next v2 3/9] ethtool: Add an interface for flashing transceiver modules' firmware
Date: Thu, 1 Feb 2024 17:24:55 +0200
Message-ID: <20240201152501.3955887-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201152501.3955887-1-danieller@nvidia.com>
References: <20240201152501.3955887-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|BL0PR12MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c8391b-d5ad-42cf-3cef-08dc233a16b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LfZFx+ZKzEl5vH/lgZu+Aqk8R4hqyk8SaQjtQ3DEBVCpzSzkI9TASkYBjZM9LQ2TTcDLh7MBE8ewlMA+0d0uoUktbQj3MSs997O75FWtJ7qR0KryO7m4epKOkcpol9Or86ohKYgAP+LMgqccS9zOGtfKrpM9zLA9TzC51JRle8T/B2TNPTBAazyXlJ+NDCqSJmvHMDXIGMIxy9hFnsCAL3sIGeZd6WIDW+PM3//RkMw1rvkaEhvoQZblBKTb/te0r68+Ak9fF57uGyTVLH1cG2TiKKu6ucbEdV3NNeelYbmI5tHmQUPP70W5xqZXFBEwBP/srDFgmTFBoKu23ZF+2H/PBGRs3Qh64LeN8ztbFizm19yk+5vYTNFPPjwO0g2MDUGWxx+8ffaaTHd59PxL1N0kQkQiRllmiZMpGb7A7y2RMdcHPtmSD38WHs9kuaKq/5iPEzuGtpUZHVmPd9h1O4tbYqWzxWeDZ5btTaMVDsaxq7f2hcXeV1dde6btY/1vuN1h+UFp4jJCYjZpkSrz64qubuRk8Qf/b1IPhtWC/u8MYzROsk2qjIf9nhnQwp1bViH6WNni6zC0Qp8XOqfBabkpQKXtl7ywoachySvDP0UyreUw23c2Zr2I0+KmpNUPUmlvcs1VcsAU5mJZytbIb3JOw14PDj1kjAiX2z8vLs+Tol88IHxt6qM16k845tf1urhHNTLu6SQGyT3rL5oz8QSO0axw5E3hbq1WvAjtd/i6DTIBVC6Qg9ANmJSjHrMKXZSSfAjjoDBGe/ECxQFlig==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(5660300002)(4326008)(70206006)(2906002)(7416002)(8676002)(70586007)(8936002)(86362001)(83380400001)(36756003)(316002)(54906003)(6916009)(36860700001)(82740400003)(7636003)(356005)(6666004)(478600001)(47076005)(2616005)(426003)(336012)(26005)(40460700003)(40480700001)(1076003)(16526019)(107886003)(134885004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:25:57.3722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c8391b-d5ad-42cf-3cef-08dc233a16b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948

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
    v2:
    	* Change the status attr to be u32 and make it an enum in the
    	  yaml file.
    	* total attr: u64 -> uint.

 Documentation/netlink/specs/ethtool.yaml     | 63 ++++++++++++++++++++
 Documentation/networking/ethtool-netlink.rst | 62 +++++++++++++++++++
 include/uapi/linux/ethtool.h                 | 18 ++++++
 include/uapi/linux/ethtool_netlink.h         | 20 +++++++
 4 files changed, 163 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..24b2c8dd86df 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -16,6 +16,11 @@ definitions:
     name: stringset
     type: enum
     entries: []
+  -
+    name: module-fw-flash-status
+    type: enum
+    entries: [ started, in_progress, completed, error ]
+
 
 attribute-sets:
   -
@@ -942,6 +947,39 @@ attribute-sets:
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
@@ -1693,3 +1731,28 @@ operations:
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
index d583d9abf2f8..e73149c66620 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -228,6 +228,7 @@ Userspace to kernel:
   ``ETHTOOL_MSG_PLCA_GET_STATUS``       get PLCA RS status
   ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
+  ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``   flash transceiver module firmware
   ===================================== =================================
 
 Kernel to userspace:
@@ -274,6 +275,7 @@ Kernel to userspace:
   ``ETHTOOL_MSG_PLCA_GET_STATUS_REPLY``    PLCA RS status
   ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
   ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
+  ``ETHTOOL_MSG_MODULE_FW_FLASH_NTF``      transceiver module flash updates
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -2004,6 +2006,65 @@ The attributes are propagated to the driver through the following structure:
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
 
@@ -2110,4 +2171,5 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_PLCA_GET_STATUS``
   n/a                                 ``ETHTOOL_MSG_MM_GET``
   n/a                                 ``ETHTOOL_MSG_MM_SET``
+  n/a                                 ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 06ef6b78b7de..79041bdccd61 100644
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
index 3f89074aa06c..44e02533d01d 100644
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
@@ -976,6 +978,24 @@ enum {
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


