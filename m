Return-Path: <linux-kernel+bounces-71773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B9585AA44
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CC81C21618
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481A8495E2;
	Mon, 19 Feb 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lUwDyEZh"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50742482D2;
	Mon, 19 Feb 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364791; cv=fail; b=eAx7/+FxINOrU/w5OxeYFCozV8DFwoFVW/S/AQ97t9SGQ+7x8Eu6Fjpr+XQtHIHKq6h4lGuQDpUM7v0LMnJ9s0xQv51v2aGodx+NLGO3v/c4JrlEVeprBJkMMRi8hJ4F+V+xJEAeI5CVL0Bn/XjqqMJ52UUcUGXMovdYJm23pKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364791; c=relaxed/simple;
	bh=LwcbMZJdbbD2N+Y1HEkfhjXN84rRlVHRbH6e3r8yRLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMF6NfLeghoni1/Zagn4cYJHGQ1u/XifJTmw+D68dCX0Vej8IaDYbwD+09HGWME1g0NfA6Nwv8vTZyVUUyjpCDmyXJam4S0eT7uv+zlcGSFWs+R6Wi84buVnWf45ZkJd+bc+co1k7fAPL0tzqfCaabFTYayKuYTxttJYwxIv9oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lUwDyEZh; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrrC71ZrqFHZXm8ZfYaOcGU1mwmh2lJXL5zCSk0tzmxo9URIfkYX+G6KbxySy85ObS+LJ0EAw4rPhbSYvS48hcKb+1fQkn4sRo5fhRbMdR9Ut/SnaeKxcMxuazA/WLNvbzQ8lpO31cMcDYjFgwIrE11ctSYnYq+zuw9H75Hj8m1LgHAL0Ugz0q6JgmFcok4WA5Nn2v9U+Ijl6Y6wUyJ/jqdnF0GC279nHPpJU0xuo4wWVwu+OllXW52yR2NqdNCT0cTQIFyZ8+wliG9RJBwrMk/zAeu0htSdLF8QTgB2Q94xdeVz1GkZg7dGsarEFro0ZB/BbOez0PuqvEBytxNgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA1R2X8RPSwS54KaB3Y/EcLiBw0pbaWevj8uAD8CN4Q=;
 b=LFI1+ki0ICCRvQbW0h5Di3TvblrWK2F8Bt0gLulvZum8kuiHYIFMbg9SELFFqq0Zvg57wnk9ofYIKi3WaATdDcJVzongyh6mk+Dywy9W/GmrnI7lSMRud39liCeWcwTgVZ+9N1orY/sFsfVgYK5cEAp22lXis240vbfA56KEmcqUju3v96f5EHlhzTmWhVWcmOSuApeprPh4Hi4Qox6EsaZGLYig2huBPqM5arbtHdNKqV1GNpSZwlTV4S9+5ltztDLNRDfjKdltpFDoE8fuJIywMaP4IFV6/Lj107nQ87ZifHw7owqaLNWgTGWzTW4aMFzb0i6Dfd7oxE7AQElrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA1R2X8RPSwS54KaB3Y/EcLiBw0pbaWevj8uAD8CN4Q=;
 b=lUwDyEZhiZuRniKQl1L2weInk7vMcVtQtWIPukDM/N55vWSrQEtPLikIkcgCsYWBk7EkuT+rvuk+NrW+MFOjM6SA3/1AeZ/emB/WlIiKFlJvX4GlXKZ3odS82/ZaH1btfvqHk0QWb1+rQaMWHz6Da/joX4YfF/4V3YPkn9UxHwo=
Received: from MW4PR04CA0281.namprd04.prod.outlook.com (2603:10b6:303:89::16)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Mon, 19 Feb
 2024 17:46:25 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::a5) by MW4PR04CA0281.outlook.office365.com
 (2603:10b6:303:89::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 17:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Mon, 19 Feb 2024 17:46:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:46:24 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:46:24 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 19 Feb 2024 11:46:23 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 0/4] add zynqmp TCM bindings
Date: Mon, 19 Feb 2024 09:44:33 -0800
Message-ID: <20240219174437.3722620-6-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219174437.3722620-1-tanmay.shah@amd.com>
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DM6PR12MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 947436b9-ce33-4f12-46cf-08dc3172b169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JXTR5dJo1b2aNjO8d2Iq9uZiKt67Rqxs99AsdBjRxmKDMEfBJ1MCsI6BfO6HOcVAg8pPNwBfNAAzMoBCYh+R9jADZsNZ+ORxzoDIFJf1riZ08ePlCOPPj3GR+armphqC/0GjJRqBoCneKFNkd+i0c00prKKui9Fsp73FyJ9iYIMgWyJkplCa4eVf5ZizG/2W3hM2Y9ooiFzqJoWXJ6FeprC+FPJ/tLfAWJFRphIr2K3fqz1hIQo8d/IGCV8X/jGFp87hJCItg9qAvvGTBKsMDugZjKnWku4QVB3UZd1VBaTXZctZ2NZkpvfRDanGRc55oGsdoWkViU3UPJdrFsQUG9Pa/PGS1I3C3GjvOZTD+S44sFWadYJN1zkkeBW5n6SATl+J3FYvzkLGtUxXQr4DQluYCbnxecIVdN5xwqLIqR2c6rYsED5mY9nJSdY8XMkFp0mSY/225tp2QTw8/rXG0s+C5t54tdBlJoh4AL0lMjFB1CB3lTQUvenIeco/bYV5r11Moy9gk3SY8+LDU3FsYTkhsKKv50ZkyWPDavCkL97V+VaPU9Whi4u+cjufxMXWiwbfL+1g/+/KgT4HHaZ1x2VNjujRHAhBAXJEECUJFKg4AzBg7Jrzbz2PPD9U5/RhJVzxJo3UOOUWFAAAHO2DsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:46:25.0548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 947436b9-ce33-4f12-46cf-08dc3172b169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563

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



Radhey Shyam Pandey (1):
  dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings

Tanmay Shah (3):
  remoteproc: zynqmp: fix lockstep mode memory region
  dts: zynqmp: add properties for TCM in remoteproc
  remoteproc: zynqmp: parse TCM from device tree

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 +++++++++++--
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |   8 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  65 ++++-
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 257 ++++++++----------
 4 files changed, 357 insertions(+), 165 deletions(-)


base-commit: 929654e8f1add50b01d5a56171a31c311b0a739a
-- 
2.25.1


