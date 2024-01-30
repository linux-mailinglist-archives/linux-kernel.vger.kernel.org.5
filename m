Return-Path: <linux-kernel+bounces-44424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EB28421E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB822962ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3869C66B38;
	Tue, 30 Jan 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FbaL/ZI4"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034462800;
	Tue, 30 Jan 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611734; cv=fail; b=G8gATvrhimoyBpfeISARQe1jTdlB/UNg+uHh5D7pvQnw5e5ZTwIOEoprAVLhrDCRGNJTpt2EULR0I+1yD5gMkmagL2o/hAP/5aLXLMNfWZXJG9ExY2uy7fpTXghci8GeSQXkBKvx+Me5/23G2f/s46wu8tgpzJrnDETEG7V2m6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611734; c=relaxed/simple;
	bh=DEtYQNhc0v4Y+C1eknONeRQQEuN9udppi9e7pjjzaIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oDF7ua3Vabvs1e3DROd0QrLf/00vDIHO/SR7I39Q5TP9AyGaikEdoL3eULo0uWsl73BDvQ0VkVsMTVWZSc+VMmEGnxY5ZvaEy60yQu+qxwHh2DkXRq6iq0ndY0Tg+ZEQyrU631f55rEScCRbQhGPHas0s9NnJYZ+1HLB3yP8Q9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FbaL/ZI4; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LW35Frx5jfRh0vu0Q6iyq2wqzrU1iaCLPo22r330SU4Q/MgtGVj3/sOdbpxfw5pM9Aauk3pgRzKuhqdsMGE0nopB6wV0NZ/95Ejj1NNmER/3CbxrKGfsgR1ISn7tnkETDavQ5w9w1e5iC007CyD6Y/78hOQVLeFeLXbMJ8nXtNmjNm6QwhqbT4E/C4g02iqVGsXurqzuzkPdMwWPl9s3NNd22pWL8DJdK6WYaQo9U+xvM4kUs5/IV+ZbKH7JO30CO3SDYsTSCIFZiui+AVFxwNdVJj/VpA340+7jbClSQXXDrWSAI6kXNIGGJByBU/HudR9kX15t0wYUHJkHm5IUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b9Rd5v2XpKc1z4tVb+cjGsX5X0G00eyhnO67gJFD+w=;
 b=Z11G7yx8hXrR7EqAxVLlWMyGvl6S9jItp5tjuEVdShhVx7oSD7eMEdeQ/m0ZIWxryDHAING7N9arpOJR9zMKYmB6xIHt/zPeOsRfRTKSFZxxcXuooc0sPZWdhBQc5AI88pfozAogW/D8lCV0bxK+ycYRmlCQrubVGIqTU0K4wFvE92qMqZmiEXSr3M/bKr2bDzEwvAZwBO2W81dsukgyM9fTohZFvTPeCpTBqTUVv7kkZ33K1wJ+PBVBMLAmpFNxMZzhDB1No5BG8nXZItv3pG4QLId4NKbRe/kGWuc3BQLY3EkqMH2ww+SIasC2h0qY0XL5MQPlEd7fplAoe+fBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b9Rd5v2XpKc1z4tVb+cjGsX5X0G00eyhnO67gJFD+w=;
 b=FbaL/ZI46FLMy86821IxPqBSpRbHJTfGtSydwjZAfTbnkKBONImAGpdrIG+IzVVqDF8/qZNF3UZU8qrsid/0aMmUFLx1S3kYKNKHQNyU3W1qYDyKaOgOJ1EoaDfbCk1imx4eScXJ1hnEhHBfmTJi+4dBkHgqmu/aiWNCR+HouOc=
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 10:48:50 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::40) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 10:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7270.0 via Frontend Transport; Tue, 30 Jan 2024 10:48:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 04:48:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 04:48:49 -0600
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 30 Jan 2024 04:48:45 -0600
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vineeth.karumanchi@amd.com>, <git@amd.com>
Subject: [PATCH net-next 0/3] net: macb: WOL enhancements 
Date: Tue, 30 Jan 2024 16:18:42 +0530
Message-ID: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DM4PR12MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: 82038b3e-95c6-4425-6733-08dc21810b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	erX+K7K4Ljftd+yFvBt7M2MmTQRVSamRCCKsY/HrfEjlWIg8dZvgicd39xcYBtil3hvpsNRPp9dC4Ua80u9q1aMr3YvMXeWOuhBb7pTL6562xbvS1J0CtTGlM9FCKxXgFGVHe1o5poGIngVe1r6W7DTTFk33g422qa28axbnNczBKaIpWiz2ienyvcUSCFX3dHPlS72GDzSHqW5CLk7AwWMOIcLhaJFu4n4xK6PipHPPeKqYHB4/W1o524LVkbMmz5fbCFF5nJJyYXIocu0FJFSLiIu2l8uLHbH79h7Gv1hfBqQRz6jhgIm50p16MNkcuCinGBfIJGkuB+3qJP3+5hBZ+augHw5m4QBNUYR4jo6o0g2wrHNI7W0SMKyFDC0uCWHbbfnXF2WfjgRL9eMfUiSh3tT49UAUY6peR9crIawt1H3bQsfdG3yzPjAy1bQoO6ZRjSYBGaouVMZ8UNmCv4k3986YweRWQW3vo03Y4mRhpfn9su1JF+bqBiakf9j8ptqjilfbA02gCAW1jqj6YwhjZv+Zrne/jaElCLd+CY9U13QzPGkh5wbQ2rviObBHCos45WouZoL4F2atbJta/piaUQzqOdco9ykDNRD6B5LWLEnrhg94q0Jp6CcDE4oNDyk2U1pG3EdVNGYX4dqVADnWlX3ve7Za7AZkxgMFx6dMTkhizterR+/Qo1OEdAU6ET+psOTj06MWZMET0xBEiwF/uxqaC8y90+ee1fIqBNBhsdmIqsuG4RI/xUyxDTat+GC6dgOzpzcBGt+KzhPhs94mcsJ2sOFVh5K2RcJ3ox8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(921011)(4743002)(426003)(2616005)(1076003)(336012)(41300700001)(40460700003)(40480700001)(26005)(47076005)(36860700001)(356005)(36756003)(6666004)(478600001)(83380400001)(81166007)(82740400003)(86362001)(70586007)(44832011)(5660300002)(70206006)(110136005)(54906003)(316002)(4744005)(2906002)(8676002)(8936002)(4326008)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 10:48:50.2763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82038b3e-95c6-4425-6733-08dc21810b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391

- Add provisioning for queue tie-off and queue disable during suspend.
- Add ARP packet support to WOL.

Vineeth Karumanchi (3):
  net: macb: queue tie-off or disable during WOL suspend
  dt-bindings: net: cdns,macb: Add wol-arp-packet property
  net: macb: Add ARP support to WOL

 .../devicetree/bindings/net/cdns,macb.yaml    |   5 +
 drivers/net/ethernet/cadence/macb.h           |   8 ++
 drivers/net/ethernet/cadence/macb_main.c      | 112 ++++++++++++++++--
 3 files changed, 112 insertions(+), 13 deletions(-)

-- 
2.34.1


