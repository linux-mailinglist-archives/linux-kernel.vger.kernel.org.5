Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F447D6108
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjJYFPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjJYFP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:15:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D8012F;
        Tue, 24 Oct 2023 22:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaoYAYSrIfP5F05vChGGAayQ/WDs2y57vcUPnhR2YEGZ1w2X/Yg428Ag5HHfEr+HNkYxRR+3Qzob2II1id8Tn6jT0Icqpjn3h98+jY46Czph+cS/ITQozYHk4+rHaP7qswLUX2Cpf5bpJOGf6S1HsfpTUuTqAscHVusF96oHVdMBnpSHfl01RQxKTUk9OC2o4YxO3ZQavuTerfE7FDvsT3JahY8AyP2w8ER3hxW5LQ66W4vnoVcEKs/mC+IzKBPDMD18kYEZ4RYreS1TXdrIZp+1efu+EIpGyekLMXp9B/xeY9x4rRkW1c94DzrddX69r55acCabC2YVc5kad4kP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYNdSThUkIaYmDQvYYDjfrMXaqhA4VCgyyyEVd8cgqA=;
 b=nRLTwNhkOaoWOh6NcXvN4pODdON3FYYOaJd+wGKorpZxfsEbBTJFjO2bg4UnEcAGy5ZAijOJTHIgGxAktYNG+lUO1XAxv1ogBVWIwsWU+LXDty832/OckqVfBX4wH1XHAiNy79atNczmFx5zOtosM24ZjugptBl0KSqJI1+mceBnJLN73XMnJ2k8PbkOuQavriYscxlwLd2ea1dkIuyoWhBU0k/1B6LudMWK3RtL/znMbQWv+rWki4E+wxkE2g2mI33QoIa64yqQAPc957xarWW3CrGlFHU8qjFWrBgtjKuBgNCFqinQ5+UYcXpapj9wHp1rQWV209P6j89G8x3/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYNdSThUkIaYmDQvYYDjfrMXaqhA4VCgyyyEVd8cgqA=;
 b=CJSlVzJTfzgqAaAJzQeSni4fMwu8LK3sNhV/IQoG6ne3bR/0ao8nkeD1miKmLifAhkZBMXomvkvXuxJQPMO3aZNDc+zKnBq0M6PNB3z2ul4sf6bTxJ1Nk1sdz/D80BJX6A1EBRFCwYunepk9OJl1RdUzbrwdfl+jkt0Ipos8hdg=
Received: from CY8PR10CA0005.namprd10.prod.outlook.com (2603:10b6:930:4f::22)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 05:15:24 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::42) by CY8PR10CA0005.outlook.office365.com
 (2603:10b6:930:4f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 05:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 05:15:23 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 00:15:20 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2 0/4] Few cleanups and AMD Family 19h Models 90h-9fh EDAC Support
Date:   Wed, 25 Oct 2023 05:14:51 +0000
Message-ID: <20231025051455.101424-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d69d66-619f-4818-c7a7-08dbd5196404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zK1v0sgwkQQFMMhsMp/bWYxAJ+LpmC0ufPifZzcRU1Gh2vmrMW5oxo4carDOKSZ0J16yq4Lyxdj7oMIt9qx5jkhUFm1A0OE/QFDqTSxiWo3Bn/ACxPHPawXCrsbPWciW0pMleumIoW08gOJkqqjLc6VDUu2dtH0wuImRfPmuLFi3AFzv0gIqX01wm0YCgXxQZ2xInRV66PPDAD23Bm7MYNHUTEW1B9KQOPu2QBffRGmvFh31DYLriKKXDJV0kegLdOScMGsqQZJzPHSzG4ann4UXkmk920FJcdhCZaVWS26vog2EU20sdxebrjUoWXhCS1Y2w5AeR0O1ElclO2StDy2NMWRzCDNr+G1ouf2cjBbDWAj8MxJbTH3lDCmYUVMlCx2LpBXC796ZXoBgK5wNvMIHoqcy5tG6hSFYbVnTpw93Lf71L/JIFMyxPXpn0foAy0Pw3SpooqtUsMEH9JzNlJuIBCW56fR5a3JY4r/Sk8UGdIqU/EL5VTSDbtBx3wb2I3PcKSKAhysM/Nf699MZIXJ3raq45eZwSmf+X32p5pPoibro2VpMxabWBzl7jBOP0AOGNkf8Mg2H/qP4HqrpL8L0J2en1uzgszNMhGgXHZdkLVGSk4TvYIBdzjbJiWSdSlHBYwFSeV7N+PhvmFduWDv7sfvIWTi1Y56qek4kol5PQcUATOHatWNJ6fQ9+Tq6JpXwGc4dhf2Qu8dICl3ip4lmFVoD8trTQ9XhXjPXSjP4Af2UyJXj1uxfDikGaYod
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(36840700001)(40470700004)(46966006)(6666004)(2906002)(54906003)(81166007)(36860700001)(70206006)(82740400003)(316002)(6916009)(16526019)(478600001)(70586007)(2616005)(1076003)(7696005)(47076005)(40480700001)(966005)(336012)(426003)(83380400001)(4326008)(36756003)(5660300002)(40460700003)(8676002)(41300700001)(8936002)(26005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 05:15:23.1053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d69d66-619f-4818-c7a7-08dbd5196404
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Remove SMCA Error decoding and Support for AMD Family 19h Models 90h-9fh.

The below patchset is based on previously submitted changes
https://lore.kernel.org/linux-edac/20230720125425.3735538-1-muralimk@amd.com/T/#mbed00e5d997e8c39a8f2b6b82c73feff2419280a

Patch 1:
Remove SMCA Extended Error code descriptions, because some of the
existing bit definitions in the CTL register of SMCA bank type are
reassigned without defining new HWID and McaType.

Patch 2:
Add New SMCA bank types MALL, USR_DP, USR_CP.

Patch 3:
Add HBM3 memory in the enum.

Patch 4:
Add Family 19h and Models 90h-9fh Enumeration support.

Muralidhara M K (4):
  EDAC/mce_amd: Remove SMCA Extended Error code descriptions
  x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types
  EDAC/mc: Add new HBM3 memory type
  EDAC/amd64: Add Family 19h Models 90h ~ 9fh enumeration support

 arch/x86/include/asm/mce.h    |   3 +
 arch/x86/kernel/cpu/mce/amd.c |   6 +
 drivers/edac/amd64_edac.c     |  69 ++++-
 drivers/edac/edac_mc.c        |   1 +
 drivers/edac/mce_amd.c        | 480 ----------------------------------
 include/linux/edac.h          |   3 +
 6 files changed, 70 insertions(+), 492 deletions(-)

-- 
2.25.1

