Return-Path: <linux-kernel+bounces-57285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F55E84D623
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65621F25015
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE6C200DD;
	Wed,  7 Feb 2024 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5X8/JPKT"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800F200BE;
	Wed,  7 Feb 2024 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346605; cv=fail; b=FkC0PzFZHhztkCHWiKCQk4N6pYEuzJ+gBZoPwEa40YxOkZ0UNHh8C0L4BgJXNslrfQRwsHExjqReekcMd4GL/Ia+njyJEEXMvKwoufuqokxKt7st930rwyXRKPtdxTCOfPMws2b2TIPmXtXoHjVm4b6bTY8dAaQbS4NyH8mACqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346605; c=relaxed/simple;
	bh=j2E9uh4j1qPvr4dapFu+x3uBvUcuGAN1CviBz9Ff428=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V9yTw56Yq8i/irIuQAdLeBWZibdysL41QwW2cvwhFeAbe3NyxQXuKDkV3iDB6epxYDy9Y+Ke/Ru8PNjRaltB143036anGdhUwARsM0jYXImIx22UEpdp6dzc6AIE7h5Os0RCAYZocYJBZOoY9hXOjKc1JiNX6vD9zKr4bTOPhOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5X8/JPKT; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By55j9BzLYZk6BFA6FzCEcagDWuLeYssoEbvWcyMuNjXi4FvNlUxsugGvksMq7NFrPDwiWIXSrH53RXJisewZbSUleu9fQQXDfix9594mwoITt9Uo6tnMMnVCkLzE6sRBu3MpAlK31F1Qmst+GT0Wf+2ZuleLj0E02qwt/kUfi/iAsBri5FqEZc8++Dlo5BnM40ymCw0wPGk4GaPRV9zmlFniZaGomp+o/evH6K1PcjsxHM44pW2BOv4zRYB0mopeBuJDYtIdelqpxI6GuqttDwQOnWDMFRD2w+T9pQWrrPdIxCQWzxNY7xAuhrfL9/w8DRhN+8nyRXfNf4I2U19pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pefoVknZj3nWZQOkUulzfv4GSoYKDwV1lZlqqXB9FfQ=;
 b=DHvmz6NzMDC6Im1JgXw01s5oYb1HHWmxQ9A4Ebk0pHsvE+oYju8qgxmqC6XNBVR1x+aGhhkglnTQzIBJ/gRejgFdoTqFCgloedupc4fdB6VGyqm0FemM2qXBSpkDRI2y2HquqexDHobgPW0R9x+tzsNk1m22+HE5edY2PFfxhGhG0wX5oGyzhcIG43JBWDpOL08BAARxSZZR7G5cKbVoYS6ui8DCcnEmpfhpYMEhuM1EfYZCJyEcriOND5PyVDwvFtbpghre3JvKmIPb9YudNXPCW+1Xlf3SuCrZ73o0Kdjpiu6qon44D51bWYJx0v+wvfcU46Wo2VBiUfnBa/BbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pefoVknZj3nWZQOkUulzfv4GSoYKDwV1lZlqqXB9FfQ=;
 b=5X8/JPKThuTAh85DzBmgulw6+TNq0VCJS14G7JGRQJxS++1OMGdALq8HJFGuejQtNVwlQu8GwrCoY/VqC8XRDffgEbycak9fZxerNBWFy/S5TKbBuj2Bu8qaH8C7vElL4/NrJ5JoPP+4aBQEJOz4KDVANEpHpOFAYn1OIdvBXIk=
Received: from BN1PR14CA0004.namprd14.prod.outlook.com (2603:10b6:408:e3::9)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 22:56:40 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:e3:cafe::86) by BN1PR14CA0004.outlook.office365.com
 (2603:10b6:408:e3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Wed, 7 Feb 2024 22:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 22:56:39 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 16:56:38 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH 0/2] Extend size of the MCE Records pool
Date: Wed, 7 Feb 2024 16:56:30 -0600
Message-ID: <20240207225632.159276-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6495a2ff-f651-4763-9287-08dc28300bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mumhOSpc7UVaduJxBNBQXuuUQhR6SGIJiNwOJ0BPPcfBSMX7SJry5tglAtwvkPkydm+z8WOvM2faBhLTJU9bbzx7tzAh3q9qVYhAKJSXCr7fm5c+lGXTS4soUGYBV5L4vA1UxnaxAohFlpG4GyEKpmz13/esUjsU54V0LR6da5llMpT2achAVYISZ3+J+VT4ZeozhH9Z/yKLYCIvDeFavk/8ZO8VfrTO3R+iYveMquFoJQrnuCd0Vpluyaz3DrTOaMlDqKw+8dQWtuiyhSv6YHSiyLZqUXIIqLCi2RSzJaYUZuPS9v64LlS8AXH8NlRv3I7qUXFxXA5KiGuLu9OvnfuiJe7BQWg2+Ry+5JLE8oA9cD9ZVD9R6JT9PfvruuvKfq/4GDVxUFjvjEd2yMYEfy6BSmG+7dYZvCuDXKt3P0vpfm5yMR3Q01Oh5vQrzpuqK9LZvc8c75HqI/coSFZy7pCdfeVg+fFjxLFkHFWS3zaj3XTJg03dRfjSlrz5E2mBPLIhqWQGsld38LfLP7kk0W0dlRIaZpx0mwTR3ioGTeXkewKEkZIRkW2Fcg+JQSVnKPLo7soV9dSudcjigc6MUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(26005)(2616005)(336012)(16526019)(426003)(83380400001)(478600001)(1076003)(966005)(7696005)(86362001)(70586007)(316002)(70206006)(4326008)(8676002)(54906003)(8936002)(110136005)(356005)(81166007)(6666004)(82740400003)(44832011)(36756003)(41300700001)(2906002)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:56:39.9405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6495a2ff-f651-4763-9287-08dc28300bd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863

This patchset extends size of the existing MCE records pool to ensure
that MCE records are not dropped, particularly on systems with higher
CPU count.

This is a followup of the below discussion:
https://lore.kernel.org/linux-edac/20231011163320.79732-1-sironi@amazon.de/

The fist patch extends the size of MCE Records pool in accordance to the
CPU count of the system.

The second patch adds a new command line parameter to extend the size of
MCE Records pool by a predetermined number of pages.

Avadhut Naik (2):
  x86/MCE: Extend size of the MCE Records pool
  x86/MCE: Add command line option to extend MCE Records pool

 .../admin-guide/kernel-parameters.txt         |  2 +
 arch/x86/kernel/cpu/mce/core.c                |  3 ++
 arch/x86/kernel/cpu/mce/genpool.c             | 38 +++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h            |  1 +
 4 files changed, 44 insertions(+)


base-commit: 93e1e1fe2f97859cb079078b6b750542ebbfdea8
-- 
2.34.1


