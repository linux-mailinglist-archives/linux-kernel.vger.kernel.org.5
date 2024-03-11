Return-Path: <linux-kernel+bounces-98468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87E877A88
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF490281A97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22D98C1D;
	Mon, 11 Mar 2024 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aaIHCSRT"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354217489;
	Mon, 11 Mar 2024 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710134618; cv=fail; b=m4YRmVD+mkNXURfS0ajMyiuD/gmbvLohEFy4dJCpbwYjxNteCgxrSVxvGpEtXtEfne+A9SvL+4TxxRQoy8G3Y/pAkxG63xM6r8GWY8Ilhokj2Vcwlfn0lq0JqGa3TIbNkhXFZ1ljsZ/v2bduzHV5dpsP+DhW19pdQQy1h/kh0RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710134618; c=relaxed/simple;
	bh=zA8xRU+Kuu0HAuZB2hIdXIXhJ3EH2VS5MtDkFg3/7fE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W7DLtO99t5RumL4Dg32QFaiN7NhmZcXXwwvzADlODtpyLm/Y1n5tL0/nAi8l66okOz5Cnv5cQmI7fdW7yKWdE1+uGwdrX5LNJu7LQDwyjyMWKQE8xT+4P8zlaeUoXlHDV+9GEJslyLuXYJrXEBZ0BuCv4LAC24SlqN84Dzd/Xk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aaIHCSRT; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR03Y5N1ZsM2ySfKFUKqXZL/WbBFAN5gIVIA9T6jP51wi8k/pAbV1UfW4lQ4WrMvbVYIBU0p61yzObOiFli06CI9/V07Rkv6vMuxA9yuPeOvSX5GiZL8tRbxYY/xSxORrLKOZWgyIAWdnHi+sU23PiWYmQYHSJmSAnNlXiCN/8K2ujIVRkhjYCYAv8i5ERXnmAUfcz3k4wYlPoO2rOvpFcjGsUS3l4a09GyO+iNFk0y8iU2ROqWpF/dGe/M6zGr64bdkRqn75KbU4wIN2/uNL7XvFtgLp4/8AWM7HuL6xavm8cPiuEPzLTZRWs4OKhxw9Wy8ZbIriwauK49ZZPkkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NaVYszcmZFjnt9KZl2A/i94wOEAXkkt8RybcCRaq24=;
 b=S2/NBVs4CWQ0XPxmgCQsqmybaHuiYwaNnXbHpBN586rQL5FFCu8/eVigk6NQFxDGWcdrTrboBF2kRd6azqtF/kFyDNPEkD/rD2iZKN2XnI5jbGhQpVOiDaw3TgHxAh+80aQvrqfvFWBWPzN+xRGPtueqhbR7kq0Jma+HDMn5ZHpJm/Vz8Py2uffU7vSL6hnsyNgUFnYPGeRh9kkImkWCfFhxh2rmoRGLzqtCjER24hvK1j7F6RPjMjqvjkHc5k0T37T7mYLM18GpP+bTx/WmUcaSObnGi5qDEYr4Q/nJyaTln46+EjrEMXgEXpCdfzQD/EgEaRqM8/AO/ZKlabXokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NaVYszcmZFjnt9KZl2A/i94wOEAXkkt8RybcCRaq24=;
 b=aaIHCSRTRUU5sVE92lGyZDZwCHFub4PJAaK14jzZNRK1U+/B7Gpk9ALy5rEU0n9ZYjIb6/dQHssvSuje8uZCR15yRFwnV7e6mX9UL0cKE4xbsA7wvvBWlP/5B9aALeTwg/mTRXlgGhZlj3xq4E9GrxwAUs36wvlZT4v4O+aeQZs=
Received: from MW4PR04CA0142.namprd04.prod.outlook.com (2603:10b6:303:84::27)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 05:23:31 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::7b) by MW4PR04CA0142.outlook.office365.com
 (2603:10b6:303:84::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 05:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 05:23:31 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 00:23:26 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 0/4] perf vendor events amd: Add Zen 5 events and metrics
Date: Mon, 11 Mar 2024 10:53:14 +0530
Message-ID: <cover.1710133771.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: d7858535-ce3d-4674-2fab-08dc418b63fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BfO42KBdF6pcDp4jMgrMpXSdlMhroVObmKvQBybIF1WeN5LYTR3kL8OJ25wWvU7CyJBErRi/PBkv7ly2piFN6SL9IrnpkvhGV+fX4kUf76B0CfX2+QpVorxMLUjxNraZUHOVgq1NhBom4sOSzHZIzmnBT1Hcw7j/Qq4Fx0ZOUnBF6qySadGZbfB8/44dSlgBWx7nszNTO7v4pgy3aicmmaKT/8gwOF66XZHyVmoz298/Lzr2sphlCZ/4aVrSfmShrxAYHME9mp2+1gwyBECnPFVlIv2i+tBF9Vjrqloo/Hv+3+tmGRWbz2+FxIZNNLR4Qpq1BoB5yV73hg3EwrmaNhVieo/ECOAg5D4LMLhu4cgK9RP03+s+tBz+BDdNsW4+C8xVzhVn8REsTquOVNCYbSJSt0h219i3tdILmCxJwqiJMjAPaTPSkGAnpH0q3wlYxVoUVIcazY4bh6dCY8EBW+St6XyOgAAV1Hzg4aa7wEMrcaRE2yZb6idFyWPKjLe2k271Fi+xCLoqczl05JmNA91cH4Z0nkkzKGkEj2itjzYM1AVcN+tBBwx++6kEAkXpYSL2gL+6bl6ww9IplLbqhhJlHPE8XFij3d19c+Rp6BvvZ6DkOjk7r9lUUvIpy2HVcqh7zMkDKRNj14+t4EPz5JOAqPzjO9X69YWJlE4bMl3izqgFZQ7sYBj6Zf5c1CjyL7xSUctZrQfXLj6HtjiS4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:23:31.2092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7858535-ce3d-4674-2fab-08dc418b63fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555

Add events and metrics taken from the Performance Monitor Counters for
AMD Family 1Ah Model 00h-0Fh Processors document available at
https://bugzilla.kernel.org/attachment.cgi?id=305974

Sandipan Das (4):
  perf vendor events amd: Add Zen 5 core events
  perf vendor events amd: Add Zen 5 uncore events
  perf vendor events amd: Add Zen 5 metrics
  perf vendor events amd: Add Zen 5 mapping

 .../pmu-events/arch/x86/amdzen5/branch.json   |  82 ++
 .../pmu-events/arch/x86/amdzen5/cache.json    | 780 ++++++++++++++++
 .../pmu-events/arch/x86/amdzen5/core.json     | 122 +++
 .../arch/x86/amdzen5/floating-point.json      | 830 ++++++++++++++++++
 .../arch/x86/amdzen5/memory-controller.json   | 101 +++
 .../pmu-events/arch/x86/amdzen5/memory.json   | 180 ++++
 .../pmu-events/arch/x86/amdzen5/other.json    | 168 ++++
 .../pmu-events/arch/x86/amdzen5/pipeline.json |  98 +++
 .../arch/x86/amdzen5/recommended.json         | 357 ++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
 10 files changed, 2719 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/recommended.json

-- 
2.34.1


