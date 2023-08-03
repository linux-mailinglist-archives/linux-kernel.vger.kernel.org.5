Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4B76DDA5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjHCByg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjHCBxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:53:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AEF4C0A;
        Wed,  2 Aug 2023 18:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcteNrjO+YCA6FOm2dlbvZggEMCeU4bCpmwL3S6R2OS59iveZ7oaHn8SkrFU8ldxvTxd8HNsZM4BOFyB+KH6ZKJbN+ddf+myvWbIjx1hR3fKkJMDnA4DZEt4Fbn8dIRAlUOp8U/r3QdoUpaEt4x2pnz6f7KojRsr509qhVzIkDzwccXQSUuQx7zB0X14Yh/+dO2yTDTQvo9NneFi2aJatZBqhlpwC05R20bkLbYMoIA4PsTP6BzhVSPXSKlyed6PlhOYDjrr1Kc16V4MthBnNCeLVr+A/XNis9LwmGb2bXecZq+h5xVkfq2xbk1Ykio07Eq+LqXx0jMpVwL1edOnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0go771iIIkKMt8IdHGSPh+sqXs2P/RU4M3OWzp7KWZQ=;
 b=lh3dPjRutPLVYuHMUEeTfLk1008D+tg694vljRT9ESetzmRY9J/4aSKZ4qXTP3ed5QSPsa7pgir6IyT1jMPgdh3nmxpC+v1sKsjLyNW8MpZqKNu5n6Uze8akrBPOzekgq3WMMgLpCDXZBU4ChCOI4I3KLwwtrC1iiwhekyHdikKZgobA+kRk6Wm9JTuroVV4AFR/cTg131o6siKUAdanArdmvta7F5ihjNCq98sCErTv23XiKICKjN+BG0r/NHvBRAQND6ZY09EiJjzJrNIsVDszKtE/6S094NVuJolcz3FXp4k33BrpZVh982gjMa4X8fMTbYS3kuqTjogFvCa2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0go771iIIkKMt8IdHGSPh+sqXs2P/RU4M3OWzp7KWZQ=;
 b=iTfWprTHqJ+sHkFXO4A5qMJKyD8d6T8o2JQXWEeXjL+HUzdUdiy1/kaTzgASFyWIxfc/6Qud2AsisOlmn6BZf1U1OUhQ/lqG8obwFccfAiSS4ms0XqYv5O96GiyZUyJ5VVq89EJh4ObrAUOFesoQagTxKbr5CdUuGoSPmR3UJBI=
Received: from MW4PR03CA0143.namprd03.prod.outlook.com (2603:10b6:303:8c::28)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 01:50:30 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::6e) by MW4PR03CA0143.outlook.office365.com
 (2603:10b6:303:8c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.46 via Frontend
 Transport; Thu, 3 Aug 2023 01:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 01:50:30 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 20:50:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <jarkko@kernel.org>, <peterhuewe@gmx.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <Jason@zx2c4.com>, <dragonn@op.pl>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/3] More changes related to TPM RNG handling
Date:   Wed, 2 Aug 2023 20:50:12 -0500
Message-ID: <20230803015015.915-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f66f72f-4efa-4c1d-cb34-08db93c404df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0mtEeBnh/j8p64jitN1b7mwKYbH8/D4/Gdl/xsJPDjRguRYQhVuBgWtW7owdOXmbG8v9S8Hbf2KCBOyIYW9l/hKqRALryPa2ZfIhD5KyK1h/PU97Fozrc68LnNHn33aosGlo1w3ljivNHe2l1i2tlHnJIS8L3D8BHNA6J39+9B63B03+UIwdRD0zi/NhOEkME26Swg4LNbEF0rWv94ce/XzuleCUO5317H/aONP4ASBkKc+zG/4yoQH3dDYRDHb6mNQKmzgt1uIW/065NB/0dla5yLu4HB82HO4pA3CtgvVMpNcTMWhtt5Kj7ytHc/uOGbUrbbeFNJsT8yeUMTVE6HFzwVcPPt6ZASq2wcbNRzC4WiaCnxA6DbMO35FFbh5TSM8dU7BaV6TYJk9rzcGJIyBJf2TMW6oLh6/YkGjwxjCnbY7hyNfQraAurdus05D/0rmDGjUkygP7lkqIxb1z/MpRKlIxu3Z428Y+ZIX7+5SdcBbCuSCRg6bgBgoNn6lTryXdXArhdVSY/noOAAOy+ukdjdClJ8byoMRFUUxpdHQTA8JNiyrsJyt7lCWZ3tUQrRhjBaFQXJQ9YMLBQwnogGg4eI/EhzIrkJHfIF94bZFrDpRdgAlNNbalUzmicULWt3HFZhMRUY1rOQASfc3Ui+8Uy4lZaSHnMZZyohkH226h07PtMtjrisJPAne/veHxTKz7UsezK4bo4n1IJuGbCa+IBUJ9jfH1PPruR82oWSVaAUOYI9bBjTCsEFvoxuj8guKFFkBqQKL7zx/qZNCuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(336012)(16526019)(40460700003)(2616005)(186003)(316002)(86362001)(478600001)(54906003)(81166007)(110136005)(6666004)(7696005)(70206006)(70586007)(356005)(4326008)(82740400003)(36756003)(41300700001)(26005)(426003)(5660300002)(8676002)(8936002)(47076005)(1076003)(4744005)(2906002)(36860700001)(44832011)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:50:30.5986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f66f72f-4efa-4c1d-cb34-08db93c404df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 fixes a mistake in error handling path introduced in
previous patch.  It should fold in previous patch or go to -fixes.

Patches 2 and 3 add command line option and drop Kconfig.
These should be targeted for -next.
Mario Limonciello (3):
  tpm: Add a missing check for TPM_CHIP_FLAG_HWRNG_DISABLED
  tpm: Add command line for not trusting tpm for RNG
  tpm: Drop CONFIG_HW_RANDOM_TPM

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/char/tpm/Kconfig                        | 11 -----------
 drivers/char/tpm/tpm-chip.c                     | 17 ++++++++++++++---
 3 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.34.1

