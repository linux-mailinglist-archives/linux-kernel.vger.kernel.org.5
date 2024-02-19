Return-Path: <linux-kernel+bounces-70897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F0D859DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946D41F22E93
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8544B22330;
	Mon, 19 Feb 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="huNXhnlc"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A02232E;
	Mon, 19 Feb 2024 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329079; cv=fail; b=A3/xRuyOCIOdKup2rQ3ef2L/+3wKvUqDilbhFg5SP5CU/cHKUG/b0i+ueXRgUGDkxBzHelo4TgS4+jNiC2A251h50e5xm2KGirfPPtR2TYE9OWffRuv96kAtGiAw9e7K1mYQRoEp9s7c5ya1R8/OAXIppu/r0YUhaPX5ppc2E9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329079; c=relaxed/simple;
	bh=G4Tc+7Zb3w+pmvhaBq+QwaDIX9/OWcq55Yha3Uk8pl4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X+rOth763PPArnPHCkSWWRoKFX4IgFz9+An35n+sXbppN+gsGmbjdfxg3PwAAg11Hu5p+hIa8JoSsIskJpjXlPQOfWsQE65QNVymNQIKiWDhr0E61cbKLCwGOPdpLMWDVmYeCzSUl5FlGz6+ilfN8B9/Ijw3tqHCZcH+HrPDkfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=huNXhnlc; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iesoww8bkchDaiMQXpSKUtVNZ5w+7OdNntqikxtU8zqEH7T7PjxG8Jfr8sgIy+7N6JmtKIlssrU3CiKW5oFHBTveNzzWW8LAjSZxUW3QrmXCwOz8jB6k9cm7kGzC6qUWOkdnczxOJXs0xHLBX4278e2mgvvSCxuca2skBnjNoSU0y8I5KjaCJtFbAjtNmnyRGW9rr+7aBwjR5QP64IqaRfMjeSM4KSuhWN94kTXJhzqxRXqyqFaNfFIOPHGKxSJh9wno/keLnY3bsu0hTXLePg8p1E7Wesa8zzUFwTAuE1LAF76wEo3i/bEGDpWQ7u7U+q/lI5VKwCq8Ugg4ONXCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHn3iXH7UVdNTmCEfhrVhu0TnsY4LxYdcTCsJr0bNbg=;
 b=eXrl6NDIJHjdAaZ7DR+wjB2Gjehdyj/wSaSa2CmbqlOT377T4IxgziyEeCCuvkqrX+ZAWh2/MZrROVp1meJnQSPaAx76fL2hrHrbJ20doqO36xf1VrXOYE9blYcVeUzcG1FnR4mad6vSejTVqjATlsYSmI52VysBgoLgG3m+ykvcZCYy/8ffqjJcs3AHS+wyEAHXZBBxq+dfe9iqMn1dgTAhqbR24QTRckUUnS/1BdfjEzxPZI7E7GDF702PMLqwYGscI4sCoOpg9j0E4ov4WVdrOz3GjkG9rAEw/MHbITMeiprETg/2Mu44gzP/YP2wkTKcvWJbb2YC00CTQ2Wsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHn3iXH7UVdNTmCEfhrVhu0TnsY4LxYdcTCsJr0bNbg=;
 b=huNXhnlcTzE8sI/yU/Vndq8XBQLBOz1VeSTlKLSUgfBEUBle6ZMI3oi7Xf6vo5ZvxGfNso9e037APnpybLhfrPn5SXLIoBbsgqXFb8xpxuB9wG83xiHoWq2wijpm2p1EZ2zLeMFnODkx1/8R9d91IegJH642Xo2eCmh1dNz7X34=
Received: from CH0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:610:b1::14)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 07:51:14 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::fc) by CH0PR13CA0009.outlook.office365.com
 (2603:10b6:610:b1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16 via Frontend
 Transport; Mon, 19 Feb 2024 07:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 07:51:13 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 01:51:09 -0600
From: Meng Li <li.meng@amd.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Andrei Vagin <avagin@google.com>,
	Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC: Nathan Fontenot <nathan.fontenot@amd.com>, Deepak Sharma
	<deepak.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>,
	<linux-kernel@vger.kernel.org>, Meng Li <li.meng@amd.com>
Subject: [PATCH] selftests/overlayfs: fix compilation error in overlayfs
Date: Mon, 19 Feb 2024 15:50:29 +0800
Message-ID: <20240219075029.2318383-1-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e892a7-2e85-4ec8-162d-08dc311f8be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GuGnJlzXi1CmMzvWJxO7nzdzh9YmTJDUsmT1xywgRWQhsq/dr5Yj5E1+ASXE8UJt+RMw4bDSD+BQrgD6SZa+A591dMdrZndU1zZWebcIOAA01kWog1qsWWWg+xFRr+nrHlxKuITkj2AxKNAXNiq53wuUJV5pxvl6Md3d1Tjc+8IeF/7TZCO4hynYlR+gzdIKe+LjX1XBsyzBGohvBjsiJXl9GM54FB0oCYLBvg3dIMU1RhoNhVlCtKPXG7a51thJ8/xwAMTHnLfvttQj7m3pS/tcu2JI4PYm/9KdQHbsy0l/o5b5bvYR9Mo+hzC9Zyai6Zfhc7k1N1eZ2WkUgekbPDUcf9jz0IKoCA5OjTzwboNuLXRlFBb9t9iFpWFo3SgFcMjiHZJtsjc/0jhWKz6Mf/ArsVLUxwYYRGADxxJ2QUXRZohOdItEi1wyFv7wfj2HdGlU/GOWpm8qzMJsnhjpOInA9k1iGM50gmOb3m6ZJBDiFs8MwPVrJlwfuNqJF1Qy1ulZQJtqtArVrp46I6JW/U+g/2WOge//tuRUOzlXwB8G0Bueynr/Xi896N5WWvwkFCdAooCbtkqPuPMQZPm3cWYpfILHN5sEbq85UAZHVkgO4GYBKJeaftZGOj21gaBKG3jttSswh+RxGzAhp5nVlCfisB0oTA24ViFMgi1xtRI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(36860700004)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36756003)(82740400003)(86362001)(356005)(81166007)(7696005)(41300700001)(316002)(6666004)(54906003)(110136005)(478600001)(83380400001)(336012)(2616005)(16526019)(426003)(1076003)(26005)(8936002)(8676002)(4326008)(70586007)(70206006)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 07:51:13.9755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e892a7-2e85-4ec8-162d-08dc311f8be7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539

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


