Return-Path: <linux-kernel+bounces-43635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F222184170D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE528490D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EA853E3F;
	Mon, 29 Jan 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="356QQrd7"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33351C31;
	Mon, 29 Jan 2024 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571656; cv=fail; b=jjs1Q+B7vUjHQQm7Nfc2pD7OxmsyGHC0JGebGRuhqH1uxPcHC9/IH2b0bSCSlq9CxNMzxUdT6/1HvXRe+07LSc34mZpLg6Hsburou+Wxnzs7KCpo5lqXgYHKF0fw4TGuwsEtQldqLnfcF5IpnENC0H1pSWSXS2/dlyrkNqET5ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571656; c=relaxed/simple;
	bh=gh+TsMhvzM3pPaDHAyYzKoinxVLcZoy6meTrzhPpolE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZB2MFfD19NOnaEQmUKkm5TEmJMlZE5Bn/r+q9e6BcnmqoSq8w6VkRMTTeBM+38V7wrqgaUyqKvjVWj9yvVpEbvOnPVRcYojuX6U2W/WUSJJC7jipxqiRYwo9dtN7vzlEulm6kKJAZNAvuRjKOMTYNcQ3qZ1zEfy2RX/CMvy5X8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=356QQrd7; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy1x/pPPjGRFZD3oCFEUIPyAW6X8nFmJOlWZXT72iqL4cSEfZBvKVwOeftKviTSE1fp4le3RjzRZMz2gzCtq3Eal4gQSjs5spT8r+ZBLLGHF5rCUbmq9i3aHxg8rAdpMlk5MJIkr0JoveHgsfE8btC1zF0sK5ZQZvZBoMkH5l8TLdnePxDbFerhBPjIF7oN1vI3Li9PtfGaegI9RmgKy+iVBxdDh1M3QR5O4O7LElY9i7Llo+wMGNgl6mvkHJSS07KTpNPWh4ThioJb5I/U8ooZI5PxmQFcXwS6Pc4DeJ2S9IH5EkunJxL/rEd3D7R5nwBPDPsx4tistosIM7RWWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fD7LuxfKAOHaKcbplIOcuKT3kHFAg1mEL25+0AjaKA=;
 b=UDDgu2K3Br1bloIfw3cwWnecOEshHQA/54kcgHIz2xmfZ5RS3N5JNypsH8cR/l+vm/kNwjF0OASClpgkaRVaougn+9V69d/gvKAntx541WryALDiI/Z43Q1dQeV6HyBPLnxzY93edEzcBnEGm7U31nqz0Ke3lUTClAeLw6MtC3QYutnNk/Uk8ekf/0NQE5PGbG8z9/vDB+y5ByHu5VlE3aNEjlZsc920RXehLaZ0dvhUM9QQqM55ZMxY0PuuntQO5alqOXDKwpAa8sOOWuxOK5s7kuWgHcNZ7Nl82dtOxpSRMZKmns4lw40oqBibP8jtZ1RGEInx38LMPfZXSZdkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fD7LuxfKAOHaKcbplIOcuKT3kHFAg1mEL25+0AjaKA=;
 b=356QQrd7BrAN3fquNghiEsiEckW+A1FhrcVeLquO6S+DbLg+yZnFwTbkyY5bC01HAN1/Hyr1IFMsmkGMty9DaGMohSpcK3UPnO4pHYIfsD4H739bXHg1pTB9vdjp/Y5GJbHg0OWTRCkkXlwvhFzckV4OUL5aMMfqChwlg/k0skU=
Received: from CH2PR19CA0008.namprd19.prod.outlook.com (2603:10b6:610:4d::18)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 23:40:49 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::7d) by CH2PR19CA0008.outlook.office365.com
 (2603:10b6:610:4d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 23:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 23:40:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 17:40:48 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net 0/6] pds_core: Various fixes
Date: Mon, 29 Jan 2024 15:40:29 -0800
Message-ID: <20240129234035.69802-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7916f3-5da2-43f5-8237-08dc2123b901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dcSYqEwRpK0mXZjX+w6J4L1JWjqYBicYJ3KORyqhBITSAYiatOwse4Rzj2iPuHYiFibnm2ZYqCNVooEdp1ZTFwgAgVMTOralVFsGCd7f+xF+fRZx+b9FkXSBBlkki6EyFH2G6J4oryyaO2+K4yGuSVefx5gBIJgS6HwDY9chv3banQ4juwM1bDJLyPz1ZPRS5xeBd9i9EABLeDE0ZISszqwzcM+oC/L6vJSAVg21Zggu6daqETvWmG1rcBHh/3FOAa7Y0CSAOQeW5aZL9FTIfqU7yjGY94ZLj1vvj2JfH7wDEQjgoTizGPH6XqSDvtkbX90eYs3CytNC6mqS/NNNZlKKa6oYfMP/cm3WlG5LY1YMLkiH8Q9lhJaXrfPZXL6b+BllvJAARiF+87qT3va9zId9Dc/KoJ0xeNaeqYDiouh/8X8VmrLQwiTN+hj6/dYBGaMxzPdQVAFWtzcMR5jaCgsWo3sdkziOSnP5QzXJDfV5yj9CchXW2hPxrUkasCrafTsvvVqzYgy5FHm7FwmaeJYOpFZz8ERxriwWXZoVeji57i+7ru/ZEudk+UYzkmUCaqG32aXNWLSb7Om5Kw5R9gEoju1ZdVzibHHh+kvm7UrrLPt2GIzPR2ANGUHU0LumFq4ygKE0Vk+DgnD7RhF/KRkrK+uod2+IZQmeRjdWjfmehmlxgcRip2KqAzEhyhMYV92OXLQcg9wEUEpFIsWPX7u0q2HKv1kmGl/KresT4w0C0YWkCO9g6uLADnwNLklhdp4b3G4HZIN6HyRf706X2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(426003)(1076003)(16526019)(26005)(6666004)(336012)(36860700001)(2616005)(47076005)(8936002)(5660300002)(8676002)(4326008)(81166007)(44832011)(41300700001)(2906002)(478600001)(966005)(54906003)(110136005)(70206006)(316002)(70586007)(36756003)(86362001)(82740400003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:40:49.0598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7916f3-5da2-43f5-8237-08dc2123b901
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350

This series includes the following changes:

There can be many users of the pds_core's adminq. This includes
pds_core's uses and any clients that depend on it. When the pds_core
device goes through a reset for any reason the adminq is freed
and reconfigured. There are some gaps in the current implementation
that will cause crashes during reset if any of the previously mentioned
users of the adminq attempt to use it after it's been freed.

Issues around how resets are handled, specifically regarding the driver's
error handlers.

Originally these patches were aimed at net-next, but it was requested to
push the fixes patches to net. The original patches can be found here:

https://lore.kernel.org/netdev/20240126174255.17052-1-brett.creeley@amd.com/

Also, the Reviewed-by tags were left in place from net-next reviews as the
patches didn't change.

Brett Creeley (6):
  pds_core: Prevent health thread from running during reset/remove
  pds_core: Cancel AQ work on teardown
  pds_core: Use struct pdsc for the pdsc_adminq_isr private data
  pds_core: Prevent race issues involving the adminq
  pds_core: Clear BARs on reset
  pds_core: Rework teardown/setup flow to be more common

 drivers/net/ethernet/amd/pds_core/adminq.c  | 64 +++++++++++++++------
 drivers/net/ethernet/amd/pds_core/core.c    | 46 +++++++++++----
 drivers/net/ethernet/amd/pds_core/core.h    |  2 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c |  4 ++
 drivers/net/ethernet/amd/pds_core/dev.c     | 16 +++---
 drivers/net/ethernet/amd/pds_core/devlink.c |  3 +-
 drivers/net/ethernet/amd/pds_core/fw.c      |  3 +
 drivers/net/ethernet/amd/pds_core/main.c    | 26 +++++++--
 8 files changed, 124 insertions(+), 40 deletions(-)

-- 
2.17.1


