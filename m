Return-Path: <linux-kernel+bounces-99336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFDA8786D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E69281199
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7A4535D5;
	Mon, 11 Mar 2024 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4YzjrcHH"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532F4AEEB;
	Mon, 11 Mar 2024 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179998; cv=fail; b=qAKFtK/zUX9vlj7thrY8KXhnSXSKc0SI1LgfRDhZ2oB6eMYAWOzi0gs2oFyA9FePwtL/8M6gZqt6YYgFwyUfU4yJ+4cetT10dm1WFnAMvAp/LrtcVekMVZGIR+xwEihiwoWAQsCavTED+nYmzgsn6Bz618i6+2rfO65ibd2IWgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179998; c=relaxed/simple;
	bh=l8uIdRyLCRyCnchbr5JPhwWhC/XBEKqaJrXxnvC2VUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oLurzIid3T9eQLqEdwUDh0VVqXP33oUus7gPyd8sJaUtiltmkG0hyRXgqHLpFieZ5Kkx30MUl5NQSN70IDUINbOBjt7H9KEg0Db11/KfMTjjFZi+NpNLf5M5LtWQH/NjrES35fWHsEqN2c1EPfuUHw2UgvxSrfMUJ6bpxX31ZjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4YzjrcHH; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBfBAjdKwhSpkdevzchQ7IAOJzXTjva5SPbADDZYmBwYq7mc19kAvKPrP3aCFAHLuBctld4ADdAAwJKrQ3U0mo2F9kZybWXpjI2xTchaRfhLtuzvhAi7qt2L7JaaugvMvU2fBJAZvkyaCWNu2RxTbH1cLzuCu3kDcjGfsVo4DRgkrtXnMJmhvuU8Bby1JdAUr6mIuxbI14vkJQJRDP0qyIbpxzkGuMFDalidSQSktk1XkeWy4TMopaKOc6RAToZYC6+2hk9HjwZHF3ffNUeAw12nRmg+zsJQsiGyz87JhwyfrDi2b2wqWUFodz00REJZxuF/KyvO9Ndly550MJhDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsy8XsIZAcCAel9rzkJb3pS+9CeFFLKAtfXysL+Cnas=;
 b=mrPbqzR1OP0c6Bu1LAN0itw8vWrgRtiAM5zkxN0L7tk8GHJm8xwGRbjVHYcEidwXnRotYv19P1j25hxKqYODEAGmidXN87FVnIayIMnl7mMhXSZnT40dlQ6dxC0IOn2W71xFwbDPYI3jGW2JHOhwhWRiPqkibJVZ7YNM4Gl0/O6r8fGxg/gJ1oRiWkWclU6gtLr0khht/0lo2k4IbI+yuJ45w/ysKIWvT+4WfFO/MADmKGFYbCnrMYlWvR/S1J497duecAt5eEF5x7c+t6e6sg8YUtfOmpI4ZiyzFKRvhqTicztj6T63fyin3JPUcM3+2WA1FHhUjDu/HzKNs9fdMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsy8XsIZAcCAel9rzkJb3pS+9CeFFLKAtfXysL+Cnas=;
 b=4YzjrcHHz2bTZtUoXZfJZB7An6fUuAuA1O6Bz6XpWqkOmoXf2HyEmuWyV6mLDS46GM5MlaZPZBGE385QCh+zSTcyZmdqVwt6bv5RDpDuAGyybxu+sQ5+0xqwoIVihoas58mxhJsV+MXUs/YOHE42wclQQP3Kz+L29Wu/DVeK+HY=
Received: from CH2PR15CA0004.namprd15.prod.outlook.com (2603:10b6:610:51::14)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 17:59:53 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::7e) by CH2PR15CA0004.outlook.office365.com
 (2603:10b6:610:51::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:59:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:59:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:59:52 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:59:51 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 0/4] add zynqmp TCM bindings
Date: Mon, 11 Mar 2024 10:59:23 -0700
Message-ID: <20240311175926.1625180-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 53eabc16-be11-43b4-eb8d-08dc41f50ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LiFCWIbx+CuTh2kNJOh+J5tjdJb3bgPCv7xQ08y34/HZ7mavfr09ls6wNS7WXCVzS9Uej27Y3ucwk+0uECKuMBK0YrxrWPtiUd2iiROG3bR2+p3WoDtz8U1LRPnUmKNpbO6LNpv9KZF1WGoQOvs68T0cPYCfKOPZ+o2cxlElY6+4adYPKCu+QB/GiVU3IxEeT3KoiI1oz7xFa3/bt7mCVIKJgU9gfaj+vNY9Ss7cBTxp6IoUN845dIlAXlLZmi8mtqTQk3AeCDlrWtt3Dwag+LG+xTWO10HGOe8xyOpbQFG2veziO9QgPXkvCsroMBSuMhwLysPt9Lg/s/gcVmINjgkQ2IZSrK5gX6qqHWeIi0vDe9FGl2GXuBY8l6BiNX7IAop7bA2gkur5/x3JjtXdTf1S28E41px1qBzpyScAiNi7p/ADvThM0vR2/39w7FnYCQS36DcmtRMwgjhic+5am8mUk0FMEfP0VmTa5sfn2MVZHqEpFc6GpJEFPnXpBihjEThBwZjyNxtbdEBw/7uKrbgSar+JuI5iJMeqXLLKw8O0TOEb0Nv5EsdqHmBQmOe8PjvfM9++QcpQrYa99S4mh0T30rBLdYWNYacxzhT08G5RpBpPYH18YgWZdQcihdWSVzBqqDCzGuCLXWkXU3rKtoUAwE5C7DtSM7msLWZvXiWlhk0tzmnxULjviz1J55UtqBalJDKfZmUt43Rtkym82g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:59:53.4558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53eabc16-be11-43b4-eb8d-08dc41f50ddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021

Tightly-Coupled Memories(TCMs) are low-latency memory that provides
predictable instruction execution and predictable data load/store
timing. Each Cortex-R5F processor contains exclusive two 64 KB memory
banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
In lockstep mode, both 128KB memory is accessible to the cluster.

As per ZynqMP Ultrascale+ Technical Reference Manual UG1085, following
is address space of TCM memory. The bindings in this patch series
introduces properties to accommodate following address space with
address translation between Linux and Cortex-R5 views.

|     |     |     |
| --- | --- | --- |
|      *Mode*        |   *R5 View* | *Linux view* |  Notes               |
| *Split Mode*       | *start addr*| *start addr* |                      |
| R5_0 ATCM (64 KB)  | 0x0000_0000 | 0xFFE0_0000  |                      |
| R5_0 BTCM (64 KB)  | 0x0002_0000 | 0xFFE2_0000  |                      |
| R5_1 ATCM (64 KB)  | 0x0000_0000 | 0xFFE9_0000  | alias of 0xFFE1_0000 |
| R5_1 BTCM (64 KB)  | 0x0002_0000 | 0xFFEB_0000  | alias of 0xFFE3_0000 |
|  ___               |     ___     |    ___       |                      |
| *Lockstep Mode*    |             |              |                      |
| R5_0 ATCM (128 KB) | 0x0000_0000 | 0xFFE0_0000  |                      |
| R5_0 BTCM (128 KB) | 0x0002_0000 | 0xFFE2_0000  |                      |

References:
UG1085 TCM address space:
https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Tightly-Coupled-Memory-Address-Map

Changes in v13:
  - Have power-domains property for lockstep case instead of
    keeping it flexible.
  - Add "items:" list in power-domains property

Changes in v12:
  - add "reg", "reg-names" and "power-domains" in pattern properties
  - add "reg" and "reg-names" in required list
  - keep "power-domains" in required list as it was before the change

Changes in v11:
  - Fix yamllint warning and reduce indentation as needed
  - Remove redundant initialization of the variable
  - Return correct error code if memory allocation failed

Changs in v10:
  - Add new patch (1/4) to series that changes hardcode TCM addresses in
    lockstep mode and removes separate handling of TCM in lockstep and
    split mode
  - modify number of "reg", "reg-names" and "power-domains" entries
    based on cluster mode
  - Add extra optional atcm and btcm in "reg" property for lockstep mode
  - Add "reg-names" for extra optional atcm and btcm for lockstep mode
  - Drop previous Ack as bindings has new change
  - Add individual tcm regions via "reg" and "reg-names" for lockstep mode
  - Add each tcm's power-domains in lockstep mode
  - Drop previous Ack as new change in dts patchset
  - Remove redundant changes in driver to handle TCM in lockstep mode

Changes in v9:
  - Fix rproc lockstep dts
  - Introduce new API to request and release core1 TCM power-domains in
    lockstep mode. This will be used during prepare -> add_tcm_banks
    callback to enable TCM in lockstep mode.
  - Parse TCM from device-tree in lockstep mode and split mode in
    uniform way.
  - Fix TCM representation in device-tree in lockstep mode.
  - Fix comments as suggested

Changes in v8:
  - Remove use of pm_domains framework
  - Remove checking of pm_domain_id validation to power on/off tcm
  - Remove spurious change
  - parse power-domains property from device-tree and use EEMI calls
    to power on/off TCM instead of using pm domains framework

Changes in v7:
  - %s/pm_dev1/pm_dev_core0/r
  - %s/pm_dev_link1/pm_dev_core0_link/r
  - %s/pm_dev2/pm_dev_core1/r
  - %s/pm_dev_link2/pm_dev_core1_link/r
  - remove pm_domain_id check to move next patch
  - add comment about how 1st entry in pm domain list is used
  - fix loop when jump to fail_add_pm_domains loop
  - move checking of pm_domain_id from previous patch
  - fix mem_bank_data memory allocation

Changes in v6:
  - Introduce new node entry for r5f cluster split mode dts and
    keep it disabled by default.
  - Keep remoteproc lockstep mode enabled by default to maintian
    back compatibility.
  - Enable split mode only for zcu102 board to demo split mode use
  - Remove spurious change
  - Handle errors in add_pm_domains function
  - Remove redundant code to handle errors from remove_pm_domains
  - Missing . at the end of the commit message
  - remove redundant initialization of variables
  - remove fail_tcm label and relevant code to free memory
    acquired using devm_* API. As this will be freed when device free it
  - add extra check to see if "reg" property is supported or not

Changes in v5:
  - maintain Rob's Ack on bindings patch as no changes in bindings
  - split previous patch into multiple patches
  - Use pm domain framework to turn on/off TCM
  - Add support of parsing TCM information from device-tree
  - maintain backward compatibility with previous bindings without
    TCM information available in device-tree

This patch series continues previous effort to upstream ZynqMP
TCM bindings:
Previous v4 version link:
https://lore.kernel.org/all/20230829181900.2561194-1-tanmay.shah@amd.com/

Previous v3 version link:
https://lore.kernel.org/all/1689964908-22371-1-git-send-email-radhey.shyam.pandey@amd.com/

Radhey Shyam Pandey (1):
  dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings

Tanmay Shah (3):
  remoteproc: zynqmp: fix lockstep mode memory region
  dts: zynqmp: add properties for TCM in remoteproc
  remoteproc: zynqmp: parse TCM from device tree

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 201 ++++++++++++--
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |   8 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  65 ++++-
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 257 ++++++++----------
 4 files changed, 368 insertions(+), 163 deletions(-)


base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
-- 
2.25.1


