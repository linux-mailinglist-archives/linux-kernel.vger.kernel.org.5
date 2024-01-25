Return-Path: <linux-kernel+bounces-39149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604C83CB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA31C23060
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98012133994;
	Thu, 25 Jan 2024 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5sH39EXF"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63C31E501;
	Thu, 25 Jan 2024 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208550; cv=fail; b=F6kmNapABw27KWv+eyCUfeWOYXLl+GmO9YfaagKC3/OJIOESIIs1ZYkEoSxgY1u+2OoxGe8eWvWtCKT8xxSFGXwY2YLabNwOrMu6xLM0YRdGcrEFyoizDiwZa0R3Ht964ovB9CH7dkI99eYKgp6BTvGAHjY1hjtkEo6qvfVfJeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208550; c=relaxed/simple;
	bh=8xI0hz7fxd/8K+3oefumBBSxI7Jdj+WFbo2lbeBwLFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fK2Xv3Ha3R6CkBnA8/s8nVw7GVmRTwcMGIe9UWFX8ecynkLFHXtqWeHy9ZbtRuVIDeA431bgYwr2DTwkaRr8ZVQIOkSwhNwDQpxuoZh2Z6G4Rf8A2jOE0SmR6EL/i7StvIDpQzrCx/SWeSJwn1EXIAUJNspIeekxOb4bdntQAf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5sH39EXF; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXH6ky6LeQ0zd6L2aUGvwLhHvdyoDdbHFphVIezmffFEt/5HRh/LNFhUYSW5SuFh7u9jAKNPSYRG/Rrb9Y2tsMZ5b6yWTjHwAUQy/TcCbzA3Hvb8RzekBlYYM+JETs1QUOBtzxVzyEVEcRU0WBjrLKtcfoRpTtbuM7e2OAaWckyR4bwVdw1o5y5i7mP76c/oeDP+kP2RJQobwuzGxVpRf8BuyXpPKn5ELoViuHl/i0SiDqQW4CwKfDyDZGZdDUq5aq9WMUU/j+Zn9cwkWznc642pdKnueLAqZPs1fizPUuTtv7lIeic66Nyg6RggnGsEgofoxjVss/r2mlVDy2jtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDe6RZlBI2IyODeMOcY8qHkcwCfxCvjxWG44p+fWyoI=;
 b=n8Efq5qSF1L/vdEsdwFpXAJyCgp4MAysmAVr51Nd4sA9zx0Qia7V6AP0CtzPFRuPtlIp0KNbJZhFXMHyo1r7MLg4wSsUPS9qG9KihfjTYyPo8GPM9IQ3b6PCrf1jyBZptXPaQj6OCvbAcvV8PGef23AsDPTB2N6xJdeHXmOMGeb2DdavpWNz4mpEm16c7FnUSqWeHgPpCPYLU8WeRiUbjk04vkTPp2lUkzCsMm3UFVoZnGw59ITJIJWCz857g1i42LBcksCI10nF+WnzT0FblzigTXwglbQ+9TXrRRX6+If9xVkGS2qQKSnaMco7pP4+skK6xx/wJ+Gq2AwpI04AOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDe6RZlBI2IyODeMOcY8qHkcwCfxCvjxWG44p+fWyoI=;
 b=5sH39EXFDUNFffYPtk/sacAadaY5kds/u0PHb9JMzS6/OoSoFo2zHF0qcJaNbfDUlHuZL++7Wni4+qbZvTe+7gJq6EjGOnBhK3UeUBDSspwKEKyGSZiuluxYOO8RjWTAm40TQjKCEDFPFZfSS6URoLZeDJBBCJ7+yPJajOhSyxo=
Received: from MW3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:303:2b::22)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 25 Jan
 2024 18:49:04 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::72) by MW3PR05CA0017.outlook.office365.com
 (2603:10b6:303:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.10 via Frontend
 Transport; Thu, 25 Jan 2024 18:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.0 via Frontend Transport; Thu, 25 Jan 2024 18:49:04 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 25 Jan 2024 12:49:03 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v2 0/2] Update mce_record tracepoint
Date: Thu, 25 Jan 2024 12:48:55 -0600
Message-ID: <20240125184857.851355-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ed3da4-ece9-48e8-01a4-08dc1dd64da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f3ecOUIV7EfWwvCwC7ruB/j/Rpwdx0XFrU8bH4rN2+b4Z+drVBF+nOLY/HrwiAPaf7RCFzZY13oFMNTNhqrz7SvNlO3/QPCtfwX9XUMf+spMYOZQsap8gXca5RCOW5fAV2CqMADvZo0oOGXVqdK2bTu1aeB3Y6yJQ5tbgF0wkBrmxpbMPeVbIEilKoHFJiAQqpZTmiBDxsdjGX2S2AUXraDHvlvRfDRv3f69wXKTECzV3MxLK6SkYXqKMrlWbUpMgk/rdsjIT2bAvBJcrG7RZMq5dfqK6Xq3nH6EwZfAvKNHGG+xfODzlDsnDURvmEU+jfNimojPuB1nl/yfucMIfSeokuGQmU6W2UVwM/6cpWtD88NU7Gf2JuzgiQy6NX9B8aV1uC5EOVLa6Se7FesG0VxEAmSQTngOesHvVCyW09D7fa+g1E/ltkc5C+S04LpRGMPd97qpcUDMsGUkoGHnSR35xSS6u+yMdOVss9IgeOy+UdglMX1KO7Yqc+y/uNqylzfmmYwDXmoP+gaQ/h5M4/fTbUsoITI8ngJvV9fZ3DSUL94s6iTQh2cssQF7HQklbmghD5GoUPhA04eOTFFgepXGWnDOSS8VifeVdmlKqCdv7A5BVKgi2fTtFhT5/OSeiU+dG2fcZKcfQpDx9I0Tg/9gWgM84fwrLWL/CZe2h9iziLQA7hLnL3HUXzb8EJL/W5FSBx5Z2/D5ld/PEv7Ske0824JVr//wP46eGdut/no=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(41300700001)(2616005)(26005)(16526019)(7696005)(1076003)(6666004)(8936002)(83380400001)(336012)(426003)(8676002)(4326008)(44832011)(478600001)(70206006)(54906003)(70586007)(316002)(110136005)(5660300002)(86362001)(36860700001)(81166007)(82740400003)(356005)(47076005)(36756003)(40480700001)(40460700003)(4744005)(15650500001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 18:49:04.1162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ed3da4-ece9-48e8-01a4-08dc1dd64da4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057

This patchset updates the mce_record tracepoint so that the recently added
fields of struct mce are exported through it to userspace.

The first patch adds PPIN (Protected Processor Inventory Number) field to
the tracepoint.

The second patch adds the microcode field (Microcode Revision) to the
tracepoint.

Changes in v2:
 - Export microcode field (Microcode Revision) through the tracepoiont in
   addition to PPIN.

Avadhut Naik (2):
  tracing: Include PPIN in mce_record tracepoint
  tracing: Include Microcode Revision in mce_record tracepoint

 include/trace/events/mce.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


base-commit: 0d4f19418f067465b0a84a287d9a51e443a0bc3a
-- 
2.34.1


