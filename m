Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627957B60B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjJCGWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJCGWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:22:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936E9BB;
        Mon,  2 Oct 2023 23:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0Q2373ZZjdElfbVE+ZLkCf1tiEiiIzwke2WZJysQoLg1UFQz7RXFfMCeLMtJAwgUy6wrJBhYP0sFU4WadCOX+GftZzYq2x5BK0BGCLf+rlBtXC3jGIrCxEf6mliUqVHyptrHhjxx7jcUK8pGVwITRskmeBflFMUVfFuUbogbWjS+Itr8LPqFNPP8Un9hJG/IxmGevZXtz5anTOKK6l7a7HM8IP3ealz8wureoqZsEMXc4CMbYG3CIgiM8fozfMgJVF5BOTRggckSTSnL9NvaaZ6uyUaZXJIP4mdB1btCcBIdH3TFJW0YANrc7qI1TgtkMP7j5ujXBapOF2nNzoCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaoOu3CMYkndc/sLaTpOzxKw7/xeOWftlTmvq/r/VL0=;
 b=LexgDcM0NA1ohSf1L3V1+4yvT47JKB1MlsuLHyK1jTMliRMS4gvm9NTbztXLf21d0gYEtTUZCv8wjrskFxqpQ3JGheGAdjoo07U7Mso/oAOSfe/95F84ApePc4CJ7RcGJtDev8FG5ZFjD6X10lCmNaBU0QzzuuAqo+sV8BartOB6F29FzZ6Nqk02sLl0IldnJSJBOKvX0iyWTenKR9xk5hu2tiqn5hvlFtodkB+i7M9M6bW/1SKWF71l2Pn83vU7U3HlJlhZAb/zXSm0YOSJfhVgXJs92Yv4KopIAgPFLb0f2DjmE6yWaRNs4tXU253+8ZwSP7Lt8pGoN58epsRiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaoOu3CMYkndc/sLaTpOzxKw7/xeOWftlTmvq/r/VL0=;
 b=SSOfAfBx+iUEf1f+mHtTCthhiTk4A53s4XwuKMS549hiUgqlQIgZgj0rxBOxm9Ddm55GOB0ozph7VY03rgP3kwO7RA7W0ess3xeV+ROXdMWueItYkAk3BHDCN7ulCjW1Js9qO7HMHMFVbGGsQM9UC4q/LctEGLzsPPd0QZ++NM4=
Received: from MW4PR03CA0254.namprd03.prod.outlook.com (2603:10b6:303:b4::19)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 06:22:34 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:b4:cafe::9e) by MW4PR03CA0254.outlook.office365.com
 (2603:10b6:303:b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 06:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Tue, 3 Oct 2023 06:22:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 01:22:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 23:22:22 -0700
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 3 Oct 2023 01:22:21 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 0/2] update for versal net platform
Date:   Mon, 2 Oct 2023 23:21:51 -0700
Message-ID: <20231003062153.12215-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: f24a7ed4-194a-40e5-8a83-08dbc3d92141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEobcJCUtkNjG0NQeekmrHAwLQZFMxQ2pcVzTSlKlHWB3Xd3ghntBPmd2jt6T0UgNdJ13dXXMSNHV0zTqZ/VlXhs2h5j5VR33pND7hiQDHfGQE66gqVxbslUxX5SAFEIupwWk1BnDvgoAYqzSKLut4JQLMKWiUT+fRjoAKjSlE7sSm3bk7nxiqA0UYryza9U4xG4DQpnQUcaPOFuu2TV7oFUJtuoZ0VwZ+SgQr1Is51zfOQRHdSriV54z4qIxyEgFTxC7MsmOKZpDq4C2iSjOw26+8hoSfnp97zmqd6VzC9zmezoM/U2LMdrFg7vEkX49FGirVDx1SJOvU/YAtTl63dwAJinIQWaMDcMaRP0kIV4pY4yHeDIf4MOAISzXzdpt7aEmV3iq4ZT57WbFCCNHh/1EVqosbWjk2EvzZccEMY0QRTNm/CTvdZ0dnOuv1awz7HvtaVBEwWNiwJIzvn+6AJoeag0NHrWEiLndThJ2VwYeAy67OUPdSfa1Q0LV+jTe8CHhkuw2eMGP0bbGZd5F16fR9Ky3+10zKEB08ldles1rEsGiVf+IKHZ3BE3FZxoT5XfufGHr0uTIAwwDV7taZYNMSED9EDcsivV5GZVSljDNG/Hwhxuy2LRRqvJsUDe006Zg+ePSFumFGVcitHR4hocpZzzXuzkZb/yGfdPhGJPwavRsoMG0DxMpbgAPrGJR5BhA30FZgqqpczbXc/VwQm/bjQGDH1ihIu+NEWuSbD7N06FaXEzZyGsUbmVHPhNB5vMzGeWQuwRrEyM2Yl22A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(426003)(336012)(2616005)(1076003)(36860700001)(81166007)(40460700003)(82740400003)(356005)(86362001)(36756003)(40480700001)(83380400001)(47076005)(316002)(70206006)(54906003)(44832011)(8676002)(4326008)(5660300002)(41300700001)(4744005)(8936002)(110136005)(70586007)(2906002)(26005)(6636002)(15650500001)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 06:22:33.4913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f24a7ed4-194a-40e5-8a83-08dbc3d92141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update clock driver to support for Versal NET platforms.
Versal Net is a new AMD/Xilinx  SoC.

Jay Buddhabhatti (2):
  drivers: clk: zynqmp: calculate closest mux rate
  drivers: clk: zynqmp: update divider round rate logic

 drivers/clk/zynqmp/clk-mux-zynqmp.c |  2 +-
 drivers/clk/zynqmp/divider.c        | 70 +++++------------------------
 2 files changed, 11 insertions(+), 61 deletions(-)

-- 
2.17.1

