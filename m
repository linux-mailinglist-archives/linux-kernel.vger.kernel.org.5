Return-Path: <linux-kernel+bounces-40533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6A83E202
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DED1C22995
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C020224E3;
	Fri, 26 Jan 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rA6qjoK8"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE92232B;
	Fri, 26 Jan 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295321; cv=fail; b=KUmX52NooaryR31eDBqG7UNjVYka/2EeTSSATKhkoXDN4D/cZodu30ZOiHbLRrK18YPx6KX+FlufGho2f4T4/UkTYjPVWsPIJ5Mk/n5oQZIpI/T3kYKnKCyaI+bptPcblQs/9GAvWzLnHpu7I27tquI0GIJZPgh2U9oQzKoNY3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295321; c=relaxed/simple;
	bh=C91UcQEh4Agd4/sArZTa0X7SH3zMFQ2oenaxwehvShQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqJhqr9Z9t0LuZE9JbZw5yn02S5yekMNoAIdXbJEOlhOsBaaszFnXgTNl/eFVnVqN4U+Y5031qdIGwj1fye8Xu6ehJ042X+OCzN7bCo49jdZO2kktFLZ5VyUXJfD93ku2avFK0MgT8HYoTSgbYQHAsPYemiBYYx4uSrhOxt484M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rA6qjoK8; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuRdQDnhRAahkfVcrcE6B8AIYDJp095v1lm6hcqCmkyDqQEU2Fj+Fg1okWnbJJSGSEUuEEzRFQzTFUkvsRAjQqgMpQL3xL//i4dD2fqybWrkc3VNamIt1XI1iB1kSUxgiNmRNpu09kKXzfPmnvNlGQFydbsDTCGodSan+VYFxTYEfar7FFGRL+BehNwQ4q3+oqQ2Y3jXAbuai7CKj74LcxGSkds8JkDlSYj1KNTVM6y0suce7/WejfyDwTMgXrCdWq37/h8Zfb5Gra+apwyvYp5b+L86inM6z+XqkIu8Ad9ZYTTd2N4iTruqUnhSFrMCc6q8uz8v9IgA8dMY6KTd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMCuH9mZs7slE8wzx6pXth3rWgnD5dQQOLmhWG9Wv/8=;
 b=b0NgBT2cJtJxjpeTf2Veq1PJtQjveU+7Drb9tKNDzbsI4gA09NIH41FTA0Q5kMaFsyCX3oNfNyHnxR0FESR/lcDSScvFeE1v0pLurp6Dcay5ji6snAARG10SLwS94fpp1LDmaqATv/SrjyWQB+Ycqo4cUpCfGbTEP1j6sTOfBBCy91SJLMn7l2a5kLytHjkOY1/cfJOHFl4AJuA1Q1iS3U4QrxGE1znPVIdgjKHnooPeRhdIUnhfUtRvwH8Vs3+jFaAeDeyORpUA6cYlVKbz8FnJH9zORmi6tdzVFjGwF/+696rUvBnYkdD2qKua+ir/hAFs/JWlMCoZFkN82FHK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMCuH9mZs7slE8wzx6pXth3rWgnD5dQQOLmhWG9Wv/8=;
 b=rA6qjoK8k6NIUwyfJs25MxOf9kXkaFgq8oRywMJpVK85xEt9+YbQuH2xvi+vZrGQFB6r3T3dnp5Jvo/1qk/iGk3XBETgc62eB0fnxeSm6tkkLENOt0ARlP0ZpUm/6F6GBo6K+Q9LLYPvVVcowdb0sTmK1vX+LqJcKdC8cl9ubwg=
Received: from BN9PR03CA0582.namprd03.prod.outlook.com (2603:10b6:408:10d::17)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 18:55:14 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::73) by BN9PR03CA0582.outlook.office365.com
 (2603:10b6:408:10d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 18:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 18:55:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 12:55:11 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 1/2] ACPI: video: Handle fetching EDID that is longer than 256 bytes
Date: Fri, 26 Jan 2024 12:46:38 -0600
Message-ID: <20240126184639.8187-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126184639.8187-1-mario.limonciello@amd.com>
References: <20240126184639.8187-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 532a03b3-f739-407b-10be-08dc1ea053f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DmKRLI0LVgR2+zLXC5D73BiuqB5jNYNBq5vxPpIsDEn9C0hv3ZOZe3s2RoOzlyVuSbbixp+iByXzCBsmIPXjMbOEsXcmJLXZpgdaUABaRGyQoUWLkb3NMqYkQPic8MKqQlj2NoAtlddX/TF3lOVh52jXExlXZr5TURaWbVagidO/Fq/e0FjzAAJMt7YjBpMsUYOFWca1VwePtwhEA2+uZKnjfT7MQWwGfyasJ5tZwAiRCg+d2JJ7jiXyOvwRmKSWn0nVwp+o+ehlSIbUY/4ooKh1pQdW+aLqh8E0uvhlr9a0WsV7Jd59qk8ye5k5zmKiy/S5LjzagcjapAT/x9kcnsw/TwhAhq10nsAO3/nhDl8mA2J1mJkbYICXoQalhiwSdhiVGs1nCR65xociZZlBh/oe1SILiIdw26WmCoGEAoaeNrvyQjypCo8lNV4AajI7U6ExgWjw7lhvbl6z7xH/nCCKrMC+U0LoCzVFRVF7c8rBsz7TLGyF1VIoM9+DEd8KUvBVzH/Y8vbvxv7S3kebaitsHL5qkaYIKWYiYGSRstRg+Uiegjc0d9C3/9nxROkfyFETOtREWlau1YRQyYiCJCD4lYAcQ5bRsAWWYtLf1jncLNfOQv+pjphTrIQnAXXCWRe/g711zKi9CAyzhqHboE4GpskJxUGxDlQibOb36gx0W2eZpKJ8HPr62zpEL/a5/X0Zzh7FMqUHmaZI1Gq/HW1+IOX+4t8AwDg3jCy9+qldAJLcZq4bC/PEBOG4sMY26P6x3tAc7cj17HaFn2ZrlbC7zdUeZkIZGzP6gS3g/0g=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(16526019)(81166007)(86362001)(26005)(2616005)(478600001)(426003)(336012)(36860700001)(8676002)(8936002)(41300700001)(36756003)(70586007)(82740400003)(47076005)(83380400001)(1076003)(4326008)(54906003)(110136005)(70206006)(356005)(44832011)(7696005)(6666004)(316002)(5660300002)(966005)(40460700003)(40480700001)(148743002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:55:13.1494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532a03b3-f739-407b-10be-08dc1ea053f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

The ACPI specification allows for an EDID to be up to 512 bytes but
the _DDC EDID fetching code will only try up to 256 bytes.

Modify the code to instead start at 512 bytes and work it's way
down instead.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extensions/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/acpi_video.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 62f4364e4460..b3b15dd4755d 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -624,6 +624,10 @@ acpi_video_device_EDID(struct acpi_video_device *device,
 		arg0.integer.value = 1;
 	else if (length == 256)
 		arg0.integer.value = 2;
+	else if (length == 384)
+		arg0.integer.value = 3;
+	else if (length == 512)
+		arg0.integer.value = 4;
 	else
 		return -EINVAL;
 
@@ -1443,7 +1447,7 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 
 	for (i = 0; i < video->attached_count; i++) {
 		video_device = video->attached_array[i].bind_info;
-		length = 256;
+		length = 512;
 
 		if (!video_device)
 			continue;
@@ -1478,13 +1482,18 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 
 		if (ACPI_FAILURE(status) || !buffer ||
 		    buffer->type != ACPI_TYPE_BUFFER) {
-			length = 128;
-			status = acpi_video_device_EDID(video_device, &buffer,
-							length);
-			if (ACPI_FAILURE(status) || !buffer ||
-			    buffer->type != ACPI_TYPE_BUFFER) {
-				continue;
+			while (length) {
+				length -= 128;
+				status = acpi_video_device_EDID(video_device, &buffer,
+								length);
+				if (ACPI_FAILURE(status) || !buffer ||
+				    buffer->type != ACPI_TYPE_BUFFER) {
+					continue;
+				}
+				break;
 			}
+			if (!length)
+				continue;
 		}
 
 		*edid = buffer->buffer.pointer;
-- 
2.34.1


