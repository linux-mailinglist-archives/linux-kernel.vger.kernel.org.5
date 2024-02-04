Return-Path: <linux-kernel+bounces-51623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536C848D69
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEE31F22165
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F9224C9;
	Sun,  4 Feb 2024 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sv0m3mcN"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219F922337;
	Sun,  4 Feb 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048800; cv=fail; b=FcTKIM02XMVhAzrE8axjjLQJzzLccAlDavIeuBYyQnNzWLt8GkIPJJWmKmlyoPVO6fupj7f8xVusNcUSxEnagCfMbpyH4OjjHKWsShzmWF8YILY7+NxrwIIb99ED7PuMUVt3KVNPE6b1zYDw5sV8xhIoJfJLKpGutdNBgd4Zdjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048800; c=relaxed/simple;
	bh=En7HNw0kBast0EU2JviQ1J3+DuHZyt9W+6/R3eSQS20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dsyLYKrzl6H8PuXqHynMTFK0ejG5nv1heGAdvTFArgGbq/AAVNhN41hGYaUjdJeGzgWtIW9GiOMmaZFH7BOZwSrOFYD5ZZWlcIPyGN/uVDe4wPrT0F3xwdTm2/FeaklvDuJwpvbSq81cxQfzsfWqo0hff0l8VkAdnspniiMhTAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sv0m3mcN; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSFFnq22N5vihpmp+CUR93HdqyiiAOvyXN5L70ASi+VbqUp7hCyZqFgKdYOe5xBrxvvv5Es7HOCgMikH6UtffJIpzK4GtjoPxIMZxyk8ZvSkprpQfwISbhYKJghBLQgUKvB9WIh9vscihXkRKvadnh3rCJfMLTgFosSu8GrjxVo+ggaLa0yVvTntAjSq2ji8CWlE1eHAgIxBg+Z+HOEnkcM/B2HZNPmTOTjXfbbaQiRvB9EXfCLsIpW2BkzdcGSHtgCBHGKbGcgws5mYYorxHxbyS/IpKSDx4wy4MWp9DGHo4oEFMQB8bQSAjhYZqmoNc8RmaDPVWoOCLBjhy+0krQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6TJQJJWJZACvt2k7ug+VO25cTUh4yNyRRj6Xik2Bz8=;
 b=arRhePtwu7aQdUX/3L1v8r8q6GghRW/PErRMlja6pWpqlSk5WzxMpjbobqH8QFcoua1AIzonkyJqK2qA6HAX2PNt9fS2wHjxZjyGk4JcJwsCJMQbdRvce70SL9tI3rLS+9Gpo6C6gAq53EDvn8KpyLQDsBfQVpovrwzx1un5dUxGBg31RtOiNw1Qmm9pc8irFJ70mQc76P68dGp0QHuC94U7BSXx/bHjPzKV3wOiw1lsqvuEUmfOaWrChQySblDRxbgTTIc5d425THxoUZcRGQLkq4CJf43oaDfZiy2adgyRhJtGKN7N48GDlFnYNd+XXY8jxugN/1LLFdN393G1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6TJQJJWJZACvt2k7ug+VO25cTUh4yNyRRj6Xik2Bz8=;
 b=sv0m3mcNGz4xYYfKb0c+2905/fvU+6xnal1AdwLPejrNpy0ZfyaRZ5gKSU7sHnNh8fE9VNo9HXVHYKFhQ+OssZaYsx2XeTPiFiUDd6zFXCiQ1xR+yfA5eU4KAvuX7L2g0FpkKzpDm9W1Buk/uXjA3zdXEvVmGK/K1umZ4fm9kx8=
Received: from BL1PR13CA0083.namprd13.prod.outlook.com (2603:10b6:208:2b8::28)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Sun, 4 Feb
 2024 12:13:12 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::a) by BL1PR13CA0083.outlook.office365.com
 (2603:10b6:208:2b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Sun, 4 Feb 2024 12:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 4 Feb 2024 12:13:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 4 Feb 2024 06:13:09 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] AMD Pstate Driver Core Performance Boost
Date: Sun, 4 Feb 2024 20:12:51 +0800
Message-ID: <cover.1707047943.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|BN9PR12MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: 280a6257-d46a-41be-5203-08dc257aa8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xx98VuOgA9cxT68PSMdDZsfNrEng7IDsjJswSjEYL0Y6VZaIeo2JUx6+eS/xmQ1RfgG3kcG8Oiy8Ko8pza4BjOovwen1/f5pF6EmHDoK6L75ZQHtm9A39TyJVtWs7AKwxlv8NigJwwPpTFMmZ05zO52VTE856axgH7ybFdObQnEe4MTHsB+jFAmnNfpGORyhBSZ5bIk0AQnIFZ/2x91jTroO3M+/w3NNQyfeWHk8FFYTe2H76r009FvlL7FjRm95UKp4ou6qNmVhaKY/C35raBazeRnov4fHAXfuCuXo6gZz9jpOdrpNSs1A9P4ku52D2zn8aJXVj+tl67WzbotvCrmswPUBGZ8PuFDCm4Yy94RyV8gZAsprbTC/Qu4NDvS+hqWaLJ//3USbDBw/bOogPXt3DB8mrTdNi8XM/OOL4F2g0LtuUdpsKZSdAkUsxoaLTpe+TXLmyFq4Rvsrc36uFQZZVk4tYq48IYht9QQuVxFSunZXdFtzEW1CiRImaTTCuDyQZwencph5d9+HNvPFirwla2pHPQqOluPQVm/BU6ZZGUMWlpzJp2fOPcPf1sqY9RNViBMeu/pATLtj7DWG11WDQQBqPV63/0dv3f1AVkdt1syD6kWsnloYHjCAusAjHkM7qSStaYNiaaos2sRuF+XiqY0Z3iCYZoI3SH87YzRDlvyRcCnkoHRjM7QPxCtke8xaZmVRTRd2pQBgbrvTtDZdfMwpuEUrxIY6Mi5gagyS1ucHuW06dViujwIMs1/9Ljm9LFZdRLA1o4QWHL+VTw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(41300700001)(478600001)(86362001)(36756003)(966005)(426003)(336012)(2616005)(81166007)(356005)(82740400003)(47076005)(26005)(16526019)(83380400001)(2906002)(316002)(70206006)(6636002)(5660300002)(6666004)(44832011)(54906003)(8676002)(36860700001)(70586007)(110136005)(4326008)(8936002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 12:13:12.6844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 280a6257-d46a-41be-5203-08dc257aa8c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292

The patchset series add core performance boost feature for AMD pstate
driver including passisve ,guide and active mode support.

User can change core frequency boost control with a new sysfs entry:

"/sys/devices/system/cpu/amd_pstate/cpb_boost"

The legancy boost interface has been removed due to the function
conflict with new cpb_boost which can support all modes.

1). enable core boost:
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
  0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
  3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578

2). disabble core boost:
$ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
   0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
  3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578


The patches have been tested with the AMD 7950X processor and many users
would like to get core boost control enabled for power saving.



Changes from v1:
 * drop suspend/resume fix patch 6/7 because of the fix should be in
   another fix series instead of CPB feature
 * move the set_boost remove patch to the last(Mario)
 * Fix commit info with "Closes:" (Mario)
 * simplified global.cpb_supported initialization(Mario)
 * Add guide mode support for CPB control
 * Fixed some Doc typos and add guide mode info to Doc as well.

v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.com/


Perry Yuan (6):
  cpufreq: amd-pstate: initialize new core precision boost state
  cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
  cpufreq: amd-pstate: fix max_perf calculation for amd_get_max_freq()
  cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
    while cpb boost off
  Documentation: cpufreq: amd-pstate: introduce the new cpu boost
    control method
  cpufreq: amd-pstate: remove legacy set_boost callback for passive mode

 Documentation/admin-guide/pm/amd-pstate.rst |  11 ++
 drivers/cpufreq/amd-pstate.c                | 168 ++++++++++++++++----
 include/linux/amd-pstate.h                  |   1 -
 3 files changed, 145 insertions(+), 35 deletions(-)

-- 
2.34.1


