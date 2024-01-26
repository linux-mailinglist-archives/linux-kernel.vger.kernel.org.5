Return-Path: <linux-kernel+bounces-39731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3040583D581
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6AB1F2230A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006364CF6;
	Fri, 26 Jan 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pqzcDBFK"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1E125CF;
	Fri, 26 Jan 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255913; cv=fail; b=e/owwm4OLtQPXR6P+EBct07O3J8U9+4enCF1NjV+sraw2j3N2cv/x8U3AephQvBE379P7xWD01BbosbNqgWWWDWnc8bGeUe9F4uumXcRv4AghuNYk2i7jHVB9Xm1BjJ+KdFwLy/su1OIfnBSpbqzVDW2/Rv/nwkVPBoLj9JsSyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255913; c=relaxed/simple;
	bh=iZJpxoABYIcc3Ov/ec4qonLeOnn3YlhhTTTR2FClyZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TkZQFvPRbHRB0olC02Q90d/gblMyZtmaV8jG3Brl2gbNJvAVkvgVI6t/oIV9x8Dcot26JOeJQHCuTP4zT6ooLg4OkYJ/BF1TJFwOPAzEwGKqeUd52Hpu83bHzX+Em4tkK/mNK7CLbxsQ81ylYR+KLBCaRsk+qO4KcD0Jpq0vf1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pqzcDBFK; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cy5D9FCIkpU1a/pf51CHyeK8xYTVF6x8+VZKEvl/Tbob04Odj3lVht7nXBhn6P0Cm/d8N/GxSfz7S9i+Btfpn+i63qT6Il4vPx0KNk8pHekb6+a2UIXlutb6vrjOYTNz40RbyvNNEGCiBh/9T4LLvcFPemUlIYEPChkYsMsp8MHgMluWHBWgix360KY9yMNOEU/DEpSklFsWyqe9Rc0Xto+26ycICq3uIgIoDkzDnU1DCncKjtePXSswBDg7I3rMkCGUjQjWrhHMFHegGr8V2S3PvTTKkddAjDChLip5U1t8XtGHzJI/lEWKVLvmYYMXA2yY4TcjCcuwzLUTNsdnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDcIHQG2+G2tlbGqUmQTPWZFbHJ1KvmTHROAwPXx1pY=;
 b=a85o4v7aWOyUJzIUZCWssJY0FGpRzkuGQJhgSUANu3fyVb0rKdEbRb5ClddL+M7T7GOTw+S5zuqUAYcHZUsvuAOUludpErPKWN+MJfBX0vfm2bUIq2mEPUcjGhnnE6KvFKe1KGDjFiO/xEyZ3/BiNxXQfRG4WLabObV7n4v93AZPvXmEGgvKSrO34ZPqRV+Q8J0Xu1pmdCh2aAJakLuB6xYow6oI9L5F9IY+HWS6cdhUizBsZl1iMSOsJLo8BDmgFXuicM0+05DXWeQdh+A59HeIkIBdtki26WCkTFs4fm35UrAD9oPYFlWNm0831Uvk8q+6Et2K8pCYP5wFIARXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDcIHQG2+G2tlbGqUmQTPWZFbHJ1KvmTHROAwPXx1pY=;
 b=pqzcDBFK7NDbTY60mfkZ9a8PPgQBIHFzlUEQbY/WOx31gu8vYQwebvF502VQCSHreKUyeOswtjLtyg3XsSjD5TkJ5eirCeluWv44VjY/HiIZoc+FTTwgQlV0YFF2uG3+jF0eaSQS60cdTJ/1ZQgUpO1NeihNtMS3S9D7p+Cekwo=
Received: from BY5PR17CA0005.namprd17.prod.outlook.com (2603:10b6:a03:1b8::18)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 07:58:30 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::6f) by BY5PR17CA0005.outlook.office365.com
 (2603:10b6:a03:1b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Fri, 26 Jan 2024 07:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 26 Jan 2024 07:58:29 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 01:58:24 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v3 0/2] Update mce_record tracepoint
Date: Fri, 26 Jan 2024 01:57:58 -0600
Message-ID: <20240126075800.1174583-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe9f54c-c351-4c30-8b23-08dc1e4495b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pfRXF44HoTpA0q7gyy2j8mYBrQReEtQVaRw/ifDHlbJuzIKxHvwjickE02gGxnmdUQrnTTYMGJ2IAM1FzYlqsG3/yjFcE0QbBCOKvFXfSW3wMlbGM8cREu4zaTIPeVttY1MYfjzIwWBslVgKSE4iL+Obz3hl3PvhTs3S8pSFwjVClb5oHb4IicDJ3o4NIWGCpZzYzoVzQvncsvnRuB7iEUrc+116eLeR1j/sStXsugHGBj31UMs6PM/bmGtLB2qgIGjUnhDZf892Vvo632Bl0fgT3zSI1R2+qM0v5agwaByF5eMpgkIJGVbur6kWUfiqC4eWrodWq3TiMSNNy8eXySp1nnNN7crljJgwk6+080iiKtR+BbOtLl2LIHgPnkiLi0UlbyZdXhUd+D9f1YA1355hWWeuW/a9ySd6mm9qaSBp/2Vd5f6YVPMVfh8hlS7QP1ERGwVMxfFwPYIg2xyGN6qaeYWUNK1K9iG/Lgh2/xEVyFVv87TmYFXJob28H30sqNhKS1bfER5UhpZDbBlxjTj5TgGpvBQDVjLL72FZvhIUR1NUWTl91+BBjBc1s2xgDbZLOX9u+vPasR1AamTkvl5vVdhkMr1kNcabw0fsgZ1ojn1mtSTPJsgrjhC1XHSnj9/Gn40uJSLzaGRy1qW4QoWQNKfPaUO1GbHcnDQ5hp08k5hmAx8NPuL61ikYdf6rtwJCBz4V5/j4e16gI+ZeG8jcXczDh/U6t2WUGR/wSRXAVXp2/ce/j26eCDli2eaNUh97hJhlLW6xRhnrsb+TYg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(336012)(40480700001)(40460700003)(26005)(1076003)(426003)(47076005)(478600001)(36860700001)(2616005)(36756003)(7696005)(6666004)(83380400001)(16526019)(81166007)(356005)(82740400003)(110136005)(86362001)(316002)(44832011)(70586007)(54906003)(4744005)(2906002)(5660300002)(4326008)(8936002)(8676002)(70206006)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 07:58:29.6698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe9f54c-c351-4c30-8b23-08dc1e4495b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274

This patchset updates the mce_record tracepoint so that the recently added
fields of struct mce are exported through it to userspace.

The first patch adds PPIN (Protected Processor Inventory Number) field to
the tracepoint.

The second patch adds the microcode field (Microcode Revision) to the
tracepoint.

Changes in v2:
 - Export microcode field (Microcode Revision) through the tracepoiont in
   addition to PPIN.

Changes in v3:
 - Change format specifier for microcode revision from %u to %x
 - Fix tab alignments
 - Add Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Avadhut Naik (2):
  tracing: Include PPIN in mce_record tracepoint
  tracing: Include Microcode Revision in mce_record tracepoint

 include/trace/events/mce.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


base-commit: 0d4f19418f067465b0a84a287d9a51e443a0bc3a
-- 
2.34.1


