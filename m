Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD92E7F4151
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjKVJOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjKVJOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:14:09 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F93195;
        Wed, 22 Nov 2023 01:14:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/vdDeaQ/a/Ngyc3Uw4LxSgODG48pq/Hek4r2IdIMJSbB0kkXZ6Npcenb9C6BAekSxOK+FG9KFBacswDtoJPHYgiOvZkEb8duToOw9YuA6eXK5N865Kto6R0CRkvkrkuPbfLSgKwB3ZKS4ex1roYnZEfishfqcP2vV135LYHHnYEQGeEUKUuK/1ycmqZWpGvSD6P7WMbMQy4Hwls3RVLzMhs4J6WPCBUL4y9z86Y5WZ40ti/RLrdqaRA25BtFctanL3Uv6l0bDR1haHwyCl1Ax79IwAp1U/40qd3CoMNOBIVGzipCAn/3Q8efGHhjWDGqkxzL4JXusHNzCltx5wZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgZEZQLHuPP6CmUYTwlzhoAJKxwRrGyDHo1kmJTAtrU=;
 b=TWr0A4+xt9Ng2DPRS7AlUpfFJ5KbP1RK49q1lIDpPZyA84va+UbA2qsEK9wkTUgEHtOH7g37mLqt2Wk/XRhACsFyU3LSkats0dHAKaO66bfrMccwnl+xZkOFsnGnVx6uxnvwpKArPJV1kGcxf/yhRn4VzYackyqtvvNlbqvK66nzD8wybvxfHTdmTua8tn7YPh7ZkHRber2XNA1uCNMgGv4M/D24Bi89xGm+7O1zKkAhyVceJpExZu460adS3QAl5IZ1jHhph/vhzyq/F7HzCUSdokJNSKd8MYfpefW22KQ30fBcpK1jnAbsXovWoe6gtn9Kb7vPsXcimQy34Ll8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgZEZQLHuPP6CmUYTwlzhoAJKxwRrGyDHo1kmJTAtrU=;
 b=IT7wp1RRSlU84E/fMiaFu8Af2ENvxrB7+flC8AJpIqK65ankY7JmnhMnQ5ZGNtMexLD7XNsPQN8WhACkgqkrjTGtos8IxOWQOQnS7KoubLT2g4Y2KlhTvhX0mTBJwpVw1kE2yLYOyqUcN/oxXKdh6TWpGM4LJOfbOwz+tDMgXnc=
Received: from SA1PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:2d3::7)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 09:14:00 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::22) by SA1PR03CA0008.outlook.office365.com
 (2603:10b6:806:2d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 09:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:13:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:13:58 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
        <monstr@monstr.eu>, <michal.simek@xilinx.com>, <git@xilinx.com>,
        <robh@kernel.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/2] dt-bindings: soc: Add new board description for MicroBlaze V
Date:   Wed, 22 Nov 2023 10:13:51 +0100
Message-ID: <e7af81b1ef3f6b7a07f4f0691f5140156477e87e.1700644418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <ef58475a717c62bc86aeea5148d5b88cdc0cc106.1700644418.git.michal.simek@amd.com>
References: <ef58475a717c62bc86aeea5148d5b88cdc0cc106.1700644418.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=michal.simek@amd.com; h=from:subject:message-id; bh=eBqeGx+483L1A7JYgYuN41o0Jr6/LPGQdFIY0BjdBBY=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTYY94MPAnrxWJezjm0UiwweNnaZp+6qs6W6vPzPkU7C W8OWbC9I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWwIF6cATISnjmF+mIf6Jd9bx5bZMDs3 bT0iMu1b7FU9hnlWas9Msn2vzNJbv8rdv7AhNlX26HwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5f6c78-eaca-4a59-442c-08dbeb3b5cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSDhyV4biwvBrDclIPwfgSwGYl+4SxqoIS2wMHiVRVRKoyrGjHxfMNUybnsIwiA4yuL8sPgvcR9FiUCQstcRzsXSB4d3lWntBNomYgYoe5dyBGopo6x+CN6yACGY0UpOh2JMGNNrdDPXVY68dFaWtBVogIvZ5GIH1d3+Bm+gc4eqhrCEWQecTluuFUtxWFV/cj5dWfWXPQyRNLiPuaSNisxkxDNpGh5See/h0jFE8kJrodfAcm0H/QSEik1j6epOu6+kw2Wn5mLkvwReWPwSCclxSNy5KR24BrmzlVkXiDEiQyiBynNoab5CgxbeGHh6T8Eg+EtPmu32aN2uqlKEZr3Cf9JaHXzRr55FWZ02ct0FM8Ugo5JowiNphGxvdXHt4zK3PZKpB2uv3I/c5x1S5nKADL7Kr5Ti8ze0X0IatcSMwlupGkI40Y+7HQRUZkLyXYePlnaDq7kDohtA/ZmtbqFa2VlSBGASfL1FOFNxD4QLmBk3hPtnXPHXdbGWkYeIGsFn/P/TkM/ZGz14xyiJWjdVbTM99Ic6CKDKCn7p6gomTF3xqaLCZbjnSOtY9oJtH9MLBH7BhqGmfp8CkPVQXmeajhOc1du/nMAERebLnjhi9giIOoeFFMRqHmEFafjl7Ebs8vlUIRZb5W6RIKSrtDf6wcCizbH4WN82f8HiRXGEK8yhiHlZpx/fAW1pqGGlPKl0GY4EBICbYuVfoKtWB5n2wQeTzTGAhsWaoaL8dva9najTuyC0Who2l5pM1mtyQfx3XJOKYKYB8w8oz09ni4krukmQAb64zvKK6RATP2A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(478600001)(36756003)(70206006)(70586007)(110136005)(2616005)(40460700003)(426003)(336012)(54906003)(316002)(82740400003)(356005)(81166007)(40480700001)(4326008)(36860700001)(8676002)(8936002)(5660300002)(6666004)(44832011)(47076005)(7416002)(16526019)(26005)(86362001)(2906002)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:13:59.5051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5f6c78-eaca-4a59-442c-08dbeb3b5cce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
It is hardware compatible with classic MicroBlaze processor. Processor can
be used with standard AMD/Xilinx IPs including interrupt controller and
timer.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Put MicroBlaze V description to xilinx.yaml
- Add qemu target platform as platform used for testing.

 Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
index f57ed0347894..ec8155a343d0 100644
--- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
+++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
@@ -132,6 +132,11 @@ properties:
           - const: xlnx,zynqmp-smk-k26
           - const: xlnx,zynqmp
 
+      - description: AMD MicroBlaze V (QEMU)
+        items:
+         - const: qemu,mbv
+         - const: amd,mbv
+
 additionalProperties: true
 
 ...
-- 
2.36.1

