Return-Path: <linux-kernel+bounces-45188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93CC842CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F9028DB61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0567B3D3;
	Tue, 30 Jan 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YZaWIhni"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5287B3C2;
	Tue, 30 Jan 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642802; cv=fail; b=UZir/CCc0Ou+JEdHd2RnOClGDXOt5kWy13j0LbYTp87IvKeTBKPFwqy17UkHlu0xavZmHlRlUxJ8fgptPQmeLvWpPEgO9ZZVsoFvRIcieOhwuo3E54xoVImiEPHazKmSzrh7/qPfHVeM9BX9EtV9qRUZsIiZ0YiGNz+aoyDDOOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642802; c=relaxed/simple;
	bh=t/kac1SUVOseqzVc1HIcxkPZzSxbn043Y6pJAqpqEic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=klaDiDBPXjub3NwVkH0o6hQU8iZs6aymW4OmUbzJkyVYnjRmThYIm5T7BfYyC25LeaIfavKJLCmWkvF8xF4i4sV3ZLjbSbPIveOwf6Z5wn3qwOQnHFnVwAbLAa8G9L/kBOXXwolhgtSO/mw/TelnnzKtGx3r2rZZxMuAp/ZkNaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YZaWIhni; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkZzc+0V3Bec3vQFeJpgHY8z2vk3rt46/BqgJ5Hwaq0miLzkRo3VCbmf8t38txS+f1nlq9HLfxRlRAt1CL+C8m1ZEU3e5Su10h8cKnzrcG+LjdCVYbJwtgXyw36A6Ynj1KATW81W24kqVuaHbUIFCd2xE9K1fCpLajCdVwnj9S0dJSytFJ57BmMKdG8x8LaudeEGThVqaAREqVa9ofGETpUmsYrbRSipj6Ubg5XfU5aGbnGXtwcud6GYcHWCfumOUu69pyy2IC8IBYDykt1qvn3CWXvAJU/LxzYxhqxvmMilEk4rvDLP0u4cTRAYNVkVY5SymIbWIJK4Ym76sW++Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db6bwX7jDfv+EKu4pIOtvEQGFdVmC8EilqoAb6TLfdQ=;
 b=dIbuMH/oHlp9ZtXfJwqBcS2/YUKdJk8+Ny/asJ9xFU/9XqpIx+qCFv6M6AKtWBaOjc65t9aviLtgxJSqzw2vFeB1a615xWyslDSAGdwlQw+S/nUJuxQ1UMKkOIa3fI4Hf+ZXhGM0e7wgP/tyADanmRIjHlkR6nYknNx31XIno5b/GaQTdg/ciNW9N2u0dCIoZAxj9SeBrD3YR4hO/qA5jph05IJF7eudCp3bduY6e246qL4BXx1U8SG/+U30RW4MxVak/OEt3oDi5IVovlYwdS2xNB1FbFz4dxDHKOWtu3tSwgAAqBL+WG/MDxt9T0SHPjq5yP557ugZZnFonDTSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db6bwX7jDfv+EKu4pIOtvEQGFdVmC8EilqoAb6TLfdQ=;
 b=YZaWIhniWVAP3Ih8sotOrMJEBNLbyM5hzRUHV/g1mlkgWkNCvG6CHhiulktmG5vyissteY1+iONLluvCPD5QmXACvEm1v4Wh7oT3sJSBJmwanYFJZ47Sp7kllaqn7nEBZmOamRdZIhYqsxsvm3ola6P513LsUCXDaPEY/rEB4kU=
Received: from MW3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:303:2b::29)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:26:37 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::e6) by MW3PR05CA0024.outlook.office365.com
 (2603:10b6:303:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Tue, 30 Jan 2024 19:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 19:26:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 13:26:35 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 0/4] Add support for fetching EDID from ACPI _DDC
Date: Tue, 30 Jan 2024 13:26:04 -0600
Message-ID: <20240130192608.11666-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|BL1PR12MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8bfb43-2b46-4bc9-7077-08dc21c96084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mquWkRiRkZcSi2khJNb55Izfh1y6iIiAdlSWiP/EBVCoDICJsaA3/RCB1+15zCiPu3VZc/48QXLOrP1u4RCq4Tt4YofAE8uJWaiorzKMuMZRcQFqbtZcIfL3BLus1CEdv6v2propws9BQ7ff/GWDf7fuFE6MJ0EaJ1mvs7ED44VPM4tIC+UNe2wz8ediLcuPv0+blI3LYwR2MgiHxOR5mXQziOdsi6+TaAcro9jhpV7qC9h4PwxywJhVnBx41LVmeKO8isXHlwT6MoNZ6tGs0FLQj2z22pAY5QDR06vpM93HfTZYmUPiU4Yvoue8mR3NX/V6tIORWsbhe/loZ/QZMhVuyCOjUVXogfpeZ4UUgwmeUYybf+rbNN9oxoIipPIyXOyHYFNhInDKJYkfU0iw5unFXjJml/7P64bTUjPekDMEkMtknrbQE4AJI5/q9ZBpBMHZ8UoCKkkep59+GBeUmW7QBvXhizfy5c3Z8HFsP5BAA3BqpvbuT9MVLbqJ0isuT+hlO5PyTkzsn5INDzAmhwsi3b52ZWDQziZL1xN9eBev3A+x2IRjyQRJP5NkAaegR2+gRs/jvPXy5CR2piGGld8zOASu+tZ2z9xK7eaJMcgWmY27/N1fegnVGZnY6hilSH1G+Ml2/1EzTA7FE39v/jX0JLhZJfQNKF5CouIof4qnXDt7klazPJgb0At8MANVKwxgWPgNQqc9PvN5xLZlmdIrDJt6jIdTCkdHs/81PEdQD1AxtQfq/k3lEw6kN8do
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(966005)(83380400001)(36756003)(2616005)(70206006)(54906003)(8676002)(86362001)(70586007)(110136005)(316002)(7696005)(8936002)(478600001)(4326008)(2906002)(26005)(16526019)(1076003)(6666004)(336012)(44832011)(426003)(5660300002)(41300700001)(356005)(40460700003)(40480700001)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:26:36.9484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8bfb43-2b46-4bc9-7077-08dc21c96084
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126

Some laptops ship an EDID in the BIOS encoded in the _DDC method that
differs than the EDID directly on the laptop panel for $REASONS.

This is the EDID that is used by the AMD Windows driver, and so sometimes
different results are found in different operating systems.

This series adds a new DRM helper that will use acpi_video to fetch the
EDID.

On amdgpu when an eDP panel is found the BIOS
is checked first for an EDID and that used as a preference if found.

On nouveau it replaces the previous local function doing a similar role.

This does *not* use struct drm_edid as this will require more involved
amdgpu display driver work that will come separately as part of follow-ups
to: https://lore.kernel.org/amd-gfx/20240126163429.56714-1-mwen@igalia.com/

Mario Limonciello (4):
  ACPI: video: Handle fetching EDID that is longer than 256 bytes
  drm: Add drm_get_acpi_edid() helper
  drm/amd: Fetch the EDID from _DDC if available for eDP
  drm/nouveau: Use drm_get_acpi_edid() helper

 drivers/acpi/acpi_video.c                     | 25 +++----
 drivers/gpu/drm/Kconfig                       |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  8 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  9 ++-
 drivers/gpu/drm/drm_edid.c                    | 73 +++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_acpi.c        | 27 -------
 drivers/gpu/drm/nouveau/nouveau_acpi.h        |  2 -
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  2 +-
 include/drm/drm_edid.h                        |  1 +
 12 files changed, 115 insertions(+), 51 deletions(-)

-- 
2.34.1


