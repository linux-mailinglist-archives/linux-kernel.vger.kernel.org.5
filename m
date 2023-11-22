Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4528F7F43B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbjKVKXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbjKVKXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:23:36 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0659BD49;
        Wed, 22 Nov 2023 02:23:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VguhcinnDkjugR8J76LUWqF8QVCo5xV+ZUaqtoPoTkF81BzYMVGzoxSvf9ch6Z6RU+tbXvCRcQci5t79RJzP6qV61lN0W482xKJJycPMOf4eY3tT+KF1LT+AoZCJ8Dmkk6Pb5TH9BtOHDNVFLEG2dKhMXj4cdOshrX4/vwvXjhafxqaxM0Apt7VQv8n1VGsmnGlBC05lY5Zq6Ggq2NK1uacj/xreiORY9bnqRMr1m3bpH7eEWN3NKkfQcKflsc6sLZYw5U4LE0NsrMv4GGWCR7IM4GmV96eth2GTUrr5YLFqB9f3C6L7u1/Oqnn+uPh0Zspf5QdBbMB/xsdd7igVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFmDsksmG4TRlUREloeSofFvW90mH1my/qnhiBlVd5M=;
 b=BDnM6InfxLBQIxw14buAkxo20D45PlKK5cFyLLsSrc7DT2pYugdO1RAWK9lpYZg6N5+8is047MTf2abdIz3bWhsVvRkdOkGLXYzZEi4Ff/Y38/jweJ1DCgNHjbqHZdiSqNu6Jq6+aLZDWLGpyLINMfaRQbcBx+DFdz8tdKisuSHo8UwJENMLK9etOPuOfswYF8kZLc16MwSfBLTU55E+B7go3tChQT+lxX1cbgAj7labw5ghChrcAzO/fhSGCRyR1it/+Nzcr2hAG5Eg+SKgKnJsqCW2ADL3ZTbZm/j0M8ncm1c4L+SueVoqDfyaO6flEVrYk7uRCaFOJXZkfPXFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFmDsksmG4TRlUREloeSofFvW90mH1my/qnhiBlVd5M=;
 b=N6Q8+6mlbdb0CCSR/G6TsKWAlP4VBL6iuPYJamTcUashkjnotpYL7UIOjx/uvphiLH+1LhEAV3vrVbw7NzYRqwlEWoguLlnP6HyELLD+U4GQOT0QwfKxB7IOPqj3+Z6JabgM02W2P1toZQKtP4cSaIuJS23vod6Gvv03mrbhs+Y=
Received: from MW4PR03CA0191.namprd03.prod.outlook.com (2603:10b6:303:b8::16)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 10:23:22 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::ae) by MW4PR03CA0191.outlook.office365.com
 (2603:10b6:303:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 10:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 10:23:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 04:23:19 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
        <monstr@monstr.eu>, <michal.simek@xilinx.com>, <git@xilinx.com>,
        <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/2] dt-bindings: soc: Add new board description for MicroBlaze V
Date:   Wed, 22 Nov 2023 11:23:13 +0100
Message-ID: <9f925b8e1580df2bd53ce37028d56775b51e1415.1700648588.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <281ed28bccc14e7006caf17d6cfeb2a679b0e255.1700648588.git.michal.simek@amd.com>
References: <281ed28bccc14e7006caf17d6cfeb2a679b0e255.1700648588.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=michal.simek@amd.com; h=from:subject:message-id; bh=bDV0zdfgVpuSsO0W8zTOM/b/Px1yaSaO6gWWaEUAr34=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTYa312i8oa9Q8surXlGNfRhZlyeae6PGwy/046ZK7Yk s0261NlRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiI0C2GeUa/Z345fs9sWeDd KtZ4+0tsUgGiBgzzU49unvrE7nTTnIW/dgfp8SSsvDzRGgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM8PR12MB5400:EE_
X-MS-Office365-Filtering-Correlation-Id: a17e08eb-2fac-4898-0cdf-08dbeb450d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCeraGcW0afW8ZfdJWzU2eV9nC79GA/5fLlOUbEjq70jYTFq4sRoNR+ktWgomc77UyGLiP+c5OECBMPv08I2DQbDsAy3ph1HVh9Ayxiw7IN/q+6elVP7XhdMpISAyR5sQp27PER9w6PLiCHqPwmypzr0XnBwojXo+xuLHdWrwzOpIh6EW594Ckl6qvycAbjOMc3INKC1yneBSj/N+uCmXLwCOhfFx+TIhvKotkJaex3EK3J7q9N+bYr0s48hrsKU9LJbvCkjhg/sPSkKebQilHJZjyyqEKBqc8qGCRBK0ey09GRES9RfbcyaDTwTA6qdHap8K1kMMf8oFxn9rt8ickxS7ITdt67BqfSjl4+y0mKiK9WYc0vPoucZiKzEhIEVA8SM01OZLrOz4Y8cXNwf/cTT8JXFfaFt0F8IEH2jrWiucw4ciL5M1yywjOdCgTBbNz0eZAtCX/o0Lo1N8NgioC6HXdejk76n3bjLCY9flA2nx/VfvoRwwbLjJV3z5Ko6FF7W5OySYmo8/zp9Uc0SuPUH+4IumQMQB+aKzVyUFlVWm4crABRnKYTX8sF/fb5tLjTXNivF3DPBaiwe9IU4dUmizzL37l+2KuJSanYooZQKCvNom0lAmJBy5GJ5POBdFptjBUoD6GpBnKjjpvcY4fAJnoMwRYGPoT4pfwhaGpOG+8Mt/EGbZdL9fEhCgAqCHsgNEqxeQyTSbakkOPOMYWa6UhVwUnssfDP2OYr9s0CbYYJ+GbuZ5/3P1oGHIjaeCDAAlqHZglXGZ43qVo4323L2umP3Rh/64AQpvRDlW4Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(40460700003)(8936002)(4326008)(8676002)(5660300002)(86362001)(44832011)(7416002)(41300700001)(36756003)(81166007)(26005)(426003)(336012)(82740400003)(356005)(2616005)(47076005)(54906003)(36860700001)(316002)(16526019)(40480700001)(70206006)(70586007)(110136005)(478600001)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:23:21.5292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17e08eb-2fac-4898-0cdf-08dbeb450d9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
- Add Krzysztof's ACK

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

