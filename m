Return-Path: <linux-kernel+bounces-16054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15351823787
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1B42837A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F41DA44;
	Wed,  3 Jan 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B729325i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68771DA38;
	Wed,  3 Jan 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFFDCv3VctXla/Gi6ZjkBaFWPupLUhlWdpxIBeHbUXA+pLoHV0eYz9BOYxO4q6kiz/ynu5LpbZlET9bnCBj8mjGYJerADCuqOdOhQNnObNhErGr+oUujTe8gnifYw+ziXJ56lRFa+2rO27qAbrSU7ecdzo9Vwi1bFhJxJ46pIP/5cLJezIc2LX8nD1DSzglsdqWpp37J69ATi/YtEBSf+hewyudS9uogFWle284o66GzLQCDV6oF0LoRURdghC2cFJMhvgkXBeK+z/qWSWCqcF+YuKhYM2mmqVDJKpc5Vl2nE7+o/7+99GmItGicYDkOo0DYauDqeuRdVWjCmwRpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njb5DyoE966LEZ0l7SJQc04tI0oe7hFfHZoLIFux/hk=;
 b=fRo/f4IYCRE/i/HE9uh6DDXH25HOwS4LCcO8wKAliqX2vVPVnUSt48u1FG6rZXhoJ8dhB89vVR7TzbO6GZdWnJcFmrsehU4Rpc8DberMX8XzsjmwishyQRRmss8mEWXaYLNpuazkKVNIeIBme4E0eU3YDbkakBAmyMdNAJ9PU1+9Mzn9S4wRN3CYAkRxulDklxnBnO4zkBqB8DJvJTbTHgWZLjhaeH9V5vgbvIghnpAWxOYmRR0WztWUZzV7v5VpILsV8l6AyTH/ILMdi0rloYn1QoxMhuVntxXf0cAUly8esgisT6WZ6HpdUleoX/oJjj1JO9vihIB+3h3fNNpUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njb5DyoE966LEZ0l7SJQc04tI0oe7hFfHZoLIFux/hk=;
 b=B729325iBrndjWEr8taVnVy2PYNLAThOlVm7qC0jH5A+fnem5YtE0jWt1odm0SY22k3g847gx8HIuANKoMmfnQvNq/5x9wtmpD7btitLlJVQd6gUx6hQM1cWlcsVeuO8BrJmTdbpCN1EyFe3pWYEiWamUbe8wA/jJGYtxWHmzpk=
Received: from BYAPR06CA0035.namprd06.prod.outlook.com (2603:10b6:a03:d4::48)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 22:12:01 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::80) by BYAPR06CA0035.outlook.office365.com
 (2603:10b6:a03:d4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 22:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 22:12:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 16:12:00 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 16:12:00 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 3 Jan 2024 16:11:59 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tanmay
 Shah <tanmay.shah@amd.com>
Subject: [PATCH v4 0/2] remoteproc: get rproc devices for clusters
Date: Wed, 3 Jan 2024 14:11:23 -0800
Message-ID: <20240103221124.3063683-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|BN9PR12MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: fa528eb2-0927-4b24-f8b4-08dc0ca9029b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LCY68rq6gdg6Yx88ZHopREhXMWvMUXg1AIXv4xDsy8FuAieCjCi7LJcNYPc9t6RsoiCDBg44j0lgWTP4qKlKjTVeaQdillGhPDb3gyS93jkf5SiD/sO30cYC8FgbJHTTdxc/um1J6iAvvjlSbNeATFyiMOWTQWHUIIk+Oc8J3W6U4saJz4wh+a2m5Q0CQG5QNYA171ewUfMfM0sMQzgaqxNZ5BvgZfGSeBdlP34/b3WyTaNGX2pQCvI+jfzBg0AlRpoOl7AbY2XrA1oKYFZg+huyc+kN12i604RuUi0YviTOVo8csLyF886+iTDo0l7j+IcKWcZoY9STG+Vawxzo2BzNoarsAtbDeopTwHMEEno5P02MiEy0P2HV/uIw1uQmKGFGEX4SMtpyPbajI8NZ32v6z5STfMObvjqbM0ZNYMAC0RbaLmG2zfbkanEdY93ZLmS8GfAsxfRkP7VNg02jhj3L1gVYM7RHArJhFz9CVruBC0t1eGN0nCNg/1dxK6SvcUiCMsCj4psSVeua/dXb22DGpfgEJXIFrnQQ/x2h2++LqEdihmXFHznQ7+w+8Nj6N7Vp8kys6nQMR0pZRF7MNt3TMc0zBc8japkEyCXQDfO52Bl9z9L0WuX7hhnFTtryUepUbjOxDRG0GK+gfVD406f5/x7W7e3FeIGi580P1f22zesu7fuZGMZCV4+aRSVKvgv0pCqvX8xW1jX0too3K36/OT1hqTpjw0Ie3FXUzDwYzIafnCXnzMuGil5S0iwJMO+BKeG0WjJ+1UxeS5xljw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(70586007)(83380400001)(70206006)(2616005)(81166007)(356005)(426003)(336012)(478600001)(36756003)(966005)(1076003)(26005)(47076005)(4326008)(110136005)(36860700001)(316002)(54906003)(6666004)(41300700001)(8936002)(8676002)(86362001)(44832011)(5660300002)(4744005)(82740400003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 22:12:01.1300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa528eb2-0927-4b24-f8b4-08dc0ca9029b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209

This series extends original patch and makes rproc_put() work
for clusters along with rprog_get_by_phandle().

Changes in v4:
  - Retrieve cluster device using rproc->dev.parent->parent relation

Changes in v3:
  - remove module_put call that was introduced in the patch by mistake
  - remove redundant check in rproc_put
  - Add inline comments in rproc_put that explains functionality

Changes in v2:
  - Introduce patch to fix rproc_put as per modified rproc_get_by_phandle

v1: https://lore.kernel.org/all/20221214221643.1286585-1-mathieu.poirier@linaro.org/

Mathieu Poirier (1):
  remoteproc: Make rproc_get_by_phandle() work for clusters

Tanmay Shah (1):
  remoteproc: enhance rproc_put() for clusters

 drivers/remoteproc/remoteproc_core.c | 29 ++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)


base-commit: ff9af5732fe761fa8e7aa66cb482f93a37e284ee
-- 
2.25.1


