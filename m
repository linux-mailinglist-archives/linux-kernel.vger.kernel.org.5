Return-Path: <linux-kernel+bounces-8329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D66181B5C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C715CB2406C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892B373178;
	Thu, 21 Dec 2023 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uyS6qk20"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657FC6EB4D;
	Thu, 21 Dec 2023 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk9+4oTDP+jtnX0qOA+jAmywjkydnuF7JxBTw4+S0X0aY4b8qp5Yr+99PyASnuKr+ZbDgSIb581WbAp1OsUSpH9s5ze1lBw9+rJiasWo1wi30F2PHpJQ9LpIqikR/s0SGWXU3yBGTy5h0DZMbSh7yAP5alw4IQufdSybr/Ld74jvvalwyxp4yuXy1E3R7PE+G1Q7SU6OC0HZ3Wfh9yTlGo7cqgL9K04POKbE03KW+LI5HO1flbA4jVf30F39Kx4QU4cbhypM6mnOkOJuOd4MZKsPL96TjaCB5CEaY6qvoLgMH3R+hDoSvo1pwlMyYEkw8rnVUzjg0EMPZpKbMc3Dfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8EW+A2ylUPQXWMXlQnsQpve+NUOMeP0l+OfB2frPP0=;
 b=h1/8Jm2gOVngWTasBz4jNx1nlCwuziqsADYcowpi1l/dfDcTpU9pmFa/wvMnMtfScro6AamVhQbvq3/nbbfOvWJanEuQwJOf4Gv6r2yaeSVDiH7JMEilWSUozfbnFRifttbSO1WMc3m3ZvPT9162azV8RF10b2SKAqjB6xdMbY/rGVIQj9N38qYbFYv8qImVHlhGwzDJGj1i/EJGK0sOcOkiyuVp1h8FOfzdB2qrnzJnElpPYqz+oFI9TfFeaR5z7Tqmvq1DikevisdcCK3jkquSdg76/9BTUqAjnIXlYci1S0zp5b64Cbgz5n99nezQo7HpIH8NUhPycM7x2OJzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8EW+A2ylUPQXWMXlQnsQpve+NUOMeP0l+OfB2frPP0=;
 b=uyS6qk20fV/2L/Q2AcysWK/kAAg3RhRnT1AeFOE/zuEZggwEGrZy4s4FJGdrK21OOmIK+1E8qVWBbImKTXdhMZP/eX8AVvyTo32999YNMfsYStcLcVUZlVLFqAKhPlQwqX0eBFE7EbWKCK/bnD8J/WJKSRrJiZ1Bd5Amjjh0yCs=
Received: from BYAPR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:40::28)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 12:28:03 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::4d) by BYAPR04CA0015.outlook.office365.com
 (2603:10b6:a03:40::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 12:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 12:28:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 06:28:00 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Mark Brown <broonie@kernel.org>, "Naman
 Trivedi Manojbhai" <naman.trivedimanojbhai@amd.com>, Parth Gajjar
	<parth.gajjar@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	"Wolfram Sang" <wsa@kernel.org>, <devicetree@vger.kernel.org>, kishore Manne
	<nava.kishore.manne@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH v3 0/4] dt-bindings: xilinx: Add missing firmware child nodes
Date: Thu, 21 Dec 2023 13:27:53 +0100
Message-ID: <cover.1703161663.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=michal.simek@amd.com; h=from:subject:message-id; bh=yNGsKt64bh0rhJILDw7kTRzHHB6RuZoh1RZtL9CJ75o=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQWfcfc6YrTV/7cxalyI+Tyj6wDH1vaSh8Y/JNYsvWm0 ewFjY47O2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEbH0Y5uf0599TPFfVsLYy 30xmXae66dXdyxnml6VwNuuHTFQ0fL8zcvd1Drlzv2axAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: c4809390-e83d-4fd2-1044-08dc022046ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UgQ05RJCNsDZ3PVQ1wh6Z6UwuTbYXWhRD/D++LxqmALk45zPtMDo7aR9eTpz1zfn/mwbo4RnEibBq4+2EiEc7nhiwU4yvXQJ9fKi45bRjqIxgmxpqSEjnbjb8ZBTuL0beY9l2HPJ4W2mDRbI+3vfPFHBDgWZlRerZilhNXKX+eOa6aq3k+uvi//NydXa2XGx5CjPjg2f7qcHfWEhuJJSxNXzg2rvHbeY+yuSR79eOTQtiZ+nAvU/A/c8G+gHm+S6Sd+2MBgHz7In9B/IsO5bA+QbU5xyrLYXbvooDRc0REm/mOne7yw4PYzGMGXTdxgQhHg1KPC19QmMlFOtDItMc9b9IHiPfGA09jktkRADyyNs3XBEY6tnD02jiW5LQz9zj95mYNESirpWKiRGRZNp6xTGHMLA1Jq2dvBx4t91Dcial2MDY8gpsqFisNjgVmAW3KE8yI7E1kn8aHoA0O+KGO/KuJRLR98h38SJFngIpMdREoG9RdhuFE3WSDwOGQklRAC9aABJOVLdIJ9r1ROS3C20QF831xXo2r0QT4hMz0uDOVkOCB/mB9nEeCNkq+x2V7EVmGJ2QVgsneJdiKdxrU82psnvLUKOJ69jFqsz7F6ALjwOcx9ZFr4Jda3wxtpIG/uSembuV6UH9DuHKDCOsAIEIixmCDtHwfF4CM9ZRhHj9EOcOtOs4nOGBIVjGX2XsKK9qpiVKT0UWibaf3G7Wl1g2lHbvhxUKCMbK/ogikwu0xSjXZQLWqRcqacxMI5hqlPy/okrXphiWk5f81P53w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(47076005)(356005)(81166007)(82740400003)(41300700001)(86362001)(26005)(16526019)(36860700001)(36756003)(336012)(83380400001)(426003)(2616005)(7416002)(5660300002)(2906002)(8676002)(8936002)(4326008)(316002)(70206006)(70586007)(54906003)(478600001)(40480700001)(110136005)(966005)(6666004)(40460700003)(44832011)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 12:28:03.1691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4809390-e83d-4fd2-1044-08dc022046ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227

Hi,

series is converting missing descriptions for child nodes and also
synchronizing name for power-management discussed with Krzysztof in v1
version available here.
https://lore.kernel.org/r/fc7863a2-d3c5-47c8-9484-ef9cd6d7dd5d@linaro.org

Thanks,
Michal

Changes in v3:
- s/power-controller/power-management/g
- extend example
- s/power-controller/power-management/g
- align commit message
- s/power-controller/power-management/g
- update subject and commit message to match sed above

Changes in v2:
- Sort nodes by name
- Rename zynqmp-power to power-controller
- Keep only single patch for easier handling as done in v1
- New patch in series
- New patch is series
- New patch is series

Michal Simek (4):
  dt-bindings: firmware: xilinx: Describe missing child nodes
  dt-bindings: firmware: xilinx: Sort node names (clock-controller)
  dt-bindings: power: reset: xilinx: Rename node names in examples
  arm64: zynqmp: Rename zynqmp-power node to power-management

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 68 ++++++++++++++++---
 .../power/reset/xlnx,zynqmp-power.yaml        |  4 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  2 +-
 3 files changed, 62 insertions(+), 12 deletions(-)

-- 
2.36.1


