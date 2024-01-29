Return-Path: <linux-kernel+bounces-42523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD98E840292
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652E0283120
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0856454;
	Mon, 29 Jan 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VVG/Z89y"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8D55E6D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523289; cv=fail; b=iclkd7A/aPUjH2XHiogIunbjMbo+TFbHrVH+x0JvlxAZH3nM6WU4xHs2qmVyqSK6aj/97Y4bv6p+30U/KlAKnKW8g29L8aAVOcrBb9LuvoKayeeBV1Qk7lOPw8/sP+OCTsTSsUWFgRY+mSFy+hYyfVBDG+BGUXLxnD0EwyBYX30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523289; c=relaxed/simple;
	bh=sDsa2rrz1C9gAis2A2KB5XriCh0e4eWEsIv0+7a9zyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J87YgvI0Z4bUITbILKzmFNdF5t+eN9PnHOPk4cn65OAW0lQOqbxSMvYmz/Q8AJrfcPBiX8hkAijUqSAmILjujL4NPp3PoDhVBbCSi296j7A4Cp1wj/31+hDsRGsXaukv9Wuujf29uFCL+ldb6mZMz9buMFVp8MvYUkl9b0mbr8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VVG/Z89y; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/bsnUl/3Fim3B8Sd3d0Qp6vVMQprk3bjsouBwT57BHRsXXo+nMdDapzM6KzQWc9VbOgMjHOY9IbpLnyn6x4wv+DIQ+VXvxvq/jlbFz6gOKaG3D97W3H0yhmC9u/TWgdzVL45xJw2JYeLlQyJNqgQpfrUpTABODCcSB184TNKupzD5WmOLk7/4my/B2DXvqp+8ckCCV5jmxlxMVQsM9M5B/xCS1Y85zb3mmTCwufPvoZuMAg10PsGCDrzdraBM8aY1dGrkc45xC/ZcEXWRFJgH7JoHQiJX592NkmmLOHR6LsRNCyWn2eM6QfspY2SmoJdjVbfjld7UxlyjAClxxZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXz8U5sHL14QZqUyWbb3DSTiT0B8Egw2qRU0QM00mkY=;
 b=GuKmocaWYbc5Y5km1vodzH8Jjw3eqLdxVpKHCazqlhOwhXG1SDy1S7KWsRKNGCLmBn2dwdgZjsfyKGulZ7SUkf77Xg/PgjGJbR8+3ARJsmsI9sD102u1fck0wla7G+YKDVPjhqgT+96d5JoURdBVvhOWq9fB0oRIkRw9gnHt365CRMhsBMHxtYCiQD37PwHFMbvL71PkHm4v1W8mQKI5qVAMwkKLkbMkI/+263IMi3Ax/3ENZbOvlNIxQdffYKTrmxjjRq/7gq6hx5T4kT4S90rFaKwqqnTUnT6nGZvJHwhesIIHLdS0uD8PXEl/7TXVRKB+25hQLm8pY412xw4UWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXz8U5sHL14QZqUyWbb3DSTiT0B8Egw2qRU0QM00mkY=;
 b=VVG/Z89yTSWY2AgwHNYkzS4AL+Sh8zedeEiZ6D9sc8pigm1P5ESFY+q4cs+rBBsxaOvLYYPEBUMopKuluCqOaU4OWIYrjVCI6ChsP12THVBEtzHSihJHTGnizozCGPUkOyWGsmWxeGoYsH+bhR5KSxiZDgNTtIbKfFXwRLHgvik=
Received: from BN6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:405:75::15)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:14:44 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:405:75:cafe::d8) by BN6PR17CA0026.outlook.office365.com
 (2603:10b6:405:75::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 10:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 10:14:44 +0000
Received: from jenkins-julia.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 04:14:39 -0600
From: Julia Zhang <julia.zhang@amd.com>
To: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, David Airlie <airlied@redhat.com>, Gerd Hoffmann
	<kraxel@redhat.com>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
	<virtualization@lists.linux-foundation.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Daniel Vetter
	<daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Erik Faye-Lund
	<kusmabite@gmail.com>, =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
	<marek.olsak@amd.com>, Pierre-Eric Pelloux-Prayer
	<pierre-eric.pelloux-prayer@amd.com>, Honglei Huang <honglei1.huang@amd.com>,
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>, Julia Zhang
	<julia.zhang@amd.com>
Subject: [PATCH v2 0/1] Implement device_attach for virtio gpu
Date: Mon, 29 Jan 2024 18:12:50 +0800
Message-ID: <20240129101250.3258049-1-julia.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 99948683-2562-4498-ad97-08dc20b31d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MgkGA6IdpLqfVHUHQeMwWS2mvLen/yyQLYvmN8/SMtEGKOtE2M11FC6yy6MaFxJMld6NvonwZWEXCPD+WbGEw+JEfFB7oc9c/WV3hD6uLxgryZ8LBpT+G/Bre61hFOwjNuThiv6C0TzAYS9vWujdhlz1MYkgFnvNh0txM42jiFSEhJBR7ruqsipADmwDcKMAlLMFXzfEFPxJIlgeho7rtTB4Nex9ZLKKmRXgmRwdpQb379iVDkVqwjhUbENJUTBD8kDS/Kgm6OwB08/z2lRqs5D+gOXvPvUDakmk+VdqAdfpVRK7ANRYh9VxUHom5HIiisTiZ7dfY5nV2U+SBQSEPtUWsEGDQZI3vX1fqv6T9TGOKnaKbHC6ZqgH6DjBwGsq8EAjzCBuRpomuxkWCIBSkiuR5J9NM8hJd6VCcg9Tp48hOxs3EwIIGhGWM1ZAGitRIrQmq4jJaqhMlMNeIJqyhOPEv2k5VeopnCjycgfHLAkS3v0yzlxWekIQ5dBq29htWUBLo7q3o/qzjT26vxspb/IuG9q/28moAJeqGKxFNhxKKqtNQvddPALKZeIE9/AFrBT66KskGUY6rYnJun4pkHTIwb1wwFaI8XUTvZV3FISTbHxAOyZPu4ToHmhlaz6b5ghXtZGen0Vvam2Aar2odqBvP34u+I0RXBI+Gt2t2f9Jh02Q/nM39faTtPygVhHUJuJw86wCwv7jlQUiFSioOW9pbIA/mwOeBqVsxu7wpytnWgC3wz6wJeUuZ6kG0mpzwL9JDJUx5UqeZh2gsQslPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(26005)(16526019)(1076003)(83380400001)(426003)(336012)(6666004)(7696005)(36756003)(86362001)(81166007)(82740400003)(356005)(5660300002)(44832011)(7416002)(41300700001)(4326008)(8936002)(8676002)(36860700001)(2616005)(47076005)(70586007)(70206006)(110136005)(54906003)(2906002)(4744005)(316002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 10:14:44.1367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99948683-2562-4498-ad97-08dc20b31d48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239

To realize dGPU prime feature for virtio gpu, we are trying to let dGPU
import vram object of virtio gpu. As vram objects don't have backing pages
and thus can't implement the drm_gem_object_funcs.get_sg_table callback,
this removes calling drm_gem_map_dma_buf in virtgpu_gem_map_dma_buf and
implement virtgpu specific map/unmap/attach callbacks to support both of
shmem objects and vram objects.
 
Changes from v1 to v2:
-Reimplement virtgpu_gem_device_attach() 
-Remove calling drm dma-buf funcs in virtgpu callbacks and reimplement virtgpu
specific dma-buf callbacks.

Julia Zhang (1):
  drm/virtio: Implement device_attach

 drivers/gpu/drm/virtio/virtgpu_prime.c | 40 +++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 4 deletions(-)

-- 
2.34.1


