Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401D27C41CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbjJJUpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343989AbjJJUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:44:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA0691;
        Tue, 10 Oct 2023 13:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8sfjodh94wCFjqxx3CvtIUhujLk0THyDHmp3DfAgXoLXAYPxTs8Z9MHNfXHGT5fhc5YuEi1IYXIbI87+8mCsT9zHMVsdxUOPcG5B/raFcvnbrv4RQOs+P3y5VbWHvdwMAoNxaaYmWYpkaumKCtsKoleYsVsx6VJvwRCnvADwEjzoKNZ71s54InjDEc66lHpcprai/lwJnb1SH1lOD87Ri8IHo79FDCBJ8XbXYezjcHkZphxevs+9xDqtGZPmzgMwVboYntuJP8/JPBVTXru70/rkkkslCofelo5/AvGzQK2FnFWskLcwxq4pWCdH05Vx9bVumhcJyXRautCtHNHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmeHTKaQ2CubqKAar1zi4EFXE+mrPWBkACWpqcS3JtU=;
 b=Y/fjzAgXjJEjUgTCKNgVmkcpUhLv8mKgHe5MGPXhL1iKD8Co6oky60BhEXWTjj5JPXUZ6xE+DFSHx2rBseuNh1+g1dkRMLLWFfrVLxYGukioqUYctSI00WO1ozJtgcKxgFvzq92SbPBwu+WcGXn0chZOiE9r36U1Y5tgJdpnO7gZRkjk3MEBbF+truTBxQE9WEnjoS/55Jg/GrlOvgEUqbpFq+VHK/vl2Hx+3+vzghEoLmS/aYpCvwfeqiW0hZzPuZcXncgls306ZMYbwn7i9Hl47BhGVtfQog6/uSIuDIXZ78Ah92VaNaQguWD9YVsuKo0zUUA31cliJpugrl/8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmeHTKaQ2CubqKAar1zi4EFXE+mrPWBkACWpqcS3JtU=;
 b=QuENjrLqQcGTkRwMh3CdFBotX6XFVRdlC+OHUp90pTY1oz2J02wqN5cWad3BA7KoZAQ8q3v/ACxwkq8Y0mmXIEgRdBzf1LL9FOqL3rNFGAf6J8Kg3oi+laD1xA7quEb17IRKLYPesB1FoNjfVUwbIQYO+uxjUnT2BhPqxDMRbn0=
Received: from BY5PR17CA0048.namprd17.prod.outlook.com (2603:10b6:a03:167::25)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 20:44:49 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::25) by BY5PR17CA0048.outlook.office365.com
 (2603:10b6:a03:167::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Tue, 10 Oct 2023 20:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 20:44:49 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 15:44:48 -0500
From:   John Allen <john.allen@amd.com>
To:     <linux-crypto@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <thomas.lendacky@amd.com>,
        <mario.limonciello@amd.com>, <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>
Subject: [PATCH] crypto: ccp - Dump SEV command buffer registers on SEV command error
Date:   Tue, 10 Oct 2023 20:44:32 +0000
Message-ID: <20231010204432.899126-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e8bd94-5cc0-4845-f61a-08dbc9d1bf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZ5ftt+FS9EuhO+tfi8TZGHeaSZz/n+Kj7K4a87MNq4jGy+I7LY/ve8r41mN5xE4knvSNQmdov5hk37+FbA0XUnlDPfd3KURk2jhYLBRZ00JU3QzqS6xQ+WimulLbzSABY+xTSS42RwM2FwYCoHOB1x3V2Kk7DxkdF+oG+/mdXRCgrZ96maKeSlNDBCj3WIRMS9uHBFOyaVCdVstRTitOUrLsnZw9zF7rlqLTl8Eb1o60OiSLd3+R1oIe2r250gZQTzHShbUzy+TsgwJMSUbrK8ZftTEhXJsEFVj4dZsFsLX75u8UDbyHADWl2kDzAUd0DUL45S/KDIeRUecKe9L9tY7QslrdTEOOvCbWt6MmTtt5C3GxXqbMT9llELCZjlb8VIJvyUONbPJVjFvkLATuLr4f2+NqRzYrOEW2agEKuRlImfS3PYYrDpBlT4KBwh7f8TSVOf/frl3N6lJ50ZG5YTMKpsHL+nGZMN4weBHeUwUml17H52pyDk3XjW6q/+X8MeC8nRaggpdH5toR5/qQBhO6MmaaENnN8Nrjh+tNZKsKlRAwOPtnoLcrMOeQL+HXaUfgElcTykcuRmjn/KCHB/evQwJjFKERaus1gr1sCWVT7MFCHcshd5oxzkC20fD1S51vDsPp70YpxcBITwHNPKpK+PAzAjohM7lMvHN2ftMmOp3YznkKUMjU7RuK2diq/GtpQ6ApKo5NnwVcBFTyIH1gIFFg4GqFdBaOu2lJnLtny0fgNUYvgimAQ7eSWA9FKakTNlQEJiISJ65+HDE3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(16526019)(40480700001)(41300700001)(2616005)(26005)(426003)(47076005)(336012)(8936002)(83380400001)(82740400003)(36860700001)(356005)(81166007)(4326008)(8676002)(40460700003)(70206006)(316002)(6916009)(70586007)(6666004)(44832011)(1076003)(478600001)(5660300002)(2906002)(54906003)(7696005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:44:49.3869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e8bd94-5cc0-4845-f61a-08dbc9d1bf24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSP firmware may report additional error information in the SEV command
buffer registers in situations where an error occurs as the result of an
SEV command.  In this case, check if the command buffer registers have been
modified and if so, dump the contents.

Signed-off-by: John Allen <john.allen@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index f97166fba9d9..fcaccd0b5a65 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -309,6 +309,7 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 {
 	struct psp_device *psp = psp_master;
 	struct sev_device *sev;
+	unsigned int cmdbuff_hi, cmdbuff_lo;
 	unsigned int phys_lsb, phys_msb;
 	unsigned int reg, ret = 0;
 	int buf_len;
@@ -371,6 +372,19 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	if (FIELD_GET(PSP_CMDRESP_STS, reg)) {
 		dev_dbg(sev->dev, "sev command %#x failed (%#010lx)\n",
 			cmd, FIELD_GET(PSP_CMDRESP_STS, reg));
+
+		/*
+		 * PSP firmware may report additional error information in the
+		 * command buffer registers on error. Print contents of command
+		 * buffer registers if they changed.
+		 */
+		cmdbuff_hi = ioread32(sev->io_regs + sev->vdata->cmdbuff_addr_hi_reg);
+		cmdbuff_lo = ioread32(sev->io_regs + sev->vdata->cmdbuff_addr_lo_reg);
+		if (cmdbuff_hi != phys_msb || cmdbuff_lo != phys_lsb) {
+			dev_dbg(sev->dev, "Additional error information reported in cmdbuff:");
+			dev_dbg(sev->dev, "  cmdbuff hi: %#010x\n", cmdbuff_hi);
+			dev_dbg(sev->dev, "  cmdbuff lo: %#010x\n", cmdbuff_lo);
+		}
 		ret = -EIO;
 	} else {
 		ret = sev_write_init_ex_file_if_required(cmd);
-- 
2.39.3

