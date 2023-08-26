Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161827893E3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 06:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjHZEv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 00:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjHZEvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:51:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147D82137
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrCQbaRaob2CdKzNio7O+9NvAx0v0s+TA6Bx+WhxISoeVevclnPt3IRUtL92yidZAlmguirNMoXPf5ts4nuOi3JDNGguVAZ6vKWSQ5mzI5F6ehQLg1c4fLuYl1t9FcDFhAFpdQY0mfbFesnv9BfuDbun+C6TK/lltButXMqyESSjLPypfABuaStk/X6rL3ngHXlq8OIJnN1KNMxuEQbFzLTrwRuu9ajwJvPklmkLb87a1lIiDvnO/4spyzo+3Jtn6R1SmEMcu2dWooxlJ5gurMBVAsGGIA9DbJWkySrDNWCybHiloEK8E/PL7Q9+1vys538S2Nyx9uwxYor6xp+bKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXPp5tjOQMotBbexpftA/q7c9fr4InShAe11YXw3R7g=;
 b=aa5PNRJB7rj0gUZLzaPszgd3Qgk90W/Xe4sFfGI7G7hjDfMEmRo3gRFOkKox+pPAZVA1KGz6I3vGZky+9VZ1ujRnhQd66zkIk8Wljsz9POJWtSXb6CTOW15Pi39XZAjvoueGbTtmJG1c7CEo+EYRSsos94ShziAUjX5M/S6zOQ7IOryhT/I7/ITqxydKavAQtE5JdtWQqffkDWrXjSiRxhaeooLXwPTxiIcvb9TIMPRpjTehzcNeaKRzJLzy8syb0TmMi6qnlPUIRsH0txnjTwuy/ORN7h0+gRRwH9IfgZ/9wUPd2oDNfVkQj6o/vj66KXQR0SpbaKQngk2v96buwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXPp5tjOQMotBbexpftA/q7c9fr4InShAe11YXw3R7g=;
 b=EZ+GcMwQqufqAYq9gNMNYLNvv301saFObwCGGENqqIfCjxr0UvNLsUgcWD8NKsZCRFp3YETTWwffNmsT+GVJju2RYnWL0TYOVgBTrmfaqq495CGCb1YB2h5MPvzjmGFbJ377EH7xErsQ2ACSXNrV198BvFFUymVjmVi6P3+zc10=
Received: from CY5P221CA0148.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::21)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sat, 26 Aug
 2023 04:51:16 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::c8) by CY5P221CA0148.outlook.office365.com
 (2603:10b6:930:6a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Sat, 26 Aug 2023 04:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Sat, 26 Aug 2023 04:51:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 23:51:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 21:51:14 -0700
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 23:51:12 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v4 0/5] cdx: provide sysfs interface for cdx device resources
Date:   Sat, 26 Aug 2023 10:19:39 +0530
Message-ID: <20230826044944.4161017-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de1a6ec-a7ed-439e-0129-08dba5f014da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7OlPV/qu5LhpEofxKFB0n6fiv2Y7emxzUTtdpM/pP2GaT0orr++4dHSVJ9HdcLM7u4u1zVm3sUNwFby+GhPkEdsAJTLYPgrJpD3IvBTWKmtztUUx8xvgfnm6fN+jpuMzcRY9OGgY5MzMQY7P1J1mPet10aA+7kC9f8SmTQ5T34GS88DE/GDu6vYWXwSmaPlUc7/8qxkjShjwSU3kB04JJToukyBPE6uTqCw1T43/IPvcmV8vRCRW5fru4BWPTe82FXpv5bpP5jM1lvQL2DCFpW8oUK9fpkmp+Z4yZ8LJZRLdEOSDFEDppV3n5KJZ7RB1y8+NRWJYrhlDBd+4dpHfa1JtoiASahZobTFpSaclCK3yvt+MuUm6i1GaFeG8TGoloblr/Iu4Jhp4iuIwQn09+Tx1dbv9Yf82c/hHt+ciiUbuJ+Sp/v4ki2xN5w/uFtJ2/wYnSFsQYeklvKwJ8fNZoJC4hIt0sxmJ70wvErZpk9yN1bUlNJ/bxmdLIO0x2fomRcyLQmQzAIaEzDO1O0qGAmUuLA41bIDp5maF76jiUgkDaZ0UweWyDO9Azk3j8qpHeHjFlxNmHIe6nAxhW7jiH0hhZ5Ir7oWMvY5NaOL8hR9xgwiSrxeQkvLND15q2ZdVs60qGsByWqvoVesohdwJjeYP+lxhQPNaARB/+0rZqgsyyM2T26/2vBq/odxPv8SCZ/GCIR2ZPZ6r23ZpuX1tSkIHBdyQwWgRPb8T0D8Kcx8Ig+cGctnwxtEEqJ1D7tAQAk8bkx7D9CRhL4sfXKNUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(2616005)(1076003)(40480700001)(40460700003)(5660300002)(86362001)(2906002)(44832011)(4326008)(110136005)(36756003)(41300700001)(8676002)(8936002)(54906003)(70206006)(70586007)(316002)(82740400003)(81166007)(356005)(478600001)(83380400001)(36860700001)(47076005)(26005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 04:51:16.2372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de1a6ec-a7ed-439e-0129-08dba5f014da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides sysfs interface to
 - enable and disable of cdx bus
 - reset all the devices on cdx bus
 - subsystem, class and revision for cdx device

Changes in v4:
 - Make ida as static
 - Imrpove commit message
 - Add sparse markings for the lock.

Changes in v3:
 - Remove local cdx controller list from cdx bus system and
   instead use platform bus to locate controller
 - Use ida to allocate unique id for registered controller

Changes in v2:
 - Introduce lock to protect controller ops
 - Split sysfs entry enable to enable and disable
 - sysfs entry enable and disable take bus number as an argument
 - sysfs entry reset takes bus number as an argument

Abhijit Gangurde (5):
  cdx: Remove cdx controller list from cdx bus system
  cdx: Introduce lock to protect controller ops
  cdx: add support for bus enable and disable
  cdx: add sysfs for bus reset
  cdx: add sysfs for subsystem, class and revision

 Documentation/ABI/testing/sysfs-bus-cdx |  87 ++++++++++
 drivers/cdx/cdx.c                       | 218 ++++++++++++++++++++++--
 drivers/cdx/cdx.h                       |   8 +
 drivers/cdx/controller/cdx_controller.c |  50 ++++++
 drivers/cdx/controller/mc_cdx_pcol.h    |  54 ++++++
 drivers/cdx/controller/mcdi_functions.c |  31 ++++
 drivers/cdx/controller/mcdi_functions.h |  18 ++
 include/linux/cdx/cdx_bus.h             |  41 ++++-
 include/linux/mod_devicetable.h         |  10 ++
 scripts/mod/devicetable-offsets.c       |   4 +
 scripts/mod/file2alias.c                |   8 +
 11 files changed, 513 insertions(+), 16 deletions(-)

-- 
2.25.1

