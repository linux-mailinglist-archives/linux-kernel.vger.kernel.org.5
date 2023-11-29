Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBFD7FCFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjK2Hf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjK2Hfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:35:48 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA5BD50;
        Tue, 28 Nov 2023 23:35:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmqflYw2WvC+Ygmk/A7ne2hEK06HDeWDbcFIbg5w7dIgpMKLZdNtwCW5ZJTiOqA4HcZsdEjhc836c1Xojbb+SgY4sD0oJlpBly9dJyCGrCIn9geTWmwebcDgFJxR01D6aQmMa+chiAxdKyBNZtNINioUzmot+H6oiaWrY7hJCONLCjgVSOJh3dh93eiD+NTr9zwrlFqEFuarglahwt6uC+PAJvGvTXkBVIyylpC53TIM+3/ZhEXQ5q75o1lMahOoQmA/tnIPM83OrmP8hgZGwdN/yZCjiwI5JBR/dMntVbYvQTP30cCyHeMmXzCSLpgZRMz0wH4JVBAeSNPU/UJMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDw+MZ4Ff94oi09X0vDiSxWoOV1NVBe28ToZ+DULo5Q=;
 b=V7ngjd4N3YNEwrpdoGBt5beIKMOrkxDix1o7iU532CQJcPoc4M0t/fRJPmhKrZ3s1ppRoL0MM2VAlNIDyOZJZ2t3trqrwSN4W3WFmHhHu9X4CN759achkHo2ygCAW106aMj2IH9VcdWRT/5WX7Q3VvQxLcOUMi2siI3jvBW8paXBHrT54yvdkGzUfX1GpJmTrZ6ejnmLoHvwIUtQ6exUxayyqUqoTehdkVRlSvAzVQu/Avz8c6jHACCH+zfzRO9N0OnECfrNzKOae+QLwNxDY1EecMD401Yx6DAl9SS9nvJe+3zuWRoE50KOtEx6bCxXzFE/0y6YYwz6epR0GYqAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDw+MZ4Ff94oi09X0vDiSxWoOV1NVBe28ToZ+DULo5Q=;
 b=BHduYC/E3O88SD51+umJCOtF4WpSWauko/2XRKjd4Wp/jA98DsInb3NwvYt5UPFGRONPVTtlyQR/iRoylqkptm/ap/PCpXubi11UzDaFgEXlWzqGAPNt2Rw2B6JHSfC7HJ9Vq88cJRfHVzn0K1hOh2F7lL3tbMGcH2xPOoE5RIc=
Received: from SJ0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:a03:39e::6)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 07:35:52 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::55) by SJ0PR03CA0271.outlook.office365.com
 (2603:10b6:a03:39e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Wed, 29 Nov 2023 07:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:35:52 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:35:50 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2 4/6] RAS: Add static lookup table to get CS physical ID
Date:   Wed, 29 Nov 2023 07:35:19 +0000
Message-ID: <20231129073521.2127403-5-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129073521.2127403-1-muralimk@amd.com>
References: <20231129073521.2127403-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: d20312e6-7fd8-48e2-9844-08dbf0add0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /etJjEfd1z7WmsxChjIayXISvQodfvkuj/7IOEL/RBz/9Wr2uCTNZrvsSx+VTxfHZoUnf6wZyHEHjY01rDH1KTCx+Nk96wBimphBEHklcbwG0RZYL94dBO9pC15CvYQMJHGGI80JmS958g0vMPsO7+GjxLJzh5tq/7bo0+mftfspNe+T+Z63eOH+T1F2nF8YcVHHh/Pr3APl8oEEmjC/RHjLbbIcdInjWD8fZ7xHmELW1AubL2HtRQLyWR6EnIPB06el8SsSIqDMV31nnFwvJOKFJC3EH144UcYb25G2QkVbzQG5ji9KHHUxDuyuYWRLCwvOGsB9Qxjx9vsRVSpU32OTqWC5PXtu45DHXUHjF3fWX4CREn+PNPV3Grmt9zQFKfhfB2Hg3GI43Afhpy33zeeXLaKcWvC8CFA5oBdAvaBDd4jrqVGvMbLa4CYhMp0I5KZg4PO4MjFqxXr5f0D3tu4VxQdPNtn6fQ7yVLn7XWyOPLmq7Grm/E34+fU7vpc/mj9+oZVQx+FGKr7/v//QAQmwEqJ38GO1Hkr1cQJZWK2ukf14EKYrgjnNHJM8PlqKX+VrVdiZPDZKIXfPJnf8K8qOwisN5drVzBYFJleq1DxTLkJZzUnDxAOaRoCILPkseZnveut6Rsn/XkIV0z8hYQlW1QtYI5In9qf2dBNEQCrYGKSnDrh4VyytnYsDQqoq86KH1jkMbQesOacICxc/4KUMUIBabNtOu5Zu6EwsJl9nofrtJhlC0I9mV+1Kdr2S1A1uFXfLxCyBD2OC28ha2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(356005)(82740400003)(40460700003)(81166007)(8936002)(7696005)(41300700001)(54906003)(8676002)(4326008)(70586007)(316002)(70206006)(6666004)(6916009)(5660300002)(1076003)(478600001)(2906002)(47076005)(426003)(26005)(336012)(16526019)(2616005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:35:52.4269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d20312e6-7fd8-48e2-9844-08dbf0add0c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

AMD MI300A models have a single Data Fabric (DF) instance per socket.
So, all 4 AIDs are not software-visible (using PCI Device 18h, etc.).

The MCA_IPID_UMC[InstanceId] field holds the SMN base address for the
UMC instance and SMN address mapping repeated same for each of all 4
AIDs in as socket.

Add a static lookup table by reading the UMC SMN address from the
MCA_IPID_UMC[InstanceId] field and use the value to look up the
CS physical ID from the table.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
Changes:
v1 -> v2 : None

 drivers/ras/amd/atl/umc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 94eb2c5eae3b..3533db279cec 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -153,6 +153,35 @@ static int umc_ondie_addr_to_normaddr(u64 mca_addr, u16 nid)
 	return mca_addr;
 }
 
+/*
+ * MCA_IPID_UMC[InstanceId] holds the SMN Base Address for a UMC instance.
+ * MI-300 has a fixed, model-specific mapping between a UMC instance and its
+ * related Data Fabric CS instance.
+ * Use the UMC SMN Base Address value to find the appropriate CS instance ID.
+ */
+static const u32 csmap[32] = {
+	0x393f00, 0x293f00, 0x193f00, 0x093f00, 0x392f00, 0x292f00,
+	0x192f00, 0x092f00, 0x391f00, 0x291f00, 0x191f00, 0x091f00,
+	0x390f00, 0x290f00, 0x190f00, 0x090f00, 0x793f00, 0x693f00,
+	0x593f00, 0x493f00, 0x792f00, 0x692f00, 0x592f00, 0x492f00,
+	0x791f00, 0x691f00, 0x591f00, 0x491f00, 0x790f00, 0x690f00,
+	0x590f00, 0x490f00 };
+
+/* MCA_IPID[InstanceId] give the Instance Number UMC SmnAddr */
+#define UMC_PHY_INSTANCE_NUM GENMASK(31, 0)
+
+static u8 fixup_cs_inst_id(struct mce *m)
+{
+	u32 smn_addr = FIELD_GET(UMC_PHY_INSTANCE_NUM, m->ipid);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(csmap); i++) {
+		if (smn_addr == csmap[i])
+			break;
+	}
+	return i;
+}
+
 static u8 get_socket_id(struct mce *m)
 {
 	return m->socketid;
@@ -187,6 +216,10 @@ static u64 get_norm_addr(struct mce *m)
 #define UMC_CHANNEL_NUM	GENMASK(31, 20)
 static u8 get_cs_inst_id(struct mce *m)
 {
+	/* MI300: static mapping table for MCA_IPID[InstanceId] to CS physical ID. */
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return fixup_cs_inst_id(m);
+
 	return FIELD_GET(UMC_CHANNEL_NUM, m->ipid);
 }
 
-- 
2.25.1

