Return-Path: <linux-kernel+bounces-82816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDDE868A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F84282429
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49054F84;
	Tue, 27 Feb 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CliRplUO"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB45467C;
	Tue, 27 Feb 2024 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019747; cv=fail; b=Ky8hQ6t2XOnRW21tlsl9gAVNWlOXc9352ojfEgk1q8QNiU6M7iDiqrUNKb7N9KdZF1e21Tvm5ZGL3N9ys0lr5DtXGOmiCrVfG/yzkng+pUA23U6HvK39CalQzkw9QWnp2HW9b3+nT4ShdoUBkoHkFeeU6XeppLNd9WZ92n3fn0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019747; c=relaxed/simple;
	bh=G4Tc+7Zb3w+pmvhaBq+QwaDIX9/OWcq55Yha3Uk8pl4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H5YP2O1DwcW5MWbEIWKyUYCSay0TzkT63d3ssPj0YGysJ1BZIB3G/U194YsPYkYkyULOTVmU5SD2sD3xas78dCKoveIiwDo8ZD8FcG+V0v/4+7Ebh2PRVJPBEUphfEsryLORp2Kka5JaLatJYAH7Pl4Zq38dYEEgNg+6oROXHF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CliRplUO; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHkk5LTyRuXf09dGx1HdyEJq19cJPhkDi3PGGrZ2MaaMgFKBPA8bCOah0PBF2oJMnWV5+yt99w569NV6/lBRFLgblrZlwUPcxstlEA2C30rAzt92zQZqoiSd/UoWIMtXbDEqQum/RNP9WLRVgKc3Pf3pe2T0fbJAi+HkuAQ5LqLI94FCXtBEGgyHOkV8CcIdMSbo8eVl2KAd/ttAVEMVge4iLdxUYhn8/WtsDJo09XEGAjeHvulTtFkfOSeY9D0dzJfPitzIl7U4aNvm2Cx8APYykf2b8kI2YlSEywyH+eIqtsVdu+UOTzXGncsxiikLmE5UUX1Bagh03xAzXe3euw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHn3iXH7UVdNTmCEfhrVhu0TnsY4LxYdcTCsJr0bNbg=;
 b=BqkDRh0FKK2JKhhuWEmfF8k+4GQtJZYGsvezKjhFUpbiXS+o3b9e0nTmpDW0R73r4+22Vk0oOXzl1Yb9hWVQZ+tTC1vNlBklcTJWPKZI8tur4sOiIrYBXZYOobTBA3n8uNR4rNnDU6Fn9ZqX4HvLzh5OSzzxNM1IHSkQOBXbjFXEqbMEkIhfJOsSkHi+T0a6wQ3gZvr618mOAGbLrBeB2q/lsfB2mBUWQbt/hYWxHPMFuQfAnrp/HMLk2hL7cbb3/aSEHg7E7C7RTPc7i68+uBBK6DCixQi343W4FlsEAlL2/49hvHz0SFLPt1GelZD0W5KKaSOCS3nzzL41HIdCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHn3iXH7UVdNTmCEfhrVhu0TnsY4LxYdcTCsJr0bNbg=;
 b=CliRplUO6ymxyWtY7phlpqyc9PWeS/BIzqfkRqiPEKpmGCUJ1SU9iUQR60kGbOImPJ35owWruANKwyorVltojk8WD2thqJ8WxYYvjvK+7F5CJFfSt9L5SL5Y/+ZkpoiWoGFMpidQ6G8/7ZQzhk9TR5PTxiuDKvGFsKa33Hl+Zpw=
Received: from CY5PR19CA0010.namprd19.prod.outlook.com (2603:10b6:930:15::14)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 07:42:22 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::77) by CY5PR19CA0010.outlook.office365.com
 (2603:10b6:930:15::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 07:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 07:42:22 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 01:42:18 -0600
From: Meng Li <li.meng@amd.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Andrei Vagin <avagin@google.com>,
	Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC: Nathan Fontenot <nathan.fontenot@amd.com>, Deepak Sharma
	<deepak.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
	Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>, Meng Li
	<li.meng@amd.com>
Subject: [RESEND PATCH] selftests/overlayfs: fix compilation error in overlayfs
Date: Tue, 27 Feb 2024 15:42:04 +0800
Message-ID: <20240227074204.3573450-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: d663f08b-7cc7-4e15-fb2c-08dc3767a255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W2+tmlgpiqu6bdWi0Nl4AIHGbPkuH5F1zX/nJv4LkZ/LSIM6X4NgudGfq9xpHkCKC0Vx/m+tto5og6DD56yoXJolQR6S9aGlYb2mQjiP4y1/GtXiGeBFSgFxxcexhs0i20aq26ZbpRFzOnmT17YxEaunTNJsI8JqnNirgppFcMfEfXrnLlLzBdaInmKpg6BuQVJMaQxUxNKrvHRrbZ5lcVg4D32cIXTsxz9jGp+MzBcObbbldia8QULPfYXfp1erybUHjfdgsXTMvC7XIwbQKsiLoYHSQIrySJ+zK35VmJE+ii4qeZlfzsRzycnXE8gtuLSUZ/s5zDrEpKpNJnjOLuNj+CahMns//mwk/wAy/oD/pXBrbpwK2BKRFsym3qcjoeBKO2dsVprwie/sm3ZcdH7UnfuuxHyJpV3luu45XVFqfbXXDorkS6RO8LfLiU4JSOOt1g3QOwlXmHqJLJ4t8mbCrAbWyfauuJ0HYGwh7Qp1GlsesRCXBIX0W+6Nn6alfkzPz/+X1XkCMiUGDQXtWKuEi1dUzAJTiLh4rv1cEbNGyQLJCbrdEThseHsn7fHHYQxF5+pP732jgJXW8k5cSbFmxUvt2DX11tnmVsWiOUXC2vS9yzDJXRk+pFZY64WvsctGPWYzlx2SJgkoPeNQlTybzhxT3u9+JEmxCwrOepjurAG4pZiT17Q9KNGjpTjp8xNOBun7AE9JxFhTx63acqpFkl7+SOj2dURFFNv/llBsWQ6Ej4XzATf3+2pV0fQN
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 07:42:22.3532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d663f08b-7cc7-4e15-fb2c-08dc3767a255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536

make -C tools/testing/selftests, compiling dev_in_maps fail.
In file included from dev_in_maps.c:10:
/usr/include/x86_64-linux-gnu/sys/mount.h:35:3: error: expected identifier before numeric constant
   35 |   MS_RDONLY = 1,                /* Mount read-only.  */
      |   ^~~~~~~~~

That sys/mount.h has to be included before linux/mount.h.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index e19ab0e85709..871a0923c06e 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -7,11 +7,11 @@
 
 #include <linux/unistd.h>
 #include <linux/types.h>
-#include <linux/mount.h>
 #include <sys/syscall.h>
 #include <sys/stat.h>
 #include <sys/mount.h>
 #include <sys/mman.h>
+#include <linux/mount.h>
 #include <sched.h>
 #include <fcntl.h>
 
-- 
2.34.1


